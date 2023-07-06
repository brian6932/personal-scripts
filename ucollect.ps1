foreach ($arg in $args) {
    if ($arg -match "\A\d+\Z" -and !$uid) {
        $uid = $arg
        continue
    }
    if ($arg -match '\Ai:\S+\Z' -and !$instance) {
        $instance = $arg.Substring(2)
    }
    if ($uid -and $instance) {
        break
    }
}

$logs = [System.Text.StringBuilder]::new()
$logs.Capacity = 500000000
(Invoke-WebRequest https://$instance/list?channelid=$uid).Content | jq -r '.availableLogs[] | .year+"/"+.month+"/"+.day' | ForEach-Object -Parallel {
    ($using:logs).Append((Invoke-RestMethod "https://$using:instance/channelid/$using:uid/$_`?raw"))
} -ThrottleLimit (Get-CimInstance -ClassName Win32_Processor).NumberOfLogicalProcessors

[Collections.Generic.HashSet[string]]($logs.ToString() | rg -UPo '^@\S+ :([a-z\d]\w{0,24})!\1@\1\.tmi\.twitch\.tv' -r '$1')

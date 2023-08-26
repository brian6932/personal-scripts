foreach ($arg in $args) {
    $uid ??= if ($arg -match '\A\d+\Z') {
        $arg
    }
    $instance ??= if ($arg -match '\Ai:\S+\Z') {
        $arg.Substring(2)
    }
    if ($uid -and $instance) {
        break
    }
}

$logs = [System.Text.StringBuilder]::new()
$logs.Capacity = 500000000
(Invoke-WebRequest https://$instance/list?channelid=$uid).Content | jq -r '.availableLogs[] | .year+"/"+.month+"/"+.day' | ForEach-Object -Parallel {
    ($using:logs).Append((Invoke-RestMethod "https://$using:instance/channelid/$using:uid/$_`?raw"))
} -ThrottleLimit [Environment]::ProcessorCount

[Collections.Generic.HashSet[string]]($logs.ToString() | rg -UPo '^@\S+ :([a-z\d]\w{0,24})!\1@\1\Q.tmi.twitch.tv\E' -r `$1)

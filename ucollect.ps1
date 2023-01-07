foreach ($arg in $args) {
    if ($arg -match "\A\d+\Z") {
        $uid = $arg
        break
    }
}
foreach ($arg in $args) {
    if ($arg -match '\Ai:\S+\Z') {
        $instance = $arg.Substring(2)
        break
    }
}
$logs = (Invoke-WebRequest https://$instance/list?channelid=$uid).Content | jq -r '.availableLogs[] | .year+"/"+.month+"/"+.day' | Sort-Object -Unique | ForEach-Object -Parallel {
    Invoke-RestMethod "https://$using:instance/channelid/$using:uid/$_`?raw"
} | Select-String '^@\S+ :([a-z0-9]\w{0,24})!\1@\1\.tmi\.twitch\.tv'
[Collections.Generic.HashSet[string]]::new([string[]]($logs.matches.groups | ? { $_.Name -eq 1 }).Value) > uniqueChanChatters

# Logged Channel Ban Checker
#Requires -Version 7.0.00000.000
try {
    $request = (Invoke-RestMethod "https://$($args[0].ToLower())/channels").channels.userID
    $num = $request.length
    Write-Host "$num users found on instance" -f red

    if ($num -gt 50) {
        $start = 0
        $range = 0
        $request = for ($request -lt $num; $xd = $request[($start + $range)..($range += 49 + $start)]; $start++) {
            $xd -join ','
        }
        ($request | ForEach-Object -Parallel { Invoke-RestMethod https://api.ivr.fi/v2/twitch/user?id=$_ } | Where-Object { $_.banned -eq $true }).id
    }
    else {
        $in = $request -join ','
        (Invoke-RestMethod https://api.ivr.fi/v2/twitch/user?id=$in | Where-Object { $_.banned -eq $true }).id
    }
}
catch {
    Write-Host "Instance not found" -f red
}

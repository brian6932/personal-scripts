# Logged Channel User Checker
#Requires -Version 7.0.00000.000
try {
    $logs = $args[0].ToLower()
    $user = (Invoke-RestMethod "https://api.ivr.fi/v2/twitch/user?login=$($args[1].ToLower())").id
    $request = (Invoke-RestMethod https://$logs/channels).channels.userID
    if ($request) {
        Write-Host "$($request.length) users found on instance" -f red
        $request | ForEach-Object {
            try {
                if (Invoke-RestMethod "https://$logs/list?channelid=$_&userid=$user") {
                    $_
                }
            }
            catch {}
        }
    }
    else {
        Write-Host "Instance not found" -f red
    }
}
catch {
    Write-Host "User not found" -f red
}

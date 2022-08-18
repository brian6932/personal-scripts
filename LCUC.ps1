#Logged Channel User Checker
#Requires -Version 7.0.00000.000
$logs = $args[0].ToLower()
$user = curl -fsL "https://api.ivr.fi/v2/twitch/user/$($args[1].ToLower())" | jq -r .id

if ($user) {
    $request = curl -sSL https://$logs/channels | jq -r '.channels[].userID'
    Write-Host "$($request.length) users found on instance" -f red
    $request | % { if (curl -fsL "https://$logs/list?channelid=$_&userid=$user") { $_ } }
}
else { Write-Host "User not found" -f red }

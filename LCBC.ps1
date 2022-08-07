#Logged Channel Ban Checker
#Requires -Version 7.0.00000.000
$logs = $args[0].ToLower()
$request = curl -sSL https://$logs/channels | jq -r '.channels[].userID'
$num = (curl -sSL https://$logs/channels | jq -r '.channels[].userID').length
Write-Host "$num users found on instance" -f red
if ($num -gt 50) {
    $request | % -pa { curl -sSL https://api.ivr.fi/v2/twitch/user?id=$_ | jq -r '.[] | select(.banned == true) | .id' }
}
else {
    $in = $request -join ','
    curl -sSL https://api.ivr.fi/v2/twitch/user?id=$in | jq -r '.[] | select(.banned == true) | .id'
}

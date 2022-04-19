#Logged Channel Ban Checker
#Requires -Version 7.0.00000.000
$logs = $args[0].ToLower()
$request = curl -s https://$logs/channels | jq '.channels[] .userID' -r
$num = curl -s https://$logs/channels | jq '.channels[] .userID' -r | measure -l | select -exp lines
Write-Host "$num users found" -f red
if ($num -gt 50) {
    $request | % -pa { Write-Host -f red $_; curl -s https://api.ivr.fi/v2/twitch/user?id=$_ | jq '.[] .banned' }
}
else {
    $in = $request | rg -U -P '.\n(?!$)' -r ','
    curl -s https://api.ivr.fi/v2/twitch/user?id=$in | jq '.[] .banned, .[] .id' -r
}

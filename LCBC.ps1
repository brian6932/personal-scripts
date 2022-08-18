#Logged Channel Ban Checker
#Requires -Version 7.0.00000.000
$request = curl -fsL "https://$($args[0].ToLower())/channels" | jq -r '.channels[].userID'
$num = $request.length
Write-Host "$num users found on instance" -f red

if ($request) {
    if ($num -gt 50) {
        $start = 0
        $range = 0
        $request = for ($request -lt $num; $xd = $request[($start + $range)..($range += 49 + $start)]; $start++) { $xd -join ',' }
        $request | % -pa { curl -sSL https://api.ivr.fi/v2/twitch/user?id=$_ | jq -r '.[] | select(.banned == true) | .id' }
    }
    else {
        $in = $request -join ','
        curl -sSL https://api.ivr.fi/v2/twitch/user?id=$in | jq -r '.[] | select(.banned == true) | .id'
    }
}
else { Write-Host "Instance not found" -f red }

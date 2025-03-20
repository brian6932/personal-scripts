#Requires -Version 7.0.00000.000
# https://github.com/rdavydov/Twitch-Channel-Points-Miner-v2/issues/94#issuecomment-1360683876
$cid = 'ue6666qo983tsx6so1t0vnawi233wa'

$device = Invoke-RestMethod https://id.twitch.tv/oauth2/device -Method Post -Headers @{ 'content-type' = 'application/x-www-form-urlencoded' } -Body "client_id=$cid&scopes=channel_check_subscription+channel_commercial+channel_editor+channel_feed_edit+channel_feed_read+channel_read+channel_stream+channel_subscriptions+collections_edit+communities_edit+communities_moderate+openid+user_blocks_edit+user_blocks_read+user_follows_edit+user_read+user_subscriptions+viewing_activity_read+user%3aedit%3afollows+whispers%3aedit+$([Regex]::new('(?<=<td><code class=\"highlighter-rouge\">)[^<]+').Matches((Invoke-WebRequest https://dev.twitch.tv/docs/authentication/scopes/).Content).Value.Replace(':', '%3a') -join '+')"
$url = "https://twitch.tv/activate?device-code=$($device.user_code)"
"Sign in on $url"
Start-Process $url

Start-Sleep -Seconds 10

while ($token.StatusCode -cne 200) {
    Start-Sleep -Seconds 1
    $token = Invoke-WebRequest https://id.twitch.tv/oauth2/token -Method Post -SkipHttpErrorCheck -Headers @{ 'content-type' = 'application/x-www-form-urlencoded' } -Body "client_id=$cid&device_code=$($device.device_code)&grant_type=urn:ietf:params:oauth:grant-type:device_code"
}

$token.Content | ConvertFrom-Json | ConvertTo-Json

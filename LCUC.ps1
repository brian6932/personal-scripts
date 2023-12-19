# Logged Channel User Checker
#Requires -Version 7.0.00000.000

if ($args.length -lt 2) {
    throw '2 arguments required'
}

try {
    $logs = $args[0].ToLower()
     $user = try {
        [UInt32]$args[1]
    }
    catch {
        $args[1] = ([string]$args[1]).Substring($args[1][1] -eq '@')
        (Invoke-RestMethod https://gql.twitch.tv/gql -Method Post -Body ('{"query":"{user(login:\"'+$args[1]+'\"lookupType:ALL){id}}"}') -Headers @{'client-id'='ue6666qo983tsx6so1t0vnawi233wa'}).id
    }
    $request = (Invoke-RestMethod https://$logs/channels).channels.userID
    if (!$request) {
        Write-Host 'Instance not found' -ForegroundColor Red
        exit 127
    }
    Write-Host "$($request.length) users found on instance" -ForegroundColor Red
    $request | ForEach-Object -Parallel {
        try {
            $null = Invoke-WebRequest -Method Head "https://$using:logs/list?channelid=$_&userid=$using:user"
            $_
        }
        catch {}
    } -ThrottleLimit ([Environment]::ProcessorCount)
}
catch {
    Write-Host 'User not found' -ForegroundColor Red
}

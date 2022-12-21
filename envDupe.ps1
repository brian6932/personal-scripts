# Removes duplicates in $env:Path
[Environment]::SetEnvironmentVariable('Path', ([Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';' | Sort-Object -Unique) -join ';', 'Machine')
[Environment]::SetEnvironmentVariable('Path', ([Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Sort-Object -Unique) -join ';', 'User')

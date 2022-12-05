# Removes duplicates in $env:Path
[Environment]::SetEnvironmentVariable('Path', ($env:Path -split ';' | Sort-Object -Unique) -join ';', 'Machine')

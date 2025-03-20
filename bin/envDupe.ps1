# Removes duplicates in $env:Path
'Machine', 'User' | ForEach-Object {
    [Environment]::SetEnvironmentVariable('Path', ([Environment]::GetEnvironmentVariable('Path', $_) -split [IO.Path]::PathSeparator | Sort-Object -Unique) -join [IO.Path]::PathSeparator, $_)
}

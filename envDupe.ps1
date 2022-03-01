$CurrentPath = [Environment]::GetEnvironmentVariable('Path','Machine')
$SplittedPath = $CurrentPath -split ';'
$CleanedPath = $SplittedPath | Sort-Object -Unique
$NewPath = $CleanedPath -join ';'
[Environment]::SetEnvironmentVariable('Path', $NewPath,'Machine')

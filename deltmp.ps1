# Clears common temp dirs
$env:TMP, 'C:\Windows\Temp' | ForEach-Object -Parallel { Remove-Item -Recurse -Force "$_\*" }

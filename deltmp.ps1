# Clears common temp dirs
Remove-Item -Recurse -Force "$env:TMP\*", 'C:\Windows\Temp\*'

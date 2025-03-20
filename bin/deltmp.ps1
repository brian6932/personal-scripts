# Clears common temp dirs
Remove-Item -Recurse -Force "$env:TMP/*", "$env:SystemRoot/Temp/*"

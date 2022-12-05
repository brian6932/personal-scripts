# Checks for updates for all choco packages with Rocolatey, then updates all the aforementioned packages
choco upgrade (((roco outdated -r) | ForEach-Object { $_.Split('|')[0] }))

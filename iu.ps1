Invoke-RestMethod https://i.alienpls.org/upload -Method Post -Form @{ file = Get-Item $args[0] } | Set-Clipboard -PassThru

$ErrorActionPreference = 'Stop'
Invoke-RestMethod https://i.alienpls.org/upload -Method Post -Form @{ file = [IO.FileInfo](Get-Item -LiteralPath $args[0]) } | Set-Clipboard -PassThru

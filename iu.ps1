$ErrorActionPreference = 'Stop'
Invoke-RestMethod https://i.alienpls.org/upload -Method Post -Form @{ file = [IO.FileInfo](Convert-Path -LiteralPath $args[0]) } | Set-Clipboard -PassThru

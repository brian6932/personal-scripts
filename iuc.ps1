$ErrorActionPreference = 'Stop'
curl.exe -X POST https://i.alienpls.org/upload -F "file=@$([IO.FileInfo](Get-Item -LiteralPath $args[0]))"

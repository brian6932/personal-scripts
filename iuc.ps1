$ErrorActionPreference = 'Stop'
& (Get-Command -CommandType Application curl)[0].Name -X POST https://i.alienpls.org/upload -F "file=@$([IO.FileInfo](Get-Item -LiteralPath $args[0]))"

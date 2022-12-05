# curl way: curl -X POST https://i.alienpls.org/upload -F "file=@$($args[0])"
Invoke-RestMethod https://i.alienpls.org/upload -Method Post -Form @{ file = Get-Item $args[0] } | Set-Clipboard -PassThru

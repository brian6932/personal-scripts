$ErrorActionPreference = 'Stop'
$_ = (Invoke-RestMethod https://api.imgur.com/3/upload -Method Post -Headers @{ 'authorization' = 'client-id 546c25a59c58ad7' } -Form @{ type = 'file'; image = [IO.FileInfo](Convert-Path -LiteralPath $args[0]) }).data
Set-Clipboard $_.link
ConvertTo-Json $_

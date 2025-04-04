(& (Get-Command -CommandType Application rg)[0].Name --json $args | ConvertFrom-Json).data | ForEach-Object { if ($_.line_number) { $_.path.text + ':' + $_.line_number } }

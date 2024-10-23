(& (Get-Command -CommandType Application rg)[0].Name $args[0] --json | ConvertFrom-Json).data | ForEach-Object { if ($_.line_number) { $_.path.text + ':' + $_.line_number } }

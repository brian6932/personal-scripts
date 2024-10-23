(& (Get-Command -CommandType Application rg)[0].Name WebchatDetected --json | ConvertFrom-Json).data | ForEach-Object { if ($_.line_number) { $_.path.text + ':' + $_.line_number } }

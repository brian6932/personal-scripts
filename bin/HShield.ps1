Start-Service 'hshld_*'
Start-Process -Wait "${env:ProgramFiles(x86)}/Hotspot Shield/*/bin/hsscp.exe"
Stop-Service 'hshld_*'

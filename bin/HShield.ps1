Start-Service 'hshld_*'
Start-Process -Wait "C:\Program Files (x86)\Hotspot Shield\*\bin\hsscp.exe"
Stop-Service 'hshld_*'

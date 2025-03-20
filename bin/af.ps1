# Lists all network adapters along with their IPs
Get-CimInstance Win32_NetworkAdapterConfiguration | Format-Table -AutoSize ServiceName,Description,SettingID

# Lists all network adapters along with their IPs
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName . | Select-Object -Property SetingID, Description, IPAddress

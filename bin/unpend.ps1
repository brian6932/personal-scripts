@(
	@('HKLM:/SYSTEM/CurrentControlSet/Control/Session Manager', 'PendingFileRenameOperations')
	@('HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/WindowsUpdate/Auto Update', 'RebootRequired')
	@('HKLM:/SYSTEM/CurrentControlSet/Control/Session Manager', 'PendingFileRenameOperations2')
	@('HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/WindowsUpdate/Auto Update', 'PostRebootReporting')
	@('HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/RunOnce', 'DVDRebootSignal')
	@('HKLM:/Software/Microsoft/Windows/CurrentVersion/Component Based Servicing', 'RebootPending')
	@('HKLM:/Software/Microsoft/Windows/CurrentVersion/Component Based Servicing', 'RebootInProgress')
	@('HKLM:/Software/Microsoft/Windows/CurrentVersion/Component Based Servicing', 'PackagesPending')
	@('HKLM:/SOFTWARE/Microsoft/ServerManager', 'CurrentRebootAttempts')
	@('HKLM:/SYSTEM/CurrentControlSet/Services/Netlogon', 'JoinDomain')
	@('HKLM:/SYSTEM/CurrentControlSet/Services/Netlogon', 'AvoidSpnSet')
) | ForEach-Object { Remove-ItemProperty -ErrorAction Ignore @_ }

$UpdateExeVolatile = @('HKLM:/SOFTWARE/Microsoft/Updates', 'UpdateExeVolatile')
if ((Get-ItemProperty @UpdateExeVolatile -ErrorAction -Ignore).UpdateExeVolatile -gt 0) {
	Remove-ItemProperty @UpdateExeVolatile
}

Remove-Item 'HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/WindowsUpdate/Services/Pending/*'

$ActiveComputerName = Get-ItemProperty 'HKLM:/SYSTEM/CurrentControlSet/Control/ComputerName/ActiveComputerName' 'ComputerName'
$ComputerName = Get-ItemProperty 'HKLM:/SYSTEM/CurrentControlSet/Control/ComputerName/ComputerName' 'ComputerName'

if ($ActiveComputerName.ComputerName -ne $ComputerName.ComputerName) {
	throw "Mismatched
	$($ActiveComputerName.PSPath) ($($ActiveComputerName.ComputerName))
	$($ComputerName.PSPath) ($($ComputerName.ComputerName))"
}

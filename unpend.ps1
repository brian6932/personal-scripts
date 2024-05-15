Get-ItemProperty (
	'HKLM:/SYSTEM/CurrentControlSet/Control/Session Manager/PendingFileRenameOperations',
	'HKLM:/SYSTEM/CurrentControlSet/Control/Session Manager/PendingFileRenameOperations2',
	'HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/WindowsUpdate/Auto Update/RebootRequired',
	'HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/WindowsUpdate/Auto Update/PostRebootReporting',
	'HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/RunOnce/DVDRebootSignal',
	'HKLM:/Software/Microsoft/Windows/CurrentVersion/Component Based Servicing/RebootPending',
	'HKLM:/Software/Microsoft/Windows/CurrentVersion/Component Based Servicing/RebootInProgress',
	'HKLM:/Software/Microsoft/Windows/CurrentVersion/Component Based Servicing/PackagesPending',
	'HKLM:/SOFTWARE/Microsoft/ServerManager/CurrentRebootAttempts',
	'HKLM:/SYSTEM/CurrentControlSet/Services/Netlogon/JoinDomain',
	'HKLM:/SYSTEM/CurrentControlSet/Services/Netlogon/AvoidSpnSet'
) -ErrorAction Ignore | Remove-Item

if (($_ = Get-ItemProperty HKLM:/SOFTWARE/Microsoft/Updates/UpdateExeVolatile -ErrorAction Ignore).UpdateExeVolatile -gt 0) {
	Remove-Item $_
}

Get-ChildItem HKLM:/SOFTWARE/Microsoft/Windows/CurrentVersion/WindowsUpdate/Services/Pending | Remove-Item

if (($ActiveComputerName = Get-ItemProperty HKLM:/SYSTEM/CurrentControlSet/Control/ComputerName/ActiveComputerName).ComputerName -ne ($ComputerName = Get-ItemProperty HKLM:/SYSTEM/CurrentControlSet/Control/ComputerName/ComputerName).ComputerName) {
	$ActiveComputerName, $ComputerName
	throw "Mismatched
	$($ActiveComputerName.PSPath) ($($ActiveComputerName.ComputerName))
	$($ComputerName.PSPath) ($($ComputerName.ComputerName))
	"
}

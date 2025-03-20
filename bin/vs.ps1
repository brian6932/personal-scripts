# Imports Visual Studio Build Tools env vars on demand
# -Descending used instead of bottom to keep compatibility with PowerShell 5
Import-Module "${env:ProgramFiles(x86)}/Microsoft Visual Studio/*/BuildTools/Common7/Tools/Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell (Get-ChildItem "$env:ProgramData/Microsoft/VisualStudio/Packages/_Instances" | Sort-Object LastWriteTime -Descending)[0].Name -DevCmdArguments '-arch=x64 -no_logo'

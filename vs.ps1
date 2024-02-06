# Imports Visual Studio Build Tools env vars on demand
Import-Module 'C:/Program Files (x86)/Microsoft Visual Studio/*/BuildTools/Common7/Tools/Microsoft.VisualStudio.DevShell.dll'
Enter-VsDevShell (Get-ChildItem C:/ProgramData/Microsoft/VisualStudio/Packages/_Instances)[0].Name -DevCmdArguments '-arch=x64 -no_logo'

# Reloads your history file.
$PSReadlineOptions = Get-PSReadLineOption
$HistorySaveStyle = $PSReadlineOptions.HistorySaveStyle
$HistorySavePath = $PSReadlineOptions.HistorySavePath
[Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
Set-PSReadLineOption -HistorySaveStyle SaveNothing
Get-Content $HistorySavePath -Last $MaximumHistoryCount | ForEach-Object {
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($_)
}
Set-PSReadLineOption -HistorySaveStyle $HistorySaveStyle

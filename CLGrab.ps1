#Chatter (now with recent-mesages support) List Grabber
#Requires -Version 7.2.00000.000
$channel = $args[0].ToLower()
$fossaMode = $args[1..3] -contains '-f'
$pasteMode = $args[1..3] -contains '-p'
$recentMode = $args[1..3] -contains '-r'
if ($channel -and !($channel[0] -eq '-')) {
    if ($channel) {
        if ($recentMode) {
            $request = pf -f https://recent-messages.robotty.de/api/v2/recent-messages/$channel | jq -r '.messages | .[]'
            $arr = @()
            $request = $request[$request.length..0] | ForEach-Object { $_ -match '^.+:([a-z0-9]\w{0,24})!'; $arr += $Matches[1] }
            $request = [Collections.Generic.HashSet[string]]::new([string[]]$arr) -join ' '
        }
        else {
            $request = (pf -f https://tmi.twitch.tv/group/user/$channel/chatters | jq -r '.chatters | .. | select(type == "string")') -join ' '
        }
        $charCount = $request.length
        $splitLength = $fossaMode ? 375 : 475
        $pasteMode ?
        $charCount -ge 500 ? ($request | rg -P ".{$splitLength}\K\s" -r `n | pf | Set-Clipboard -PassThru) : ($request | pf | Set-Clipboard -PassThru) :
        $charCount -ge 500 ? ($request | rg -P ".{$splitLength}\K\s" -r `n | Set-Clipboard -PassThru) : ($request | Set-Clipboard -PassThru)
    }
    else {
        Write-Host 'You have to provide a channel!' -f red
    }
}
else {
    Write-Host 'Args must be placed after channel' -f red
}

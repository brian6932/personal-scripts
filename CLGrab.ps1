# Chatter (now with recent-mesages support) List Grabber
#Requires -Version 7.2.00000.000
$channel = $args[0].ToLower()
$fossaMode = $args[1..4] -contains '-f'
$pasteMode = $args[1..4] -contains '-p'
$recentMode = $args[1..4] -contains '-r'
$noBots = $args[1..4] -contains '-nb'
if ($channel -and !($channel[0] -eq '-')) {
    if ($channel) {
        if ($recentMode) {
            $request = pf -f https://recent-messages.robotty.de/api/v2/recent-messages/$channel | jq -r '.messages | .[]'
            $arr = @()
            $request = $request[$request.length..0] | ForEach-Object { $_ -match '^@\S+ :([a-z0-9]\w{0,24})!\1@\1\.tmi\.twitch\.tv'; $arr += $Matches[1] }
            $request = [Collections.Generic.HashSet[string]]::new([string[]]$arr)
        }
        else {
            $request = (pf -f https://tmi.twitch.tv/group/user/$channel/chatters | jq -r '.chatters | .. | select(type == "string")')
        }
        if ($noBots) {
            $request = $request | Where-Object { $_ -notmatch "bo?t{1,2}(?:(?:ard)?o|\d|_)*$|^(?:fembajs|veryhag|scriptorex|apulxd|qdc26534|linestats|pepegaboat|sierrapine|charlestonbieber|icecreamdatabase|chatvote|localaniki|rewardmore|gorenmu|0weebs|befriendlier|electricbodybuilder|o?bot(?:bear1{3}0|2465|menti|e|nextdoor)|stream(?:elements|labs))$" }
        }
        $request = $request -join ' '
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

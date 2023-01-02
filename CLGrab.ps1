# Chatter (now with recent-mesages support) List Grabber
#Requires -Version 7.2.00000.000
$userRe = '[a-z0-9]\w{0,24}'
foreach ($arg in $args) {
    if ($arg -match "\A$userRe\Z") {
        $chan = $arg.ToLower()
        break
    }
}
$fossaMode = $args -contains '-f'
$pasteMode = $args -contains '-p'
$recentMode = $args -contains '-r'
$noBots = $args -contains '-nb'
if ($chan) {
    if ($recentMode) {
        foreach ($arg in $args) {
            if ($arg -match '\Ai:\S+\Z') {
                $instance = $arg.Substring(2)
                break
            }
        }
        $request = pf -f "https://$($instance ?? 'recent-messages.robotty.de')/api/v2/recent-messages/$chan" | jq -r '.messages | .[]'
        $arr = @()
        $request = $request[$request.length..0] | ForEach-Object { $_ -match "^@\S+ :($userRe)!\1@\1\.tmi\.twitch\.tv"; $arr += $Matches[1] }
        $request = [Collections.Generic.HashSet[string]]::new([string[]]$arr)
    }
    else {
        $request = (pf -f https://tmi.twitch.tv/group/user/$chan/chatters | jq -r '.chatters | .. | select(type == "string")')
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

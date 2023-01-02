# Chatter (now with recent-mesages support) List Grabber
#Requires -Version 7.2.00000.000
$userRe = '[a-z0-9]\w{0,24}'
foreach ($arg in $args) {
    if ($arg -match "\A$userRe\Z") {
        $chan = $arg.ToLower()
        break
    }
}
# split size
$fossaMode = $args -contains '-f' ? 375 : 475
$pasteMode = if ($args -contains '-p') { '| pf' }
$clipboardMode = if ($args -contains '-c') { '| Set-Clipboard -PassThru' }
if ($chan) {
    # recent-messages mode
    if ($args -contains '-r') {
        foreach ($arg in $args) {
            if ($arg -match '\Ai:\S+\Z') {
                $instance = $arg.Substring(2)
                break
            }
        }
        $request = Invoke-RestMethod "https://$($instance ?? 'recent-messages.robotty.de')/api/v2/recent-messages/$chan" | jq -r '.messages | .[]'
        $arr = @()
        $request = $request[$request.length..0] | ForEach-Object { $_ -match "^@\S+ :($userRe)!\1@\1\.tmi\.twitch\.tv"; $arr += $Matches[1] }
        $request = [Collections.Generic.HashSet[string]]::new([string[]]$arr)
    }
    else {
        $ProgressPreference = 'SilentlyContinue'
        $request = (Invoke-WebRequest https://tmi.twitch.tv/group/user/$chan/chatters).Content | jq -r '.chatters | .. | select(type == "string")'
    }
    # no bots mode
    if ($args -contains '-nb') {
        $request = $request | Where-Object { $_ -notmatch "bo?t{1,2}(?:(?:ard)?o|\d|_)*$|^(?:fembajs|veryhag|scriptorex|apulxd|qdc26534|linestats|pepegaboat|sierrapine|charlestonbieber|icecreamdatabase|chatvote|localaniki|rewardmore|gorenmu|0weebs|befriendlier|electricbodybuilder|o?bot(?:bear1{3}0|2465|menti|e|nextdoor)|stream(?:elements|labs))$" }
    }
    $request = $request -join ' '
    $charCount = if ($request.length -ge 500) { '| rg -P ".{$fossaMode}\K\s" -r `n' }
    "`$request $charCount $pasteMode $clipboardMode" | Invoke-Expression
}
else {
    Write-Host 'You have to provide a channel!' -f red
}

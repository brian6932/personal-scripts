#Requires -Version 7.2.00000.000
$channel = $args[0].ToLower()
$fossaMode = $args[1] -eq '-f' -or $args[2] -eq '-f'
$pasteMode = $args[1] -eq '-p' -or $args[2] -eq '-p'
if ($channel -ne '-p' -and $channel -ne '-f') {
    if ($channel) {
        $request = pf -f https://tmi.twitch.tv/group/user/$channel/chatters | jq -r '.chatters.broadcaster, .chatters.vips, .chatters.moderators, .chatters.viewers | .[]' | rg -U '.\n' -r ' '
        $charCount = $request.length
        $splitLength = $fossaMode ? 375 : 475
        $pasteMode ?
        $charCount -ge 500 ? ($request | rg --pcre2 ".{$splitLength}\K\s" -r `n | pf | scb -PassThru) : ($request | pf | scb -PassThru):
        $charCount -ge 500 ? ($request | rg --pcre2 ".{$splitLength}\K\s" -r `n | scb -PassThru) : ($request | scb -PassThru)
    }
    else {
        Write-Host 'You have to provide a channel!' -ForegroundColor red
    }
}
else {
    Write-Host 'Args must be placed after channel' -ForegroundColor red
}

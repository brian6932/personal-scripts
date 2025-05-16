# Shares a YouTube Playlist anonymously
"https://www.youtube.com/watch_videos?video_ids=$((yt-dlp --quiet --no-warnings --simulate --get-id --flat-playlist @args) -join ',')"

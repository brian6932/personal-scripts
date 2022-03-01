$link = $args[0]
streamlink --twitch-low-latency --hls-live-edge 1 --hls-segment-threads 10 --twitch-disable-ads --player-passthrough hls --player "C:\Program Files (x86)\K-Lite Codec Pack\MPC-HC64\mpc-hc64.exe" $link best

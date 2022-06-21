$file = $args[0]
curl -X POST https://i.alienpls.org/upload -F "file=@$file" | scb -p

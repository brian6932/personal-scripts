wordle.exe custom (Invoke-RestMethod "https://www.nytimes.com/svc/wordle/v2/$((Get-Date).ToString('yyyy-MM-dd')).json").solution

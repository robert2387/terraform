add-content -path C:\Users\Bianca\.ssh\config.txt -value @"

Host ${hostname}
    HostName ${hostname}
    User ${user}
    IdentityFile ${identityfile}
"@
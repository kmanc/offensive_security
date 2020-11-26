# [apachectl](https://httpd.apache.org/docs/2.4/programs/apachectl.html):
#### `apachectl start`
  * hosts /var/www/ on port 80

# [atftpd](https://linux.die.net/man/8/atftpd) / [tftp](https://linux.die.net/man/1/tftp):
#### `atftpd --daemon --port YYY <directory>`
#### `tftp -i X.X.X.X GET <file>` (Windows syntax)
  * atftpd starts a tftp server allowing access to files in the directory
  * tftp can be used to retrieve files 
  * -i [on Windows](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tftp) allows you to transfer in binary mode; if you don't do this you probably won't be able to run out-of-the-box

# [python http server](https://docs.python.org/3/library/http.server.html):
#### `python3 -m http.server YYY`
  * hosts your current directory on port YYY
  * -d specifies what directory you'd like to use

# [wget](https://linux.die.net/man/1/wget):
#### `wget X.X.X.X/script.sh`
#### `wget X.X.X.X/authorized_keys`

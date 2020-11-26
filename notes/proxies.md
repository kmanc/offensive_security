# [proxychains](https://web.archive.org/web/20191115232017/https://www.linuxbabe.com/desktop-linux/how-to-use-proxychains-to-redirect-your-traffic-through-proxy-server):
#### `proxychains <command you would have run>`
  * configuration is done in `/etc/proxychains.conf`
  
# [rinetd](https://web.archive.org/web/20191202033419/http://man.docs.sk/8/rinetd.html):
  * port forwarding tool whose configuration is done in `/etc/rinetd.conf`


# [ssh](https://linux.die.net/man/1/ssh):
#### `ssh X.X.X.X -p YYY -L ZZZ:A.A.A.A:BBB`
#### `ssh X.X.X.X -p YYY -R ZZZ:A.A.A.A:BBB`
#### `ssh -D YYY -p ZZZ:X.X.X.X`
  * -p defines the local port (YYY) to use to connect to the remote (X.X.X.X) server
  * -L defines the local port (ZZZ) to proxy through the other local port (YYY) to hit the other remote (A.A.A.A) server's port (BBB)
  * -R defines the remote port (BBB) to proxy through the other remote port (YYY) to the local (X.X.X.X) server's local port (ZZZ)
  * -D defines the local port (YYY) to use for communication to the remote (X.X.X.X) server's port (ZZZ)
  * -f implies -n and tells SSH to run in the background once all authorization stuff has happened; good for forwarding things
  * -N tells SSH not to execute a remote command; also good for forwarding things

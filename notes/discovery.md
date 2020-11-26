# [curl](https://linux.die.net/man/1/curl):
#### `curl --request <GET/POST/etc> X.X.X.X`
  * -A or --user-agent sends a specific user agent
  * --local-port lets you set a local port to use for the connection
  * -X or --request lets you specify which method to use

# [dirbuster](https://tools.kali.org/web-applications/dirbuster):
  * uncheck recursive
  * select proper extensions
  * sort by response to see 200s

# [dnsrecon](https://tools.kali.org/information-gathering/dnsrecon):
#### `dnsrecon -d domain.com -t axfr`
#### `dnsrecon -d domain.com -w`
  * -t defines the type of recon to run
  * -w does a deep whois inspection and reverse IP lookup

# [google hacking database](https://www.exploit-db.com/google-hacking-database):
#### `site:domain.com -site:www.domain.com`
#### `site:domain.com intitle:"Index of" pass.txt`
  * gives you ideas to Google for

# [host](https://linux.die.net/man/1/host):
#### `host -t ns website.com`
#### `host -t mx website.com`
#### `host subdomain.website.com`
#### `host X.X.X.X`
#### `host -l website.com nameserver.website.com`
  * -t defines the type (cname, ns, soa, etc)

# [nbtscan](https://tools.kali.org/information-gathering/nbtscan-unixwiz):
#### `nbtscan X.X.X.X`
  * -f shows full NBT resource record responses (recommended by the docs)
  * -m shows MAC addresses

# [netcraft](https://www.netcraft.com/):
#### `domain.com`
  * tells you about what hosts a particular site
  
# [nikto](https://tools.kali.org/information-gathering/nikto):
#### `nikto -host X.X.X.X`
  * -host specifies which machine to run the scan on
  * -Save [.] saves the output to a file (. for default name)
  * -Help prints help (why capital letters though?)

# [nmap](https://linux.die.net/man/1/nmap):
#### `nmap -sC -sV -oA nmap_results X.X.X.X`
#### `nmap -sV -oA nmap_results --script vuln X.X.X.X`
#### `nmap -sV -p- -oA deeper X.X.X.X`
  * -Pn skips host discovery; use if host is known up
  * --traceroute traces hop path to hosts
  * -sS TCP scan
  * -sU UDP scan
  * -p ports (eg. -p U:53,111,137,T:21,22,23,80,443)
  * --top-ports scans top ports (woah)
  * -sV probes open ports to determine service/version
  * -O OS detection-f fragment packets (evasion)
  * -D use decoys for scan
  * -S spoof source address
  * -g use specific port for scan
  * --data-length appends random data to packets
  * --spoof-mac spoofs mac address (wow)
  * -oA <filename> outputs scan to filename in normal, xml, and grepable formats
  * --script vuln does a "free" vuln scan for some well-known vulns
  * -p- does a deep scan of all ports

# [onesixtyone](https://github.com/trailofbits/onesixtyone):
#### `onesixtyone -c <string_file> -i <ip_file>
  * SNMP scanner and dictionary attack runner

# [openVAS](https://tools.kali.org/vulnerability-analysis/openvas):
#### `openvas-setup`
#### `openvas-feed-update`
  * GUI based vulnerability scanner that runs on localhost:9392

# [recon-ng](https://tools.kali.org/information-gathering/recon-ng):
#### `recon-ng`
#### `search whois`
  * think of this like metasploit but for recon - comes with a bunch of options and built in help functions

# [rpcclient](https://linux.die.net/man/1/rpcclient):
#### `rpcclient -U "" X.X.X.X`
  * -U chooses username
  * -C can use cached credentials if cached by winbind
  * -N suppresses password prompt
  
# [searchsploit](https://www.exploit-db.com/searchsploit):
#### `searchsploit magento`

# [snmpcheck](https://linux.die.net/man/1/snmpcheck) / [snmpwalk](https://linux.die.net/man/1/snmpwalk):
#### `snmpcheck X.X.X.X -c public`
#### `snmpwalk -c public -v1 X.X.X.X <MIB value>`
#### `snmpwalk -c public -v1 X.X.X.X 1.3.6.1.4.1.77.1.2.25`
  * SNMP queriers (above example is Windows users)
  * MIB values correspond to different things, but can include running processes, user accounts, TCP ports, and more

# [sqlmap](https://web.archive.org/web/20191201191308/https://github.com/sqlmapproject/sqlmap/wiki/Introduction):
#### `sqlmap -u X.X.X.X --crawl=1`
  * -u specifies the url of the target
  * -l allows you to input an intercept file from burp
  * -f does dbms fingerprinting
  * --crawl does enumeration
  * --os-shell tries to get an interactive shell

# [theharvester](https://tools.kali.org/information-gathering/theharvester):
#### `theharvester -d domain.com -b google`
#### `theharvester -d domain.com -b linkedin`
#### `theharvester -d domain.com -b twitter`
  * -b chooses source of search from Google, LinkedIn, Twitter, VirusTotal, and others
  * -n does a reverse DNS query on IP ranges
  * -t does TLD expansion discovery
  * -h uses SHODAN to look for discovered hosts

# [wfuzz](https://manpages.debian.org/buster/wfuzz/wfuzz.1.en.html):
#### `wfuzz -c -w /usr/share/wordlist/general/common.txt -f wfuzz.txt --sc 200 -u X.X.X.X`
  * -c outputs to console in color
  * -w chooses the wordlist
  * -f defines the output file
  * --sc limits the console output to lines that contain the string that follows it
  * -u defines the URL to test

# [whois](https://linux.die.net/man/1/whois):
#### `whois domain.com`
#### `whois X.X.X.X`
  * -d disables reading from and writing to the cache
  * -r forces use of the rwhois protocol

# [zap](https://www.zaproxy.org/):
  * change default scope to narrow results
  * click target button to apply that filter

# [cewl](https://tools.kali.org/password-attacks/cewl):
#### `cewl <website.com> -m 6 -w <hash_file>`
  * -m sets the minimum word length
  * -w writes to a file

# [crunch](https://tools.kali.org/password-attacks/crunch):
#### `crunch 6 6 0123456879abcdef -o <hash_file>`
   * first param is min password size
   * second param is max password size
   * custom alphabets supported
   * -t allows you to specify a pattern, but the syntax isn't intuitive
   
# [fgdump](https://web.archive.org/web/20191202010850/http://foofus.net/goons/fizzgig/fgdump/):
#### `fgdump.exe`
  * dumps password hashes from older Windows versions

# [hashcat](https://tools.kali.org/password-attacks/hashcat):
#### `hashcat -m 110 <hash_file> <wordlist_file> --force`
#### `hashcat -m <1000/5500/5600> -a 0 <hash_file> <wordlist_file> -O`
  * -m specifies hash type; see the man page for reference
    * 1000 for NTLM, 5500 for Net-NTLMv1, 5600 for Net-NTLMv2
  * --force ignores warnings
  * -a specifies attack type; see the man page for reference
    * 0 for wordlist, 3 for brute force
  * cached results are in `~/.hashcat/hashcat.potfile`

# [hydra](https://tools.kali.org/password-attacks/hydra):
#### `hydra -l <username> -P <hash_file> -t 10 ssh://X.X.X.X`
  * -l chooses username (caps for file)
  * -p chooses password (caps for file)
  * -t specifies number of tasks to run in parallel
  * -w makes hydra wait in between attempts to avoid being blocked

# [medusa](https://web.archive.org/web/20191115182453/https://www.mankier.com/1/medusa):
#### `medusa -h X.X.X.X -u <username> -P <hash_file> -M http -m <directory> -T 20`
#### `medusa -H <host_file> -u <username> -M smbnt -m PASS:HASH`
  * -T determines number of threads
  * -M specifies the module to run
  * -m specifies parameters to pass
  * -n for non-default TCP port numbers
  * -f stops once a valid user/pass combo is found
  
# [ncrack](https://tools.kali.org/password-attacks/ncrack):
#### `ncrack -v -f --user <username> -P <hash_file> rdp://X.X.X.X CL=1`
  * -CL determines number of open connections at a time
  * -f stops after a valid user/pass combo is found

# [pth suite](https://www.kali.org/tutorials/pass-the-hash-toolkit-winexe-updates/):
#### `pth-winexe -U  <username> //X.X.X.X cmd`
  * there are many modules in the pth suite, check them out

# [john the ripper](https://tools.kali.org/password-attacks/john):
#### `john <hash_file>`
#### `john --wordlist=<wordlist> <hash_file>`
#### `john --format=<nt/netntlm/netntlmv2> --wordlist=<wordlist> <hash_file>`
  * --wordlist[=<hash_file>] allows you to give it the word you want to run against the hash
  * --fork[=n] allows you to spawn multiple processes
  * --session[=<name>] names a session that you can restore later
  * --restore[=<name>] restores the session
  * /etc/john/john.conf can be used to do password fuzzing on an existing wordlist (adding numbers for instance)
  * nt for NTLM, netntlm for Net-NTLMv1, netntlmv2 for Net-NTLMv2

# [windows credential editor](https://web.archive.org/web/20191202011255/https://www.ampliasecurity.com/research/wcefaq.html):
#### `wce32.exe -w`
  * -w dumps cleartext logon passwords
  * -o specifies an output file
  * -g generates an NTLM hash for the supplied cleartext password

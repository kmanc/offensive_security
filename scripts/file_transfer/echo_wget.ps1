echo param ( > wget.ps1
echo     [Parameter(Mandatory=$true)][string]$url >> wget.ps1
echo ) >> wget.ps1
echo $curDir = $pwd >> wget.ps1
echo $outfile = $url.Split("/")[-1] >> wget.ps1
echo $output = -join($curDir, "\", $outfile) >> wget.ps1
echo $webclient = New-Object System.Net.WebClient >> wget.ps1
echo $webclient.DownloadFile($url, $output) >> wget.ps1


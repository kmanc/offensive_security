$curDir = $pwd
param (
    [Parameter(Mandatory=$true)][string]$url,
    [Parameter(Mandatory=$true)][string]$outfile
)
$output = -join($curDir, "\", $outfile)
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($url, $output)

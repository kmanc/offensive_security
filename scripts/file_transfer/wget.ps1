param (
    [Parameter(Mandatory=$true)][string]$url
)
$curDir = $pwd
$outfile = $url.Split("/")[-1]
$output = -join($curDir, "\", $outfile)
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($url, $output)

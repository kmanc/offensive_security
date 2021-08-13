param (
    [Parameter(Mandatory=$true)][string]$url
)
$curDir = $pwd
$outfile = $url.Split("/")[-1]
$output = -join($curDir, "\", $outfile)
Invoke-RestMethod -URI $url -OutFile $output

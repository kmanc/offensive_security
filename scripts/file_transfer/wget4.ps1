param (
    [Parameter(Mandatory=$true)][string]$url
)
$curDir = $pwd
$outfile = $url.Split("/")[-1]
$output = -join($curDir, "\", $outfile)
Start-BitsTransfer -Source $url -Destination $output

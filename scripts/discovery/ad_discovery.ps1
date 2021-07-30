$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$PDC = ($domainObj.PdcRoleOwner).Name
$searchString = "LDAP://"
$searchString += $PDC + "/"
$distinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))"
$searchString += $distinguishedName
$searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$searchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$searcher.SearchRoot = $objDomain
# To get all accounts and their properties
<#
$searcher.filter = "samAccountType=805306368"
$Result = $searcher.FindAll()
Foreach($obj in $Result)
{
    Foreach($prop in $obj.Properties)
    {
        $prop
    }
    Write-Host "-------------------------"
}
#>

# To get all groups
<#
$searcher.filter = "objectClass=Group"
$Result = $searcher.FindAll()
Foreach($obj in $Result)
{
    $obj.Properties.Name
}
#>

# To get all members of a group
<#
$searcher.filter = "name=GroupName"
$Result = $searcher.FindAll()
Foreach($obj in $Result)
{
    $obj.Properties.member
}
#>

# To get all instances of a service
<#
$searcher.filter = "serviceprincipalname=*service(like http)*"
$Result = $searcher.FindAll()
Foreach($obj in $Result)
{
    Foreach($prop in $obj.Properties)
    {
        $prop
    }
}
#>
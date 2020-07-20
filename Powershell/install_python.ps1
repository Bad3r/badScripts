<#
.SYNOPSIS
    This script will install python 3 using chocolatey 
.EXAMPLE
    PS C:\\> install_python.ps1
.NOTES
    Chocolatey installations output will be stored in install_python.log
#>

$package = "sysinternals"
$logfile = "./install_python.log"

Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Installing $package.."
choco install $package | Out-File -FilePath $logfile

$result = choco list -lo | Where-object {
     $_.ToLower().StartsWith("$package".ToLower()) }

$status = $null -ne $result
Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Installation Status: $status"

# if the package is installed print its version
if($status -eq $true) {
    $version =  $result.Split(' ')[1]
    Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) $package version: $version"
}

Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Log File: $logfile"
Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Done"

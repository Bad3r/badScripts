<#
.SYNOPSIS
    This script will install sysinternals using chocolatey 
.EXAMPLE
    PS C:\\> install_sysinternals.ps1
.LINK
    https://docs.microsoft.com/en-us/sysinternals/
.NOTES
    if the installations is successful output will be stored in install_sysinternals.log
    if errors occur during the installation process output will be sent to the terminal
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7

#>

$package = "sysinternals"
$logfile = "./install_sysinternals.log"

function installation_status {
    param ($result)
    if($null -ne $result){
        return $true;
    }
    return $false;
}

function check_version {
    param ($result)
    $parts = $result.Split(' ');
    return $parts[1];
}

Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Installing $package.."
powershell choco install $package | Out-File -FilePath $logfile

$result = powershell choco list -lo | Where-object {
     $_.ToLower().StartsWith("$package".ToLower()) }

$status = installation_status($result)
Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Installation Status: $status"

# if the package is installed print its version
if($status -eq $true) {
    $version = check_version($result)
    Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) $package version: $version"
}

Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) logfile: $logfile"
Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Done"

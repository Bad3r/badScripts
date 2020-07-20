<#
.SYNOPSIS
    Chocolatey package manager for windows using TLS 1.2 
.EXAMPLE
    PS C:\\> install_Chocolatey.ps1
    Installs Chocolatey package manager
.LINK
    https://chocolatey.org/install
.NOTES
    Requires Administrator privilege
#>

# Requires Administrator privilege
#Requires -RunAsAdministrator
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Installing Chocolatey.."

$chocoInstall = "C:\ProgramData\chocolatey"

if (-not(Test-Path $chocoInstall))
{
  Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
  Write-Host "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Chocolatey is now installed"
}
else
{
  Write-Host "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Chocolatey is already installed"
}

$chocoVersion = powershell choco -v
Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Chocolatey Version: $chocoVersion"

Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) Enabling 'allowGlobalConfirmation' feature.."
$globalConf = powershell choco feature enable -n allowGlobalConfirmation
Write-Output "[*] $('[{0:HH:mm:ss}]' -f (Get-Date)) $globalConf"

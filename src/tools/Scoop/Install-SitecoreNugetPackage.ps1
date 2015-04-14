<#
.SYNOPSIS
Installs a Sitecore.* package to a specific location.

.DESCRIPTION
Installs a Sitecore.* package to a specific location.

.PARAMETER OutputLocation
The folder where the content of the package should be extracted.

.PARAMETER PackageId
The package id of the NuGet package to install.

.PARAMETER Version
The version of the package to install

.PARAMETER ProjectPath
The path to the project containing a Bob.config

.EXAMPLE
Install-SitecoreNugetPackage -PackageId Sitecore.Databases -OutputLocation D:\temp -Version 7.2

#>
function Install-SitecoreNugetPackage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $OutputLocation,
        [Parameter(Mandatory=$true)]
        [string] $PackageId,
        [Parameter(Mandatory=$true)]
        [string] $Version,
        [string] $ProjectPath
    )
    Process
    {
        $config = Get-ScProjectConfig $ProjectPath
        $source = $config.NuGetFeed
        if(-not $source) {
            Write-Error "Source for Sitecore package could not be found. Make sure Bob.config contains the NuGetFeed key."
        }

        $nugetConfig = [System.Environment]::GetFolderPath("ApplicationData") + "\NuGet\NuGet.config"
        if($env:NuGetConfig) {
            $nugetConfig = $env:NuGetConfig
        }

        $fs = New-Object NuGet.PhysicalFileSystem $pwd
        $setting = [NuGet.Settings]::LoadDefaultSettings($fs,  $nugetConfig, $null);
        $sourceProvider = New-Object NuGet.PackageSourceProvider $setting

        $credentialProvider = New-Object NuGet.SettingsCredentialProvider -ArgumentList ([NuGet.ICredentialProvider][NuGet.NullCredentialProvider]::Instance), ([NuGet.IPackageSourceProvider]$sourceProvider)

        [NuGet.HttpClient]::DefaultCredentialProvider = $credentialProvider

        $repo = New-Object  NuGet.DataServicePackageRepository $Source

        Write-Verbose "Install $packageId $version to $OutputLocation"
        $packageToInstall = $repo.FindPackagesById($packageId) | ? {$_.Version -eq $version}
        if(-not $packageToInstall) {
            "Package $packageId with version $version not found"
        }

        $outputFileSystem = New-Object NuGet.PhysicalFileSystem $OutputLocation
        $outputFileSystem.AddFiles($packageToInstall.GetFiles(), $OutputLocation)
    }
}
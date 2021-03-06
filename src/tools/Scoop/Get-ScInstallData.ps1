<#
.SYNOPSIS
Installs all required packages and returns the paths required for a Sitecore 9 installation.

.DESCRIPTION
Installs the following nuget packages:
- Sitecore.Fundamentals
- Sitecore.Sif
- Sitecore.Xp0.Wdp
- Sitecore.Xp0.XConnect.Wdp
- Sitecore.Sif.Config

The return type is a hashtable containing the following properties which can directly be fed into the Scratch Install-*Setup Cmdlets:
- SifPath
- FundamentalsPath
- SifConfigPathSitecoreXp0
- SifConfigPathXConnectXp0
- SifConfigPathCreateCerts
- SitecorePackagePath
- XConnectPackagePath
- LicenseFilePath
- CertCreationLocation

.EXAMPLE
Get-ScInstallData

#>
function Get-ScInstallData
{
    [CmdletBinding()]
    Param(
        [String]$ProjectPath
    )
    Process
    {
        $config = Get-ScProjectConfig $ProjectPath

        $sifInstallPath = Install-NugetPackageToCache -PackageId "Sitecore.Sif" -Version $config.SitecoreSifVersion -ProjectPath $ProjectPath
        $fundamentalsInstallPath = Install-NugetPackageToCache -PackageId "Sitecore.Fundamentals" -Version $config.SitecoreFundamentalsVersion -ProjectPath $ProjectPath
        $sifConfigsInstallPath = Install-NugetPackageToCache -PackageId "Sitecore.Sif.Config" -Version $config.SitecoreSifConfigVersion -ProjectPath $ProjectPath
        $xp0WdpInstallPath = Install-NugetPackageToCache -PackageId "Sitecore.Xp0.Wdp" -Version $config.SitecoreXp0WdpVersion -ProjectPath $ProjectPath
        $xconnectWdpInstallPath = Install-NugetPackageToCache -PackageId "Sitecore.Xp0.XConnect.Wdp" -Version $config.SitecoreXp0ConnectWdpVersion -ProjectPath $ProjectPath

        return @{ `
            SifPath = $(Join-Path $sifInstallPath "SitecoreInstallFramework");
            FundamentalsPath = $(Join-Path $fundamentalsInstallPath "SitecoreFundamentals");
            SifConfigPathSitecoreXp0 = $(Join-Path $sifConfigsInstallPath "sitecore-XP0.json");
            SifConfigPathXConnectXp0 = $(Join-Path $sifConfigsInstallPath "xconnect-XP0.json");
            SifConfigPathCreateCerts = $(Join-Path $sifConfigsInstallPath "xconnect-createcert.json");
            SitecorePackagePath = $(Join-Path $xp0WdpInstallPath "xp0.scwdp.zip");
            XConnectPackagePath = $(Join-Path $xconnectWdpInstallPath "xp0xconnect.scwdp.zip");
            LicenseFilePath = $(Join-Path $(Get-ScProjectPath $ProjectPath) $config.LicensePath);
            CertCreationLocation = $config.CertCreationLocation
        }
    }
}
<#
.SYNOPSIS
Transforms all Web.*.config with the Sitecore web.config and puts it to the web-root.

.DESCRIPTION
Transforms all Web.*.config of all projects in the repo
with the Sitecore web.config and puts it to the web-root.

.PARAMETER ProjectPath
The project path containing the Sitecore configuration.

.PARAMETER Environment
The environment for which the web-configs should be transformed.

.PARAMETER Role
The role for which the web-configs should be transformed.

.EXAMPLE
Install-WebConfig 

#>
function Install-WebConfig
{
    [CmdletBinding()]
    Param(
        [string] $ProjectPath
    )
    Process
    {
        $config = Get-ScProjectConfig $ProjectPath
        $ProjectPath = $config.WebsitePath 
        $scContext = Get-ScContextInfo $ProjectPath
    
        if ($config.InstallWebConfigWebConfigPath){
            $configPath = Join-Path $ProjectPath $config.InstallWebConfigWebConfigPath
        }
        else{
            $type = $scContext.Type
            if((Get-ScMajorVersion) -ge 9){
                $configPath = Install-NugetPackageToCache -Version $config.SitecoreXp0WdpVersion -PackageId "Sitecore.Xp0.Wdp"
                Expand-RubbleArchive `
                    -Path $(Join-Path $configPath "xp0.scwdp.zip") `
                    -OutputLocation $configPath `
                    -FileFilter "Content/Website/Web.config$"
                $configPath = Join-Path $configPath "Content/Website"
            }
            else{
                $configPath = Install-NugetPackageToCache -Version $scContext.Version -PackageId "Sitecore.$type.Config" -ProjectPath $ProjectPath
                $configPath = Join-Path $configPath "Content"
            }
        }
        
        $role = $config.ActiveRole
        if(-not $role) {
            $role = "author"
        }
        $environment = $config.ActiveEnvironment
        if(-not $environment) {
            $environment = "local"
        }
        
        $webRoot = $config.WebRoot
        $webConfigPath = "$webRoot\Web.config"
        
        cp "$configPath\Web.config" "$webConfigPath"
        
        Write-Verbose "Copied $configPath\Web.config to $webConfigPath"
        
        $projects = (ls $ProjectPath -Include *.csproj -Recurse)
        $folders = @()
        
        foreach($project in  $projects){
            $folders += Split-path $project
        }
        
        Install-WebConfigByFolders $folders $webConfigPath $Environment $role.Split(";")
        
    }
}

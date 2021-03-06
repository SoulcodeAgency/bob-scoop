<#
.SYNOPSIS
Copies all unmanaged files of the current project to the WebRoot.
.DESCRIPTION
Copies all unmanaged files of the current project to the WebRoot.
`Copy-UnmanagedFiles` uses Rubble to copy the files.

.EXAMPLE
Copy-UnmanagedFiles

#>
function Copy-UnmanagedFiles
{
  [CmdletBinding()]
  Param(
    [string] $ProjectPath
  )
  Process
  {
    $config = Get-ScProjectConfig $ProjectPath
    $webPath = Join-Path (Join-Path  $config.GlobalWebPath ($config.WebsiteCodeName)) $config.WebFolderName
    Copy-RubbleItem -Path $config.WebsitePath -Destination $webPath -Pattern (Get-RubblePattern $config.UnmanagedFiles)
  }
}

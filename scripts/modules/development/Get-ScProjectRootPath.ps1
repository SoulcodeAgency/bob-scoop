﻿<# 
.SYNOPSIS 
    NOT USED BY BOB!
    ----------------
    Traverses directories, starting with the project directory, testing for a RootIdentifier.
.DESCRIPTION 
    Not used at the moment as Bob.config has been moved to project specific /App_Config folder!
.NOTES 
    Author     :  Unic AG
.LINK 
    http://sitecore.unic.com
#>
Function Get-ScProjectRootPath
{
    [CmdletBinding(
        SupportsShouldProcess=$True,
        ConfirmImpact="Low"
    )]
    Param(
        [String]$ProjectPath = "",
        [String]$RootIdentifier = "misc",
        [String]$stopString = ":"
    )
    Begin{}

    Process
    {
        if(-not $ProjectPath -and (Get-Command | ? {$_.Name -eq "Get-Project"})) {
            $project = Get-Project 
            if($Project) {
                $ProjectPath = Split-Path $project.FullName -Parent
            }
        }

        if(-not $ProjectPath) {
            throw "No ProjectPath could be found. Please provide one."
        }

        $currentPath = Get-Item $projectPath
        
        while (-not (Get-ChildItem $currentPath | Where-Object {$_.Name -eq $RootIdentifier}) -and (-not $currentPath.Name.Contains($stopString)))
        {    
            $currentPath = Get-Item (Split-Path $currentPath.FullName -Parent)
        }
        
        if($currentPath.Name.Contains($stopString)) {
            throw "No ProjectRootPath found based on $RootIdentifier. Please check if $RootIdentifier is correct."
        }
        
        return $currentPath

    }
}
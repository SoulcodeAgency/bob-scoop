﻿$scriptInvocation = (Get-Variable MyInvocation -Scope 0).Value
$scriptPath = Split-Path $scriptInvocation.MyCommand.Definition -Parent
$modulesPath = Join-Path $scriptPath 'modules'

Import-Module (Join-Path $modulesPath build) -Force
New-SerializationPackage $args[0] $args[1] $args[2]
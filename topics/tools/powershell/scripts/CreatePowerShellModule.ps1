# This script creates a blank PowerShell module. Modify the parameters below and run the script.  

$main = {
    # Set the parameters to pass to the function
    $module = @{
        # The name of your module
        ModuleName    = 'My PowerShell Module'
        # The version of your module
        ModuleVersion = "1.0.0.0"
        # Your name
        Author        = "YourNameHere"
        # The minimum PowerShell version this module supports
        PSVersion     = '5.1'
        # The functions to create blank files for in the Public folder
        Functions     = 
            'Get-MyFunction', 
            'Set-MyFunction'
        }
    # Execute the function to create the new module
    New-ModuleTemplate @module
}

Function New-ModuleTemplate {
    [CmdletBinding()]
    [OutputType()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModuleName,
        [Parameter(Mandatory = $true)]
        [string]$ModuleVersion,
        [Parameter(Mandatory = $true)]
        [string]$Author,
        [Parameter(Mandatory = $true)]
        [string]$PSVersion,
        [Parameter(Mandatory = $false)]
        [string[]]$Functions
    )
    $ModulePath = Join-Path .\ "$($ModuleName)\$($ModuleVersion)"
    New-Item -Path $ModulePath -ItemType Directory
    Set-Location $ModulePath
    New-Item -Path .\Public -ItemType Directory

    $ManifestParameters = @{
        ModuleVersion     = $ModuleVersion
        Author            = $Author
        Path              = ".\$($ModuleName).psd1"
        RootModule        = ".\$($ModuleName).psm1"
        PowerShellVersion = $PSVersion
    }
    New-ModuleManifest @ManifestParameters

    $File = @{
        Path     = ".\$($ModuleName).psm1"
        Encoding = 'utf8'
    }
    Out-File @File

    $Functions | ForEach-Object {
        Out-File -Path ".\Public\$($_).ps1" -Encoding utf8
    }
}

& $main
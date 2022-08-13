# Chapter 6 - Making Adaptable Automations

The author provides a nice template for creating modules. This script creates a module structure with blank files. 
```powershell
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

# Set the parameters to pass to the function
$module = @{
    # The name of your module
    ModuleName    = 'PoshAutomate-ServerConfig'
    # The version of your module
    ModuleVersion = "1.0.0.0"
    # Your name
    Author        = "YourNameHere"
    # The minimum PowerShell version this module supports
    PSVersion     = '5.1'
    # The functions to create blank files for in the Public folder
    Functions     = 'Disable-WindowsService', 
        'Install-RequiredFeatures', 'Set-FirewallDefaults', 
        'Set-SecurityBaseline', 'Set-ServerConfig', 
        'Test-SecurityBaseline'
}
# Execute the function to create the new module
New-ModuleTemplate @module
```

You can then add the following code to the .psm1 file to automatically import the functions from the `Public` folder.

```powershell
$Path = Join-Path $PSScriptRoot 'Public'
$Functions = Get-ChildItem -Path $Path -Filter '*.ps1'
 
Foreach ($import in $Functions) {
    Try {
        Write-Verbose "dot-sourcing file '$($import.fullname)'"
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.name)"
    }
}
```

## Waiting for Commands to Complete
Some commands, like `Stop-Service` have the `-NoWait` switch. This switch tells the cmdlet to send the stop signal but do not wait for it to stop.

Other commands, such as `Invoke-WebRequest` do not have a no-wait option. In these cases you can use PowerShell jobs to get the wait functionality:

```powershell
Start-Job -ScriptBlock {
Invoke-WebRequest -Uri $UrlA -OutFile $FileA
}
Start-Job -ScriptBlock {
Invoke-WebRequest -Uri $UrlB -OutFile $FileB
}
Get-Job | Wait-Job
```
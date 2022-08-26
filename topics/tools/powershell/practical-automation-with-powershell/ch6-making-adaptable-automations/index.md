# Chapter 6 - Making Adaptable Automations

- [Chapter 6 - Making Adaptable Automations](#chapter-6---making-adaptable-automations)
  - [Waiting for Commands to Complete](#waiting-for-commands-to-complete)
  - [Disabling Windows Services](#disabling-windows-services)
  - [Building Data-Driven Functions](#building-data-driven-functions)
    - [Creating JSON for Registry Checks](#creating-json-for-registry-checks)
    - [Updating JSON with Registry Types](#updating-json-with-registry-types)
    - [Using Classes for Registry Checks](#using-classes-for-registry-checks)
  - [Installing Windows Features](#installing-windows-features)
  - [Updating Windows Firewall](#updating-windows-firewall)
  - [Creating a Server Config Class](#creating-a-server-config-class)
  - [Using Your Configuration Data](#using-your-configuration-data)

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

Use the `Receive-Job` cmdlet to get the return information.

## Disabling Windows Services
The following script takes in a list of services and sets the startup type to `Disabled`.  It then attempts to stop the service and records the resulting state. If there are any services that haven't been stopped in the predetermined amount of time, then an attempt is made to kill the process. If the script is unable to kill the process, then a reboot flag is noted.  Here's an example of the output:

![](img/2022-08-15-04-12-48.png)

**Disable-WindowsService**  
```powershell
Function Disable-WindowsService {
    [CmdletBinding()]
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Services,
        [Parameter(Mandatory = $true)]
        [int]$HardKillSeconds,
        [Parameter(Mandatory = $true)]
        [int]$SecondsToWait
    )

    [System.Collections.Generic.List[PSObject]] $ServiceStatus = @()
    foreach ($Name in $Services) {
        # Create a custom PowerShell object to track the status of each service
        $ServiceStatus.Add([pscustomobject]@{
            Service  = $Name
            HardKill = $false
            Status   = $null
            Startup  = $null
        })
        try {
            # Attempt to find the service, then disable and stop it
            $Get = @{
                Name        = $Name
                ErrorAction = 'Stop'
            }
            $Service = Get-Service @Get
            $Set = @{
                InputObject = $Service
                StartupType = 'Disabled'
            }
            Set-Service @Set
            $Stop = @{
                InputObject = $Service
                Force       = $true
                NoWait      = $true
                ErrorAction = 'SilentlyContinue'
            }
            Stop-Service @Stop
            Get-Service -Name $Name | ForEach-Object {
                $ServiceStatus[-1].Status = $_.Status.ToString()
                $ServiceStatus[-1].Startup = $_.StartType.ToString()
            }
        }
        catch {
            $msg = 'NoServiceFoundForGivenName,Microsoft.PowerShell' +
                '.Commands.GetServiceCommand'
            if ($_.FullyQualifiedErrorId -eq $msg) {
                # If the service doesn't exist, then there is nothing to stop, so consider that a success
                $ServiceStatus[-1].Status = 'Stopped'
            }
            else {
                Write-Error $_
            }
        }
    }

    $timer = [system.diagnostics.stopwatch]::StartNew()
    # Monitor the stopping of each service
    do {
        $ServiceStatus | Where-Object { $_.Status -ne 'Stopped' } | 
        ForEach-Object { 
            $_.Status = (Get-Service $_.Service).Status.ToString()
            
            # If any services have not stopped in the predetermined amount of time, kill the process.
            if ($_.HardKill -eq $false -and 
                $timer.Elapsed.TotalSeconds -gt $HardKillSeconds) {
                Write-Verbose "Attempting hard kill on $($_.Service)"
                $query = "SELECT * from Win32_Service WHERE name = '{0}'"
                $query = $query -f $_.Service
                $svcProcess = Get-CimInstance -Query $query
                $Process = @{
                    Id          = $svcProcess.ProcessId
                    Force       = $true
                    ErrorAction = 'SilentlyContinue'
                }
                Stop-Process @Process
                $_.HardKill = $true
            }
        }
        $Running = $ServiceStatus | Where-Object { $_.Status -ne 'Stopped' }
    } while ( $Running -and $timer.Elapsed.TotalSeconds -lt $SecondsToWait )
    # set reboot required if any services did not stop
    $ServiceStatus | 
        Where-Object { $_.Status -ne 'Stopped' } | 
        ForEach-Object { $_.Status = 'Reboot Required' }
    
    # return results
    $ServiceStatus
}
```

## Building Data-Driven Functions
The author provides an example of using registry checks to convert a PowerShell object into a JSON file. Use the JSON validator site at [jsonlint.com](https://jsonlint.com/) to validate JSON syntax.

### Creating JSON for Registry Checks
```powershell
[System.Collections.Generic.List[PSObject]] $JsonBuilder = @()
$JsonBuilder.Add(@{
    KeyPath =
    'HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters'
    Name    = 'EnableSecuritySignature'
    Tests   = @(
        @{operator = 'eq'; value = '1' }
    )
})
$JsonBuilder.Add(@{
    KeyPath =
    'HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\Security'
    Name    = 'MaxSize'
    Tests   = @(
        @{operator = 'ge'; value = '32768' }
    )
})
$JsonBuilder.Add(@{
    KeyPath =
    'HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters'
    Name    = 'AutoDisconnect'
    Tests   = @(
        @{operator = 'in'; value = '1..15' }
    )
})
$JsonBuilder.Add(@{
    KeyPath =
    'HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters'
    Name    = 'EnableForcedLogoff'
    Tests   = @(
        @{operator = 'eq'; value = '1' }
        @{operator = 'eq'; value = '$null' }
    )
})
 
$JsonBuilder |
    ConvertTo-Json -Depth 3 |
    Out-File .\RegistryChecks.json -Encoding UTF8
```

### Updating JSON with Registry Types
You can then use the code below to add custom fields to your data, in this case the `Type` and `Value` fields:  
![](img/2022-08-17-03-12-41.png)

This script adds new properties and exports the data structure into a new .json file.
```powershell
$checks = Get-Content .\RegistryChecks.json -Raw | 
    ConvertFrom-Json

# Use the Select-Object to add new properties to the object
$updated = $checks | 
    Select-Object -Property *, @{l='Type';e={'DWORD'}}, 
        @{l='Data';e={$_.Tests[0].Value}}

# Convert the updated object with the new properties back to JSON and export
ConvertTo-Json -InputObject $updated -Depth 3 | 
    Out-File -FilePath .\RegistryChecksAndResolves.json -Encoding utf8
```

### Using Classes for Registry Checks
Use classes when the script is expecting a specifically-formatted object. If you are creating classes from JSON, then you'll need a class for each nested JSON object.  

Here's an example on how to create a class for a nested JSON object:
```powershell
# Listing 6 - Registry Test Class
class RegistryTest {
    [string]$operator
    [string]$Value
    # Method to create a blank instance of this class
    RegistryTest(){
    }
    # Method to create an instance of this class populated with data from a generic PowerShell object
    RegistryTest(
        [object]$object
    ){
        $this.operator = $object.Operator
        $this.Value = $object.Value
    }
}
```
And here's how to use the nested class in the parent class. 
```powershell
# Listing 7 - Registry Check Class
class RegistryCheck {
    [string]$KeyPath
    [string]$Name
    [string]$Type
    [string]$Data
    [string]$SetValue
    [Boolean]$Success
    [RegistryTest[]]$Tests # Use of nested class
    # Method to create a blank instance of the parent class
    RegistryCheck(){
        $this.Tests += [RegistryTest]::new()
        $this.Success = $false
    }
    # Method to create an instance of this class populated with data from a generic PowerShell object
    RegistryCheck(
        [object]$object
    ){
        $this.KeyPath = $object.KeyPath
		$this.Name = $object.Name
		$this.Type = $object.Type
        $this.Data = $object.Data
        $this.Success = $false
        $this.SetValue = $object.SetValue

        $object.Tests | Foreach-Object {
            $this.Tests += [RegistryTest]::new($_)
        }
    }
}
```
The following code takes in a `RegistryCheck` object and performs a check on the registry value.
```powershell
Function Test-SecurityBaseline {
    [CmdletBinding()]
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)]
        [RegistryCheck]$Check
    )
    # Set the initial value of $Data to null
    $Data = $null
    if (-not (Test-Path -Path $Check.KeyPath)) {
        # If the path is not found, there is nothing to do because $Data is already set to null.
        Write-Verbose "Path not found"
    }
    else {
        # Get the keys that exist in the key path and confirm that the key you want is present.
        $SubKeys = Get-Item -LiteralPath $Check.KeyPath
        if ($SubKeys.Property -notcontains $Check.Name) {
            # If the key is not found, there is nothing to do because $Data is already set to null.
            Write-Verbose "Name not found"
        }
        else {
            try {
                # If the key is found, get the value and update the $Data variable with the value.
                $ItemProperty = @{
                    Path = $Check.KeyPath
                    Name = $Check.Name
                }
                $Data = Get-ItemProperty @ItemProperty | 
                    Select-Object -ExpandProperty $Check.Name
            }
            catch {
                $Data = $null
            }
        }
    }
    
    # Run through each test for this registry key.
    foreach ($test in $Check.Tests) {
        # Build the string to create the If statement to test the value of the $Data variable.
        $filter = 'if($Data -{0} {1}){{$true}}'
        $filter = $filter -f $test.operator, $test.Value
        Write-Verbose $filter
        if (Invoke-Expression $filter) {
            # If the statement returns true, you know a test passed, so update the Success property.
            $Check.Success = $true
        }
    }
    
    # Add the value of the key for your records and debugging
    $Check.SetValue = $Data
    $Check
}
```

If the registry check fails, then the following function will create the required key/value pair:

```powershell
Function Set-SecurityBaseline{
    [CmdletBinding()]
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)]
        [RegistryCheck]$Check
    )
    # Create the registry key path if it does not exist
    if(-not (Test-Path -Path $Check.KeyPath)){
        New-Item -Path $Check.KeyPath -Force -ErrorAction Stop
    }
        
    # Create or Update the registry key with the predetermined value
    $ItemProperty = @{
        Path         = $Check.KeyPath
        Name         = $Check.Name
        Value        = $Check.Data
        PropertyType = $Check.Type
        Force        = $true
        ErrorAction  = 'Continue'
    }
    New-ItemProperty @ItemProperty
}
```

## Installing Windows Features
The next example shows how you can submit a string array to install Windows Features. A couple of things to note:
- The use of `System.Collections.Generic.List[PSObject]`.  Per [here](https://gist.github.com/kevinblumenfeld/4a698dbc90272a336ed9367b11d91f1c), it's recommended to use a generic list when you know the type of the elements but not the size of the collection.
- The use of a custom property `@{l='Name'; e={$Name}}`. This is because 'Install-WindowsFeature' doesn't return the Name property.
```powershell
Function Install-RequiredFeatures {
    [CmdletBinding()]
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Features
    )
    [System.Collections.Generic.List[PSObject]] $FeatureInstalls = @()
    foreach ($Name in $Features) {
        Install-WindowsFeature -Name $Name -ErrorAction SilentlyContinue |
            Select-Object -Property @{l='Name';e={$Name}}, * |
            ForEach-Object{ $FeatureInstalls.Add($_) }
    }
 
    $FeatureInstalls
}
```
## Updating Windows Firewall
The next example shows how you can configure Windows firewall to (1) enable for all profiles, (2) block inbound traffic on the Public profile and (3) set up logging. 
```powershell
Function Set-FirewallDefaults {
    [CmdletBinding()]
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)]
        [UInt64]$LogSize
    )
    # Create a custom object to record and output the results of the commands.
    $FirewallSettings = [pscustomobject]@{
        Enabled       = $false
        PublicBlocked = $false
        LogFileSet    = $false
        Errors        = $null
    }

    try {
        # Enable all firewall profiles
        $NetFirewallProfile = @{
            Profile     = 'Domain', 'Public', 'Private'
            Enabled     = 'True'
            ErrorAction = 'Stop'
        }
        Set-NetFirewallProfile @NetFirewallProfile
        $FirewallSettings.Enabled = $true
        
        # Block all inbound public traffic
        $NetFirewallProfile = @{
            Name                 = 'Public'
            DefaultInboundAction = 'Block'
            ErrorAction          = 'Stop'
        }
        Set-NetFirewallProfile @NetFirewallProfile
        $FirewallSettings.PublicBlocked = $true

        $log = '%windir%\system32\logfiles\firewall\pfirewall.log'
        # Set the firewall log settings, including the size.
        $NetFirewallProfile = @{
            Name                 = 'Domain', 'Public', 'Private'
            LogFileName          = $log
            LogBlocked           = 'True'
            LogMaxSizeKilobytes  = $LogSize
            ErrorAction          = 'Stop'
        }
        Set-NetFirewallProfile @NetFirewallProfile
        $FirewallSettings.LogFileSet = $true
    }
    catch {
      $_
    }

    $FirewallSettings
}
```

## Creating a Server Config Class
The following code is used to create a server config class.  This class definition would typically be stored in the module (.psm1) file.

```powershell
class ServerConfig {
    [string[]]$Features
    [string[]]$Services
    [RegistryCheck[]]$SecurityBaseline
	[UInt64]$FirewallLogSize
    # Method to create a blank instance of this class
    ServerConfig(){
        $this.SecurityBaseline += [RegistryCheck]::new()
    }
    # Method to create an instance of this class populated with data from a generic PowerShell object
    ServerConfig(
        [object]$object
    ){
        $this.Features = $object.Features
        $this.Services = $object.Services
        $this.FirewallLogSize = $object.FirewallLogSize
        $object.SecurityBaseline | Foreach-Object {
            $this.SecurityBaseline += [RegistryCheck]::new($_)
        }
    }
}
```

An advantage of using classes is they enable to create your configuration JSON.  For example, you can add a function `New-ServerConfig` that creates a blank instance of the `ServerConfig` class:

```powershell
Function New-ServerConfig{
    [ServerConfig]::new()
}
```

Then you can use `ConvertTo-Json` from the `New-ServerConfig` function to generate a JSON template:

```powershell
Import-Module .\PoshAutomate-ServerConfig.psd1 -Force
New-ServerConfig | ConvertTo-Json -Depth 4
```
Here's the JSON output:
```json
{
    "Features": null,
    "Service": null,
    "SecurityBaseline": [
        {
            "KeyPath": null,
            "Name": null,
            "Type": null,
            "Data": null,
            "SetValue": null,
            "Tests": [
                {
                    "operator": null,
                    "Value": null
                }
            ]
        }
    ],
    "FirewallLogSize": 0
}
```

## Using Your Configuration Data
The following function

```powershell
Function Set-ServerConfig {
    [CmdletBinding()]
    [OutputType([object])]
    param(
        [Parameter(Mandatory = $true)]
        [object]$ConfigJson,
        [Parameter(Mandatory = $true)]
        [object]$LogFile
    )
    # Import the configuration data from the JSON file
    $JsonObject = Get-Content $ConfigJson -Raw | 
        ConvertFrom-Json
    # Convert the JSON data to the class you defined
    $Config = [ServerConfig]::new($JsonObject)

    # A small function to ensure consistent logs are written for an activity starting
    Function Write-StartLog {
        param(
            $Message
        )
        "`n$('#' * 50)`n# $($Message)`n" | Out-File $LogFile -Append
        Write-Host $Message
    }

    # A small function to ensure consistent logs are written for an activity completing
    Function Write-OutputLog {
        param(
            $Object
        )
        $output = $Object | Format-Table | Out-String
        if ([string]::IsNullOrEmpty($output)) {
            $output = 'No data'
        }
        "$($output.Trim())`n$('#' * 50)" | Out-File $LogFile -Append
        Write-Host $output
    }
    $msg = "Start Server Setup - $(Get-Date)`nFrom JSON $($ConfigJson)"
    Write-StartLog -Message $msg

    # Set Windows Features first
    Write-StartLog -Message "Set Features"
    $Features = Install-RequiredFeatures -Features $Config.Features
    Write-OutputLog -Object $Features

    # Set the services
    Write-StartLog -Message "Set Services"
    $WindowsService = @{
        Services        = $Config.Services
        HardKillSeconds = 60
        SecondsToWait   = 90
    }
    $Services = Disable-WindowsService @WindowsService
    Write-OutputLog -Object $Services
    
    Write-StartLog -Message "Set Security Baseline"
    # Check each registry key in the Security baseline
    foreach ($sbl in $Config.SecurityBaseline) {
        $sbl = Test-SecurityBaseline $sbl
    }

    # Fix any that did not pass the test
    foreach ($sbl in $Config.SecurityBaseline | 
        Where-Object { $_.Success -ne $true }) {
        Set-SecurityBaseline $sbl
        $sbl = Test-SecurityBaseline $sbl
    }
    $SecLog = $SecBaseline | 
        Select-Object -Property KeyPath, Name, Data, Result, SetValue
    Write-OutputLog -Object $SecLog

    # Set the firewall
    Write-StartLog -Message "Set Firewall"
    $Firewall = Set-FirewallDefaults -LogSize $Config.FirewallLogSize
    Write-OutputLog -Object $Firewall

    Write-Host "Server configuration is complete."
    Write-Host "All logs written to $($LogFile)"
}
```

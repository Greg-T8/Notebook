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

# Listing 7 - Registry Check Class
class RegistryCheck {
    [string]$KeyPath
	[string]$Name
	[string]$Type
    [string]$Data
    [string]$SetValue
    [Boolean]$Success
    [RegistryTest[]]$Tests
    # Method to create a blank instance of this class
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

# Listing 12 - Server Config Class
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

# Listing 13 - New-ServerConfig
Function New-ServerConfig{
    [ServerConfig]::new()
}

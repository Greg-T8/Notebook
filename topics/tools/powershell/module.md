# Creating and Using PowerShell Modules
Run the following script to create a blank PowerShell module: [CreatePowerShellModule.ps1](scripts/CreatePowerShellModule.ps1).

Then add the following code to the resulting `.psm1` file to automatically import functions from the Public folder:

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

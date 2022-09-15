# Listing 4 - PoshAssetMgmt.psm1
$_PoshAssetMgmt = [pscustomobject]@{
    SqlInstance  = "$($env:COMPUTERNAME)\SQLEXPRESS"
    Database     = 'PoshAssetMgmt'
    ServerTable  = 'Servers'
}
 
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
 
[System.Collections.Generic.List[PSObject]]$RequiredModules = @()
$RequiredModules.Add([pscustomobject]@{
    Name = 'dbatools'
    Version = '1.1.5'
})
 
foreach($module in $RequiredModules){
    $Check = Get-Module $module.Name -ListAvailable
 
    if(-not $check){
        throw "Module $($module.Name) not found"
    }
 
    $VersionCheck = $Check |
        Where-Object{ $_.Version -ge $module.Version }
 
    if(-not $VersionCheck){
        Write-Error "Module $($module.Name) running older version"
    }
 
    Import-Module -Name $module.Name
}
# Unit Testing with PowerShell

The simplest case...

```powershell
function Set-TextFile {
    Set-Content -Path "$PSScriptRoot\TextFile.txt" -Value 'Hello, World!'
}

Describe "Set-TextFile" {
    It "writes 'Hello, World!' to TextFile.txt" {

        # Call function
        Set-TextFile

        # Assert test result
        Get-Content -Path "$PSScriptRoot\TextFile.txt" | Should -Be "Hello, World!"
    }
}
```

Output: 

<img src='img/20240247-044707.png' width=500px>


Generalizing the function...

```powershell
function Set-TextFile {
    param(
        $Path,
        $Message
    )
    Set-Content -Path $Path -Value $Message
}

Describe "Set-TextFile" {
    It "writes a message' to a text file" {
        # Arrange test data
        $message = 'Hello, World!'
        $path = "$PSScriptRoot\TextFile.txt"

        # Call function
        Set-TextFile -Path $path -Message $message

        # Assert test result
        Get-Content -Path $path | Should -Be $message
    }
}
```

Output: 

<img src='img/20240258-045814.png' width=500px>


Converting to functional programming...

```powershell
function Set-TextFile {
    param(
        $Path,
        $Message,
        [scriptblock]$SetContent = ${function:SetActualContent}
    )
    & $SetContent -Path $Path -Message $Message
}

function SetActualContent {
    param(
        $Path,
        $Message
    )
    Set-Content -Path $Path -Value $Message
}

Describe "Set-TextFile" {
    It "writes a message' to a text file" {
        # Arrange test data
        $message = 'Hello, World!'
        $path = "$PSScriptRoot\TextFile.txt"
        $setTestContent = { Write-Host "Writing $message to $path." }

        # Call function
        Set-TextFile -Path $path -Message $message -SetContent $setTestContent

        # Assert test result
    }
}
```


## For later

When developming PowerShell modules for use with a CI/CD pipeline, you need tools that facilitate the buiding and publishing of PowerShell modules.

The `PowerShellGet` module has tools that ena

e the `PowerShellGet` module to demonstrate the development of unit tests. When developing modules for use with a CI/CD pipeline, 

The `PowerShellGet` module is an interesting test case

The `PowerShellGet` module has commands, like `Install-Module` that make it easy to search for and install PowerShell modules. The 1.0-version of this module is installed by default in Windows. Later versions introduce additional functionality, such as `Update-ModuleManifest`, that cater to developing and publishing your own PowerShell module.

Example of a script that installs the latest version of the `PowerShellGet` module.

```powershell
# VerifyPowerShellGet.ps1
function VerifyPowerShellGet {
    [OutputType()]
    $minimumVersion = '2.2.5'
    $updateRequired = $true
    $installedVersion = Get-Module -Name PowerShellGet -ListAvailable |
        Sort-Object -Property Version -Descending |
        Select-Object -ExpandProperty Version |
        Select-Object -First 1
    if ($installedVersion -ge $minimumVersion) {
        Write-Information "PowerShellGet version is $installedVersion. No update required"
        $updateRequired = $false
    }
    if ($updateRequired) {
        Write-Information "PowerShellGet version is $installedVersion. Updating to version $minimumVersion..."
        $minimumVersion
        $installModuleSplat = @{
            Name               = 'PowerShellGet'
            Scope              = 'CurrentUser'
            Force              = $true
            AllowClobber       = $true
            SkipPublisherCheck = $true
            RequiredVersion    = $minimumVersion
        }
        Install-Module @installModuleSplat
        Write-Information "PowerShellGet updated to version $minimumVersion"
    }
}
```

Some things to note about this code: 

- The script uses `Get-Module`, which looks for the `PowerShellGet` module
- The scritp may call `Install-Module` to install the latest version of `VerifyPowerShellGet`




Here's a unit test for `VerifyPowerShellGet`:

```powershell
# VerifyPowerShellGet.ps1
BeforeAll {
    . $PSCommandPath.Replace(".Tests.ps1", ".ps1")
}

Describe "Verify PowerShellGet" {
    It 'Installs the required version of PowerShellGet if not already installed' {
        Mock Get-Module -ParameterFilter { $Name -eq 'PowerShellGet' } -MockWith {
            [PSCustomObject]@{ Name = 'PowerShellGet'; Version = '2.0.0' }
        }
        Mock Install-Module

        $result = VerifyPowerShellGet

        Should -Invoke -CommandName 'Install-Module' -Times 1
    }
}
```

Output: 

<img src='img/20240255-045504.png' width=600px>

Some concern items about this test:

- The unit test is difficult to understand due to excessive use of Mocks
- There's no result of the function, i.e. no output to confirm the function results
- The only way to verify the result is to assert that `Install-Module` was called

The excessive use of Mocks becomes apparent when a PowerShell function makes many separate calls to out-of-process dependencies. Examples of out-of-process dependencies are calls to external resources, e.g. the file system, cloud services, etc. The more make calls to out-of-process dependencies, the slower the unit tests become, and the more we have to wait for the results.  

The last bullet point is most concerning because what if someone changed `Install-Module` to `Update-Module`?  The result of the test would then fail since `Install-Module` was never called.

Let's see how we can make this better...

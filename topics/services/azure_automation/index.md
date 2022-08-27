# Notes on Azure Automation
Helpful Links
- https://github.com/azureautomation
- https://docs.microsoft.com/en-us/powershell/module/az.automation/?view=azps-8.2.0
- 

## PowerShell Usage
Use the module `Az.Automation`.  Here are some example commands and their output.

### Get-AzAutomationAccount
```powershell
Get-AzAutomationAccount
```
Output:  
![](img/2022-08-27-05-30-05.png)

### Get-AzAutomationConnection
This command retrieves RunAs accounts.
```powershell
Get-AzAutomationConnection -AutomationAccountName <name> -ResourceGroupName <name>
```
Output:  
![](img/2022-08-27-05-45-27.png)


## Miscellaneous Notes
When using the Azure AD module, you need to create a RunAs account.  The RunAs account is tied to a service principal.  This principal needs a role Azure AD to do its business.

Use the following commands to assign a role.

```powershell
# Get the service principal
$servicePrincipal = @{
  $ObjectId = 'Object Id of service principal'
}
$runAsSevicePrincipal = Get-AzureADServicePrincipal @servicePrincipal

# Add the Service Principal to the Directory Readers Role
Add-AzureADDirectoryRoleMember -ObjectId (Get-AzureADDirectoryRole | where-object {$_.DisplayName -eq "Directory Readers"}).Objectid -RefObjectId $runAsServicePrincipal.ObjectId

# Add the Service Principal to the User Administrator Role
Add-AzureADDirectoryRoleMember -ObjectId (Get-AzureADDirectoryRole | where-object {$_.DisplayName -eq "User Account Administrator"}).Objectid -RefObjectId $aaAadUser.ObjectId

# Add the Service Principal to the Global Administrator Role
Add-AzureADDirectoryRoleMember -ObjectId (Get-AzureADDirectoryRole | where-object {$_.DisplayName -eq "Company Administrator"}).Objectid -RefObjectId $runAsServicePrincipal.ObjectId
```
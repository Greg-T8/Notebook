# Notes on Azure Automation

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
# Source Control Integration for Azure Automation
Links:
- [Use Source Control Integration](https://docs.microsoft.com/en-us/azure/automation/source-control-integration)
- [Managed Identities](https://docs.microsoft.com/en-us/azure/automation/automation-security-overview#managed-identities)
- 

## Walkthrough for Azure DevOps (Git) using PowerShell

### Prerequisites
- A source control repository (GitHub or Azure DevOps)
- A system-assigned or user-assigned managed identity
- Managed identity must have the Contributor role in the Automation account

Quick note on Managed identities
- They are the recommended method for authenticating in runbooks
- Don't require you to provision or rotate any secrets
- Don't have to specify Run As connection object in your code
- Two types:
  - **System-assigned identity**: tied to the application and is deleted if the app is deleted
  - **User-assigned identity**: a standalone Azure resource that can be assigned to your app. Supported for cloud jobs only.

Use `Get-AzAutomationAccount` to confirm enablement of the managed identity:  
![](img/2022-08-27-06-35-49.png)

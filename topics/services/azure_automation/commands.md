## Azure Automation Command Usage
Use the module `Az.Automation`.  Here are some example commands and their output.

### Get-AzAutomationAccount
```powershell
Get-AzAutomationAccount
```
![](img/2022-08-27-05-30-05.png)

### Get-AzAutomationConnection
This command retrieves RunAs accounts.
```powershell
Get-AzAutomationConnection -AutomationAccountName <name> -ResourceGroupName <name>
```
![](img/2022-08-27-05-45-27.png)

### Get-AzAutomationCertificate
```powershell
Get-AzAutomationCertificate -AutomationAccountName <name> -ResourceGroupName <name>
```
![](img/2022-08-27-05-52-15.png)

### Get-AzAutomationModule
```powershell
Get-AzAutomationModule -AutomationAccountName <name> -ResourceGroupName <name>
```
![](img/2022-08-27-05-54-50.png)

### Get-AzAutomationRegistrationInfo
This command retrieves the endpoint URL and keys.  This information is used to register the hybrid runbook worker.
```powershell
Get-AzAutomationRegistrationInfo -AutomationAccountName <name> -ResourceGroupName <name>
```
![](img/2022-08-27-06-00-45.png)

### Get-AzAutomationRunbook
```powershell
Get-AzAutomationRunbook -AutomationAccountName <name> -ResourceGroupName <name>
```
![](img/2022-08-27-06-02-40.png)

# Microsoft Purview Notes

- [Purview Roles and Permissions](#purview-roles-and-permissions)
  - [Helpful Links](#helpful-links)
  - [Permissions Overview](#permissions-overview)
  - [The Organization Management Role Group](#the-organization-management-role-group)
  - [Azure AD Roles vs Microsoft Purview Role Groups](#azure-ad-roles-vs-microsoft-purview-role-groups)
  - [The Compliance Administrator](#the-compliance-administrator)
  - [The Compliance Data Administrator](#the-compliance-data-administrator)
  - [Use PowerShell to Manage Purview Permissions](#use-powershell-to-manage-purview-permissions)
    - [Get Role Group Details](#get-role-group-details)
    - [Get Role Details](#get-role-details)
    - [Compare Role Assignments in Role Groups](#compare-role-assignments-in-role-groups)
    - [Audit Membership for all Microsoft Purview Role Groups](#audit-membership-for-all-microsoft-purview-role-groups)
    - [Audit Membership for Specific Users](#audit-membership-for-specific-users)
    - [Manage Role Membership](#manage-role-membership)
    - [Remove a Set of Users from all Role Groups](#remove-a-set-of-users-from-all-role-groups)
- [Sensitivity Labels](#sensitivity-labels)
  - [Helpful Links](#helpful-links-1)
  - [Roles and Permissions](#roles-and-permissions)
  - [Licensing for Sensitivity Labels](#licensing-for-sensitivity-labels)
  - [Overview](#overview)
    - [Labels, Sublabels, and Label Scopes](#labels-sublabels-and-label-scopes)
    - [Container Support for Sensitivity Labels](#container-support-for-sensitivity-labels)
    - [Define and Create Sensitivity Labels](#define-and-create-sensitivity-labels)
    - [Editing or Deleting a Sensitivity Label](#editing-or-deleting-a-sensitivity-label)
    - [Markings for Sensitivity Labels](#markings-for-sensitivity-labels)
    - [Built-in Labeling for the Office Apps](#built-in-labeling-for-the-office-apps)
    - [Label Taxonomy](#label-taxonomy)
  - [Automatically Applying Sensitivity Labels](#automatically-applying-sensitivity-labels)
    - [Client-side Labeling](#client-side-labeling)
    - [Service-side Auto Labeling](#service-side-auto-labeling)
  - [Detect Sensitive Information Type and Trainable Classifier Matches](#detect-sensitive-information-type-and-trainable-classifier-matches)
  - [Label Override Behavior](#label-override-behavior)
  - [Protecting SharePoint Sites, Teams, and Groups with Sensitivity Labels](#protecting-sharepoint-sites-teams-and-groups-with-sensitivity-labels)
    - [Enable sensitivity label support for groups in PowerShell](#enable-sensitivity-label-support-for-groups-in-powershell)
    - [Synchronize sensitivity labels with Azure AD](#synchronize-sensitivity-labels-with-azure-ad)
  - [Enable PDF Support](#enable-pdf-support)
    - [Support for PDF Attachments in Message Encryption](#support-for-pdf-attachments-in-message-encryption)
  - [Protecting On-Premises Data](#protecting-on-premises-data)
    - [Installing the Scanner](#installing-the-scanner)
    - [Configuring the Scanner](#configuring-the-scanner)
    - [Scanning Scenarios](#scanning-scenarios)
    - [Scanner Offline Mode](#scanner-offline-mode)
    - [Operating the Scanner](#operating-the-scanner)
    - [Troubleshooting the Scanner](#troubleshooting-the-scanner)
    - [Recycle the Scanner Service](#recycle-the-scanner-service)
  - [External Access](#external-access)
    - [Azure RMS for Individuals](#azure-rms-for-individuals)
    - [Addressing MFA Requirements for External Users](#addressing-mfa-requirements-for-external-users)
  - [Application Support for Accessing Protected Documents](#application-support-for-accessing-protected-documents)
    - [Manage Protected Document Attributes](#manage-protected-document-attributes)
    - [RMS Issuer and RMS Owner](#rms-issuer-and-rms-owner)
    - [Determine The Owner of a Protected Document](#determine-the-owner-of-a-protected-document)
    - [Change the Owner of a Protected Document](#change-the-owner-of-a-protected-document)
    - [Remove Protection from a Document](#remove-protection-from-a-document)
    - [Remove Encryption from a Document in SharePoint Online](#remove-encryption-from-a-document-in-sharepoint-online)
  - [Manage the Azure Information Protection Service](#manage-the-azure-information-protection-service)
  - [Track and Revoke Documents](#track-and-revoke-documents)
    - [Track Document Access](#track-document-access)
    - [Revoke Document Access](#revoke-document-access)
  - [Audit Label Access and Usage](#audit-label-access-and-usage)
    - [Activity Explorer](#activity-explorer)
    - [Auditing Framework](#auditing-framework)
    - [Search-UnifiedAuditLog Cmdlet](#search-unifiedauditlog-cmdlet)
  - [Use PowerShell to Manage Sensitivity Labels and RMS Templates](#use-powershell-to-manage-sensitivity-labels-and-rms-templates)
    - [AIPService PowerShell module](#aipservice-powershell-module)
    - [Get Info on Sensitivity Labels and Policies](#get-info-on-sensitivity-labels-and-policies)
    - [Create a Sensitivity Label](#create-a-sensitivity-label)
    - [Use a Custom Color for a Sensitivity Label](#use-a-custom-color-for-a-sensitivity-label)
    - [Create a Label Policy](#create-a-label-policy)
    - [Add a Sensitivity Label to a Label Policy](#add-a-sensitivity-label-to-a-label-policy)
    - [Set the Parent Label for a Sensitivity Label](#set-the-parent-label-for-a-sensitivity-label)
    - [Remove a Sensitivity Label from a Label Policy](#remove-a-sensitivity-label-from-a-label-policy)
    - [Remove a Label Policy](#remove-a-label-policy)
    - [Remove a Sensitivity Label](#remove-a-sensitivity-label)
    - [Get the Relationship Between a Label and an Azure RMS Template](#get-the-relationship-between-a-label-and-an-azure-rms-template)
    - [Back Up an Azure RMS Template](#back-up-an-azure-rms-template)
    - [Remove an RMS Template](#remove-an-rms-template)
    - [Restore an RMS Template](#restore-an-rms-template)

## Purview Roles and Permissions

### Helpful Links

- [Permissions in the Microsoft Purview compliance portal](https://learn.microsoft.com/en-us/microsoft-365/compliance/microsoft-365-compliance-center-permissions?view=o365-worldwide)
- [Roles and role groups in Microsoft Defender for Office 365 and Microsoft Purview compliance](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/scc-permissions?toc=%2Fmicrosoft-365%2Fcompliance%2Ftoc.json&bc=%2Fmicrosoft-365%2Fbreadcrumb%2Ftoc.json&view=o365-worldwide)

### Permissions Overview

The Microsoft Purview compliance portal has a **Permissions** tab you may use for assigning permissions. Permissions in the compliance portal are based on role-based access control (RBAC) permissions model. 

The RBAC model is similar to the one used with Exchange Online. But it's important to remember that the role groups in Exchange Online and role groups for Defender for Office 365 or Purview compliance don't share membership or permissions. For example, while an Organization Management role group exists in Exchange Online, the permissions granted and role group members are different than the Organization Management role group in Defender for Office 365 and Purview compliance. 

There are several concepts for the RBAC model:

- Role: grants permissions to do a set of tasks
- Role Group: a set of roles that enable users to do their jobs across compliance solutions in the compliance portal

You add users to role groups. Role groups contain multiple roles, with each role having a set of permissions.  

<img src='./img/20230549-034923.png' width=300px>

You can create new role groups but you cannot create new roles. To make things confusing, there are roles with the same name as role groups.  For example, the Security Administrator role group contains the Security Administrator role, among other roles. To make things even more confusing, there are role groups with the same name as Azure AD roles, e.g. "Compliance Administrator". Membership in the Azure AD role does not carry over to membership in the Purview compliance role group&mdash;they are completely separate.

The **Permissions** tab lists role groups. To view the Permissions tab, you need to be an admin. Specifically, you need to be assigned the **Role Management** role, and that role is assigned only to the **Organization Management** role group by default. The **Role Management** role also allows you to view, create, and modify role groups. 

<img src='./img/20230546-034659.png' width=500px>

You may view the corresponding Azure AD roles and Microsoft Purview compliance role groups in the permissions tab.  Again, these are completely separate groups, even though some groups carry the same name.  
 
<img src='./img/20230550-055029.png' width=600px>

See [Role groups in Microsoft Defender for Office 365 and Microsoft Purview compliance](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/scc-permissions?toc=%2Fmicrosoft-365%2Fcompliance%2Ftoc.json&bc=%2Fmicrosoft-365%2Fbreadcrumb%2Ftoc.json&view=o365-worldwide#role-groups-in-microsoft-defender-for-office-365-and-microsoft-purview-compliance) for a table that lists the role groups along with their roles.

See [Roles in Microsoft Defender for Office 365 and Microsoft Purview compliance](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/scc-permissions?toc=%2Fmicrosoft-365%2Fcompliance%2Ftoc.json&bc=%2Fmicrosoft-365%2Fbreadcrumb%2Ftoc.json&view=o365-worldwide#roles-in-microsoft-defender-for-office-365-and-microsoft-purview-compliance) for a table that lists the available roles and the role groups they're assigned to by default.

### The Organization Management Role Group

The Organization Management role group is the most powerful role group in Purview compliance. It has the highest count of assigned roles (38) and is the only role group which grants the ability to assign roles in Purview compliance.  Azure AD Global Admins are automatically added to the Organization Management role group, but you won't see them in the output of the `Get-RoleGroupMember` cmdlet.

The Organization Management role group has access to all areas in Microsoft Purview. However, it does not have access to all roles. Here are the following notable roles the Organization Management group **does not** have access to:  

- Export - Lets people export the mailbox and site content that was returned from a search.
- Preview - Lets people view a list of items that were returned from a content search. They'll also be able to open each item from the list to view its contents.
- RMS Decrypt - Lets people decrypt RMS-protected content when exporting search results.
- Data Classification List Viewer - Allow viewing list of files in content explorer.
- Data Classification Content Viewer - Allow viewing in-place rendering of files in content explorer.

**Note:** An Azure AD Global Admin can access and view items in Content Explorer while a person explicitly assigned to the Microsoft Purview Organization Management role group cannot.

### Azure AD Roles vs Microsoft Purview Role Groups

Azure AD and Microsoft Purview have the following similarly-named roles:

- Compliance Administrator
- Compliance Data Administrator
- Security Administrator
- Security Operator
- Security Reader
- Azure Information Protection Administrator (Azure AD)
- Information Protection (Purview)
- Information Protection Admins (Purview)

For the most part, these roles have overlapping permission sets but there are some notable differences. The main difference is upon assignment. In Azure AD, permissions assignment takes effect immediately after the next browser restart. In Microsoft Purview, permissions assignment may take 5-15 minutes and also requires a browser restart. You must take this delay into consideration when using PIM to activate roles with Microsoft Purview role groups.

### The Compliance Administrator

The Compliance Administrator has access to the following areas in Microsoft Purview:

- Compliance Manager
- Data Classification > Classifiers
- Data Classification > Content Explorer (cannot list or view content) *
- Data Classification > Activity Explorer *
- Data Connectors
- Alerts, Policies, Roles & Scopes > Adaptive Scopes *
- Solutions
  - Content Search
  - Communication Compliance
  - Data Loss Prevention *
  - eDiscovery
  - Data Lifecycle Management > Microsoft 365 * 
  - Data Lifecycle Management > Exchange (legacy) ** 
  - Information Protection * 
  - Information Barriers > Segments * 
  - Insider Risk Management
  - Records Management * 
  - Privacy Risk Management

&nbsp; * Applies only for the Microsoft Purview Compliance Administrator role group
<br>
&nbsp; ** Applies only for the Azure AD Compliance Administrator role

From above, the Microsoft Purview Compliance Administrator role group has access to more features than the Azure AD Compliance Administrator role. 

The Compliance Administrator does not have access to the following areas in Microsoft Purview: 

- Data Classification > Content Explorer (list and view content)
- Roles & Scopes > Permissions
- Solutions
  - Audit

Additionally, the Compliance Administrator does not have access to the following Microsoft Purview roles (note, not role groups):

- Search and Purge - Lets people bulk-remove data that matches the criteria of a content search.
- Export - Lets people export the mailbox and site content that was returned from a search.
- RMS Decrypt - Lets people decrypt RMS-protected content when exporting search results.
- Data Classification List Viewer - Allow viewing list of files in content explorer.
- Data Classification Content Viewer - Allow viewing in-place rendering of files in content explorer.

The list above is not exhaustive and only includes roles that I consider notable. 

### The Compliance Data Administrator

Like the Compliance Administrator, Azure AD and Microsoft Purview have similarly-named roles for the Compliance Data Administrator. The Compliance Data Administrator has access to most features that the Compliance Administrator has access to except for eDiscovery, Communication Compliance, and Insider Risk Management.

The Compliance Data Administrator has access to the following areas:

- Compliance Manager
- Data Classification > Classifiers
- Data Classification > Content Explorer (cannot list or view content)
- Data Classification > Activity Explorer
- Data Connectors (view only)
- Alerts, Policies, Roles & Scopes > Adaptive Scopes
- Solutions
  - Content Search
  - Data Loss Prevention
  - Data Lifecycle Management > Microsoft 365
  - Information Protection
  - Information Barriers
  - Records Management
  - Privacy Risk Management
  - Subject Rights Request

The Compliance Data Administrator does not have access to the following areas

- Roles & Scopes > Permissions
- Solutions
  - Audit
  - Communication Compliance
  - eDiscovery
  - Data Lifecycle Management > Exchange (Legacy)
  - Insider Risk Management

Additionally, the Compliance Data Administrator does not have access to the following Microsoft Purview roles that the Compliance Administrator role group has access to:

- Case Management - Lets people create, edit, delete, and control access to eDiscovery cases.
- Communication Compliance Admin - Used to manage policies in Communication Compliance feature.
- Communication Compliance Case Admin - Used to access Communication Compliance case.
- Data Classification Feedback Provider - Allow providing feedback to classifiers in content explorer.
- Data Classification Feedback Reviewer - Allow reviewing feedback to classifiers in feedback explorer.
- Data Connector Admin - Used to create and manage connectors to import and archive non-Microsoft data in Microsoft 365
- Data Investigation Management - Lets people create, edit, delete, and control access to data investigation.
- Hold - Lets people place content in mailboxes, sites, and public folders on hold. When on hold, a copy of the content is stored in a secure location. Content owners will still be able to modify or delete the original content.
- Insider Risk Management Admin - Lets people create, edit, delete, and control access to Insider Risk Management feature.

### Use PowerShell to Manage Purview Permissions

View all role-based commands in Microsoft Purview.  Requires either Azure AD Global Admin or Microsoft Purview Organization Management. 

```powershell
Get-Command -Module tmp* -Noun *role*
```

<img src='./img/20230556-055635.png' width=500px>

**Note:** Unlike many other parameters in PowerShell, the `-Identity` parameter in the cmdlets for managing role groups is case sensitive. You will get an error if you specify the wrong case:  

<img src='./img/20230526-042652.png' width=600px>

#### Get Role Group Details

Use the following PowerShell command to pull role group information, including a list of roles assigned to each role group:  

```powershell
Get-RoleGroup |
  Select Name,
      @{n='RoleCount';e={($_ | Select -ExpandProperty roles).count}},
      @{n='Roles'; e={ ($_ | Select -ExpandProperty roles) -replace '.*/', '' -join "`n" }} |
  Sort RoleCount -Descending | ft -wrap
```

<img src='./img/20230516-031652.png' width=500px>

#### Get Role Details

Use the following PowerShell command to pull role information. In PowerShell, a role is called a *management role*. 

```powershell
Get-ManagementRole | select Name, Description | sort Name
```

Use the following command to list all management roles in a specified role group:  

```powershell
function Get-PvManagementRole {
    param(
        [string]$RoleGroup
    )
    Write-Output (Get-RoleGroup) |
        ? DisplayName -eq "$RoleGroup" |
        Select -ExpandProperty roles |
        % { $_ -replace ".*/",'' } |
        % { Get-ManagementRole -Identity $_ } |
        Select Name, Description | Sort Name
}
```

<img src='./img/20230558-045824.png' width=600px>

Use the following command to list all role groups that contain the specified management role:

```powershell
function Get-PvRoleGroup {
    param(
        [string[]]$ManagementRole
    )
    Write-Output (Get-RoleGroup) -PipelineVariable roleGroup |
        Select -ExpandProperty roles |
        % { $_ -replace ".*/",'' } -PipelineVariable role |
        ? { $_ -in $ManagementRole } |
        Select @{n='Role'; e={$role}}, @{n='RoleGroup';e={$roleGroup.DisplayName}}
}
```

<img src='./img/20230503-050342.png' width=400px>

#### Compare Role Assignments in Role Groups

Use the following commands to compare role assignments between role groups.

```powershell
$allmanagementRoles = Get-ManagementRole | Select -ExpandProperty Name
$orgMgmtRoles = Get-RoleGroup -Identity 'OrganizationManagement' | select -ExpandProperty roles | % {$_ -replace ".*/", ""}
Compare-Object $allManagementRoles $orgMgmtRoles | Sort InputObject
```

For the example above, the results below show all roles which the Organization Management role group does not have.  

<img src='./img/20230534-033453.png' width=400px>

Let's say you want to compare role assignments between the following two role groups - Compliance Administrator and Compliance Data Administrator.  You can use the following approach:  

```powershell
$complianceAdministratorRoles = Get-RoleGroup -Identity 'ComplianceAdministrator' |
   Select -ExpandProperty Roles |
   % {$_ -replace ".*/", ""}
$complianceDataAdministratorRoles = Get-RoleGroup -Identity 'ComplianceDataAdministrator' |
   Select -ExpandProperty Roles |
   % {$_ -replace ".*/", ""}
Compare-Object $complianceAdministratorRoles $complianceDataAdministratorRoles | Select -ExpandProperty InputObject
```

This command results in the following output:  

<img src='./img/20230521-042116.png' width=600px>

To get role details you can expand on this further:  

```powershell
Compare-Object $complianceAdministratorRoles $complianceDataAdministratorRoles | 
   Select -ExpandProperty InputObject |
   % {Get-ManagementRole -Identity $_} |
   Select Name, Description | Sort Name
```

Here are the results which list the role details available in the Compliance Administrator role group but are not available in the Compliance Data Administrator role group:  

<img src='./img/20230522-042240.png' width=600px>

Additional command to compare role groups:

<img src='./img/20230619-051915.png' width=600px>

#### Audit Membership for all Microsoft Purview Role Groups

Use the following command to list all users and their corresponding Microsoft Purview role group membership:  

```powershell
function Get-PvAllRoleGroupAssignments {
    Write-Output (Get-RoleGroup) -PipelineVariable roleGroup | 
        % {Get-RoleGroupMember -Identity $_.Name} | 
        Select @{n='Name'; e={$_.DisplayName}}, @{n='Alias'; e={$_.Alias}}, @{n='RoleGroup'; e={$roleGroup.DisplayName}} | 
        Sort Name, RoleGroup 
}
```

<img src='./img/20230522-052214.png' width=500px>

A couple of things to note about this command:

1. `Write-Output` is needed for `-PipelineVariable`, as this parameter doesn't seem to work for `Get-RoleGroup`
2. The output of `Get-RoleGroupMember` includes the *PrimarySmtpAddress* property, but this property is not defined. The *Alias* property is the only property that has a defined email address.

#### Audit Membership for Specific Users

Use the following command to list all role groups for a set of users:  

```powershell
# List Microsoft Purview role groups for a set of users
function Get-PvRoleGroupAssignment {
    param(
        [string[]]$Upn
    )
    Write-Output $Upn -PipelineVariable user | 
        % {Get-RoleGroup} -PipelineVariable roleGroup | 
        % {Get-RoleGroupMember -Identity $_.Name} | 
        ? {$_.Alias -eq $user} | 
        Select @{n='User';e={$user}}, @{n='RoleGroup';e={$roleGroup.DisplayName}} | 
        Sort User, RoleGroup
}
```

<img src='./img/20230544-044433.png' width=400px>

Use the following command to list all role groups and roles for a set of users:

```powershell
function Get-PvManagementRoleAssignment {
    param(
        [string[]]$Upn
    )
    Write-Output $Upn -PipelineVariable user |
        % {Get-RoleGroup} -PipelineVariable roleGroup |
        % {Get-RoleGroupMember -Identity $_.Name} |
        ? {$_.Alias -eq $user} |
        % {$roleGroup | Select -ExpandProperty Roles} |
        % {$_ -replace ".*/", ''} -PipelineVariable role |
        Select @{n='User';e={$user}}, @{n='Role';e={$role}}, @{n='RoleGroup';e={$roleGroup.DisplayName}} |
        Sort User, Role, RoleGroup
}
```

<img src='./img/20230551-035141.png' width=500px>

Here is another version that uses the functions defined above. This example shows that the role group *Information Protection* is a higher-privileged role group than *Information Protection Admins*.  

```powershell
$ipa = Get-PvManagementRole -RoleGroup 'Information Protection Admins' | Select -ExpandProperty Name
$ip = Get-PvManagementRole -RoleGroup 'Information Protection' | Select -ExpandProperty Name
Compare-Object $ip $ipa -IncludeEqual
```

<img src='./img/20230636-033600.png' width=500px>

#### Manage Role Membership

Use the following command to add a member to a role group:  

```powershell
Add-RoleGroupMember -Identity OrganizationManagement -Member AdeleV@tate0423sandbox.onmicrosoft.com
```

Use the following command to remove a member from a role group:  

```powershell
Remove-RoleGroupMember -Identity OrganizationManagement -Member 'Adele Vance'
```

In both commands above you may either use the UserPrincipalName or the Display Name properties. 

Here are a couple of pointers to keep in mind when testing role membership:

1. Close out the browser profile and relaunch it to catch the changes. Refreshing or even closing the tab and opening a new tab may not be sufficient.
2. Allow up to 5-10 minutes for the changes to take effect.  

#### Remove a Set of Users from all Role Groups

Use the following command to remove a member from all assigned role groups in Microsoft Purview:  

```powershell
function Remove-PvAllRoleGroupAssignments {
    param(
        [string[]]$Upn
    )
    Write-Output $Upn -PipelineVariable user |
        % {Get-RoleGroup} -PipelineVariable roleGroup | 
        % {Get-RoleGroupMember -Identity $_.Name} | 
        ? {$_.Alias -eq $user} | 
        % {Remove-RoleGroupMember -Identity $roleGroup.Name -Member $user -Confirm:$false; ''} | 
        Select @{n='User';e={$user}}, @{n='RoleGroup';e={$roleGroup.DisplayName}}, @{n='Status';e={'Removed'}}
}
```

Note: the empty string `''` on the 5th line is to force output to the Select statement, as `Remove-RoleGroupMember` does not send any output to the pipeline.

<img src='./img/20230517-051721.png' width=400px>


## Sensitivity Labels

### Helpful Links

- [Learn about sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels?view=o365-worldwide)
- [Create a well-designed data classification framework](https://learn.microsoft.com/en-us/compliance/assurance/assurance-create-data-classification-framework)
- [Microsoft Information Protection SDK: Classification label concepts](https://learn.microsoft.com/en-us/information-protection/develop/concept-classification-labels)
- [Microsoft roadmap for sensitivity labels](https://www.microsoft.com/en-us/microsoft-365/roadmap?filters=Worldwide%20(Standard%20Multi-Tenant)&searchterms=label)
- [Microsoft Purview CxE](https://microsoft.github.io/ComplianceCxE/)
- [Guidance on external collaboration with sensitivity labels](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/secure-external-collaboration-using-sensitivity-labels/ba-p/1680498)
- [End-user documentation for sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/get-started-with-sensitivity-labels?view=o365-worldwide#end-user-documentation-for-sensitivity-labels)
- [Licensing for sensitivity labels](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance#microsoft-purview-information-protection-sensitivity-labeling)
- [Partner solutions that integrate with Microsoft Information Protection](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/microsoft-information-protection-showcases-integrated-partner/ba-p/262657)
- [Unified Labeling Support Tool](https://github.com/microsoft/UnifiedLabelingSupportTool) - PowerShell module for troubleshooting sensitivity labels and Azure RMS templates
- [AIP Audit Export](https://github.com/Azure-Samples/Azure-Information-Protection-Samples/tree/master/AIP-Audit-Export) - Export labeling events to Log Analytics
- [Migration Playbook for Built-in Labeling](https://microsoft.github.io/ComplianceCxE/playbooks/AIP2MIP/CompareAIP2MIP/)
- [Known Issues - Azure Information Protection](https://learn.microsoft.com/en-us/azure/information-protection/known-issues)

### Roles and Permissions

The following role groups have permissions for managing sensitivity labels:
 
- Organization Management*
- Compliance Administrator*
- Compliance Data Administrator*
- Information Protection*
- Information Protection Admins*
- Information Protection Analysts
- Information Protection Investigators
- Information Protection Readers

**Note:** Items with an asterisk (*) have the ability to activate and manage the AIP super user feature (need to confirm this)

The **Information Protection** role group is the most privileged of this bunch and has the following roles:

- Information Protection Admin - Create, edit, and delete DLP policies, sensitivity labels and their policies, and all classifier types. Manage endpoint DLP settings and simulation mode for auto-labeling policies.
- Data Classification Content Viewer - Allow viewing in-place rendering of files in content explorer.
- Data Classification List Viewer - Allow viewing list of files in content explorer.
- Information Protection Analyst - Access and manage DLP alerts and activity explorer. View-only access to DLP policies, sensitivity labels and their policies, and all classifier types.
- Information Protection Investigator - Access and manage DLP alerts, activity explorer, and content explorer. View-only access to DLP policies, sensitivity labels and their policies, and all classifier types.
- Information Protection Reader - View-only access to reports for DLP policies and sensitivity labels and their policies.
- Purview Evaluation Administrator - Used to create and manage M365 Purview Evaluation lab

The **Information Protection Admins** role group has only the following roles:

- Information Protection Admin - Create, edit, and delete DLP policies, sensitivity labels and their policies, and all classifier types. Manage endpoint DLP settings and simulation mode for auto-labeling policies.
- Purview Evaluation Administrator - Used to create and manage M365 Purview Evaluation lab

The **Information Protection Investigators** role group has the following roles:  

- Data Classification Content Viewer - Allow viewing in-place rendering of files in content explorer.
- Data Classification List Viewer - Allow viewing list of files in content explorer.
- Information Protection Analyst - Access and manage DLP alerts and activity explorer. View-only access to DLP policies, sensitivity labels and their policies, and all classifier types.
- Information Protection Investigator - Access and manage DLP alerts, activity explorer, and content explorer. View-only access to DLP policies, sensitivity labels and their policies, and all classifier types.
- Purview Evaluation Administrator - Used to create and manage M365 Purview Evaluation lab

The **Information Protection Analysts** role group has the following roles:

- Data Classification List Viewer - Allow viewing list of files in content explorer.
- Information Protection Analyst - Access and manage DLP alerts and activity explorer. View-only access to DLP policies, sensitivity labels and their policies, and all classifier types.
- Purview Evaluation Administrator - Used to create and manage M365 Purview Evaluation lab

The **Information Protection Readers** role group has the following role:  

- Information Protection Reader - View-only access to reports for DLP policies and sensitivity labels and their policies.

Alternatively you can create a new role group and add the **Sensitivity Label Administrator** role.  For a read-only group, use **Sensitivity Label Reader**. 

See [Permissions required to create and manage sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/get-started-with-sensitivity-labels?view=o365-worldwide#permissions-required-to-create-and-manage-sensitivity-labels)

### Licensing for Sensitivity Labels

The following licenses are required for using Information Protection features:

- An E5 license is required for each user who accesses protected documents in locations that use automatic labeling. 
- An E3 license is required when using manual labeling. Labeling by using a default label is considered manual labeling, as the user has the option to accept or change the label. By default, information protection features are applied at the tenant level for all users within the tenant.
- No license is necessary for someone who only opens and accesses the content in protected files.

See [Microsoft Licensing Guidance: Purview Information Protection](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance#microsoft-purview-information-protection-sensitivity-labeling)

### Overview

Sensitivity labels enable you to protect files and containers (Teams, SharePoint, OneDrive) from unauthorized access. Sensitivity labels can be applied manually using the [Sensitivity Bar](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide#sensitivity-bar) in the Office apps. Sensitivity labels also have [PDF support](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide#pdf-support). See [Common scenarios for sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/get-started-with-sensitivity-labels?view=o365-worldwide#common-scenarios-for-sensitivity-labels). A sensitivity label is stored in clear text in the metadata for files and emails. This allows third-party apps and services to read it and apply their own protective actions. It also means the label stays with the content, no matter where it's stored or saved.

#### Labels, Sublabels, and Label Scopes

When you create sensitivity labels, they appear in a list on the **Information Protection > Labels** page in Microsoft Purview Compliance (https://compliance.microsoft.com). In this list, the order of the labels is important because it reflects their priority. You want your most restrictive sensitivity label, such as Highly Confidential, to appear at the bottom of your list, and your least restrictive label to appear at the top.

You can apply just one sensitivity label to an item, such as an email, document, or container. If you set an option that requires your users to provide a justification for changing a label to lower sensitivity, the order of this list identifies the lower sensitivity. However, users are not required to provide justification when changing to a lower priority *within a sublabel*. 

With sublabels, you can group one or more labels below a parent label that a user sees in an Office app. Sublabels are simply a way to present labels to users in logical groups. Sublabels don't inherit any settings from their parent label, except for their label color. When you publish a sublabel for a user, that user can then apply that sublabel to content and containers, but can't apply just the parent label. Don't choose a parent label as the default label, or configure a parent label to be automatically applied (or recommended). If you do, the parent label can't be applied.

The ordering of sublabels is used with automatic labeling. When you configure auto-labeling policies, multiple matches can result for more than one label. Then, the last sensitive label is selected, and then if applicable, the last sublabel. When you configure sublabels themselves (rather than auto-labeling policies) for automatic labeling, the behavior is a little different when sublabels share the same parent label. For example, a sublabel configured for automatic labeling is preferred over a sublabel configured for recommended labeling. See [How multiple conditions are evaluated when they apply to more than one label](https://learn.microsoft.com/en-us/microsoft-365/compliance/apply-sensitivity-label-automatically?view=o365-worldwide#how-multiple-conditions-are-evaluated-when-they-apply-to-more-than-one-label)

When you create a sensitivity label, you're asked to configure the label's scope, which determines two things:

- Which label settings you can configure for that label
- The availability of the label to apps and services, which includes whether users can see and select the label

See [Learn about sensitivity labels](https://learn.microsoft.com/en-us/purview/sensitivity-labels?view=o365-worldwide)

#### Container Support for Sensitivity Labels

Containers include Teams, SharePoint sites, and Microsoft 365 Groups. Sensitivity labels can be applied to these containers, but the labels do not apply to the files within the containers. To protect files within Teams and SharePoint sites you must apply sensitivity labels to the files themselves (either manually or automatically) or to the SharePoint document library.

<img src='img/20230831-053108.png' width='600px'>

See [Use sensitivity labels with Teams, groups, and sites](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-teams-groups-sites?view=o365-worldwide#how-to-enable-sensitivity-labels-for-containers-and-synchronize-labels) for enabling scopes for containers.

#### Define and Create Sensitivity Labels

By default, tenants do not have any labels, so you must create them. Sensitivity labels are provided using two steps:

1. Create the label
2. Publish the label to users using a label policy

Per [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide#when-to-expect-new-labels-and-changes-to-take-effect), allow up to 24 hours for labels and their settings to become available.  

<img src='img/20230633-033336.png' width='400px'>

See [Create and configure sensitivity labels and their policies](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide) for more info.

#### Editing or Deleting a Sensitivity Label

If you delete a sensitivity label from the admin portal, the label isn't automatically removed from content, and any protection settings continue to be enforced on content that had that label applied. However, some caveats apply. See [Removing and deleting labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide#removing-and-deleting-labels) for more info.

#### Markings for Sensitivity Labels

When specifying the label settings, use the Content Marking section to apply visible marking. You can specify conditional settings for Word, Excel, PowerPoint, and Outlook. See [Dynamic markings with variables](https://learn.microsoft.com/en-us/purview/sensitivity-labels-office-apps#dynamic-markings-with-variables).

<img src='img/20231159-035920.png' width='500px'>

#### Built-in Labeling for the Office Apps

A subscription edition of Office apps is required to use sensitivity labels. Standalone/perpetual editions of Office aren't supported.

See [here](https://learn.microsoft.com/en-us/purview/sensitivity-labels-aip?view=o365-worldwide#features-supported-only-by-built-in-labeling-for-office-apps) for a list of features supported by built-in labeling for Office apps:

- Intelligent classification services for automatic and recommended labeling, i.e. trainable classifiers, exact data match, and named entities
- Sensitivity bar that's integrated into existing user workflows
- PDF support
- Protect meeting invites, with their attachments and responses
- For custom permissions, the ability to assign different permissions to users and groups
- Encrypt-only emails
- Support for account switching
- Users can't disable labeling

See [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-aip?view=o365-worldwide#features-not-planned-to-be-supported-by-built-in-labeling-for-office-apps) for a list of features Microsoft does not plan to support:
- Application of labels to Office 97-2003 formats, e.g. .doc files
- Local usage logging to the Windows Event log
- Permanently disconnected computers
- Standalone editions of Office, i.e. "Perpetual Office", rather than subscription-based Office

#### Label Taxonomy

Defining the right label taxonomy and protection policies is the most critical step in a Microsoft Purview Information Protection deployment. It is important that you define a label taxonomy that will work for a long time, as changing labels after they have been deployed is a difficult task.

A good label taxonomy needs to meet business and/or regulatory needs, be intuitively understandable by users, provide good policy tips, and be easy to use. It should not prevent users from doing their jobs, while at the same time help prevent instances of data leakage or misuse and address compliance requirements.

See [Create a well-designed data classification framework](https://learn.microsoft.com/en-us/compliance/assurance/assurance-create-data-classification-framework) for further guidance. Eligible customers (new and existing) can activate a set of default protection labels and policies. See [Default Sensitivity Labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/mip-easy-trials?view=o365-worldwide#default-sensitivity-labels).

**Good Practice:**

- Start small and keep it simple.
- Start with a configuration that affords sufficient protection without being overly restrictive
- Only introduce sublabels when you have a clear need for them, as users may find it challenging to find the right label to apply amongst a group of sublabels.
- Define labels that will last a long time
- Start with what threats you are trying to prevent, e.g. users from accidentally putting sensitive data where unauthorized users can view it. Based on those requirements, define the minimal controls that must be there to ensure those scenarios don't happen.
- Use label names that intuitively resonate with your users. Don't use acronyms. Use short, meaningful words, e.g. "Confidential", "Secret"
- Avoid terms that may be ambiguous. Don't use terms where not all users might agree on whether "Confidential" or "Secret" is the most sensitive label; use "Confidential" and "Highly Confidential" instead.
- Use sublabels with intent. Labels are used to represent the actual sensitivity  of the content that is labeled. Sublabels represent variations in the protection or the scope of the content. 
- Compartmentalize sparingly. Using sublabels to give rights to people in specific departments is good practice, but you should use this capability in moderation. Limit the number of sublabels for departments to a small number and stick with it.
- Involve different teams to review your proposed label taxonomy. Defining labels is not an IT security task alone, and early feedback will help you define a label taxonomy that will work for a long time

See the full list and descriptions [here](https://microsoft.github.io/ComplianceCxE/dag/mip-dlp/)


### Automatically Applying Sensitivity Labels

There are two methods for automatically applying sensitivity labels:  client-side labeling and service-side auto labeling. 

See the following links for more information:

- [Apply a sensitivity label to content automatically](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically)
- [Recommend that the user applies a sensitivity label](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically#recommend-that-the-user-applies-a-sensitivity-label)
- [How Microsoft 365 automatically applies or recommends sensitivity labels](https://support.microsoft.com/en-us/office/sensitivity-labels-are-automatically-applied-or-recommended-for-your-files-and-emails-in-office-622e0d9c-f38c-470a-bcdb-9e90b24d71a1)
- [Known issues with automatically applying or recommending sensitivity labels](https://support.microsoft.com/en-us/office/known-issues-with-automatically-applying-or-recommending-sensitivity-labels-451698ae-311b-4d28-83aa-a839a66f6efc?ui=en-us&rs=en-us&ad=us).
- [End-user documentation](https://learn.microsoft.com/en-us/purview/sensitivity-labels-office-apps#end-user-documentation).

#### Client-side Labeling

Client-side labeling takes place within the Office apps (Word, Excel, PowerPoint, and Outlook) and supports two labeling methods: (1) recommending a label to users and (2) automatically applying a label. With client-side labeling, the auto-labeling settings are configured within the label.  See screenshot below.

<img src='img/20231107-040725.png' width=600px>

##### Recommended Labeling

When using recommended labeling, with sensitive information types, the Word application displays the **Show Sensitive Content** button. This button allows the user to see the sensitive information detected and optionally remove the content.

<img src='img/20231157-055712.png' width=600px>

However, the **Show Sensitive Content** button does not appear for trainable classifiers. Instead, the user only receives the option to apply the label.

<img src='img/20231159-055919.png' width=600px>

Soon Microsoft will introduce support for contextual highlighting for trainable classifiers.

<img src='img/20231137-063754.png' width=800px>

##### Automatic Client-Side Labeling

When configuring labeling settings, you also have the option to automatically apply a label.

<img src='img/20231112-041231.png' width=600px>

When using automatic client-side labeling, the user receives a policy tip advising that a label has been applied. 

<img src='img/20231113-041331.png' width=400px>

#### Service-side Auto Labeling

See [How to configure auto-labeling policies for SharePoint, OneDrive, and Exchange](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically#how-to-configure-auto-labeling-policies-for-sharepoint-onedrive-and-exchange).

When configuring auto labeling policies, you can't automatically label documents and email until your policy has run at least one simulation. See [Learn about simulation model](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically#learn-about-simulation-mode). Microsoft recommends that you start with a small scope and then use the results from simulation to expand the scope, prior to enabling the policy. 

Service-side auto labeling enables you to label documents based on classifiers or based on file type, e.g. .docx, .pdf, etc.

<img src='img/20231106-060624.png' width=600px>

You can also scope auto labeling policies to specific SharePoint sites, OneDrive accounts, or Exchange mailboxes.

### Detect Sensitive Information Type and Trainable Classifier Matches

Microsoft does not (yet) allow you to view contextual information for trainable classifiers and some sensitivity information types in Content Explorer. You can use the results of an auto-labeling simulation to help you determine why a document was labeled or recommended for labeling.

Use the following steps:

1. Create a SharePoint site for the auto-labeling simulation, e.g. "Information Protection Simulation"
2. Create an auto-labeling policy that targets the trainable classifier or sensitive information type

In this case, the auto-labeling policy exists just for simulation purposes. The policy just exists for simulation; you never enable the policy.

The screenshot below shows an example of the simulation testing results.

<img src='img/20231101-060116.png' width=700px>

You can then view the contextual summary for trainable classifiers or sensitive information types to help you understand why the content was marked as sensitive. 

<img src='img/20231102-060252.png' width=600px>


### Label Override Behavior

Auto-labeling carries the potential for a labeled item to be overriden. Here are the rules to be aware of:

- If an label is applied manually, then client-side auto labeling and service-side auto labeling will not override the label.
- If a label is applied automatically, either by a default label or through auto-labeling, and the label has a lower priority than what the auto-labeling service evaluates, then the auto-labeling service will override the label with the higher priority label.
- For sublabels, if a file is not already labeled, automatic labeling takes precedence over recommended labeling, and the highest order sublabel will be selected
- For sublabels, if a file is already labeled from a sublabel w/ the same parent, no action is taken. This applies if the existing label was a default label or automatically applied


See [Will an existing label be overrriden?](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically#will-an-existing-label-be-overridden) and [How multiple conditions are evaluated when they apply to more than one label](https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically#how-multiple-conditions-are-evaluated-when-they-apply-to-more-than-one-label).


### Protecting SharePoint Sites, Teams, and Groups with Sensitivity Labels

Sensitivity labels for SharePoint sites, Teams, and Microsoft 365 Groups is not enabled by default. You must take several steps to enable sensitivity labels for these containers. See [Use sensitivity labels with teams, groups, and sites](https://learn.microsoft.com/en-us/purview/sensitivity-labels-teams-groups-sites).

#### Enable sensitivity label support for groups in PowerShell

Follow the guidance [here](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels#enable-sensitivity-label-support-in-powershell) to set the `EnableMIPLabels` setting for groups to `True`. New tenants do not have a directory setting for groups, so you must create one. See [here](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-cmdlets#template-settings) for a description of each template setting. Here are the default settings:

<img src='img/20230830-043058.png' width=600px>

#### Synchronize sensitivity labels with Azure AD

As a global administrator, run `Execute-AzureADLabelSync` in a Windows PowerShell session. 

<img src='img/20230807-030748.png' width=500px>

This command is tricky to get working. I've only had success when running in the following scenarios:

1. Running in Windows PowerShell, not modern PowerShell
2. After introducing the **Groups & Sites** scope to a label, waiting overnight, and then running the command

In other scenarios, the command may time out after 5 minutes with a JSON error.

In my case, the Sensitivity Label option for Microsoft 365 Groups appeared only after creating a Team, not a Microsoft 365 Group, and specifying a sensitivity label for the Team. The Sensitivity Label option will not appear for existing Microsoft 365 Groups.  

<img src='img/20230821-032128.png' width=500px>

See the Microsoft Groups article [Assign sensitivity labels](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels) for more info on changing, removing, and troubleshooting labels for Microsoft 365 Groups.

### Enable PDF Support

By default, enablement of sensitivity labels for PDFs is turned off. See [Adding support for PDF](https://learn.microsoft.com/en-us/purview/sensitivity-labels-sharepoint-onedrive-files?view=o365-worldwide#adding-support-for-pdf) and [Set-SPOTenant](https://learn.microsoft.com/en-us/powershell/module/sharepoint-online/set-spotenant?view=sharepoint-ps#-enablesensitivitylabelforpdf).

PDF support enables the following scenarios:

- Applying a sensitivity label in Office for the web
- Uploading a labeled document, and then extracting and displaying that sensitivity label
- Search, eDiscovery, and data loss prevention (DLP) for labeled PDFs
- Auto-labeling policies and default sensitivity labels for SharePoint document libraries

To enable, use `SetSPOTenant` with the `-EnableSensitivityLabelforPDF:$true` option.

<img src='img/20231039-033953.png' width=500px>

To confirm use `Get-SPOTenant` and view the `EnableSensitivityLabelforPDF` property. See [Get-SPOTenant](https://docs.microsoft.com/en-us/powershell/module/sharepoint-online/get-spotenant?view=sharepoint-ps).

<img src='img/20231040-034059.png' width=500px>

#### Support for PDF Attachments in Message Encryption

By default, PDF files are not encrypted when sending protected messages. To support encryption for PDF documents you must take two actions:

1. Enable PDF encryption using `Set-IRMConfiguration`.  
2. Establish DLP policies to apply encryption to PDF attachments.  

See [Message Encryption FAQ - Are PDF file attachments supported?](https://learn.microsoft.com/en-us/purview/ome-faq#are-pdf-file-attachments-supported-).

In the first option using `Set-IRMConfiguration`, encryption of PDF files is only supported for messages sent from Outlook on the web, Outlook for Mac, and the Outlook mobile apps.  PDF encryption does not work and is not supported for the Win32 Outlook desktop app.

The following screenshot enables PDF encryption for messages sent from Outlook on the web and mobile apps but not for the Outlook Win32 desktop app. See [Set-IRMConfiguration](https://docs.microsoft.com/en-us/powershell/module/exchange/set-irmconfiguration?view=exchange-ps).

![](img/20230836-043600.png)

The second option is intended to support the Win32 Outlook desktop app; however, users lose the ability to choose whether to apply encryption, as DLP and mail flow rules must receive an *unencrypted* message and then apply encryption based on certain conditions. 

For defining mail flow rules and DLP policies, see [Define mail flow rules to encrypt email messages](https://learn.microsoft.com/en-us/purview/define-mail-flow-rules-to-encrypt-email) and [Conditions Exchange for DLP policies](https://learn.microsoft.com/en-us/purview/dlp-exchange-conditions-and-actions#conditions-exchange-for-dlp-policies).

### Protecting On-Premises Data

The on-premises scanner can protect data in local paths, UNC paths, and SharePoint Server document libraries. Per [here](https://learn.microsoft.com/en-us/purview/deploy-scanner#overview-of-the-scanner), the scanner runs in four modes:

1. Discovery mode only: creates a report that checks what happens when your files are labeled
2. Discovery mode with sensitive information
3. Automatic labeling mode
4. Specific file types

**NOTE:** When scanning content for sensitive information, the scanner only scans for sensitive information types. The scanner does not scan for trainable classifiers.

Purview Compliance roles required:  

- Compliance Administrator
- Compliance Data Administrator
- Security Administrator
- Organization Management

**NOTE:** You may need Global Admin to introduce the scanner cluster.

Use the following links for more information:

- [Overview of the scanner](https://learn.microsoft.com/en-us/purview/deploy-scanner#overview-of-the-scanner)
- [Supported file types](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-file-types)
- [Configure & install the scanner](https://learn.microsoft.com/en-us/purview/deploy-scanner-configure-install?tabs=azure-portal-only)
  - This documentation lacks a critical step; you must also follow [Prerequisites for running AIP labeling cmdlets unattended](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-powershell#prerequisites-for-running-aip-labeling-cmdlets-unattended)
- [Run the scanner](https://learn.microsoft.com/en-us/purview/deploy-scanner-manage)

Setup requirements:

- Active Directory service account. See [Service account requirements](https://learn.microsoft.com/en-us/purview/deploy-scanner-prereqs#service-account-requirements)
- SQL Server. See [SQL server requirements](https://learn.microsoft.com/en-us/purview/deploy-scanner-prereqs#sql-server-requirements)
- Azure Information Protection Unified Labeling Client. See [Download and install the Azure Information Protection Unified Labeling Client](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/install-unifiedlabelingclient-app)
- Entra App Registration. See [Prerequisites for running AIP labeling cmdlets unattended](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-powershell#prerequisites-for-running-aip-labeling-cmdlets-unattended)
- Cloud-only or synced account with labeling policies

You do not need a synced account to use the scanner.  You can use a non-synced Active Directory account to operate the scanner service locally and then configure a cloud-only account to operate on behalf of the non-synced account. See [here](https://learn.microsoft.com/en-us/purview/deploy-scanner-prereqs#restriction-the-scanner-service-account-cannot-be-synchronized-to-microsoft-entra-id-but-the-server-has-internet-connectivity).

#### Installing the Scanner

Follow through the guidance in [Configure and install the scanner](https://learn.microsoft.com/en-us/purview/deploy-scanner-configure-install?tabs=azure-portal-only). Then follow through [Prerequisites for running AIP labeling cmdlets unattended](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-powershell#prerequisites-for-running-aip-labeling-cmdlets-unattended). 

Here are some of the key steps:

1. Create the scanner cluster and content scan job in Microsoft Purview Compliance > Settings > Information Protection Scanner
2. Install the scanner using `Install-AIPScanner` with the `-SQLServerInstance` and `-Cluster` parameters
3. Create an app registration and with secret value
4. Configure app registration permissions for the **Azure Rights Management Services** and **Microsoft Information Protection** APIs
5. Run `Set-AIPAuthentication` to configure the scanner to use the app registration. 

When running through the prerequisites listed above you need to add permissions for the **Azure Rights Management Services** API and the **Microsoft Information Protection Sync Service** API:  

<img src='img/20231109-050925.png' width=700px>

When running `Install-AIPScanner`, make sure to give the service accounts the rights it needs to access the SQL instance. Also make sure to specify the service account using the domain\username convention. Here's an example of a successful install.

<img src='img/20231251-035118.png' width=700px>

When running `Set-AIPAuthentication`, use the `-DelegatedUser` parameter to specify an Azure AD user account that has an assigned labeling policy.  Use the `-OnBehalfOf` parameter to specify an Active Directory account that runs the scanner service. Specify the domain\username convention instead of the UPN convention. You must run this command using the scanner service account. The scanner service account needs to run this command from an administrative command window. The cloud account does not need a license.

<img src='img/20231118-051821.png' width=700px>

While the result indicates success, it doesn't guarantee that the scanner will operate without error. After the installation is complete, run `Start-AIPScannerDiagnostics` to confirm the configuration:

<img src='img/20231128-052837.png' width=600px>

#### Configuring the Scanner

The scanner has a number of configuration options that are not immediately intuitive. See the following screenshot.

<img src='img/20231116-041658.png' width=400px>

Full descriptions are available in the context menu. Here are some of the key options that warrant further explanation:

| Option | Description |
| --- | --- |
| **Info types to be discovered** | All: Sets the content scan job to scan your content for all sensitive information types <br> Policy only: Scans only for sensitive information types configured in labels. Labels must have an applicable policy  |
| **Treat recommended labeling as automatic** | Off: Use automatic classification rules <br> On: Use both automatic and recommended classification rules <br> The automatic/recommended option is defined in the settings per label |
| **Enforce sensitivity labeling policy** | Off: Scans the data in "what-if" mode <br> On: Scans the data and applies sensitivity labels for files that meet conditions |
| **Label files based on content** | Off: Apply a label to all files without inspecting the content <br> On: Apply a label to files that match the content inspection conditions |
| **Enable DLP policy rules** | See [Use a DLP policy](https://learn.microsoft.com/en-us/purview/deploy-scanner-configure-install?tabs=azure-portal-only#use-a-dlp-policy) |

Depending on the configuration you choose, your labels may need to have auto-labeling conditions, i.e. recommended labeling or automatic labeling. See [here](https://learn.microsoft.com/en-us/purview/deploy-scanner-prereqs#restriction-your-labels-do-not-have-auto-labeling-conditions). If your labels do not have these conditions, then you will receive configuration errors if **Discover all info types** is set to **Policy only**.

#### Scanning Scenarios

##### Scenario 1: Perform a discovery scan for all files

- **Enforce sensitivity labeling policy**: Off
- **Label files based on content**: Off
- **Default label**: Custom

Use `Set-AIPScannerConfiguration` with the `-ReportLevel Debug` option to log results for every file. The results are stored in a CSV that detail (1) whether if any files have existing protection and (2) the action that would be taken when **Enforce sensitivity labeling policy** is set to **On**.

##### Scenario 2: Perform a discovery scan on all files for only files that contain sensitive information

- **Enforce sensitivity labeling policy**: Off
- **Info types to be discovered**: All
- **Label files based on content**: On
- **Default label**: None

Use `Set-AIPScannerConfiguration` with the `-ReportLevel Info` option to only record files that contain sensitive information. The scanner report contains the column **Information Type Name**. This column indicates the sensitive information type detected in the file. The column **Applied Label** indicates the type of label that would be applied if a labeling policy was in place.

##### Scenario 3: Run the scanner automatically

The following configuration runs the scanner automatically and only protects files with sensitive information types that are specified by labeling policies.

- **Schedule**: Always
- **Enforce sensitivity labeling policy**: On
- **Info types to be discovered**: Policy Only
- **Treat recommended labeling as automatic**: On
- **Label files based on content**: On
- **Default label**: None

##### Scenario 4: Specify specific files to scan or exclude

- **Include or exclude file type to scan**: Include; then specify file extensions, e.g. .docx, .pdf, etc.

In the other three scenarios, you can get away with configuring the settings in the content scan job. However, in this scenario, it is better to configure the settings in the repository. Reason being is the content scan job settings, i.e. the parent, have built-in exclusion rules for file types that are not supported, e.g. .lnk, .exe.  When configuring the repository, you can choose an explicit include rule for file types you want to be scanned, e.g. .docx, .pdf, etc.

#### Scanner Offline Mode

All configuration changes must come from the Purview Compliance portal. You can use the `Set-AIPScannerConfiguration` cmdlet to update configuration locally, but you must first set the scanner to function in **offline** mode. If you try to update the scanner locally without the scanner running in offline mode, then you will receive an error message.

<img src='img/20231114-071435.png' width=800px> 

You would only want to set the scanner in offline mode if there is a requirement for the scanner to not have internet connectivity. In this case you would export the scan job configuration from the portal and import the configuration using `Import-AIPScannerConfiguration`. You also need to run `Set-AIPScannerContentScanJob` with the `-Enforce On` option. See [Restriction: The scanner server cannot have internet connectivity](https://learn.microsoft.com/en-us/purview/deploy-scanner-prereqs#restriction-the-scanner-server-cannot-have-internet-connectivity).

#### Operating the Scanner

Here's a list of useful commands:

- `Start-AIPScan`: Use the `-Reset` option to scan all files instead of just new or modified files
- `Get-AIPScannerStatus`: indicates status of the scanner cluster, whether the cluster is scanning, idle, or offline
- `Get-AIPScannerConfiguration`: lists report level, SQL instance, database, and online/offline configuration state
- `Get-AIPScannerContentScanJob`: lists the scanner settings that repositories inherit from the content scan job
- `Get-AIPScannerRepository`: lists the effective scanner settings for the repository
- `Start-AIPScannerDiagnostics`: Use the `-ResetConfig` option to reset the policy cache. By default, policy refreshes occur every 4 hours.

##### Always-On Mode

When in regular operation, you configure the scanner to operate on in an always-on mode by setting the **Schedule** in the portal to **Always**.  In this case, the scanner continually operates and remains in the **Scanning** state.

<img src='img/20231136-033600.png' width=350px>

You cannot use `Stop-AIPScan` to stop the scanner service when the scanner is in always-on mode. To stop the scanner, you must (1) set the **Schedule** in the portal to **Manual** and (2) [recycle the scanner service](#recycle-the-scanner-service).

##### Manual Mode

In the **Content scan jobs** tab, use either the **Scan now** option or the **Rescan all files** option to run a manual scan. The **Scan now** option scans only new or modified files. The **Rescan all files** option scans all files, even if they have been scanned before and the Azure Information Protection policy has not changed.

<img src='img/20231114-041447.png' width=600px>

When initiating a scan from the portal, it may take a few minutes for the scan to start. For immediate results, use `Start-AIPScan` with the `-Reset` option to perform a full scan of all files.


##### Review Scanner Results

The portal doesn't show you details of the scan results. You must retrieve this information on the scanner server. Here's a useful PowerShell command for viewing a summary of scan results:

```powershell
Get-AIPScannerStatus | Select -ExpandProperty nodesinfo | select -ExpandProperty summary
```

<img src='img/20231103-050311.png' width=600px>

When the scan is complete, review the reports in **%localappdata\Microsoft\MSIP\Scanner\Reports**. The report is in a CSV format.

<img src='img/20231158-055807.png' width=800px>

#### Troubleshooting the Scanner

In the settings of the Purview Compliance portal, check the **Nodes** tab for errors.

<img src='img/20231112-041222.png' width=600px>

Run `Get-AIPScannerStatus` and verify the cluster status: 

<img src='img/20231104-030416.png' width=500px>

##### Troubleshoot the Scanner Configuration

On the scanner server, run `Start-AIPScannerDiagnostics`.  The command will output text in red if there's an error in the scanner configuration. The DiagnosticLogs.zip file can be used for further troubleshooting. For example, the zip file includes an export of the **policy.xml** file, which you can use to confirm settings from the label policy.

<img src='img/20231132-033224.png' width=700px>

#### Recycle the Scanner Service

The scanner policy refreshes occur every 4 hours. To force an immediate policy refresh, try running `Start-AIPSCannerDiagnostics` with the `-ResetConfig` option to pull the latest policy configuration from the cloud. However, when using `-ResetConfig` I always encounter the warning message "Failed to delete policy cache...". So, instead of running `StartAIPScannerDiagnostics -ResetConfig` switch, I manually delete the policy cache using the following commands:

```powershell
Stop-Service AIPScanner
Remove-Item "$env:LOCALAPPDATA\Microsoft\MSIP\mip\MSIP.Scanner.exe\mip\mip.policies.sqlite3"
Start-Service AIPScanner
```

After running the commands to delete the policy cache, run the following commands to verify the changes:

- `Start-AIPScannerDiagnostics`: confirm there are no errors in the configuration
- `Get-AIPScannerContentScanJob`: confirm parent settings for the scanner repository (there are only three of them)
- `Get-AIPScannerRepository`: confirm all the explicit settings or the inherited settings from the content scan job

When troubleshooting scan jobs, use `Start-AIPScan` with the `-Reset` option to perform a full scan of all files, even if the files have been scanned before and the Azure Information Protection policy has not changed.

Use `Get-AIPScannerStatus` to monitor the job results:  

```powershell
Get-AIPScannerStatus | Select -ExpandProperty nodesinfo | select -ExpandProperty summary
```

Each scan job provides a detailed report, in .csv format, of labeling activities.  When troubleshooting the result of scan jobs, use `Set-AIPScannerConfiguration -ReportLevel Debug` to enable detailed logging for all scanned files. See [Set-AIPScannerConfiguration](https://learn.microsoft.com/en-us/powershell/module/azureinformationprotection/set-aipscannerconfiguration?view=azureipps#-reportlevel) for more detail on this option.

If the report is not available, then toggle the `-ReportLevel` option, for example from to `Info` to `Debug` and run the scan job again; then toggle it back.

### External Access

Users must have an account in Entra ID to access protected content. Azure/Office 365 customers can access without any additional configuration.  Non-Azure/Office 365 customers must sign up for an Azure RMS for Individuals account. The Azure RMS for Individuals service creates an account in an unmanaged Entra ID tenant.

#### Azure RMS for Individuals

Sensitivity labels use Azure RMS to protect content. Azure RMS uses Entra ID to authenticate access. When a user signs up for an Azure RMS for Individuals  account, the service creates an unmanaged Azure tenant and directory for the organization with an account for the user, so that this user (and subsequent users) can then authenticate to the Azure RMS service. See [Azure RMS FAQ](https://learn.microsoft.com/en-us/azure/information-protection/faqs-rms#when-i-share-a-protected-document-with-somebody-outside-my-company-how-does-that-user-get-authenticated)  
and [RMS for Individuals and Azure Information Protection](https://learn.microsoft.com/en-us/azure/information-protection/rms-for-individuals).  

The following link can be provided to external users to sign up for an Azure RMS for Individuals account: https://aka.ms/rms-signup 

##### Azure RMS Sign-Up Experiences

Then accessing the Azure RMS for Individuals sign-up page, users are first presented with a box to provide their email address:  

<img src='img/20231011-041129.png' width=500px>

###### Scenario 1: Azure RMS for Individuals Account Already Exists

If the user's email address is already associated with an Azure tenant, then the user receives a message indicating an account already exists.  Note: the account exists in an unmanaged Azure tenant that is created with security defaults enabled. If the age of the user account is beyond the initial 14-day grace period for MFA, then the user will be required to register for MFA when signing in.

<img src='img/20231013-041309.png' width=500px>

After successful sign-in, the user receives a message indicating the Azure RMS Individuals account is ready for use. At this point, the user may open protected documents.

<img src='img/20231017-041733.png' width=500px>

**Note:** The license mentioned is a **Rights Management Adhoc** license. Tenants are assigned with 10,000 of these licenses, and licenses are automatically assigned when users sign up for Azure RMS for Individuals. It is not necessary to manually assign these licenses. See [here](https://learn.microsoft.com/en-us/microsoft-365/troubleshoot/licensing/rights-management-adhoc-sku-office-365#cause) and [here](https://learn.microsoft.com/en-us/azure/information-protection/deployment-roadmap-classify-label-protect#confirm-your-subscription-and-assign-user-licenses) for more information on the Rights Management Adhoc license.

<img src='img/20231041-044158.png' width=300px>

The screenshot above becomes available after taking over an unmanaged tenant.

###### Scenario 2: Azure RMS for Individuals Account Does Not Exist

If the user's email address is not associated with an Azure tenant, then the user can choose **Yes** to create a new account and provide a password.  

<img src='img/20231022-042217.png' width=500px>

To complete the registration process, the user must provide a verification code that is sent to the user's email address.

<img src='img/20231022-042249.png' width=500px>

After successful sign-in, the user is redirected to the Microsoft Azure Information Portal. At this point, the user can close out the page and return to the original document to open it.

<img src='img/20231029-042914.png' width=500px>

###### Scenario 3: No Option to Create an Azure RMS for Individuals Account

If the user's organization has performed a takeover of an unmanaged tenant, then the user will not be able to create an Azure RMS for Individuals account.  Instead, the user receives the following message advising that their IT admin create an account:

<img src='img/20231019-041940.png' width=500px>

An IT admin can create an account for the user in Entra ID. No Office 365 or Exchange license is required. The user then may go back and complete the Azure RMS for Individuals registration process.

<img src='img/20231003-050321.png' width=500px>

However, it's generally not practically to request the user's organization to create an Entra ID account for the user, as the organization may not be ready to provide this level of support. In this case, the best recourse is to provision a guest account for the user in your tenant.

##### Unmanaged Tenant Considerations

Any registered user can sign in to the Azure Portal with their newly-created Azure RMS for Individuals account and view items within the Entra ID services, including other user accounts that have been created.  

<img src='img/20231000-040033.png' width=800/>

On tenant creation, the service places **Microsoft Rights Management Services** as the only Global Administrator.

<img src='img/20231056-035634.png' width=800/>

If there is a need to take over the unmanaged tenant, Microsoft provides the following guidance for an admin takeover: [Take over an unmanaged directory as administrator in Microsoft Entra ID](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/domains-admin-takeover).

#### Addressing MFA Requirements for External Users

If your organization requires MFA for guest users, then a guest account must exist in your organization's tenant before external users can open protected documents. This requirement stems from the fact that the resource tenant, not the guest tenant, is always responsible for MFA. See [MFA for Microsoft Entra external users](https://learn.microsoft.com/en-us/azure/active-directory/external-identities/authentication-conditional-access#mfa-for-microsoft-entra-external-users) and [MFA for non-Azure AD external users](https://learn.microsoft.com/en-us/azure/active-directory/external-identities/authentication-conditional-access#mfa-for-non-azure-ad-external-users).

Users will receive the following error message when a guest account does not exist.  This message applies for both Microsoft and non-Microsoft customers. The user receives this message after authenticating with MFA.

![](img/20231045-034512.png)

You have three options to avoid this error:

1. Trust MFA registrations from other tenants, or
2. Create a guest account in your tenant, or
3. Configure an exception for the Azure Information Protection application

##### Trust MFA Registrations from Other Tenants

For users who have an account in Entra ID, Microsoft recommends using [External Identities cross-tenant access settings](https://learn.microsoft.com/en-us/azure/active-directory/external-identities/cross-tenant-access-overview#organizational-settings) to trust MFA claims from other tenants.  See [Conditional Access policies and encrypted documents](https://learn.microsoft.com/en-us/purview/encryption-azure-ad-configuration#conditional-access-policies-and-encrypted-documents). Note that unmanaged tenants used with Azure RMS for Individuals count as external tenants and would therefore benefit from this configuration.

<img src='img/20231000-040023.png' width=500px>

##### Provision Guest Accounts in Your Tenant

If you do not want to trust MFA registrations from other tenants, the next secure option is to use guest accounts. 

Per [here](https://learn.microsoft.com/en-us/purview/encryption-azure-ad-configuration#guest-accounts-for-external-users-to-open-encrypted-documents), you have two options for creating guest accounts:

1. Create the guest account manually
2. Use [SharePoint and OneDrive integration with Azure AD B2B](https://learn.microsoft.com/en-us/sharepoint/sharepoint-azureb2b-integration) so that guest accounts are automatically created when your users share links.

For the best experience, in addition to having a guest account, the user must have an account in Entra ID, either from being an Azure/Office 365 customer or through signing up for an Azure RMS for Individuals account.  

If a user does not have an account in Entra ID, then the authentication experience varies depending on whether the user has registered for a Microsoft (consumer) account. If the user has not registered for a Microsoft account then the user will be prompted for a one-time passcode. If the user has registered for a Microsoft account then the user will be prompted to sign in with their Microsoft account. See [Invitation Redemption Workflow](https://docs.microsoft.com/en-us/azure/active-directory/external-identities/redemption-experience#invitation-redemption-flow). 

Registering for a Microsoft account is a separate process than registering for Azure RMS for Individuals. Users may use a Microsoft account to avoid the one-time passcode prompt. If a user has registered for both a Microsoft account and an Azure RMS for Individuals account, then the user will need to choose between "Work or school account" and "Personal account".  In this case the correct option is "Work or school", which corresponds to the Azure RMS for Individuals account.

<img src='img/20231011-031155.png' width=300px>

##### Configure an Exception for the Azure Information Protection Application

A third option is to configure an exception for the Azure Information Protection application. Prior to the introduction of external identities cross-tenant access settings, this option may have been the most practical. However, it is less secure because it allows any application to bypass MFA.

See [Conditional Access policies for Azure Information Protection](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/conditional-access-policies-for-azure-information-protection/ba-p/250357) and [FAQ](https://learn.microsoft.com/en-us/azure/information-protection/faqs#i-see-azure-information-protection-is-listed-as-an-available-cloud-app-for-conditional-accesshow-does-this-work).

<img src='img/20231012-041215.png' width=300px>

### Application Support for Accessing Protected Documents

Users must use an Azure RMS-enlightened application to access protected content. This list includes

- Microsoft 365 Apps
- Office Professional Plus 2013, 2016, and 2019
- Office 2016 for Mac, Office 2019 for Mac

See [Application support for protection](https://learn.microsoft.com/en-us/azure/information-protection/requirements-applications#rms-enlightened-applications).

With regard to label visibility, users outside the organization do not see the label name. However, they do see the content markings, e.g. header or footer, and the name and description of the underlying Azure RMS protection template. The description of the Azure RMS template pulls from the description of the label, so external users do ultimately see the label description. 

See [Support for external users and labeled content](https://learn.microsoft.com/en-us/purview/sensitivity-labels-office-apps?view=o365-worldwide#support-for-external-users-and-labeled-content).

#### Manage Protected Document Attributes

The following sections use commands from the [AIPService](https://learn.microsoft.com/en-us/powershell/module/aipservice/?view=azureipps) and [AzureInformationProtection](https://learn.microsoft.com/en-us/powershell/module/azureinformationprotection/?view=azureipps) PowerShell modules.  See [Azure Information Protection](https://learn.microsoft.com/en-us/powershell/azure/aip/overview?view=azureipps) for an overview on how to use these modules. The AzureInformationProtection module is different and from and supplements the AIPService PowerShell module that manages the Azure Rights Management service for Azure Information Protection.  

#### RMS Issuer and RMS Owner

The account that protects the content becomes the Rights Management issuer.  This account is logged as the RMSIssuer.  The Rights Management issuer has Full Control usage rights in addition:

- The Rights Management issuer can open items after the expiry date
- The Rights Management issuer can always access offline
- The Rights Management issuer can still open a document after it is revoked

The Rights Management issuer also becomes the Rights Management owner. There are two scenarios where the Rights Management owner can be different from the Rights Management issuer:

1. When bulk-protecting files in a file share, e.g. by using the `Set-AIPFileLabel` cmdlet
2. When using the Rights Management connector to protect Office documents on a Windows Server folder

In these scenarios, you have the option to specify a separate owner.  For example, the `Set-AIPFileLabel` cmdlet has the (undocumented) **Owner** parameter, which you can use to assign the Rights Management owner to another account.

<img src='img/20231054-035434.png' width=600px>

See [Rights Management Issuer and Rights Management Owner](https://learn.microsoft.com/en-us/azure/information-protection/configure-usage-rights#rights-management-issuer-and-rights-management-owner).

#### Determine The Owner of a Protected Document

If a document is protected with user-defined permissions, then the person opening the document who doesn't have permissions will receive a message to contact the document owner with email address provided:

![](img/20231030-053027.png)

If a document is protected with a label that uses predefined permissions, then the person opening the document who doesn't have permissions will receive a message to request permission from the contact owner. However, no email address is provided, leaving the user without any knowledge of the content owner:

![](img/20231037-053713.png)

The user can open the document properties and see the original author and the person who last saved the document, but this doesn't guarantee that the content owner, i.e. the person who encrypted the document, is the same as the original author.

Unfortunately, the user currently does not have a built-in method for determining the content owner for a protected document with predefined permissions. However, there are a couple of workarounds:

- Azure Information Protection Unified Labeling Client
- Get-AIPFileStatus Cmdlet

##### Azure Information Protection Unified Labeling Client

The Azure Information Protection Unified Labeling client is set for retirement. However, the client is still available for download and can be used to determine the owner of a protected document. See [Azure Information Protection client for Windows](https://docs.microsoft.com/en-us/azure/information-protection/rms-client/clientv2-admin-guide-install).

The Azure Information Protection Unified Labeling client introduces a context menu entry into Windows File Explorer called **Classify and Protect**. When a user opens a document using Classify and Protect without having permissions to the document, the client displays the content owner's email address:   

<img src='img/20231058-055858.png' width=700px>

The **View Permission** button becomes available only when the user does have permissions to the document.

<img src='img/20231057-035720.png' width=500px>

##### Get-AIPFileStatus Cmdlet

An admin can use `Get-AIPFileStatus` to determine the owner of a protected document. See [Get-AIPFileStatus](https://learn.microsoft.com/en-us/powershell/module/azureinformationprotection/get-aipfilestatus?view=azureipps). This cmdlet is available in the [AzureInformationProtection](https://learn.microsoft.com/en-us/powershell/module/azureinformationprotection/?view=azureipps) PowerShell module, which is installed with the [Azure Innformation Protection Unified Labeling](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/aip-clientv2) client.

<img src='img/20231054-035434.png' width=600px>

When specifying a directory instead of a file name, the command recursively searches and provides file protection results for all protected files. See [Example 3: List the files labeled...](https://learn.microsoft.com/en-us/powershell/module/azureinformationprotection/get-aipfilestatus?view=azureipps#example-3-list-the-files-labeled-confidential-and-export-the-results-to-a-csv-file).

A couple of things to note:

1. Files protected using custom permissions instead of a template indicate "Restricted Access" instead of the template name.
2. Password-protected files always return the protection status of **False**
3. This command may be used only for protected files in your tenant; it cannot be used to get the file protection status of protected files from other tenants.

#### Change the Owner of a Protected Document

If the document was protected using custom permissions, then you must remove protection and protect the document again. You cannot change the RMS owner of the existing document. See [FAQ - I've protected a document and now want to change usage rights](https://learn.microsoft.com/en-us/azure/information-protection/faqs-rms#ive-protected-a-document-and-now-want-to-change-the-usage-rights-or-add-usersdo-i-need-to-reprotect-the-document).

Note: `Set-AIPFileLabel` has an undocumented `-Owner` switch. However, this switch does not change the owner of the RMS file. See [Set-AIPFileLabel](https://learn.microsoft.com/en-us/powershell/module/azureinformationprotection/set-aipfilelabel?view=azureipps).

#### Remove Protection from a Document

Use `Set-AIPFileLabel` with the `-RemoveProtection` option to remove protection from a document. `Set-AIPFileLabel` is available in the [AzureInformationProtection](https://learn.microsoft.com/en-us/powershell/module/azureinformationprotection/?view=azureipps) PowerShell module, which comes when installing the [Azure Information Protection Unified Labeling Client](https://learn.microsoft.com/en-us/azure/information-protection/rms-client/aip-clientv2).

<img src='img/20231012-061242.png' width=1100px>

To run this command successfully, the **SuperUserFeature** must be enabled, and the admin must be a super user. See [Enable the super user feature](https://docs.microsoft.com/en-us/azure/information-protection/configure-super-users).  

#### Remove Encryption from a Document in SharePoint Online 

See [Unlock-SPOSensitivityLabelEncryptedFile](https://learn.microsoft.com/en-us/powershell/module/sharepoint-online/unlock-sposensitivitylabelencryptedfile?view=sharepoint-ps). This method supports Office docs and PDFs. The **Modified By** column in SharePoint will reflect that the **System Account** modified the document.

![](img/20231030-033043.png)

To get the URL, copy the Path from document details:  

<img src='img/20231031-033150.png' width=200px>

### Manage the Azure Information Protection Service

See [Configure super users for Azure Information Protection](https://docs.microsoft.com/en-us/azure/information-protection/configure-super-users).  Use the following commands to manage the super user feature:

- `Get-AIPServiceSuperUserFeature`
- `Enable-AIPServiceSuperUserFeature`
- `Disable-AIPServiceSuperUserFeature`
- `Add-AIPServiceSuperUser`
- `Remove-AIPServiceSuperUser`
- `Set-AIPServiceSuperUserGroup`
- `Clear-AIPServiceSuperUserGroup`

When the super user feature is enabled, super users may open any protected document that was encrypted by the tenant's RMS service. Be sure to read [Security best practices for the super user feature](https://learn.microsoft.com/en-us/azure/information-protection/configure-super-users#security-best-practices-for-the-super-user-feature). 

You can use `Get-AipServiceAdminLog` to understand when the super user feature was used.  Protection See [Logging and analyzing the protection usage from Azure Information Protection](https://learn.microsoft.com/en-us/azure/information-protection/log-analyze-usage). The log file can be large, several MB in size, so use the `-FromTime` switch to keep the file size down.

![](img/20231032-043222.png)

The log captures all administrative events related to the Azure RMS service, including when admins accessed the log and when the super user feature was activated and deactivated. Log entry times are in UTC. See [Example auditing for the super user feature](https://learn.microsoft.com/en-us/azure/information-protection/configure-super-users#example-auditing-for-the-super-user-feature).

![](img/20231033-043336.png)

### Track and Revoke Documents

Microsoft is introducing new features both to the Purview Compliance portal and to the Office apps to enable tracking and revocation for labeled and protected files. See [Track and revoke encrypted documents](https://learn.microsoft.com/en-us/purview/track-and-revoke-admin). 

Per the [Microsoft Roadmap](https://www.microsoft.com/en-us/microsoft-365/roadmap?filters=Worldwide%20(Standard%20Multi-Tenant)&searchterms=revocation), expect new features in document tracking and revocation to be introduced in 2023 Q4. These features include

1. The ability ability for Office to register files for tracking.  This only applies to local files.
2. The ability for users to access the Purview Compliance portal to check who has tried accessing their labeled and protected documents, and revoke when needed.
3. Users can access the Compliance Portal from the Sensitivity menu

Today, there are a few [limitations](https://learn.microsoft.com/en-us/purview/track-and-revoke-admin#limitations):

1. Tracking and revocation doesn't work for PDFs
2. Tracked documents uploaded to OneDrive or SharePoint lose their ability to be tracked or revoked. Tracking applies for local files only.
3. As of October 2023, enablement of document tracking is only supported with the beta version of Office

Also note that usage of the Azure Information Protection Unified Labeling client, which is set for retirement, does not enable document tracking as it once did, as Microsoft has disabled Office integration that enables this feature.

#### Track Document Access

Per [Track document access](https://learn.microsoft.com/en-us/purview/track-and-revoke-admin#track-document-access), from the `AIPService` PowerShell module, use `Get-AipServiceDocumentLog` and note the **ContentId**.

<img src='img/20231040-044020.png' width=900px>

The cmdlet performs a string match on the **ContentName**. Wildcards are not supported. Log entries corresponding typically show up immediately after enabling tracking on a document, i.e. by opening a local document with a supported version of Office. An **Issuer** as *personal* means that the file was downloaded from OneDrive or SharePoint instead of being created locally.

Note, you can use the undocumented `-UserEmail` option to search for tracked documents from a specific user:

<img src='img/20231004-040405.png' width=800px>

In the screenshot below, note the document owner as the user in the resource tenant, i.e. where the tracking originated.  

<img src='img/20231003-040342.png' width=900px>

Then use `Get-AipServiceTrackingLog` with the document's **ContentId** to return your tracking data.

In the screenshot below, note the requester email is from an external tenant.  The time reported is in UTC, not local time.

<img src='img/20231006-040651.png' width=700px>

#### Revoke Document Access

See [Revoke document access from PowerShell](https://learn.microsoft.com/en-us/purview/track-and-revoke-admin#revoke-document-access-from-powershell).

Use the same procedure above to find the **ContentId** of the document you wish to revoke; then run `Set-AIPServiceDocumentRevoked` with your document's **ContentId** to revoke access to the document.

<img src='img/20231039-043913.png' width=1100px>

Specify the **Issuer** (not the **Owner**) as found from `Get-AipServiceDocumentLog`:  

<img src='img/20231040-044020.png' width=900px>

If **offline access** is allowed, users will continue to be able to access the documents that have been revoked until the offline policy period expires. If no expiration date is set, the default policy period is 30 days. See [Rights Management use license for offline access](https://learn.microsoft.com/en-us/purview/encryption-sensitivity-labels#rights-management-use-license-for-offline-access). You can change the default validity period for the tenant using `Set-AipServiceMaxUseLicenseValidityTime`.  See [Rights Management use license](https://learn.microsoft.com/en-us/azure/information-protection/configure-usage-rights#rights-management-use-license).

When attempting to access a revoked document, the user receives a permissions message:

<img src='img/20231043-044315.png' width=900px>

To restore access use `Clear-AipServiceDocumentRevoked`:

<img src='img/20231045-044540.png' width=900px>

### Audit Label Access and Usage

You have several options to determine if a label has been accessed or used:

- Microsoft Purview Compliance Portal > Activity Explorer
- Microsoft Purview Compliance Portal > Audit
- PowerShell Search-UnifiedAuditLog cmdlet
- Microsoft Defender for Cloud Apps > Activity Log

In all cases above, search results only return for items managed by Microsoft Purview.  This includes SharePoint, OneDrive, Teams, Exchange Online, and managed devices. Audit results do not include access events of this scope, e.g. protected documents opened by external users. 

With regard to the RMS service, an access event is generated each time a labeled or protected document is opened. See [Access audit logs](https://learn.microsoft.com/en-us/azure/information-protection/audit-logs#access-audit-logs). However, file access and denied events (1) do not currently include the file name and (2) are not accessible in the Microsoft 365 unified audit log. See [Protection usage logs and Microsoft 365 unified audit log](https://learn.microsoft.com/en-us/azure/information-protection/log-analyze-usage#protection-usage-logs-and-microsoft-365-unified-audit-log). This effectively means the audit log may not be used to view RMS events. 

However, labeled documents that are accessed by users managed under Microsoft Purview will appear in the audit log. See [Sensitivity label activities](https://learn.microsoft.com/en-us/purview/audit-log-activities#sensitivity-label-activities) for the types of labeling events stored in the audit log. 

See [Auditing labeling activities](https://learn.microsoft.com/en-us/purview/sensitivity-labels-office-apps#auditing-labeling-activities).

#### Activity Explorer

The Activity Explorer in the Microsoft Purview Compliance portal provides a 30-day search window of label activities. See [Get started with activity explorer](https://learn.microsoft.com/en-us/microsoft-365/compliance/data-classification-activity-explorer?view=o365-worldwide) and [Labeling actions reported in Activity Explorer](https://learn.microsoft.com/en-us/purview/data-classification-activity-explorer-available-events?view=o365-worldwide). Activity Explorer records labeling activities, such as when a label is applied or changed or when a labeled file is read. For small environments, it generally takes between 3-5 minutes for an activity to appear in Activity Explorer. Some activities take longer than others to appear. For example, the `File read` activity may take 10-15 minutes. 

Per [Labeling actions reported in Activity Explorer](https://learn.microsoft.com/en-us/purview/data-classification-activity-explorer-available-events#sensitivity-label-applied), Activity Explorer does not record events by the RMS Service. Therefore, do not expect access events for protected documents outside of areas managed by Microsoft Purview to appear in Activity Explorer, e.g. protected documents opened by external users.

#### Auditing Framework

Microsoft provides an auditing framework that may be used to track label usage. You can use two methods for accessing labeling events the audit log for sites and items managed by Microsoft Purview:

- Microsoft Purview Compliance Audit log search
- The Search-UnifiedAuditLog cmdlet

Per the [FAQ](https://learn.microsoft.com/en-us/purview/audit-log-search?redirectSourcePath=%252fen-us%252farticle%252fSearch-the-audit-log-in-the-Office-365-Security-Compliance-Center-0d4d0f35-390b-4518-800e-0c7ec95e946c#frequently-asked-questions), data in the audit search is generally available within 60-90 minutes but can take up to 24 hours to appear. See [Before you search the audit log](https://learn.microsoft.com/en-us/purview/audit-log-search#before-you-search-the-audit-log).

#### Search-UnifiedAuditLog Cmdlet

The Microsoft Purview Audit feature and `Search-UnifiedLog` cmdlet have a 90-day search window for non-E5-licensed users and a 365-day search window for E5-licensed users (see [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-solutions-overview?view=o365-worldwide#comparison-of-key-capabilities)). You can search up to a 10-year history if (1) the user's whose audit data is covered is assigned a 10-Year Audit Log Retention Add-on license (in addition to an E5 license) and (2) you have explicitly created an audit retention policy for longer 1 year for activities that record sensitivity label actions. See [Manage audit log retention policies](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-log-retention-policies?view=o365-worldwide).

Microsoft Defender for Cloud Apps stores its activity data for 180 days (see [here](https://learn.microsoft.com/en-us/defender-cloud-apps/cas-compliance-trust#data-retention)). In the advanced filter use **Action type > contains > "Sensitivity"**. The results indicate sensitivity label actions but do not indicate the sensitivity label display name.

The article, [Analyzing the Use of Sensitivity Labels without the Activity Explorer](https://office365itpros.com/2022/11/15/sensitivity-labels-analysis/) references a script,  [AnalyzeSensitivityLabelUsage.ps1](https://github.com/12Knocksinna/Office365itpros/blob/master/AnalyzeSensitivityLabelUsage.PS1), that can be used to report sensitivity label usage. 

See [Sensitivity label activities](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-log-activities?view=o365-worldwide#sensitivity-label-activities) for a list of all events from using sensitivity labels. See [Sentinel - Microsoft Purview Information Protection Connector Reference](https://learn.microsoft.com/en-us/azure/sentinel/microsoft-purview-record-types-activities) for a list of Information Protection activities. The [Office 365 Management Activity API schema](https://learn.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-schema) is a definitive list of all properties in audit data record types.

### Use PowerShell to Manage Sensitivity Labels and RMS Templates

**Security & Compliance PowerShell**  
The commands for managing sensitivity labels are found in [Security & Compliance PowerShell](https://learn.microsoft.com/en-us/powershell/exchange/scc-powershell?view=exchange-ps). Use `Connect-IPPSession` in the Exchange Online Management PowerShell module to manage sensitivity labels and policies.

Documentation for managing labels through PowerShell can be found at [Policy and Compliance](https://learn.microsoft.com/en-us/powershell/module/exchange/?view=exchange-ps#policy-and-compliance). 

Run `Get-Command -Module tmp* -noun *label*` to see the available commands.

<img src='img/20230654-115431.png' width=700px>

#### AIPService PowerShell module

The [AIPService](https://learn.microsoft.com/en-us/powershell/module/aipservice/?view=azureipps) PowerShell module provides additional commands for managing the underlying RMS service and templates. Notable commands include

- `Connect-AipService`
- `Get-AipServiceTemplate`
- `Get-AipServiceTemplateProperty`
- `Get-AipSuperUser`
- `Get-AipSuperUserGroup`
- `Get-AipSuperUserFeature`

The AIPService PowerShell module only works in Windows PowerShell. It does not work in PowerShell Core.

After you delete a sensitivity label, the underlying RMS template remains in the AIP service, allowing users to be able to open protected documents even after a label is removed.

#### Get Info on Sensitivity Labels and Policies

Run `Get-Label` to get a list of all sensitivity labels in your tenant. 

```powershell
Get-Label | Select Priority, ContentType, DisplayName, ParentLabelDisplayName, Name, ExchangeObjectId, ParentId | ft -AutoSize
```

![](img/20230606-120634.png)

Wrapped in a function, this looks like:  

```powershell
function Get-PvLabel {
    Get-Label | Select-Object Priority, ContentType, DisplayName, 
        ParentLabelDisplayName, Name, ExchangeObjectId, ParentId | 
        Format-Table -AutoSize
}
```

Use the `-Identity` parameter to get a specific label. This parameter takes the label's Name property or GUID (ExchangeObjectId). **You cannot specify the label's DisplayName property for the `Identity` parameter.** In the case of Microsoft's default labels (see above picture), the `ExchangeObjectId` is the same as the label's `Name`. However, these two values will be different for custom labels that you create

![](img/20230657-045742.png)

Use `Get-LabelPolicy` to get a list of all label policies in your tenant. 

```powershell
Get-LabelPolicy | Select Name, Priority, CreatedBy, WhenChanged, ExchangeObjectId, Labels, ScopedLabels | ft -AutoSize
```

![](img/20230610-041038.png)

The command output from above prints the labels but it doesn't make it easy to understand which labels are part of which policies. Use the following command to get a better view of the labels in each policy:  

```powershell
function Get-PvLabelPolicy {
    param(
        [switch]$TreeView
    )
    $labels = Get-Label | Select-Object Name, Priority, ExchangeObjectId,
        @{n = 'LabelPath'; e = {
            if ($_.ParentId) {
                "$( $_.ParentLabelDisplayName ) > $( $_.DisplayName )"
            }
            else {
                "$( $_.DisplayName )"
            }
        }}

    $labelLookup = @{}
    foreach ($l in $labels) {
        $labelLookup[$l.Name] = $l
    }

    $results = Get-LabelPolicy -WarningAction Ignore | 
        Select-Object Name, Priority, CreatedBy, WhenChanged, ExchangeObjectId,
            @{n = 'Labels'; e = {
                $sortedLabels = [System.Collections.Generic.List[PSCustomObject]]::new()
                foreach ($l in $_.Labels) {
                    if ($labelLookup.ContainsKey($l)) {
                        $sortedLabels.Add(
                            [PSCustomObject]@{
                                Name = $l
                                Priority = $labelLookup[$l].Priority
                                LabelPath = $labelLookup[$l].LabelPath
                            }
                        )
                    }
                }
                $sortedLabels | Sort-Object Priority | Select-Object -ExpandProperty LabelPath
            }}
        
    if ($PSBoundParameters.TreeView) {
        $results | Select-Object Name, 
            @{n='Labels';e={$_.Labels -join "`n"}} |
            Format-Table -wrap
    } else {
        $results
    }
}
Get-PvLabelPolicy | Tee-Object -Variable results
$results | Select Name, @{n='Labels';e={$_.Labels -join "`n"}} | ft -wrap

```

Use the `-TreeView` option to list the labels in order of priority.

<img src='img/20230657-035712.png' width=400px>

You can also run the command without any options to obtain the ExchangeObjectId.

<img src='img/20230657-035759.png' width=500px>

#### Create a Sensitivity Label

Use `New-Label` to create a new sensitivity label. This command requires three parameters, `Name`, `DisplayName`, and `Tooltip`. When needing to create new labels quickly, such as in a test environment, you may use the following command to create a new label with only specifying the `DisplayName` property.

```powershell
function New-PvLabel {
    param(
        [Parameter(Mandatory)]
        [string]$DisplayName,
        [string]$OrgPrefix = 'myorg',
        [string]$Tooltip = 'TBD'
    )
    $guid = (New-Guid).ToString().Substring(0,8)
    $labelName = "$OrgPrefix`_$guid"
    try {
        New-Label -DisplayName $DisplayName -Name $labelName -Tooltip $Tooltip -ErrorAction stop -WarningAction ignore
    } catch {
        Write-Warning $_.Exception.Message
    }
}
```

![](img/20230624-042415.png)

**ProTip!** As the company adopts the labeling system, the need to change label names may come up.  You can always change the `DisplayName` but you can't change the `Name`. Use a convention for the `Name` parameter such as `myorg_` followed by a GUID. This will allow you to change the `DisplayName` without having to recreate the label.

#### Use a Custom Color for a Sensitivity Label

The Compliance portal only lets you select from a limited number of colors for a sensitivity label. However, you can use PowerShell to set a custom color for a label. The following command will set the color to a light blue.  

```powershell
Set-Label -Identity '<Name or ExchangeObjectId>' -AdvancedSettings @{Color="#40e0e0"}
```

![](img/20230733-033302.png)

#### Create a Label Policy

Use the following command to create a new label policy. You cannot change the policy name once it is created. To change the name, you must delete the policy and create a new one.  

```powershell
function New-PvLabelPolicy {
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string[]]$Labels
    )
    $labelPolicy = @{
        Name = $Name
        Labels = $Labels
    }
    try {
        New-LabelPolicy @labelPolicy -ErrorAction stop -WarningAction ignore | Out-Null
    } catch {
        Write-Warning $_.Exception.Message
    }
}
```

![](img/20230637-033711.png)

#### Add a Sensitivity Label to a Label Policy

Use the following command to add one or more labels to a label policy:  

```powershell
Set-LabelPolicy -Identity 'My Label Policy' -AddLabel 'ExchangeObjectId or Name'
```

![](img/20230658-035835.png)

#### Set the Parent Label for a Sensitivity Label

Setting a parent label can only be done through PowerShell. Use the following command to set the parent label for a label:  

```powershell
Set-Label -Identity 'ExchangeObjectId or Name' -ParentLabel 'ExchangeObjectId or Name'
```

![](img/20230612-041236.png)


#### Remove a Sensitivity Label from a Label Policy

Let's say you want to delete a sensitivity label. Before you can delete it you must it remove it from all policies. Use the following commands to remove a label from a single label policy or all policies:

```powershell
function Remove-PvLabelFromPolicy {
    param (
        # Must be the label Name property, not the ExchangeObjectId or DisplayName
        [string]$LabelName,
        [Parameter(Mandatory=$true,ParameterSetName='Single')]
        [string]$LabelPolicyName,
        [Parameter(Mandatory=$true,ParameterSetName='All')]
        [switch]$All
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Single' {
            $label = Get-Label -Identity $LabelName 
            Set-LabelPolicy -Identity $LabelPolicyName -RemoveLabel $label.Name -WarningAction Ignore
        }
        'All' {
            Write-Output (Get-LabelPolicy) -PipelineVariable labelPolicy |
                Select-Object -ExpandProperty Labels |
                Where-Object { $_ -eq $LabelName } | 
                ForEach-Object { 
                    Set-LabelPolicy -Identity $labelPolicy.Name -RemoveLabel $_ -WarningAction Ignore
                }
        }
    }
}
```

Here's an example that removes the **Personal** label from all label policies:  
![](img/20230617-031746.png)

#### Remove a Label Policy

Use `Remove-LabelPolicy` to remove a label policy. This command requires the `Identity` parameter which takes the label policy's `Name` or `ExchangeObjectId`. After executing the command, the label policy will be placed in a pending deletion state. Allow 5-10 minutes for the deletion process to complete.

Run the following command to check the deletion state:

```powershell
Get-LabelPolicy -Identity <Name or ExchangeObjectId> | Select Name, Mode, DistributionStatus
```

![](img/20230624-032455.png)

#### Remove a Sensitivity Label

Prior to removing a sensitivity label you must make sure that the label is not assigned to any label policies. Use the following command to remove a label:

```powershell
Remove-Label -Identity <Name or ExchangeObjectId>
```

After executing the command, the label will be placed in a pending deletion state. Allow 5-10 minutes for the deletion process to complete.

<img src='img/20230626-032657.png' width=400px>

#### Get the Relationship Between a Label and an Azure RMS Template

When you delete a label that uses protection, the underlying protection template remains in the Azure RMS service. It is usually desirable to allow these templates to remain in the service so that users can continue to decrypt documents that were encrypted with the template. 

However, when you find yourself with a large number of templates you don't need, such as in testing, you may want to remove unused templates from the Azure RMS service. You may also want to rename templates that are no longer in use to prevent confusion. To do this, you need to know the relationship between the label and the template so that you don't delete a template that is still in use.

##### From Security and Compliance PowerShell

Use `Get-Label` with the `-IncludeDetailedLabelActions` switch to list the ID of the RMS template used by the label, i.e. the `EncryptionTemplateId` property:  

```powershell
Get-Label -IncludeDetailedLabelActions | select DisplayName, Name, ExchangeObjectId, EncryptionTemplateId
```

![](img/20230702-060249.png)

##### From AIPService PowerShell

Use the `LabelId` property from `Get-AipServiceTemplate` to find the label that corresponds to the template:  

```powershell
[array](Get-AipServiceTemplate) | Select TemplateId, Status, LabelId, Names
```

![](img/20230708-060835.png)

A status of `Published` indicates that the template is in use by a label policy.  A status of `Archived` indicates the template is not in use by a label policy.

The `Get-AipServiceTemplate` command has atypical PowerShell behavior. As a result, you may need to cast `Get-AipServiceTemplate` to an array for it to work properly with the PowerShell pipeline.  

The `LabelId` property from `Get-AipServiceTemplate` (in the prior screenshot) corresponds to the `ExchangeObjectId` or `Guid` property from `Get-Label` (in the screenshot below).

```powershell
Get-Label | Select DisplayName, Name, ExchangeObjectId, Guid
```

![](img/20230749-034935.png)

#### Back Up an Azure RMS Template

Use `Export-AipServiceTemplate` to back up an RMS template to an XML file. The file details include the template's name, public key and signature, tenant ID and label ID.  

```powershell
function Export-PvAzureRMSTemplates {
    # This function backs up an Azure RMS template to an XML file. The XML file is named after the template's GUID.
    param(
        [Parameter(Mandatory, ParameterSetName='All')]
        [switch]$All,
        [Parameter(Mandatory, ParameterSetName='Single')]
        [string]$TemplateId,
        [Parameter(Mandatory)]
        [string]$FolderPath
    )
    $ErrorActionPreference = 'Stop'
    if (-not (Test-Path $FolderPath)) {
        New-Item -Path $FolderPath -ItemType Directory | Out-Null
    }
    $templateIds = @()
    if ($PSCmdlet.ParameterSetName -eq 'All') {
        $templates = Get-AipServiceTemplate
        $templateIds += $templates | Select-Object -ExpandProperty TemplateId | Select-Object -ExpandProperty Guid
    } else {
        $templateIds += $TemplateId
    }
    foreach ($t in $templateIds) {
        $templatePath = $FolderPath + "\" + $t + ".xml"
        Export-AipServiceTemplate -TemplateId $t -Path $templatePath -Force
    }
}
```

#### Remove an RMS Template

In some cases you may want to completely remove an RMS template from the AIP service.  To do this use `Remove-AIPServiceTemplate` with the `-TemplateId` parameter. Global Admin permissions are required. **Warning**: This will remove the template from the AIP service and prevent users from decrypting documents that were encrypted with the template. Make sure you back up the template before removing in case you need to restore it.

 As an additional note, you can only remove templates that you have created. The [Microsoft documentation](https://learn.microsoft.com/en-us/powershell/module/aipservice/remove-aipservicetemplate?view=azureipps) indicates you can only delete templates that you have created for your organization and that you cannot delete the default templates. However, in testing I 
was able to delete the default templates.
![](img/20230710-051013.png)

If you remove an Azure RMS template that's still linked to a label, then you will receive a warning message when retrieving details about the label:  
![](img/20230725-042539.png)

#### Restore an RMS Template

Use `Import-AipServiceTemplate` to restore an RMS template from an XML file. Given that RMS templates are unique to the tenant, you can only restore templates that were backed up from the same tenant.  
![](img/20230727-042727.png)


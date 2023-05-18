# Permissions, Roles, and Scopes in Microsoft Purview

## Links
- [Permissions in the Microsoft Purview compliance portal](https://learn.microsoft.com/en-us/microsoft-365/compliance/microsoft-365-compliance-center-permissions?view=o365-worldwide)
- [Roles and role groups in Microsoft Defender for Office 365 and Microsoft Purview compliance](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/scc-permissions?toc=%2Fmicrosoft-365%2Fcompliance%2Ftoc.json&bc=%2Fmicrosoft-365%2Fbreadcrumb%2Ftoc.json&view=o365-worldwide)

## Overview
The Microsoft Purview compliance portal has a **Permissions** tab you may use for assigning permissions. Permissions in the compliance portal are based on role-based access control (RBAC) permissions model. 

The RBAC model is similar to the one used with Exchange Online. But it's important to remember that the role groups in Exchange Online and role groups for Defender for Office 365 or Purview compliance don't share membership or permissions. For example, while an Organization Management role group exists in Exchange Online, the permissions granted and role group members are different than the Organization Management role group in Defender for Office 365 and Purview compliance. 

There are several concepts for the RBAC model:
- Role: grants permissions to do a set of tasks
- Role Group: a set of roles that enable users to do their jobs across compliance solutions in the compliance portal

You add users to role groups, and role groups contain multiple roles, with each role having a set of permissions.  
![](img/20230549-034923.png)

You can create new role groups but you cannot create new roles. 

The **Permissions** tab lists role groups. To view the Permissions tab, you need to be an admin. Specifically, you need to be assigned the **Role Management** role, and that role is assigned only to the **Organization Management** role group by default. The **Role Management** role also allows you to view, create, and modify role groups. 

![](img/20230546-034659.png)

Here's a description of the role groups with the most permissions.

| Role Group | Number of Role Assignments | Description
| - | - | - |
| OrganizationManagement                | 38  | Members of this management role group have permissions to manage Exchange objects and their properties in the Exchange organization. Members can also delegate role groups and management roles in the organization. This role group shouldn't be deleted.  | 
| ComplianceAdministrator               | 33  | Manage settings for device management, data loss prevention, reports, and preservation.  | 
| ComplianceDataAdministrator           | 24  | Manage settings for device management, data protection, data loss prevention, reports, and preservation.  | 
| SecurityAdministrator                 | 17  |   | 
| PrivacyManagement                     | 13  | Manage access control for Privacy Management solution in the Microsoft 365 Compliance Center.  | 
| GlobalReader                          | 12  | View reports, alerts, and settings of security and compliance features.  | 
| SecurityOperator                      | 11  | Manage security alerts, and also view reports and settings of security features.  | 
| eDiscoveryManager                     | 11  | Perform searches and place holds on mailboxes, SharePoint Online sites, and OneDrive for Business locations.  | 
| InsiderRiskManagement                 | 11  | Manage access control for Insider risk management in the Microsoft 365 Compliance Center.  | 
| CommunicationCompliance               | 10  | Provides permission to all the communication compliance roles: administrator, analyst, investigator, and viewer.  | 
| DataInvestigator                      |  9  | Perform searches on mailboxes, SharePoint Online sites, and OneDrive for Business locations.  | 
| SecurityReader                        |  8  |   | 
| InformationProtection                 |  7  | Full control over all information protection features, including sensitivity labels and their policies, DLP, all classifier types, activity and content explorers, and all related reports.  | 
| PrivacyManagementInvestigators        |  6  | Analysts of privacy management solution that can investigate policy matches, view message content, and take remediation actions.  | 
| CommunicationComplianceInvestigators  |  6  | Analysts of communication compliance that can investigate policy matches, view message content, and take remediation actions.  | 
| InformationProtectionInvestigators    |  5  | Access and manage DLP alerts, activity explorer, and content explorer. View-only access to DLP policies, sensitivity labels and their policies, and all classifier types.  | 
| ComplianceManagerAdministrators       |  5  | Manage template creation and modification.  | 
| InsiderRiskManagementInvestigators    |  5  | Investigators of insider risk management that can triage alerts, investigate and action on cases as well as explore content.  | 
| PrivacyManagementAnalysts             |  5  | Analysts of privacy management solution that can investigate policy matches, view messages meta data, and take remediation actions.  | 
| PrivacyManagementAdministrators       |  5  | Administrators of privacy management solution that can create/edit policies and define global settings.  | 
| SubjectRightsRequestAdministrators    |  5  | Administrators who are able to create subject rights requests.  | 
| InsiderRiskManagementAdmins           |  4  | Administrators of insider risk management that can create/edit policies and define global settings.  | 
| CommunicationComplianceAdministrators |  4  | Administrators of communication compliance that can create/edit policies and define global settings.  | 
| ComplianceManagerAssessors            |  4  | Create assessments, implement improvement actions, and update test status for improvement actions.  | 
| DataEstateInsightsReaders             |  4  | A role group that provides read-only access to all insights reports across platforms and providers.  | 
| RecordsManagement                     |  4  | Members of this management role group have permissions to manage and dispose record content.  | 
| InformationProtectionAnalysts         |  3  | Access and manage DLP alerts and activity explorer. View-only access to DLP policies, sensitivity labels and their policies, and all classifier types.  | 
| ComplianceManagerContributors         |  3  | Create assessments and perform work to implement improvement actions.  | 
| InsiderRiskManagementAnalysts         |  3  | Analysts of insider risk management that can triage alerts, investigate and action on cases (but cannot explore content).  | 
| PrivacyManagementViewers              |  3  | Viewer of privacy management solution that can access the available dashboards and widgets.  | 
| PrivacyManagementContributors         |  3  | Manage contributor access for privacy management cases.  | 
| DataCatalogCurators                   |  2  | Data Catalog curators can perform create, read, modify, and delete actions on catalog data objects and establish relationships between objects.  | 
| InformationProtectionAdmins           |  2  | Create, edit, and delete DLP policies, sensitivity labels and their policies, and all classifier types. Manage endpoint DLP settings and simulation mode for auto-labeling policies.  | 
| CommunicationComplianceViewers        |  2  | Viewer of communication compliance that can access the available reports and widgets.  | 
| SubjectRightsRequestApprovers         |  2  | Approvers who are able to approve subject rights requests.  | 
| IRMContributors                       |  2  | Manage contributor access for Insider risk management.  | 
| CommunicationComplianceAnalysts       |  2  | Analysts of communication compliance that can investigate policy matches, view messages meta data, and take remediation actions.  | 
| QuarantineAdministrator               |  1  | Manage and control quarantined messages.  | 
| Reviewer                              |  1  | Use a limited set of the analysis features in Office 365 Advanced eDiscovery. Members of this group can see only the documents that are assigned to them.  | 
| InsiderRiskManagementSessionApprovers |  1  | For internal approval use only.  | 
| ServiceAssuranceUser                  |  1  | Access the Service Assurance section in the Security & Compliance Center. Members of this role group can use this section to review documents related to security, privacy, and compliance in Office 365 to perform risk and assurance reviews for their own organization.  | 
| SupervisoryReview                     |  1  | Control policies and permissions for reviewing employee communications.  | 
| KnowledgeAdministrators               |  1  | Can configure knowledge, learning, assign trainings and other intelligent features.  | 
| InsiderRiskManagementAuditors         |  1  | Auditors of insider risk management that can view the audit logs of actions performed by Analysts, Investigators and Administrators.  | 
| AttackSimAdministrators               |  1  | Create and manage all aspects of attack simulation campaigns.  | 
| InformationProtectionReaders          |  1  | View-only access to reports for DLP policies and sensitivity labels and their policies.  | 
| ContentExplorerListViewer             |  1  | Provides the ability to view all items in Content explorer in list format only.  | 
| ContentExplorerContentViewer          |  1  | Provides the ability to view the contents of the files.  | 
| ComplianceManagerReaders              |  1  | View all Compliance Manager content except for administrator functions.  | 
| MailFlowAdministrator                 |  1  |   | 
| BillingAdministrator                  |  1  | Can configure Billing features.  | 
| AttackSimPayloadAuthors               |  1  | Create and manage attack payloads that can be deployed by attack simulator administrator.  | 
| InsiderRiskManagementApprovers        |  1  | For internal approval use only.  | 
| DefaultRoleAssignmentPolicy           |  1  |   | 

Used the following PowerShell commands to pull this info:
```powershell
Get-RoleGroup | Select Name, @{n='No. Role Assignments';e={($_ | Select -ExpandProperty roleassignments).count}}, Description | Sort 'No. Role Assignments' -Descending | ft -auto
```

```powershell
((Get-RoleGroup | select -ExpandProperty roleassignments) -replace ".*/", '' | sort | ? {$_ -match "Organization Management"}).count
```

## Use PowerShell to Manage Role Groups
Here are the commands...

It's important to note the `-Identity` parameter in `Get-RoleGroupMember` is case sensitive. 

![](img/20230526-042652.png)
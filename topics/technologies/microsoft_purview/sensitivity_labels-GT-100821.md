# Sensitivity Labels in Microsoft Purview Information Protection

- [Helpful Links](#helpful-links)
- [Licensing for Sensitivity Labels](#licensing-for-sensitivity-labels)
- [Overview](#overview)
  - [Labels, Sublabels, and Label Scopes](#labels-sublabels-and-label-scopes)
  - [Container Support for Sensitivity Labels](#container-support-for-sensitivity-labels)
  - [Define and Create Sensitivity Labels](#define-and-create-sensitivity-labels)
  - [Editing or Deleting a Sensitivity Label](#editing-or-deleting-a-sensitivity-label)
  - [Built-in Labeling for the Office Apps](#built-in-labeling-for-the-office-apps)
  - [Label Taxonomy](#label-taxonomy)
  - [External Access](#external-access)
    - [Azure RMS for Individuals](#azure-rms-for-individuals)
    - [Addressing MFA Requirements for External Users](#addressing-mfa-requirements-for-external-users)
      - [Trust MFA Registrations from Other Tenants](#trust-mfa-registrations-from-other-tenants)
      - [Provision Guest Accounts in Your Tenant](#provision-guest-accounts-in-your-tenant)
      - [Configure an Exception for the Azure Information Protection Application](#configure-an-exception-for-the-azure-information-protection-application)
    - [Application Support for Accessing Protected Documents](#application-support-for-accessing-protected-documents)
- [Roles and Permissions in Microsoft Purview](#roles-and-permissions-in-microsoft-purview)
- [Manage the Azure Information Protection Service](#manage-the-azure-information-protection-service)
- [Protecting SharePoint Sites, Teams, and Groups with Sensitivity Labels](#protecting-sharepoint-sites-teams-and-groups-with-sensitivity-labels)
  - [Applying a Sensitivity Label to Content Automatically](#applying-a-sensitivity-label-to-content-automatically)
  - [Enabling PDF Support](#enabling-pdf-support)
- [Use PowerShell to manage Sensitivity Labels](#use-powershell-to-manage-sensitivity-labels)
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
  - [Determine if Label Has Been Used](#determine-if-label-has-been-used)
  - [Back Up an Azure RMS Template](#back-up-an-azure-rms-template)
  - [Remove an RMS Template](#remove-an-rms-template)
  - [Restore an RMS Template](#restore-an-rms-template)

## Helpful Links
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

## Licensing for Sensitivity Labels
The following licenses are required for using Information Protection features:
- An E5 license is required for each user who accesses protected documents in locations that use automatic labeling. 
- An E3 license is required when using manual labeling. Labeling by using a default label is considered manual labeling, as the user has the option to accept or change the label. By default, information protection features are applied at the tenant level for all users within the tenant.
- No license is necessary for someone who only opens and accesses the content in protected files.

See [Microsoft Licensing Guidance: Purview Information Protection](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance#microsoft-purview-information-protection-sensitivity-labeling)

  
## Overview
Sensitivity labels enable you to protect files and containers (Teams, SharePoint, OneDrive) from unauthorized access. Sensitivity labels can be applied manually using the [Sensitivity Bar](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide#sensitivity-bar) in the Office apps. Sensitivity labels also have [PDF support](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide#pdf-support). See [Common scenarios for sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/get-started-with-sensitivity-labels?view=o365-worldwide#common-scenarios-for-sensitivity-labels). A sensitivity label is stored in clear text in the metadata for files and emails. This allows third-party apps and services to read it and apply their own protective actions. It also means the label stays with the content, no matter where it's stored or saved.

### Labels, Sublabels, and Label Scopes
When you create sensitivity labels, they appear in a list on the **Information Protection > Labels** page in Microsoft Purview Compliance (https://compliance.microsoft.com). In this list, the order of the labels is important because it reflects their priority. You want your most restrictive sensitivity label, such as Highly Confidential, to appear at the bottom of your list, and your least restrictive label to appear at the top.

You can apply just one sensitivity label to an item, such as an email, document, or container. If you set an option that requires your users to provide a justification for changing a label to lower sensitivity, the order of this list identifies the lower sensitivity. However, users are not required to provide justification when changing to a lower priority *within a sublabel*. 

With sublabels, you can group one or more labels below a parent label that a user sees in an Office app. Sublabels are simply a way to present labels to users in logical groups. Sublabels don't inherit any settings from their parent label, except for their label color. When you publish a sublabel for a user, that user can then apply that sublabel to content and containers, but can't apply just the parent label. Don't choose a parent label as the default label, or configure a parent label to be automatically applied (or recommended). If you do, the parent label can't be applied.

The ordering of sublabels is used with automatic labeling. When you configure auto-labeling policies, multiple matches can result for more than one label. Then, the last sensitive label is selected, and then if applicable, the last sublabel. When you configure sublabels themselves (rather than auto-labeling policies) for automatic labeling, the behavior is a little different when sublabels share the same parent label. For example, a sublabel configured for automatic labeling is preferred over a sublabel configured for recommended labeling. See [How multiple conditions are evaluated when they apply to more than one label](https://learn.microsoft.com/en-us/microsoft-365/compliance/apply-sensitivity-label-automatically?view=o365-worldwide#how-multiple-conditions-are-evaluated-when-they-apply-to-more-than-one-label)

When you create a sensitivity label, you're asked to configure the label's scope, which determines two things:
- Which label settings you can configure for that label
- The availability of the label to apps and services, which includes whether users can see and select the label

See [Learn about sensitivity labels](https://learn.microsoft.com/en-us/purview/sensitivity-labels?view=o365-worldwide)

### Container Support for Sensitivity Labels
Containers include Teams, SharePoint sites, and Microsoft 365 Groups. Sensitivity labels can be applied to these containers, but the labels do not apply to the files within the containers. To protect files within Teams and SharePoint sites you must apply sensitivity labels to the files themselves (either manually or automatically) or to the SharePoint document library.

<img src='img/20230831-053108.png' width='600px'>

See [Use sensitivity labels with Teams, groups, and sites](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-teams-groups-sites?view=o365-worldwide#how-to-enable-sensitivity-labels-for-containers-and-synchronize-labels) for enabling scopes for containers.

### Define and Create Sensitivity Labels
By default, tenants do not have any labels, so you must create them. Sensitivity labels are provided using two steps:
1. Create the label
2. Publish the label to users using a label policy

Per [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide#when-to-expect-new-labels-and-changes-to-take-effect), allow up to 24 hours for labels and their settings to become available.  

<img src='img/20230633-033336.png' width='500px'>

See [Create and configure sensitivity labels and their policies](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide) for more info.

### Editing or Deleting a Sensitivity Label
If you delete a sensitivity label from the admin portal, the label isn't automatically removed from content, and any protection settings continue to be enforced on content that had that label applied. However, some caveats apply. See [Removing and deleting labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide#removing-and-deleting-labels) for more info.

### Built-in Labeling for the Office Apps
A subscription edition of Office apps is required to use sensitivity labels. Standalone/perpetual editions of Office aren't supported.

See [here](https://learn.microsoft.com/en-us/purview/sensitivity-labels-aip?view=o365-worldwide#features-supported-only-by-built-in-labeling-for-office-apps) for a list of features supported by built-in labeling for Office apps:
* Intelligent classification services for automatic and recommended labeling, i.e. trainable classifiers, exact data match, and named entities
* Sensitivity bar that's integrated into existing user workflows
* PDF support
* Protect meeting invites, with their attachments and responses
* For custom permissions, the ability to assign different permissions to users and groups
* Encrypt-only emails
* Support for account switching
* Users can't disable labeling

See [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-aip?view=o365-worldwide#features-not-planned-to-be-supported-by-built-in-labeling-for-office-apps) for a list of features Microsoft does not plan to support:
- Application of labels to Office 97-2003 formats, e.g. .doc files
- Local usage logging to the Windows Event log
- Permanently disconnected computers
- Standalone editions of Office, i.e. "Perpetual Office", rather than subscription-based Office

### Label Taxonomy
Defining the right label taxonomy and protection policies is the most critical step in a Microsoft Purview Information Protection deployment. It is important that you define a label taxonomy that will work for a long time, as changing labels after they have been deployed is a difficult task.

A good label taxonomy needs to meet business and/or regulatory needs, be intuitively understandable by users, provide good policy tips, and be easy to use. It should not prevent users from doing their jobs, while at the same time help prevent instances of data leakage or misuse and address compliance requirements.

See [Create a well-designed data classification framework](https://learn.microsoft.com/en-us/compliance/assurance/assurance-create-data-classification-framework) for further guidance. Eligible customers (new and existing) can activate a set of default protection labels and policies. See [Default Sensitivity Labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/mip-easy-trials?view=o365-worldwide#default-sensitivity-labels).

**Good Practices**
-  Start small and keep it simple. 
-  Start with labels and only introduce sublabels when you have a clear need for them, as users may find it challenging to find the right label to apply amongst a group of sublabels.
-  Define labels that will last a long time
- Start with what threats you are trying to prevent, e.g. users from accidentally putting sensitive data where unauthorized users can view it. Based on those requirements, define the minimal controls that must be there to ensure those scenarios don't happen.
- Use label names that intuitively resonate with your users. Don't use acronyms. Use short, meaningful words, e.g. "Confidential", "Secret"
- Avoid terms that may be ambiguous. Don't use terms where not all users might agree on whether "Confidential" or "Secret" is the most sensitive label; use "Confidential" and "Highly Confidential" instead.
-  Use sublabels with intent. Labels are used to represent the actual sensitivity  of the content that is labeled. Sublabels represent variations in the protection or the scope of the content. 
-  Compartmentalize sparingly. Using sublabels to give rights to people in specific departments is good practice, but you should use this capability in moderation. Limit the number of sublabels for departments to a small number and stick with it.
- Involve different teams to review your proposed label taxonomy. Defining labels is not an IT security task alone, and early feedback will help you define a label taxonomy that will work for a long time

See the full list and descriptions [here](https://microsoft.github.io/ComplianceCxE/dag/mip-dlp/)

### External Access
Users must have an account in Entra ID to access protected content. Azure/Office 365 customers can access without any additional configuration.  Non-Azure/Office 365 customers must sign up for an Azure RMS for Individuals account. The Azure RMS for Individuals service creates an account in an unmanaged Entra ID tenant.

#### Azure RMS for Individuals
Sensitivity labels use Azure RMS to protect content. Azure RMS uses Entra ID to authenticate access. When a user signs up for an [Azure RMS for Individuals](https://learn.microsoft.com/en-us/azure/information-protection/rms-for-individuals) account, the service creates an unmanaged Azure tenant and directory for the organization with an account for the user, so that this user (and subsequent users) can then authenticate to the Azure RMS service. See [Azure RMS FAQ](https://learn.microsoft.com/en-us/azure/information-protection/faqs-rms#when-i-share-a-protected-document-with-somebody-outside-my-company-how-does-that-user-get-authenticated).  

The following link can be provided to external users to sign up for an Azure RMS for Individuals account: https://aka.ms/rms-signup 

Any registered user can sign in to the Azure tenant created by Azure RMS for Individuals and view other user accounts that have been created.  

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

#### Application Support for Accessing Protected Documents
Users must use an Azure RMS-enlightened application to access protected content. This list includes
- Microsoft 365 Apps
- Office Professional Plus 2013, 2016, and 2019
- Office 2016 for Mac, Office 2019 for Mac

See [Application support for protection](https://learn.microsoft.com/en-us/azure/information-protection/requirements-applications#rms-enlightened-applications).

With regard to label visibility, users outside the organization do not see the label name. However, they do see the content markings, e.g. header or footer, and the name and description of the underlying Azure RMS protection template. The description of the Azure RMS template pulls from the description of the label, so external users do ultimately see the label description. 

See [Support for external users and labeled content](https://learn.microsoft.com/en-us/purview/sensitivity-labels-office-apps?view=o365-worldwide#support-for-external-users-and-labeled-content).

## Roles and Permissions in Microsoft Purview

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

## Manage the Azure Information Protection Service
See the following links for more information: 
- [Configure super users](https://docs.microsoft.com/en-us/azure/information-protection/configure-super-users)
- [Azure Information Protection](https://learn.microsoft.com/en-us/powershell/azure/aip/overview?view=azureipps) - provides documentation on the **AIPService** and **AzureInformationProtection** PowerShell modules.


## Protecting SharePoint Sites, Teams, and Groups with Sensitivity Labels
Sensitivity labels for SharePoint sites, Teams, and Microsoft 365 Groups is not enabled by default. You must take several steps to enable sensitivity labels for these containers. See [Use sensitivity labels with teams, groups, and sites](https://learn.microsoft.com/en-us/purview/sensitivity-labels-teams-groups-sites).

**Step 1: Enable sensitivity label support for groups in PowerShell**  
Follow the guidance [here](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels#enable-sensitivity-label-support-in-powershell) to set the `EnableMIPLabels` setting for groups to `True`. New tenants do not have a directory setting for groups, so you must create one. See [here](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-cmdlets#template-settings) for a description of each template setting. Here are the default settings:

![](img/20230830-043058.png)

**Step 2: Synchronize sensitivity labels with Azure AD**  
As a global administrator, run `Execute-AzureADLabelSync` in a Windows PowerShell session. 

![](img/20230807-030748.png)

This command is tricky to get working. I've only had success when running in the following scenarios:
1. Running in Windows PowerShell, not modern PowerShell
2. After introducing the **Groups & Sites** scope to a label, waiting overnight, and then running the command

In other scenarios, the command may time out after 5 minutes with a JSON error.

In my case, the Sensitivity Label option for Microsoft 365 Groups appeared only after creating a Team, not a Microsoft 365 Group, and specifying a sensitivity label for the Team. The Sensitivity Label option will not appear for existing Microsoft 365 Groups.  

![](img/20230821-032128.png)

See the Microsoft Groups article [Assign sensitivity labels](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels) for more info on changing, removing, and troubleshooting labels for Microsoft 365 Groups.


### Applying a Sensitivity Label to Content Automatically
https://learn.microsoft.com/en-us/purview/apply-sensitivity-label-automatically



### Enabling PDF Support
See https://learn.microsoft.com/en-us/purview/sensitivity-labels-sharepoint-onedrive-files?view=o365-worldwide#enable-the-preview-by-using-microsoft-powershell-opt-in

https://learn.microsoft.com/en-us/purview/ome-faq#are-pdf-file-attachments-supported-

![](img/20230836-043600.png)

## Use PowerShell to manage Sensitivity Labels

**Security & Compliance PowerShell**  
The commands for managing sensitivity labels are found in [Security & Compliance PowerShell](https://learn.microsoft.com/en-us/powershell/exchange/scc-powershell?view=exchange-ps). Use `Connect-IPPSession` in the Exchange Online Management PowerShell module to manage sensitivity labels and policies.

Documentation for managing labels through PowerShell can be found at [Policy and Compliance](https://learn.microsoft.com/en-us/powershell/module/exchange/?view=exchange-ps#policy-and-compliance). 

Run `Get-Command -Module tmp* -noun *label*` to see the available commands.

![](img/20230654-115431.png)

**AIP Service**
The [AIPService](https://learn.microsoft.com/en-us/powershell/module/aipservice/?view=azureipps) PowerShell module provides additional commands for managing the underlying RMS service and templates. Notable commands include
- `Connect-AipService`
- `Get-AipServiceTemplate`
- `Get-AipServiceTemplateProperty`
- `Get-AipSuperUser`
- `Get-AipSuperUserGroup`
- `Get-AipSuperUserFeature`

The AIPService PowerShell module only works in Windows PowerShell. It does not work in PowerShell Core.

After you delete a sensitivity label, the underlying RMS template remains in the AIP service, allowing users to be able to open protected documents even after a label is removed.

### Get Info on Sensitivity Labels and Policies
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

![](img/20230657-035712.png)

You can also run the command without any options to obtain the ExchangeObjectId.

![](img/20230657-035759.png)

### Create a Sensitivity Label
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

### Use a Custom Color for a Sensitivity Label
The Compliance portal only lets you select from a limited number of colors for a sensitivity label. However, you can use PowerShell to set a custom color for a label. The following command will set the color to a light blue.  
```powershell
Set-Label -Identity '<Name or ExchangeObjectId>' -AdvancedSettings @{Color="#40e0e0"}
```
![](img/20230733-033302.png)


### Create a Label Policy
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

### Add a Sensitivity Label to a Label Policy
Use the following command to add one or more labels to a label policy:  
```powershell
Set-LabelPolicy -Identity 'My Label Policy' -AddLabel 'ExchangeObjectId or Name'
```
![](img/20230658-035835.png)

### Set the Parent Label for a Sensitivity Label
Setting a parent label can only be done through PowerShell. Use the following command to set the parent label for a label:  
```powershell
Set-Label -Identity 'ExchangeObjectId or Name' -ParentLabel 'ExchangeObjectId or Name'
```
![](img/20230612-041236.png)


### Remove a Sensitivity Label from a Label Policy
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


### Remove a Label Policy
Use `Remove-LabelPolicy` to remove a label policy. This command requires the `Identity` parameter which takes the label policy's `Name` or `ExchangeObjectId`. After executing the command, the label policy will be placed in a pending deletion state. Allow 5-10 minutes for the deletion process to complete.

Run the following command to check the deletion state:
```powershell
Get-LabelPolicy -Identity <Name or ExchangeObjectId> | Select Name, Mode, DistributionStatus
```
![](img/20230624-032455.png)


### Remove a Sensitivity Label
Prior to removing a sensitivity label you must make sure that the label is not assigned to any label policies. Use the following command to remove a label:
```powershell
Remove-Label -Identity <Name or ExchangeObjectId>
```

After executing the command, the label will be placed in a pending deletion state. Allow 5-10 minutes for the deletion process to complete.

![](img/20230626-032657.png)

### Get the Relationship Between a Label and an Azure RMS Template
When you delete a label that uses protection, the underlying protection template remains in the Azure RMS service. It is usually desirable to allow these templates to remain in the service so that users can continue to decrypt documents that were encrypted with the template. 

However, when you find yourself with a large number of templates you don't need, such as in testing, you may want to remove unused templates from the Azure RMS service. You may also want to rename templates that are no longer in use to prevent confusion. To do this, you need to know the relationship between the label and the template so that you don't delete a template that is still in use.

**From Security and Compliance PowerShell**  
Use `Get-Label` with the `-IncludeDetailedLabelActions` switch to list the ID of the RMS template used by the label, i.e. the `EncryptionTemplateId` property:  
```powershell
Get-Label -IncludeDetailedLabelActions | select DisplayName, Name, ExchangeObjectId, EncryptionTemplateId
```
![](img/20230702-060249.png)

**From AIPService PowerShell**  
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

### Determine if Label Has Been Used
You have four options for determining if a label has been used:

* Microsoft Purview Compliance > Activity Explorer
* Microsoft Purview Compliance Portal > Audit
* PowerShell Search-UnifiedLog cmdlet
* Microsoft Defender for Cloud Apps > Activity Log

Microsoft Purview Compliance Activity Explorer has a 30-day search window (see [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/data-classification-activity-explorer?view=o365-worldwide)). 

The Microsoft Purview Audit feature and `Search-UnifiedLog` cmdlet have a 90-day search window for non-E5-licensed users and a 365-day search window for E5-licensed users (see [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-solutions-overview?view=o365-worldwide#comparison-of-key-capabilities)). You can search up to a 10-year history if (1) the user's whose audit data is covered is assigned a 10-Year Audit Log Retention Add-on license (in addition to an E5 license) and (2) you have explicitly created an audit retention policy for longer 1 year for activities that record sensitivity label actions. See [Manage audit log retention policies](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-log-retention-policies?view=o365-worldwide).

Microsoft Defender for Cloud Apps stores its activity data for 180 days (see [here](https://learn.microsoft.com/en-us/defender-cloud-apps/cas-compliance-trust#data-retention)). In the advanced filter use **Action type > contains > "Sensitivity"**. The results indicate sensitivity label actions but do not indicate the sensitivity label display name.

The article, [Analyzing the Use of Sensitivity Labels without the Activity Explorer](https://office365itpros.com/2022/11/15/sensitivity-labels-analysis/) references a script,  [AnalyzeSensitivityLabelUsage.ps1](https://github.com/12Knocksinna/Office365itpros/blob/master/AnalyzeSensitivityLabelUsage.PS1), that can be used to report sensitivity label usage. This script audits the following information protection events:
- **SensitivityLabelApplied**: 
  - Scenario A: A user labels a document using one of the Office desktop apps (Word, Excel, or PowerPoint). In this case the record type property is *SensitivityLabelAction*.
  - Scenario B: A site owner or administrator applies a sensitivity label to a SharePoint site. In this case the record type property is *SharePoint*.
- **FileSensitivityLabelApplied**: A document is labeled from an Office on the web app or from an auto-labeling policy
- **SensitivityLabelUpdated**: A user changes a sensitivity label from one of the Office desktop apps (Word, Excel, or PowerPoint)
- **MipLabel**: Events related to the detection in the transport pipeline of email messages that have been tagged (manually or automatically) with sensitivity labels.

This script does not report on the following events:
- **SiteSensitivityLabelApplied**: A sensitivity label was applied to a SharePoint site or Teams site that isn't group connected
- **SiteSensitivityLabelRemoved**: A sensitivity label was removed from a SharePoint site or Teams site that isn't group connected
- **FileSensitivityLabelChanged**: A user changed a sensitivity label (upgrade or downgrade) for an Office document either by using Office on the web or from an auto-labeling policy.
- **SiteSensitivityLabelChanged**: A different sensitivity label was applied to a SharePoint site or Teams site that isn't group-connected.
- **FileSensitivityLabelRemoved**: A sensitivity label was removed by using Office on the web, an auto-labeling policy, or by [Unlock-SPOSensitivityLabelEncryptedFile](https://learn.microsoft.com/en-us/powershell/module/sharepoint-online/unlock-sposensitivitylabelencryptedfile?view=sharepoint-ps). 
- **SensitivityLabelRemoved**: A sensitivity label is removed by using the Office desktop apps
- **DocumentSensitivityMismatchDetected**: User uploads a document to a site that's protected with a sensitivity label and the document has a higher priority sensitivity label than the sensitivity label applied to the site.  This event isn't triggered if a document has a lower priority sensitivity label. See [Analyzing Document Label Mismatch Audit Records](https://office365itpros.com/2022/08/23/document-label-mismatch-audit/.)

See [Sensitivity label activities](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-log-activities?view=o365-worldwide#sensitivity-label-activities) for a list of all events from using sensitivity labels. See [Sentinel - Microsoft Purview Information Protection Connector Reference](https://learn.microsoft.com/en-us/azure/sentinel/microsoft-purview-record-types-activities) for a list of Information Protection activities. The [Office 365 Management Activity API schema](https://learn.microsoft.com/en-us/office/office-365-management-api/office-365-management-activity-api-schema) is a definitive list of all properties in audit data record types.

### Back Up an Azure RMS Template
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
### Remove an RMS Template
In some cases you may want to completely remove an RMS template from the AIP service.  To do this use `Remove-AIPServiceTemplate` with the `-TemplateId` parameter. Global Admin permissions are required. **Warning**: This will remove the template from the AIP service and prevent users from decrypting documents that were encrypted with the template. Make sure you back up the template before removing in case you need to restore it.

 As an additional note, you can only remove templates that you have created. The [Microsoft documentation](https://learn.microsoft.com/en-us/powershell/module/aipservice/remove-aipservicetemplate?view=azureipps) indicates you can only delete templates that you have created for your organization and that you cannot delete the default templates. However, in testing I 
was able to delete the default templates.
![](img/20230710-051013.png)

If you remove an Azure RMS template that's still linked to a label, then you will receive a warning message when retrieving details about the label:  
![](img/20230725-042539.png)

### Restore an RMS Template
Use `Import-AipServiceTemplate` to restore an RMS template from an XML file. Given that RMS templates are unique to the tenant, you can only restore templates that were backed up from the same tenant.  
![](img/20230727-042727.png)
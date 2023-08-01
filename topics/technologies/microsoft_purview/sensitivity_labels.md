# Sensitivity Labels

## Contents
- [Contents](#contents)
- [Links](#links)
- [Exam Goals](#exam-goals)
- [Licensing](#licensing)
- [Overview](#overview)
  - [Label Scopes](#label-scopes)
  - [Label Priority (Order Matters)](#label-priority-order-matters)
  - [Sublabels (Grouping Labels)](#sublabels-grouping-labels)
  - [Editing or Deleting a Sensitivity Label](#editing-or-deleting-a-sensitivity-label)
  - [What Label Policies Can Do](#what-label-policies-can-do)
  - [Label Policy (Priority Matters)](#label-policy-priority-matters)
  - [Built-in Labeling for the Office Apps](#built-in-labeling-for-the-office-apps)
  - [Defining Label Taxonomy](#defining-label-taxonomy)
- [Roles and Permissions](#roles-and-permissions)
  - [Manage the Azure Information Protection Service](#manage-the-azure-information-protection-service)
- [Define and Create Sensitivity Labels](#define-and-create-sensitivity-labels)
  - [Removing and Deleting Labels](#removing-and-deleting-labels)
- [Protecting SharePoint Sites, Teams, and Groups with Sensitivity Labels](#protecting-sharepoint-sites-teams-and-groups-with-sensitivity-labels)
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

## Links
- [Learn about sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels?view=o365-worldwide)
- [Create a well-designed data classification framework](https://learn.microsoft.com/en-us/compliance/assurance/assurance-create-data-classification-framework)
- [Microsoft Information Protection SDK: Classification label concepts](https://learn.microsoft.com/en-us/information-protection/develop/concept-classification-labels)
- [Microsoft roadmap for sensitivity labels](https://www.microsoft.com/en-us/microsoft-365/roadmap?filters=Worldwide%20(Standard%20Multi-Tenant)&searchterms=label)
- [Microsoft Purview CxE](https://microsoft.github.io/ComplianceCxE/)
- [Guidance on external collaboration with sensitivity labels](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/secure-external-collaboration-using-sensitivity-labels/ba-p/1680498)
- [End-user documentation for sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/get-started-with-sensitivity-labels?view=o365-worldwide#end-user-documentation-for-sensitivity-labels)
- [Licensing for sensitivity labels](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance#microsoft-purview-information-protection-sensitivity-labeling)
- [Partner solutions that integrate with Microsoft Information Protection](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/microsoft-information-protection-showcases-integrated-partner/ba-p/262657)
- [Unified Labeling Support Tool](https://github.com/microsoft/UnifiedLabelingSupportTool)

## Exam Goals
- Implement roles and permissions for administering sensitivity labels
- Define and create sensitivity labels
- Configure and manage sensitivity label policies
- Configure auto-labeling policies for sensitivity labels
- Monitor data classification and label usage by using Content explorer, Activity explorer, and audit search
- Apply bulk classification to on-premises data by using the Microsoft Purview Information Protection scanner
- Manage protection settings and marking for applied sensitivity labels

## Licensing
Reference
- [Microsoft Purview Information Protection - Sensitivity Labeling](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance#microsoft-purview-information-protection-sensitivity-labeling)

In general, an E5 license is required for each user who accesses protected documents in locations that use automatic labeling. An E3 license is required when using manual labeling.  
  
## Overview
To collaborate with others both inside and outside the organization, content no longer stays behind a firewall&mdash;it can roam everywhere across devices, apps, and services. When this data roams, you want it to be protected in a way that meets the org's business and compliance policies.

Sensitivity labels let you classify and protect your organization's data, while making sure that user productivity and their ability to collaborate isn't hindered.

Sensitivity labels can be applied manually using the [Sensitivity Bar](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide#sensitivity-bar) in the Office apps. Sensitivity labels also have [PDF support](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide#pdf-support).

Use cases for sensitivity labels:
- Provide protection settings that include encryption and content markings
- Protect content in Office apps across different platforms and devices
- Protect content in third-party apps and services
  - e.g. in Microsoft Defender for Cloud Apps, you can protect content in SalesForce, Box, or DropBox
- Protect containers, e.g. Teams, M365 Groups, and SharePoint sites
- Protect meetings and chat
- Extend sensitivity labels to Power BI
- Extend sensitivity labels to Microsoft Purview Data Map
  - these are files and schematized assets that include SQL, Azure SQL, Azure Synapse, Azure Cosmos DB, and AWS RDS
- Extend sensitivity labels to third-party apps and services using the [Microsoft Information Protection SDK](https://learn.microsoft.com/en-us/information-protection/develop/overview)
- Label content without using any protection settings
  - Helps to provide a visual mapping of your organization's data sensitivity
  - You can use labels to generate reports; can always apply protection later

See [Common scenarios for sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/get-started-with-sensitivity-labels?view=o365-worldwide#common-scenarios-for-sensitivity-labels)

A sensitivity label is stored in clear text in the metadata for files and emails. This allows third-party apps and services to read it and apply their own protective actions. It also means the label stays with the content, no matter where it's stored or saved.

Sensitivity labels can do the following things:
- Encrypt: documents, emails, and meeting invites
- Mark content: watermarks, headers, and footers
- Protect content in containers: SharePoint sites, M365 Groups, Teams
- Apply the label automatically to files and emails, or recommend a label
- Set the default sharing link type, e.g. sharing links inherit permissions from the label

See [Manage sensitivity labels in Office apps](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide) for more configuration options.

### Label Scopes
When you create a sensitivity label, you're asked to configure the label's scope, which determines two things:
- Which label settings you can configure for that label
- The availability of the label to apps and services, which includes whether users can see and select the label

The scope configuration allows you to have sensitivity labels that are just for documents and emails, and can't be selected for containers. Alternatively, you can have labels just for containers and not for documents and emails.

![](img/20230648-034828.png)

See [Use sensitivity labels with Teams, groups, and sites](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-teams-groups-sites?view=o365-worldwide#how-to-enable-sensitivity-labels-for-containers-and-synchronize-labels) for enabling scopes for containers.

See [Labeling in Microsoft Purview](https://learn.microsoft.com/en-us/azure/purview/create-sensitivity-label) for applying labels to Azure assets in Microsoft Purview Data Map.

### Label Priority (Order Matters)
When you create sensitivity labels, they appear in a list on the **Information Protection > Labels** page. In this list, the order of the labels is important because it reflects their priority. You want your most restrictive sensitivity label, such as Highly Confidential, to appear at the bottom of your list, and your least restrictive label to appear at the top.

You can apply just one sensitivity label to an item, such as an email, document, or container. If you set an option that requires your users to provide a justification for changing a label to lower sensitivity, the order of this list identifies the lower sensitivity.  **However, this option does not apply to sublabels that share the priority of their parent label.**

The ordering of sublabels is used with automatic labeling, though. When you configure auto-labeling policies, multiple matches can result for more than one label. Then, the last sensitive label is selected, and then if applicable, the last sublabel. When you configure sublabels themselves (rather than auto-labeling policies) for automatic labeling, the behavior is a little different when sublabels share the same parent label. For example, a sublabel configured for automatic labeling is preferred over a sublabel configured for recommended labeling. See [How multiple conditions are evaluated when they apply to more than one label](https://learn.microsoft.com/en-us/microsoft-365/compliance/apply-sensitivity-label-automatically?view=o365-worldwide#how-multiple-conditions-are-evaluated-when-they-apply-to-more-than-one-label)

![](img/20230604-040455.png)

### Sublabels (Grouping Labels)
With sublabels, you can group one or more labels below a parent label that a user sees in an Office app. Sublabels are simply a way to present labels to users in logical groups. Sublabels don't inherit any settings from their parent label, except for their label color. When you publish a sublabel for a user, that user can then apply that sublabel to content and containers, but can't apply just the parent label.

Don't choose a parent label as the default label, or configure a parent label to be automatically applied (or recommended). If you do, the parent label can't be applied.

![](img/20230612-041227.png)

### Editing or Deleting a Sensitivity Label
If you delete a sensitivity label from the admin portal, the label isn't automatically removed from content, and any protection settings continue to be enforced on content that had that label applied. However, some caveats apply. See [Removing and deleting labels](#removing-and-deleting-labels).

If you edit a sensitivity label, the version of the label that was applied to content is what's enforced on that content.

### What Label Policies Can Do
After you create your sensitivity labels, you need to publish them to make them available to people and services in your organization. The sensitivity labels can then be applied to Office documents and emails, and other items that support sensitivity labels.

Unlike retention labels, which are published to locations such as Exchange mailboxes, sensitivity labels are published to users or groups.

When you configure a label policy, you can:
- **Choose which users and groups see the labels**:  Labels can be published to any specific user or email-enabled security group, distribution group, or M365 Group (which can have dynamic membership)
- **Specify a default label** for unlabeled documents, email and meeting invites, new containers, and Power BI content. Consider using a default label to set a base level of protection settings that you want applied to all of your content. However, without user training, this setting can result in accurate labeling. It's usually not a good idea to set encryption as a default label to documents. As an excample, in the need to share externally, many orgs may not have apps that support the encryption, or they might not use an account that can be authorized. See [Sharing encrypted documents with external users](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-office-apps?view=o365-worldwide#sharing-encrypted-documents-with-external-users)
- **Require a justification for changing a label**: If a user tries to remove a label or replace it with a label that has a lower-order priority, you can require the user provide a justification to perform this action. Administrators can read the justification reason in Activity Explorer.
- **Require users to apply a label** for different types of items and the containers that support sensitivity labels. This is also known as mandatory labeling. Consider using this option to increase your labeling coverage. However, without training, this setting can lead to inaccurate labeling and will frustrate your users. For containers, a label must be assigned at the time the group or site is created. 
- **Provide help link to a custom help page**. 

After you create a label policy, allow up to 24 hours for the changes to replicate through the org. 

There's no limit to the number of labels you can create and publish, with one exception: If the label applies encryption that specifies the users and permissions, there's a maximum of 500 labels per tenant. However, as a best practice to lower admin overhead and reduce complexity, try to keep the number of labels to a minimum. Real-world deployments have proved effectiveness to be noticeably reduced when users have more than 5 main labels or more htan 5 sublabels per main label.

After you create a label policy, allow up to 24 hours for the changes to replicate through the org. See [Define and create sensitivity labels](#define-and-create-sensitivity-labels). 

There's no limit to the number of labels you can create and publish, with one exception: If the label applies encryption that specifies the users and permissions, there's a maximum of 500 labels per tenant. However, as a best practice to lower admin overhead and reduce complexity, try to keep the number of labels to a minimum. Real-world deployments have proved effectiveness to be noticeably reduced when users have more than 5 main labels or more than 5 sublabels per main label.

### Label Policy (Priority Matters)
You make your sensitivity labels available to users by publishing them in a sensitivity policy that appears in a list on the **Label Policies** page. Just like sensitivity labels, the order of the sensitivity label policies is important because it reflects their priority: The label policy with the lowest priority is shown at the top of the list with the lowest order number, and the label policy with the highest priority is shown at the bottom of the list with the highest priority number. 

A label policy consists of:
* A set of labels 
* The users and groups that will be assigned the policy with labels
* The scope of the policy and policy settings for that scope (such as default label)

You can include a user in multiple label policies, and the user will get all the sensitivity labels and settings from those policies. If there's a conflict in settings from multiple policies, the settings from the policy with the highest priority (highest order number) is applied. In other words, the highest priority wins for each setting.

If you're not seeing the label policy setting behavior that you expect for a user or group, check the order of the sensitivity label policies. You might need to move a policy down. 

![](img/20230607-030710.png)

### Built-in Labeling for the Office Apps
Built-in labels (as opposed to labels provided by the soon-to-be-retired AIP client) require a subscription edition of Office apps. Standalone editions of Office aren't supported. See [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/sensitivity-labels-aip?view=o365-worldwide#benefits-of-using-built-in-labeling-for-office-apps-vs-the-aip-add-in)

Here's a list of features supported by built-in labeling for Office apps:
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

### Defining Label Taxonomy
Defining the right label taxonomy and protection policies is the most critical step in a Microsoft Purview Information Protection deployment. Labels will be the interface for users to understand content sensitivity, how it matches company policies, and will be the primary input for users to flag content that needs to be protected.

A good label taxonomy needs to meet business and/or regulatory needs, be intuitively understandable by users, provide good policy tips, and be easy to use. It should not prevent users from doing their jobs, while at the same time help prevent instances of data leakage or misuse and address compliance requirements.


See [Create a well-designed data classification framework](https://learn.microsoft.com/en-us/compliance/assurance/assurance-create-data-classification-framework) for further guidance.

Best Practices
- Start small and keep it simple.  
-  Define labels that will last a long time
- Start with what threats you are trying to prevent, e.g. users from accidentally putting sensitive data where unauthorized users can view it. Based on those requirements, define the minimal controls that must be there to ensure those scenarios don't happen.
- Use label names that intuitively resonate with your users. Don't use acronyms. Use short, meaningful words, e.g. "Confidential", "Secret"
- Avoid terms that may be ambiguous. Don't use terms where not all users might agree on whether "Confidential" or "Secret" is the most sensitive label; use "Confidential" and "Highly Confidential" instead.
-  Use sublabels with intent. Labels are used to represent the actual sensitivity  of the content that is labeled. Sublabels represent variations in the protection or the scope of the content. 
-  Compartmentalize sparingly. Using sublabels to give rights to people in specific departments is good practice, but you should use this capability in moderation. Limit the number of sublabels for departments to a small number and stick with it.
- Involve different teams to review your proposed label taxonomy. Defining labels is not an IT security task alone, and early feedback will help you define a label taxonomy that will work for a long time

See the full list and descriptions [here](https://microsoft.github.io/ComplianceCxE/dag/mip-dlp/)

Eligible customers (new and existing) can activate a set of default protection labels and policies. See [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/mip-easy-trials?view=o365-worldwide#default-sensitivity-labels).

![](img/20230628-042825.png)

## Roles and Permissions
- Reference
  - [Permissions required to create and manage sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/get-started-with-sensitivity-labels?view=o365-worldwide#permissions-required-to-create-and-manage-sensitivity-labels)

The following role groups have permissions for managing sensitivity labels:
- Organization Management*
- Compliance Administrator*
- Compliance Data Administrator*
- Information Protection*
- Information Protection Admins*
- Information Protection Analysts
- Information Protection Investigators
- Information Protection Readers

Note:  
  - Items with an asterisk (*) have the ability to activate and manage the AIP super user feature (need to confirm this)

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

### Manage the Azure Information Protection Service
See the following links for more information: 
- [Configure super users](https://docs.microsoft.com/en-us/azure/information-protection/configure-super-users)
- [Azure Information Protection](https://learn.microsoft.com/en-us/powershell/azure/aip/overview?view=azureipps) - provides documentation on the **AIPService** and **AzureInformationProtection** PowerShell modules.


## Define and Create Sensitivity Labels
By default, tenants do not have any labels, so you must create them. Sensitivity labels are provided using two steps:
1. Create the label
2. Publish the label to users using a label policy

See [Create and configure sensitivity labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide#create-and-configure-sensitivity-labels) for the process.  

Per [here](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide#when-to-expect-new-labels-and-changes-to-take-effect), allow up to 24 hours for labels and their settings to become available.  

![](img/20230633-033336.png)

See [Create and configure sensitivity labels and their policies](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide) for more info.

### Removing and Deleting Labels
You can't delete a label if it's still in a label policy. Removing a label from a label policy is less risky than deleting the label, as you can always add it back if needed. When you remove a label from a label policy, users will no longer be able to select that label for use in the Office apps. However, if an item already has that label, then users will continue to see that label is applied. Same applies for any containers that have the label applied&mdash;users will continue to see that label is applied to the container.

In comparison, when you delete a label:

* If the label applied encryption, the underlying protection template is archived so that previously protected content can still be opened. 

* For documents stored in SharePoint and OneDrive, you won't see the sensitivity label applied in the app, and the label name no longer appears in the **Sensitivity** column in SharePoint. If the deleted label applied encryption and the services can process the encrypted contents, the encryption is removed. The label information remains in the file's metadata, apps can no longer map the label ID to a display name, so users will assume the file isn't labeled.

* For documents stored outside of SharePoint and OneDrive, the label information remains in the file's metadata, but without the label ID to name mapping, users don't see the applied label name displayed. If the deleted label applied encryption, the encryption remains and users still see the name and description of the now archived protection template.

* For containers, such as sites in SharePoint and Teams: The label is removed any settings that were configured with that label are no longer enforced. This action typically takes 48-72 hours for SharePoint sites, and can be quicker for Teams and Microsoft 365 Groups.

* Be aware that without a GUID-to-name mapping available after you delete a label, deleted labels can display as GUIDs rather than label names in applications such as content explorer and activity explorer.

As with all label changes, removing a sensitivity label from a label policy or deleting a sensitivity label takes time to replicate to all users and services.

See [Removing and deleting labels](https://learn.microsoft.com/en-us/microsoft-365/compliance/create-sensitivity-labels?view=o365-worldwide#removing-and-deleting-labels) for more info.

## Protecting SharePoint Sites, Teams, and Groups with Sensitivity Labels
Sensitivity labels for SharePoint sites, Teams, and Microsoft 365 Groups is not enabled by default. You must take several steps to enable sensitivity labels for these containers. See [Use sensitivity labels with teams, groups, and sites](https://learn.microsoft.com/en-us/purview/sensitivity-labels-teams-groups-sites).

**Step 1: Enable sensitivity label support for groups in PowerShell**  
Follow the guidance [here](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels#enable-sensitivity-label-support-in-powershell) to set the `EnableMIPLabels` setting for groups to `True`. New tenants do not have a directory setting for groups, so you must create one. See [here](https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-cmdlets#template-settings) for a description of each template setting. Here are the default settings:

![](img/20230830-043058.png)





### Enabling PDF Support
See https://learn.microsoft.com/en-us/purview/sensitivity-labels-sharepoint-onedrive-files?view=o365-worldwide#enable-the-preview-by-using-microsoft-powershell-opt-in


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



[!TIP]

Testing a note box
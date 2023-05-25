# Trainable Classifiers

## Links
- [Learn about trainable classifiers](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-learn-about?view=o365-worldwide)
- [Get started with trainable classifiers](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-get-started-with?view=o365-worldwide)
- [How to retrain a classifier in content explorer](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-how-to-retrain-content-explorer?view=o365-worldwide)
- [Trainable classifier definitions](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-tc-definitions?view=o365-worldwide)
- [Increase classifier accuracy](https://learn.microsoft.com/en-us/microsoft-365/compliance/data-classification-increase-accuracy?view=o365-worldwide)

## Exam Goals
- Identify when to use trainable classifiers
- Design and create a trainable classifier
- Test a trainable classifier
- Retrain a trainable classifier

## Contents
- [Links](#links)
- [Exam Goals](#exam-goals)
- [Contents](#contents)
- [Permissions Required](#permissions-required)
- [Licensing](#licensing)
- [Overview](#overview)
- [When to use Trainable Classifiers](#when-to-use-trainable-classifiers)
- [Design and Create a Trainable Classifier](#design-and-create-a-trainable-classifier)
  - [Process flow for creating custom classifiers](#process-flow-for-creating-custom-classifiers)
- [Retrain a Trainable Classifier](#retrain-a-trainable-classifier)

## Permissions Required
- Reference
  - [Permissions](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-how-to-retrain-content-explorer?view=o365-worldwide#permissions)

Accessing and Training Classifiers
- Compliance Administrator
- Compliance Data Administrator

The roles above are the role groups in Microsoft Purview compliance portal; they are not the Azure AD roles with the same name!  The Azure AD roles with these names do not provide the same level of access in Microsoft Purview compliance portal.

To manage trainable classifiers, a user needs to be able to expand the Data Classification node in Microsoft Purview compliance portal. Standard users don't have visibility to this node.

![](img/20230514-031406.png)

A Global Admin must opt in for the tenant to create custom classifiers. This message first appears when accessing the Trainable Classifiers tab.  

![](img/20230557-035736.png)

## Licensing
- Reference
  - [Licensing Requirements](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-get-started-with?view=o365-worldwide#licensing-requirements)
  - [Microsoft 365 Guidance for Security & Compliance Service Description](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance)

Trainable classifiers are an E5 feature. 

## Overview
Categorizing and labeling content so it can be protected and handled properly is the starting place for the information protection discipline. Microsoft Purview has three ways to classify content:
1. Manually
2. Automated pattern-matching
3. Classifiers (machine learning)

**Manual Classification**
Manual classification requires human judgment and action. Users and admins categorize content as they encounter it. You can use either the pre-existing labels and sensitive information types or use custom created ones. You can then protect the content and manage its disposition.

**Automated Pattern-Matching**
These categorization methods include finding content by
- Keywords or metadata values (keyword query language)
- Using previously identified patterns of sensitive information like SSN, credit card, or bank account numbers (see Sensitive Information type definitions)
- Recognizing an item because it's a variation on a template (Document Fingerprinting)
- Using the presence of exact match strings (see Exact Data Match)

**Classifiers**
This categorization method is well-suited to content that isn't easily identified by either the manual or automated pattern-matching methods. This method of categorization is more about using a classifier to identify an item based on what the item is, not by elements that are in the item (pattern matching). A classifier learns how to identify a type of content by looking at hundreds of examples of the content you're interested in identifying.

You can view the trainable classifiers in content explorer by expanding **Trainable Classifiers** in the filters panel. 

![](img/20230525-052558.png)

**Types of Classifiers**
There are two types of classifiers  
- **pre-trained classifiers** - Microsoft has created and pre-trained multiple classifiers that you can start using without training them. These classifiers appear with the status `Ready to use`.  
- **custom trainable classifiers** - If you have content identification and categorization needs that extend beyond that the pre-trained classifiers cover, you can create and train your own classifiers.

See [Trainable classifiers definitions](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-tc-definitions?view=o365-worldwide#trainable-classifiers-definitions) for a complete list of trainable classifiers.

## When to use Trainable Classifiers
Classifiers are available to use as a condition for 
- Office auto-labeling with sensitivity labels
- Auto-apply retention policy based on a condition
- Communication compliance
- Sensitivity labels can use classifiers as conditions
- Data loss prevention

Note: classifiers only work for items that are not encrypted.

## Design and Create a Trainable Classifier
References
- [Custom Classifiers](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-learn-about?view=o365-worldwide#custom-classifiers)

You start by creating a custom trainable classifier by feeding it examples that are definitely in the category. Once it processes these examples, you test it by giving it a mix of both matching and non-matching examples. The classifier then makes predictions as to whether any given item falls into the category you're building. You then confirm its results, sorting out the true positives, true negatives, false positives, and false negatives to help increase the accuracy of its predictions.

When you publish the classifier, it sorts through items in locations like SharePoint Online, Exchange, and OneDrive, and classifies the content. After you publish the classifier, you can continue to train it using a feedback process that is similar to the initial training process.

Examples for which you can create trainable classifiers:
- Legal documents - client attorney privilege, closing sets, statement of work
- Strategic business documents - press releases, merger and acquisition, deals, business or marketing plans, intellectual property, patents, design docs
- Pricing information - invoices, price quotes, work orders, bidding documents
- Financial information - organizational investments, quarterly or annual results

### Process flow for creating custom classifiers
Creating and publishing a classifier for use in compliance solutions, such as retention policies and communication supervision, follows this flow. For more detail on creating a custom trainable classifier, see [Creating a custom classifier]().  The process starts by using seed data with a minimum of 50 samples. You then create the classifier and provide sample data, consisting of positive and negative samples. Finally, you provide feedback to the model and then publish the classifier.

![](img/20230549-054907.png)


## Retrain a Trainable Classifier
References
- [Retraining Classifiers](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-learn-about?view=o365-worldwide#retraining-classifiers)
- [How to retrain a classifier in content explorer](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-how-to-retrain-content-explorer?view=o365-worldwide)

A Microsoft 365 trainable classifier is a tool you can train to recognize various types of content by giving it samples to look at. Once trained, you can use it to identify items for application of Office sensitivity labels, communications compliance policies, and retention labels.



You can help improve the accuracy of all custom trainable classifiers and by providing them with feedback on the accuracy of the classification that they perform.  This is called retraining, and follows this workflow. 

Note: pre-trained classifiers cannot be re-trained. 

![](img/20230553-055316.png)

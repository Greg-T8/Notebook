# Trainable Classifiers

## Links
- [Learn about trainable classifiers](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-learn-about?view=o365-worldwide)
- [Get started with trainable classifiers](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-get-started-with?view=o365-worldwide)
- [How to retrain a classifier in content explorer](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-how-to-retrain-content-explorer?view=o365-worldwide)
- [Trainable classifier definitions](https://learn.microsoft.com/en-us/microsoft-365/compliance/classifier-tc-definitions?view=o365-worldwide)

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
- [Overview](#overview)
- [When to use Trainable Classifiers](#when-to-use-trainable-classifiers)

## Permissions Required
TBD

## Overview
Categorizing and labeling content so it can be protected and handled properly is the starting place for the information protection discipline. Microsoft Purview has three ways to classify content:
1. Manually
2. Automated pattern-matching
3. Classifiers

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

## When to use Trainable Classifiers
Classifiers are available to use as a condition for 
- Office auto-labeling with sensitivity labels
- Auto-apply retention policy based on a condition
- Communication compliance
- Sensitivity labels can use classifiers as conditions
- Data loss prevention

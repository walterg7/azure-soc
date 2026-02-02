## Block IP via NSG – Sentinel Playbook

This Logic Apps playbook triggers on Microsoft Sentinel incident creation and:
- Extracts the IP entity from the incident
- Creates an Azure Automation job to block the IP via NSG
- Adds comments and tags to the incident

### Prerequisites
- Microsoft Sentinel enabled
- Azure Automation Account with a PowerShell runbook
- Managed Identity permissions:
  - Sentinel Responder
  - Network Contributor (NSG scope)
  - Automation Operator

### Deployment
1. Import the JSON into Logic Apps
2. Replace placeholders:
   - [SUBSCRIPTION_ID]
   - [RESOURCE_GROUP_NAME]
   - [NSG_NAME]
   - [AUTOMATION_ACCOUNT_NAME]
   - [RUNBOOK_NAME]
3. Configure API connections using Managed Identity
4. Attach playbook to Sentinel analytics rule

### Notes
- Playbook validates IP entity position dynamically
- Designed for containment, not real-time prevention

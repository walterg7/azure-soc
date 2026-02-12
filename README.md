# azure-soc

## Components
- KQL analytics rules for brute-force and persistence detection
- Sentinel-triggered Logic Apps playbook
- Azure Automation PowerShell runbook
- NSG-based network containment

## Design Goals
- Reduce SOC alert fatigue
- Contain confirmed malicious activity
- Maintain safe rollback and low operational risk

## Repository Structure
- analytics-rules/ → Sentinel detection logic
- playbooks/ → Incident-driven automation
- runbooks/ → NSG enforcement logic

## Documentation
Full walkthrough and design rationale available at: https://walterg7.github.io/posts/azure-soc-main/

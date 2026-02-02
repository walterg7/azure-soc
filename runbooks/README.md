## Block-IP-NSG Runbook
Creates a high-priority NSG deny rule for a given source IP.

### Parameters
- ResourceGroupName
- NSGName
- SrcIp

### Behavior
- Adds deny rule, starting at priority 100 and incrementing by 1
- Rule name includes source IP for traceability
- Skips rule creation if IP is already blocked
- Designed to be reversible by deleting the rule

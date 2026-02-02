param(
    [Parameter(Mandatory = $true)]
    [string]$SrcIp,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$NsgName
)

# Authenticate using Managed Identity
Connect-AzAccount -Identity

# Get NSG
$nsg = Get-AzNetworkSecurityGroup `
    -ResourceGroupName $ResourceGroupName `
    -Name $NsgName

# Rule name (unique per IP)
$ruleName = "AutoBlock-$($SrcIp.Replace('.', '-'))"

# Get existing inbound rule priorities
$usedPriorities = $nsg.SecurityRules |
    Where-Object { $_.Direction -eq "Inbound" } |
    Select-Object -ExpandProperty Priority

# Find next available priority starting at 101
$priority = 101
while ($usedPriorities -contains $priority) {
    $priority++
}

# Rule name
$ruleName = "AutoBlock-$($SrcIp.Replace('.', '-'))"

# Avoid duplicate rules
$existingRule = $nsg.SecurityRules | Where-Object { $_.Name -eq $ruleName }

if (-not $existingRule) {

    $nsg | Add-AzNetworkSecurityRuleConfig `
        -Name $ruleName `
        -Description "Auto-block from Sentinel brute-force incident" `
        -Access Deny `
        -Protocol * `
        -Direction Inbound `
        -Priority $priority `
        -SourceAddressPrefix $SrcIp `
        -SourcePortRange * `
        -DestinationAddressPrefix * `
        -DestinationPortRange 3389

    $nsg | Set-AzNetworkSecurityGroup
}
Write-Output "IP $SrcIp blocked using priority $priority"

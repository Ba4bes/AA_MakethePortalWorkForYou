# Connect account
Connect-AzAccount

# Set subscription
Set-Azcontext $SubscriptionID

# Get Resources
Get-AzResourceGroup

# Get-AzResources
Get-AzResource

# New Resourcegroup
New-AzResourceGroup -Name "Example" -Location "West Europe"

# Create storageAccount
New-AzStorageAccount -ResourceGroupName Example -Name addnslf -SkuName Standard_LRS -Location 'West Europe'

# Get key
Get-AzStorageAccountKey -Name addnslf -ResourceGroupName Example


###### AZ CLI

# list resourcegroups
az group list

# create group
az group create -l westeurope -n example2

# Check storage account name
az storage account check-name -n djgnsdg

#Create storage account
az storage account create -n adfdsl -g example2 -l westeurope --sku standard_LRS

# Get storage account key
az storage account keys list -n adfdsl



# ARM Template
$ResourcegroupName = "Example3"
New-AzResourceGroup -Name $ResourcegroupName -Location 'West Europe'
New-AzResourceGroupDeployment -ResourceGroupName $ResourcegroupName -TemplateFile .\ARMtemplate.json -storageAccountPrefix "saff"


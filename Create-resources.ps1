# Sample script to create VM, Vnet, subnet and Public IP
$Credential = Get-Credential

$ResourceGroup = New-AzResourceGroup -Name "VirtualDay" -Location 'West Europe'

$Subnet = New-AzVirtualNetworkSubnetConfig -AddressPrefix "10.10.10.0/24" -Name "subnet"

$Parameters = @{
    Name = "Vnet"
    Location = 'West Europe'
    ResourceGroupName = $ResourceGroup.ResourceGroupName
    AddressPrefix = "10.10.0.0/16"
    Subnet = $Subnet
}
$VNET = New-AzVirtualNetwork @Parameters


$Parameters = @{
    Name = "PIP"
    ResourceGroupName = $ResourceGroup.ResourceGroupName
    Location = "West Europe"
    AllocationMethod = "Dynamic"
}

$PIP = New-AzPublicIpAddress @Parameters

$Parameters = @{
    Name = "NIC"
    ResourceGroupName = $ResourceGroup.ResourceGroupName
    Location = "West Europe"
    SubnetId = $Vnet.Subnets[0].Id
    PublicIpAddressId = $PIP.Id
}

$NIC = New-AzNetworkInterface @Parameters


$VirtualMachine = New-AzVMConfig -VMName "VM" -VMSize "Standard_B1ms"
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -ComputerName "VM" -Credential $Credential -Linux
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName "Canonical" -Offer 'UbuntuServer' -Skus '18.04-LTS' -Version latest

New-AzVM -ResourceGroupName $ResourceGroup.ResourceGroupName -Location "West Europe" -VM $VirtualMachine -Verbose


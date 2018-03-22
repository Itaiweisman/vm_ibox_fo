$vcenter="<replace_with_vcenter_name>"
$datastore="<replace_with_datastore_name" ## or $args[0] 
$cluster="<replace_with_cluster_name"
$esx="<replace_with_esx_name>"
$cred=Get-Credential
$suffix="-new"  ## or what makes sense
function ChangeMac([string]$srcvm, [string]$dstvm)
{
#$srcvm = get-vm -Name 'testvm'

#$dstvm = get-vm -Name 'clone3'

 

$NewMACAddr = Get-NetworkAdapter $srcvm

$viewTargetVM = Get-View -ViewType VirtualMachine -Property Name,Config.Hardware.Device -Filter @{"Name" = "^${dstvm}$"}

$deviceNIC = $viewTargetVM.Config.Hardware.Device | Where-Object {$_ -is [VMware.Vim.VirtualEthernetCard]}

$cardnumber = $NewMACAddr.MacAddress.Count

for ($i=1; $i -le $cardnumber; $i++) {

    $j=$i-1

    $deviceNIC[$j].MacAddress = $NewMACAddr[$j].MacAddress

    $deviceNIC[$j].addressType = "Manual"

    $specNewVMConfig = New-Object VMware.Vim.VirtualMachineConfigSpec -Property @{

    deviceChange = New-Object VMware.Vim.VirtualDeviceConfigSpec -Property @{

    operation = "edit"

    device = $deviceNIC[$j]

    }

}

$viewTargetVM.ReconfigVM($specNewVMConfig)

}

}


Connect-VIServer -Credential $cred -server $vcenter
dir "vmstores:\$vcenter@443\$cluster\$datastore\*\*.vmx" | % {
$old_name=$_.Name.Split(".")[0] 
$new_name="$old_name" + "$suffix" 
New-VM -Host $esx -Name $new_name -VMFilePath $_.DatastoreFullPath 
ChangeMac $old_name $new_name
}

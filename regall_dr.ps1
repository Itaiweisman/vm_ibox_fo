$vcenter="<replace_with_vcenter_name>"
$datastore="<replace_with_datastore_name" ## or $args[0] 
$cluster="<replace_with_cluster_name"
$esx="<replace_with_esx_name>"
$cred=Get-Credential
$suffix="-new"  ## or what makes sense
Connect-VIServer -Credential $cred -server $vcenter
dir "vmstores:\$vcenter@443\$cluster\$datastore\*\*.vmx" | % {
$name=$_.Name.Split(".")[0]+ "$suffix" 
New-VM -Host $esx -Name $name -VMFilePath $_.DatastoreFullPath }

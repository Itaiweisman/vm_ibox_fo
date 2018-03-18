$vcenter="vcsa-sales-001"
$datastore="replicated-sol-prod-datastore"
$cluster="Sales"
$esx="sales-demo-001.lab.il.infinidat.com"
$cred=Get-Credential
$suffix="-new"
Connect-VIServer -Credential $cred -server vcsa-sales-001
dir "vmstores:\$vcenter@443\$cluster\$datastore\*\io*.vmx" | % {
$name=$_.Name.Split(".")[0]+ "$suffix" 
New-VM -Host $esx -Name $name -VMFilePath $_.DatastoreFullPath }
$ibox="<replace_with_ibox_name>"
$user="<replace_with_ibox_username>"
$password="<replace_with_ibox_password>"
$file="<replace_with_a_file_containing_ds_name>" ## $args[0]
$dss=get-content $file 
foreach ($ds in $dss) { 
write-host "Trying to change role of $ds "
infinishell --user $user --password $password -c "replica.change_role local_dataset=$ds --yes" $ibox
 }

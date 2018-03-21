$ibox1_to_replicte_from="<replace_with_ibox_name>"
$user_ibox1="<replace_with_ibox_username>"
$password_ibox1="<replace_with_ibox_password>"
$ibox2_to_replicte_to="<replace_with_ibox_name>"
$user_ibox2="<replace_with_ibox_username>"
$password_ibox2="<replace_with_ibox_password>"
$file="<replace_with_a_file_containing_ds_name>" ## $args[0]
$dss=get-content $file 
foreach ($ds in $dss) { 
write-host "Trying to change role of $ds[1] "
infinishell --user $user2 --password $password2 -c "replica.change_role local_dataset=$ds[1] --yes" $ibox2_to_replicte_to
 }
 
 foreach ($ds in $dss) { 
write-host "Trying to replicate from $ds[0]  "
infinishell --user $user1 --password $password1 -c "replica.resume local_dataset=$ds[0] --yes" $ibox1_to_replicte_to
 }

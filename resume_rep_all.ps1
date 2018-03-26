$ibox1_to_replicte_from="<replace_with_ibox_name>"
$user_ibox1="<replace_with_ibox_username>"
$password_ibox1="<replace_with_ibox_password>"
$ibox2_to_replicte_to="<replace_with_ibox_name>"
$user_ibox2="<replace_with_ibox_username>"
$password_ibox2="<replace_with_ibox_password>"
$file="<replace_with_a_file_containing_ds_name>" ## $args[0]
$dss=get-content $file 
foreach ($ds in $dss) {
$source, $target=$ds.Split(' ')
write-host "Trying to change role of ds is $target "
infinishell --user $user_ibox2 --password $password_ibox2 -c "replica.change_role local_dataset=$target --yes" $ibox2_to_replicte_to
write-host "Trying to replicate from $source  "
infinishell --user $user_ibox1 --password $password_ibox1 -c "replica.resume local_dataset=$source --yes" $ibox1_to_replicte_from
 }

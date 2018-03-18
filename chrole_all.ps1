$ibox="ibox628"
$user="admin"
$password="123456"
$file=$args[0]
$dss=get-content $file
foreach ($ds in $dss) { 
write-host "Trying to change role of $ds "
infinishell --user $user --password $password -c "replica.change_role local_dataset=$ds --yes" $ibox
 }
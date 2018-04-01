$vm_list=get-content $args[0] ## File with vm list, sepearted by new line
foreach ($vm in $vm_list) {
  try {
    start-vm $vm -ErrorAction Stop
}
catch {
    $message = $_.Exception


    if ($message -like "*questions*") {
        $question = $vm | Get-VMQuestion
        $option = $question.Options | Where-Object {$_.Summary -eq "I Moved It"}
        $vm | Get-VMQuestion | Set-VMQuestion -Option $option
    }
}
  

$vm_list=get-content $args[0] ## File with vm list, sepearted by new line
foreach ($vm in $vm_list) {
  Start-VM $vm
  Get-VM $vm | Get-VMQuestion | Set-VMQuestion -Option "I moved it" 
  }
  

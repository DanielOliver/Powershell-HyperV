if((Get-VMSwitch | where { $_.Name -eq "centos" }).count -eq 0) {
    New-VMSwitch -Name "centos" -SwitchType Internal -Notes 'Internal VMs only'    
}

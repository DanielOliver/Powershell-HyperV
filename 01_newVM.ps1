Param(
    
       [Parameter(Mandatory=$true,
                HelpMessage="The Name of the VM")]
       [string]$vmName
)

if((Get-VM | Where-Object { $_.Name -eq $vmName }).count -eq 0) {
  $switchName = (Get-VMSwitch | Where-Object { $_.Name -eq "centos" }).Name
  $VM = @{
    Name = $vmName 
    MemoryStartupBytes = 2147483648
    Generation = 1
    NewVHDPath = "C:\Virtual Machines\$vmName\$vmName.vhdx"
    NewVHDSizeBytes = 53687091200
    BootDevice = "VHD"
    Path = "C:\Virtual Machines\$vmName"
    # SwitchName = $switchName
  }
  New-VM @VM

  $dvdPath = "c:\Users\efcde\CentOS-7-x86_64-Minimal-1708.iso"
  Add-VMDvdDrive -VMName $vmName -Path $dvdPath -ControllerNumber 0
  
  Start-VM $vmName

} else {
  Write-Host "VM $vmName already exists."
}

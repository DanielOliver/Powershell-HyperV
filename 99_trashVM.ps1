Param(
    
       [Parameter(Mandatory=$true,
                HelpMessage="The Name of the VM")]
       [string]$vmName
)

Stop-VM -Name $vmName -TurnOff
Remove-VM -Name $vmName -Force
Remove-Item -Path "C:\Virtual Machines\$vmName" -Force -Recurse


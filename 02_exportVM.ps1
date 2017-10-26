Param(
    [Parameter(Mandatory=$true,
             HelpMessage="The Name of the Snapshot exported")]
    [string]$snapName,

    [Parameter(Mandatory=$true,
            HelpMessage="The Name of the VM")]
    [string]$vmName
)
$exportPath = "C:\Virtual Machines\$snapName"

$vm = Get-VM -Name $vmName
$snapshot = Export-VMSnapshot -VM $vm -Name $snapName $exportPath -Passthru

New-VM -Name $snapshot.Name -NoVHD -MemoryStartupBytes $snapshot.MemoryStartup -switch "centos"

$hardDrive = Get-ChildItem -LiteralPath "C:\Virtual Machines\snap\admin\Virtual Hard Disks\" | Where-Object { $_.Name -like "*.vhdx" }

Add-VMHardDiskDrive -Path $hardDrive.FullName -VMName $snapName
Start-VM $vmName

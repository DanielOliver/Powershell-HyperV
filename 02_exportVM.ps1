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
$latestSnap = Get-VMSnapshot -VMName $vmName | Sort-Object CreationTime -Descending | Select-Object -First 1
$snap = Export-VMSnapshot -VMSnapshot $latestSnap -Path $exportPath

New-VM -Name $snapName -NoVHD -switch "centos"

$hardDrive = Get-ChildItem -LiteralPath "C:\Virtual Machines\$snapName\$vmName\Virtual Hard Disks\" | Where-Object { $_.Name -like "*.vhdx" }
Add-VMHardDiskDrive -Path $hardDrive.FullName -VMName $snapName
Start-VM $snapName

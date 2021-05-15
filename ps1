$vmobjs = @()
$Subscriptions = Get-AzSubscription
foreach ($sub in $Subscriptions)
{
    Get-AzSubscription -SubscriptionName $sub.Name | Set-AzContext
$allvm=Get-AzVM
foreach($onevm in $allvm)
{
$vm = Get-AzVMDiagnosticsExtension -ResourceGroupName $onevm.ResourceGroupName -VMName $onevm.Name
$DiagStorage = $vm.PublicSettings | ConvertFrom-Json | select StorageAccount
Write-host $onevm.Name uses $DiagStorage.StorageAccount
  $vmInfo = [pscustomobject]@{
                'VM Name'=$onevm.Name
                'ResourceGroupName' = $onevm.ResourceGroupName
                'Subscription Name'=$sub.Name
                'VMStatus'=$onevm.PowerState
                'Storage Account'=$DiagStorage.StorageAccount
                 }
            $vmobjs += $vmInfo
    }
}
$vmobjs | Export-Csv -Path "xxxx/xxxx/xxxx/xxxx" -NoTypeInformation
Write-Host "VM list with diagnostic details written to the csv file"
Invoke-Item "xxxx/xxxx/xxxx/xxxx"


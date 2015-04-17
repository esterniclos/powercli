#
# http://vmwaremine.com/2013/05/28/powercli-clone-vm/
#
# Clones virtual machine in datastore_lun with most free space.
#
# Ester Niclos Ferreras
# Last updated: 17/4/14

# PRe: connect-viserver vc



$sourceVM = "source"


$Datacenter="mydatacenter"
$cluster="mycluster"
# Use in case there are datastore clusters
$DatastoreCluster = "DS_VNX"

#
# SourceVM:
#
$new_vm = "vm1", "vm2","vm3"


$folder = get-folder -name "Production" -Location (get-folder -name "parent_folder")
$respool = get-ResourcePool "Production" -Location $cluster
	
	
	
	
foreach ($clonename in $new_vm)		
	{
    #Select datastore with more space:
    # $datastorelist = Get-Datastore -Location $Datacenter | sort -descending FreeSpaceMB
    # Use in case there are datastore clusters
    $datastorelist = Get-Datastore -Location $DatastoreCluster | sort -descending FreeSpaceMB
    $datastore = $datastorelist[0].Name
    
    # Custom OS Spec with same name as VM
    $spec = get-osCustomizationSpec -name $clonename


    "Clone $clonename in $datastore"

    if (New-VM -Name $clonename -ResourcePool $respool -VM $sourceVM -Location $folder -Datastore $datastore -DiskStorageFormat Thick -OSCustomizationSpec $spec)
    #if (New-VM -Name $clonename -ResourcePool $respool -VM $sourceVM -Location $folder -Datastore $datastore -DiskStorageFormat Thick )
		{"DONE $clonename"}
	else
		{"Something wrong with cloning"}
}	

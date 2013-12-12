#
# based on : http://www.techshifter.com/2012/01/11/vsphere-powercli-mass-enabling-disabling-of-ssh-on-vsphere-hosts/
#
# Ester Niclos Ferreras
# Last updated: 12/12/13


Get-Cluster | Foreach {
$cl=$_
Get-Cluster -name $cl | Get-VMHost | Foreach { 
         Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) -Confirm:$false 
    }
}

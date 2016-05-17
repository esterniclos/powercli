#
# based on : http://www.techshifter.com/2012/01/11/vsphere-powercli-mass-enabling-disabling-of-ssh-on-vsphere-hosts/
#
# Ester Niclos Ferreras
# Last updated: 17/05/13


Add-PSSnapin VMware.VimAutomation.Core

Get-Cluster | Foreach {
$cl=$_
Get-Cluster -name $cl | Get-VMHost | Foreach { 
         Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } ) 
		 }
}

#
# Ester Niclos. 
#
# Connects to each host, and configures snmp:
#


#
# Set your parameters here: 
#
$VCENTER="vc"
$hostuser="root"
$hostpassword=""
$snmpcommunity=""



#
# main
#



#
# Connect to virtual center and get all hostname
# 
Connect-VIServer $VCENTER
$hosts = Get-VMHost
DisConnect-VIServer vc -confirm:$false


#
# For each host, connect and enable snmp:
#
foreach ($h in $hosts)
{
	Connect-VIServer $h.Name -User $hostuser -password $hostpassword
	$hostSNMP = Get-VMHostSNMP     
    $hostSNMP = Set-VMHostSNMP $hostSNMP -Enabled:$true -ReadOnlyCommunity $snmpcommunity
    # List result:
    $hostSNMP
    Disconnect-VIServer $h.Name -confirm:$false   
}
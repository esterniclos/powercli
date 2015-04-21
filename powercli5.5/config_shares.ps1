#
# Configurates virtual machines in a certain share level
# 
# Ester Niclos Ferreras
#
# PRE: Connect-Viserver

$rp = my_resourcepool



# Get - vm
# Configure with low shares all powered off machines:
$vm = get-vm -Location $rp | WHERE {$_.PowerState -eq "PoweredOff"} 


# configure with low shares all windows 2003 machines:
# $vm  = Get-VM -Location $rp| Get-VMGuest | Where-Object {$_.OSFullName -like "Microsoft windows server 2003*"} | Select-Object VMName,OSFullName



$vm |Get-VMResourceConfiguration | Set-VMResourceConfiguration -CpuSharesLvel:Low -memSharesLevel:Low -CpuReservationMhz:0 -MemReservationMB:0

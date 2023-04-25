# Find the load balancer IP address
echo "Starting $0..."
lbIp=""
while [[ ${#lbIp} -le 5 ]]
do
  echo "$0: Checking if Loadbancer IP is assigned ... "
  lbIp=$(kubectl get svc  | grep -i LoadBalancer | grep -v pending | awk '{ print $4 }' )
  echo "$0: Ingress Loadbalancer IP is :" $lbIp, "lbIp length is : " ${#lbIp}
  sleep 10
done
export lbIp=$lbIp

echo "In do-all.sh"


START=$(date +%s)
#Sets the Environment variables
. ./env.sh
chmod +x *.sh

. ./get-creds.sh

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

#echo namespaces is $NAMESPACE
helm install ingress-nginx ingress-nginx/ingress-nginx 


echo https://cdn.mendix.com/mendix-for-private-cloud/mxpc-cli/mxpc-cli-$mendixOperatorVersion-$os.tar.gz
wget https://cdn.mendix.com/mendix-for-private-cloud/mxpc-cli/mxpc-cli-$mendixOperatorVersion-$os.tar.gz
tar xvf mxpc-cli-$mendixOperatorVersion-$os.tar.gz

. ./install-grafana-prometheus.sh

. ./generate-yamls.sh


./mxpc-cli base-install --namespace $MENDIX_NAMESPACE -i $MENDIX_CONFIG_IVAL -s $MENDIX_CONFIG_SVAL --clusterMode connected --clusterType generic
./mxpc-cli apply-config -i $MENDIX_CONFIG_IVAL -s $MENDIX_CONFIG_SVAL --file configure.yaml


### Deploy the application
kubectl apply -f demo.yaml


. ./validate.sh


#!/bin/bash
echo "In do-all.sh"


START=$(date +%s)
#Sets the Environment variables
. ./env.sh
chmod +x *.sh

. ./get-creds.sh

defaultMode="connected"
echo "Mode is $mode"


echo https://cdn.mendix.com/mendix-for-private-cloud/mxpc-cli/mxpc-cli-$mendixOperatorVersion-$os.tar.gz
wget https://cdn.mendix.com/mendix-for-private-cloud/mxpc-cli/mxpc-cli-$mendixOperatorVersion-$os.tar.gz
tar xvf mxpc-cli-$mendixOperatorVersion-$os.tar.gz

rm mxpc-cli-$mendixOperatorVersion-$os.tar.gz*

. ./install-grafana-prometheus.sh

. ./generate-yamls.sh


if [ $mode == $defaultMode ];
then
	echo "Base install "
        ./mxpc-cli base-install --namespace $MENDIX_NAMESPACE -i $MENDIX_CONFIG_IVAL -s $MENDIX_CONFIG_SVAL --clusterMode connected --clusterType generic
	echo "Apply Config "
        ./mxpc-cli apply-config -i $MENDIX_CONFIG_IVAL -s $MENDIX_CONFIG_SVAL --file configure.yaml
else
	 echo "base install "
 	 ./mxpc-cli base-install --namespace $MENDIX_NAMESPACE  --clusterMode standalone  --clusterType generic

  	echo "apply config"
  	./mxpc-cli apply-config  --file configure-standalone.yaml
fi


### Deploy the application
echo "Deploying demo application"
kubectl apply -f demo.yaml


. ./validate.sh




az group create --name myResourceGroup --location eastus
az provider show -n Microsoft.OperationsManagement -o table
az provider show -n Microsoft.OperationalInsights -o table

#az provider register --namespace Microsoft.OperationsManagement
#az provider register --namespace Microsoft.OperationalInsights


az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys
#az aks create --resource-group myResourceGroup --name myAKSCluster --enable-addons http_application_routing

az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

kubectl get nodes


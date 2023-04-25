
# AKS Mendix Quickstart


   Create a AKS Cluster

   Deploy nginx Ingress Controller

   Deploy a sample Mendix application

## Sequence Diagram

![Sequence Diagram](/images/sequence.png)


## PreRequisites
    az cli 
    Terraform is installed
    kubectl

## Update env.sh
    update env.sh
    update terraform.tfvars
   
## To Execute

     update env.sh

     terraform init
     terraform plan
     terraform apply --auto-approve

## Results

    It will show if the result was Successful or not.
   
    sharath.sahadevan@C02CR0U0MD6W gke-mendix-quickstart % kubectl get pods -n mendix
    NAMESPACE     NAME                                                             READY   STATUS    RESTARTS   AGE
    mendix        demo-master-b88bfd66f-bn5jl                                      2/2     Running   0          21m
    mendix        mendix-agent-9966b5f96-2bz5n                                     1/1     Running   0          21m
    mendix        mendix-operator-585f4f48b6-rzqrj                                 1/1     Running   0          21m
    Result: Count of pods running 
    ./validate.sh - Success: Number of running pods is        26

    Result: Checking Application Pods 
    ./validate.sh - Success: Number of running demo application pods is         1

    ./validate.sh   Application Url: demo.35.222.165.23.nip.io  #URL to access the Mendix app
    ./validate.sh   Prometheus Url:  35.184.183.116:9090



## Clean up

    terraform destroy


# AKS Mendix Quickstart


   Create a AKS Cluster

   Deploy nginx Ingress Controller

   Deploy a sample Mendix application

## Sequence Diagram

![Sequence Diagram](/images/sequence.png)


## PreRequisites
    az cli  -  az login
    Terraform is installed
    kubectl
    helm

## Setting up a new vm/machine:

    . ./install-pre-reqs.sh
    az login 

## Update env.sh and terraform.tfvars
    update env.sh
    update terraform.tfvars
   
## To Execute

     terraform init
     terraform plan
     terraform apply --auto-approve
          or 
     . ./start.sh 

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



## Connected or Standalone modes
   Update env.sh set mode to connected or standalone

     export MENDIX_CONFIG_IVAL="<TODO:REPLACE-ME>"
     export MENDIX_CONFIG_SVAL="<TODO:REPLACE-ME>"
     ....
     export mode=connected

        Or

     export mode=standalone

## Clean up

    terraform destroy
        or 
    . ./stop.sh

export PATH=$PATH:.
echo $PATH 


## Used in configure.sh
## only required for connected mode -i and -s parameter
## mxpc-cli base-install --namespace new  -i $MENDIX_CONFIG_IVAL -s $MENDIX_CONFIG_SVAL --clusterMode connected  --clusterType generic
export MENDIX_CONFIG_IVAL="<TODO:REPLACE-ME>"
export MENDIX_CONFIG_SVAL="<TODO:REPLACE-ME>"

## Registry config - configure-template.yaml is updated with this information
export MENDIX_REGISTRY_PULL_URL="<TODO:REPLACE-ME>"
export MENDIX_REGISTRY_PUSH_URL="<TODO:REPLACE-ME>"
export MENDIX_REGISTRY_NAME="<TODO:REPLACE-ME>"
export MENDIX_AUTH_USER="<TODO:REPLACE-ME>"
export MENDIX_AUTH_PW="<TODO:REPLACE-ME>"

# Location of the MDA file. This will be used to generate the demo.yaml by generate-yaml.sh
export MENDIX_DEMO_MDA="https:\/\/demo-storage-d1eyl9oe4fo8ph151641-staging.s3.us-east-2.amazonaws.com\/public\/Main+line-0.0.0.6.mda"

# Mendix namespace
export MENDIX_NAMESPACE=mendix

# Used in do-all.sh to download the right mxpc-cli version
mendixOperatorVersion=2.10.1
# For Mac
# os=macos-amd64
# For Linux
os=linux-amd64

export KUBE_CONFIG_PATH=~/.kube/config
mode=standalone

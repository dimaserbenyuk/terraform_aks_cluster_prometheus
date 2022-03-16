## Login to Azure

# login and follow prompts

az login 

TENTANT_ID=<your-tenant-id>

# view and select your subscription account

az account list -o table

# get the current default subscription using show
az account show --output table

SUBSCRIPTION=<id>

az account set --subscription $SUBSCRIPTION

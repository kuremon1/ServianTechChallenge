$variables = Get-Content -Raw -Path .\variables.json | ConvertFrom-Json

# Create resource group
az group create --name $variables.backend_rg.rgname --location $variables.backend_rg.location

# Create storage account
az storage account create --resource-group $variables.backend_rg.rgname --name $variables.backend_rg.backend_storage.storagename --sku $variables.backend_rg.backend_storage.sku --encryption-services blob

# Create blob container
az storage container create --name $variables.backend_rg.backend_storage.containername --account-name $variables.backend_rg.backend_storage.storagename
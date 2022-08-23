#Set Connection string for Azure Webapp
$postgresconnectionstring = Get-AzPostgreSqlConnectionString -Name $postgreserver -ResourceGroupName $rgname
az webapp config connection-string set -g $rgname -n $appname -t PostgresSQLAzure --settings defaultConnection=$postgresconnectionstring

#Add environment variables and retrieve values from key vault
$dbadmin = Get-AzKeyVaultSecret -VaultName $stckeyvault -Name "dbadmin" -AsPlainText
az webapp config appsettings set --resource-group $rgname --name $appname --settings dbadmin="$postgresdb.mysql.database.azure.com"

#Enable persistent storage
az webapp config appsettings set --resource-group $rgname --name $appname --settings WEBSITES_ENABLE_APP_SERVICE_STORAGE=TRUE

#enable health check
az webapp config set -g $rgname -n $appname --generic-configurations '{"healthCheckPath": "/healthcheck/"}'


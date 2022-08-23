#Set Connection string for Azure Webapp
$postgresconnectionstring = Get-AzPostgreSqlConnectionString -Name $postgreserver -ResourceGroupName $rgname
az webapp config connection-string set -g $rgname -n $appname -t PostgresSQLAzure --settings defaultConnection=$postgresconnectionstring


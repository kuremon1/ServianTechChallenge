#Pull docker images from public hub, modify conf file and build app
docker build .\techchallengeapp -t stctest\techchallengeapp:v2

#Retrieve SPN account to login to ACR
$spnid = Get-AzKeyVaultSecret -VaultName $vaultname -Name $spnname -AsPlainText
$spnsecretid = Get-AzKeyVaultSecret -VaultName $vaultname -Name $spnsecret -AsPlainText

#Log in to Azure container registry
az acr login --name $acrname --client-id $spnid --client-secret $spnsecretid --tenant-id $tenantid

#Tag container images
docker tag stctest/techchallengeapp:v2 $acrname.azurecr.io/stctest/techchallengeapp:v2

#Push image to Azure Container Registry
docker push $acrname.azurecr.io/stctest/techchallengeapp:v2
az acr repository list --name $acrname.azurecr.io --output table




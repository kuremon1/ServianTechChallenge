# serviandemo
Job applying assessment

#Deploying steps :
1- Create a Terraform backend.
Run the infra/tf_backend/create_backend.ps1 script.
This will create a new RG and storage in Azure to store the terraform backend file.
This step will run only once, so there is no need to managed variables or CI/CD.

2- Setup Prerequisites for infrastructure deployment
Create Azure Service Principal for Azure Connection
Setup Service Connection

2- Deploy the Servian Tech Challenge (STC) terraform infrastructure.
This will be composed of :
    - Resource Group
    - PostgreSQL Server & Database
    - Azure Web App Service & Service Plan
    - Key Vault
    - Azure Container Registry - to store the image
The Terraform files are stored in the infra/tf_infra folder.
All the resources will be deployed in a single main file without modules for this test.

The deployment will be made in a Release pipeline in Azure DevOps.
A start of this pipeline can be used with the infra/pipelines/deploy_tf.yml.
In this exercise, the pipeline will not be finalised or tested.
The pipeline will be based on Azure DevOps :
    - Read the Release & Group Variables
    - Replace Azure Variables tokens in files
    - Install & Plan Terraform
    - Have a required approval before 2nd stage (terraform apply)
    - Store Secret Values in Key Vault (Postgres Admin credentials)

3- Build Servian Image and push to ACR
Modify conf.toml file and push to custom ACR





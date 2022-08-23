# Servian Tech Challenge
This repository is for the Servian Tech Challenge Assessment.
https://github.com/servian/TechChallengeInstructions/blob/main/README.md


# Deploying steps :
## 1- Create a Terraform backend.
This will create a new RG and storage in Azure to store the terraform backend file.
This step will run only once, so there is no need to managed variables or CI/CD.
How to : Run the infra/tf_backend/create_backend.ps1 script.

## 2- Setup Prerequisites for infrastructure deployment
Create Azure Service Principal for Azure Connection

## 3- Deploy the Servian Tech Challenge (STC) terraform infrastructure.
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
Modify conf.toml file and push image to Azure Container Registry using PushApptoACR Script.

4- Configure Web App and Azure Postgres using configure ConfigureWebApp script.
This will setup connection string, persistent storage, environment variables and health check on Azure

The parts 3 and 4 should be part of a CI/CD Pipeline.

5- Test and validate :
There is currently an issue :
Initiating warmup request to container stctestcle_0_dd1743c2 for site stctestcle
ERROR - Container stctestcle_0_dd1743c2 for site stctestcle has exited, failing site start
ERROR - Container stctestcle_0_dd1743c2 didn't respond to HTTP pings on port: 8080, failing site start.  Stopping site stctestcle because it failed during startup.





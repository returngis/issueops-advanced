# IssueOps Demo

¡Hola developer 👋🏻! Este repositorio contiene un ejemplo de cómo trabajar con IssueOps, utilizando Issue Forms, GitHub Actions, Terraform para el despliegue de infraestructura y Microsoft Azure como destino. Si quieres verlo en funcionamiento puedes echar un vistazo a este vídeo de mi canal de YouTube:

### Requisitos

Para poder usar este repositorio necesitas:

- **Crear las etiquetas** que se usan para los diferentes tipos de arquitecturas que están disponibles en este repo: `issueops:web`, `issueops:kubernetes` e `issueops:storage`. Estas van a ayudar a los flujos de GitHub Actions a elegir una plantilla y archivos de Terraform en concreto.
- **Registrar una aplicación en Microsoft Entra ID** que nos permita desplegar los recursos en Azure a través de Terraform. Puedes hacerlo con esta línea: 
```bash
az login
AZURE_CREDENTIALS=$(az ad sp create-for-rbac --name "issueOps-advanced" --role contributor --scopes /subscriptions/$(az account show --query id -o tsv))
```
- **Crear los siguientes secretos** para los flujos de GitHub Actions:
    - `TF_SUBSCRIPTION_ID`: El Id de la suscripción donde vas a desplegar los recursos.
    - `TF_CLIENT_ID`: Client Id recuperado del comando anterior.
    - `TF_CLIENT_SECRET`: Password recuperado del comando anterior.
    - `TF_TENANT_ID`: El Id del tenant donde se encuentra la suscripción donde vas a desplegar los recursos.

Para hacerlo de forma sencilla puedes utilizar GitHub CLI:

```bash
gh auth login -s codespace

gh secret set TF_SUBSCRIPTION_ID -b"$(az account show --query id -o tsv)"
gh secret set TF_CLIENT_ID -b"$(echo $CREDENTIALS | jq -r .appId)"
gh secret set TF_CLIENT_SECRET -b"$(echo $CREDENTIALS | jq -r .password)"
gh secret set TF_TENANT_ID -b"$(az account show --query tenantId -o tsv)"
```

- **Una cuenta de Azure Storage** donde se va a guardar los estados de terraform de las diferentes arquitecturas que se creen en base a las peticiones.

```bash
LOCATION="spaincentral"
RG_NAME="issueOps-advanced"
STORAGE_NAME="issueopsadvanced"
CONTAINER_NAME="tfstate"

az group create --name $RG_NAME --location $LOCATION

az storage account create --name $STORAGE_NAME --resource-group $RG_NAME --location $LOCATION --sku Standard_LRS

az storage container create --name $CONTAINER_NAME --account-name $STORAGE_NAME
```

- **Los secretos asociados a la cuenta de storage** que son:
    - `TF_STATE_RESOURCE_GROUP_NAME`
    - `TF_STATE_AZURE_STORAGE_NAME`
    - `TF_STATE_CONTAINER_NAME`
    - `TF_STATE_STORAGE_ACCESS_KEY`

También puedes hacerlo con GitHub CLI:

```bash
ACCESS_KEY=$(az storage account keys list --account-name $STORAGE_NAME --resource-group $RG_NAME --query "[0].value" -o tsv)


gh secret set TF_STATE_RESOURCE_GROUP_NAME $RG_NAME
gh secret set TF_STATE_AZURE_STORAGE_NAME $STORAGE_NAME
gh secret set TF_STATE_CONTAINER_NAME $CONTAINER_NAME
gh secret set TF_STATE_STORAGE_ACCESS_KEY $ACCESS_KEY
``` 

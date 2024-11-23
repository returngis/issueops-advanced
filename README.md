# IssueOps Demo

¡Hola developer 👋🏻! Este repositorio contiene un ejemplo de cómo trabajar con IssueOps, utilizando Issue Forms, GitHub Actions, Terraform para el despliegue de infraestructura y Microsoft Azure como destino. Si quieres verlo en funcionamiento puedes echar un vistazo a este vídeo de mi canal de YouTube:

### Requisitos

Para poder usar este repositorio necesitas:

- **Crear las etiquetas** que se usan para los diferentes tipos de arquitecturas que están disponibles en este repo: `issueops:web`, `issueops:kubernetes` e `issueops:storage`. Estas van a ayudar a los flujos de GitHub Actions a elegir una plantilla y archivos de Terraform en concreto.
- **Registrar una aplicación en Microsoft Entra ID** que nos permita desplegar los recursos en Azure a través de Terraform. Puedes hacerlo con esta línea: 
```bash
az ad sp create-for-rbac --name "issueOps" --role contributor --scopes /subscriptions/$(az account show --query id -o tsv)
```
- **Crear los siguientes secretos** para los flujos de GitHub Actions:
    - `TF_SUBSCRIPTION_ID`: El Id de la suscripción donde vas a desplegar los recursos.
    - `TF_CLIENT_ID`: Client Id recuperado del comando anterior.
    - `TF_CLIENT_SECRET`: Password recuperado del comando anterior.
    - `TF_TENANT_ID`: El Id del tenant donde se encuentra la suscripción donde vas a desplegar los recursos.

- **Una cuenta de Azure Storage** donde se va a guardar los estados de terraform de las diferentes arquitecturas que se creen en base a las peticiones.

- **Los secretos asociados a la cuenta de storage** que son:
    - `TF_STATE_RESOURCE_GROUP_NAME`
    - `TF_STATE_AZURE_STORAGE_NAME`
    - `TF_STATE_CONTAINER_NAME`
    - `TF_STATE_STORAGE_ACCESS_KEY`
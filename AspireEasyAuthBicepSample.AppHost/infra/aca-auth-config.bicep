metadata description = 'Creates an Easy Auth configuration for a container app.'
param name string
param clientId string
param clientSecretName string
param location string = resourceGroup().location

resource containerApp 'Microsoft.App/containerApps@2023-04-01-preview' existing = {
  name: 'webfrontend'
}

// raw template comes from
// https://learn.microsoft.com/en-us/azure/templates/microsoft.app/containerapps/authconfigs
// this is currently not parameterized because the options are too wide
// get your config by running this command:
// az containerapp auth show --name $YOUR_APP_NAME -g $RG

resource easyAuth 'Microsoft.App/containerApps/authConfigs@2023-11-02-preview' = {
  name: name
  parent: containerApp
  properties: {
    // globalValidation: {
    //   redirectToProvider: 'github'
    //   unauthenticatedClientAction: 'RedirectToLoginPage'
    // }
    identityProviders: {
      gitHub: {
        enabled: true
        registration: {
          clientId: clientId
          clientSecretSettingName: clientSecretName
        }
      }
    }
    login: {
      preserveUrlFragmentsForLogins: false
    }
    platform: {
      enabled: true
    }
  }
}
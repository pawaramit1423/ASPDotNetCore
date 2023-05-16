pipeline {
    agent any

    environment {
        AZURE_SUBSCRIPTION_ID = '490ced3e-1c77-4287-971c-dc11fb980a48'
        AZURE_TENANT_ID = '5421f4b2-883c-460e-a454-a4e19519abfc'
        AZURE_CLIENT_ID = credentials('azure-service-principal-id')
        AZURE_CLIENT_SECRET = credentials('azure-service-principal-secret')
        RESOURCE_GROUP_NAME = 'Dev_Grafana'
        APP_SERVICE_NAME = 'cicddotnet'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    checkout scm
                    sh 'dotnet build'
                    sh 'dotnet publish -c Release -o ./publish'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    withCredentials([azureServicePrincipal(credentialsId: 'AzureServicePrincipal', clientIdVariable: 'AZURE_CLIENT_ID', clientSecretVariable: 'AZURE_CLIENT_SECRET', subscriptionIdVariable: 'AZURE_SUBSCRIPTION_ID', tenantIdVariable: 'AZURE_TENANT_ID')]) {
                        sh '''
                            az login --service-principal --username $AZURE_CLIENT_ID --password $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
                            az account set --subscription $AZURE_SUBSCRIPTION_ID
                            az webapp deployment source config-zip --resource-group $RESOURCE_GROUP_NAME --name $APP_SERVICE_NAME --src ./publish/your-app-name.zip
                            az logout
                        '''
                    }
                }
            }
        }
    }
}

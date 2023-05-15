pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Build the .NET Core application using MSBuild
                msbuild (
                    msBuildName: 'MSBuild',
                    solutionFile: 'MyApp.sln'
                )
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the application to Azure App Service using the Azure App Service Plugin
                azureWebAppPublish (
                    credentialsId: 'azure-credentials',
                    resourceGroup: 'my-resource-group',
                    appName: 'my-app-name',
                    filePath: '**/*.zip',
                    deployToSlotOrASE: false
                )
            }
        }
    }
}

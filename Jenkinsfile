pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Build the .NET Core application using MSBuild
                msbuild (
                    msBuildName: 'MSBuild',
                    solutionFile: 'dotnetcore.sln'
                )
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the application to Azure App Service using the Azure App Service Plugin
                azureWebAppPublish (
                    credentialsId: '50192942-3704-44bf-ae70-93d354368d0b',
                    resourceGroup: 'Dev_Grafana',
                    appName: 'cicddotnet',
                    filePath: '**/*.zip',
                    deployToSlotOrASE: false
                )
            }
        }
    }
}

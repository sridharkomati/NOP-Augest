pipeline{
    agent{label 'dotnet-7'}
    stages{
        stage('VCS'){
            steps{
                sh 'git clone https://github.com/nopSolutions/nopCommerce.git'

            }
        }
        stage('artifact build'){
          steps{
            sh 'sudo apt update'
            sh 'sudo apt upgrade dotnet-sdk-7.0'
            sh 'git clone https://github.com/CICDProjects/nopCommerceJuly23.git'
            sh 'dotnet restore src/NopCommerce.sln'
            sh 'dotnet build -c Release src/NopCommerce.sln'
            sh 'dotnet publish -c Release src/Presentation/Nop.Web/Nop.Web.csproj -o publish'
            sh 'mkdir publish/bin publish/logs'
            sh 'zip -r nopCommerce.zip publish'
            archive '**/nopCommerce.zip'
          } 
        }   
        stage('docker image build'){
            steps{
                sh 'docker image build -t nop123 .'
                sh 'docker image tag nop123 sridhar006/nopaugest:${BUILD_ID}'
                sh 'docker push sridhar006/nopaugest:${BUILD_ID}' 
            }

        }  
            

    }
}
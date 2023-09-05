pipeline{
    agent{label 'dotnet-7'}
    stages{
        stage('VCS'){
            steps{
                   git credentialsId: 'GIT_HUB_CREDENTIALS',
                       url: 'https://github.com/sridharkomati/NOP-Augest.git',
                       branch: 'tera'


            }
        }
        stage('artifact build'){
          steps{
            sh 'sudo apt update'
            sh 'sudo apt upgrade dotnet-sdk-7.0 -y'
            sh 'dotnet restore src/NopCommerce.sln'
            sh 'dotnet build -c Release src/NopCommerce.sln'
            sh 'dotnet publish -c Release src/Presentation/Nop.Web/Nop.Web.csproj -o publish'
            sh 'sudo apt install zip -y'
            sh 'zip -r nopCommerce.zip publish'
            archive '**/nopCommerce.zip'
          } 
        } 
        withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD',variable: 'PASSWORD')]) {
         sh 'docker login -u sridhar006 -p $PASSWORD'  
         }
        stage('docker push image '){
            steps{
                sh 'docker image build -t nop123 .'
                sh 'docker image tag nop123 sridhar006/nopaugest:${BUILD_ID}'
                sh 'docker push sridhar006/nopaugest:${BUILD_ID}' 
                
    }
        // stage("kubernetes deployment"){
        //    sh 'kubectl apply -f deployment.yml'
    //   }

      }  

     }
 }

// pipeline{
//     node {

//        stage("Git Clone"){

//           git credentialsId: 'GIT_HUB_CREDENTIALS', 
//           url:
//                     'https://github.com/sunitabachhav2007/node-todo-cicd.git', branch: 'master'
// }

// stage("Build") {

// sh 'docker build . -t sunitabachhav2007/node-todo-test:latest'
// sh 'docker image list'

// }

// withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD',
// variable: 'PASSWORD')]) {
// sh 'docker login -u sunitabachhav2007 -p $PASSWORD'

// }

// stage("Push Image to Docker Hub"){
// sh 'docker push sunitabachhav2007/node-todo-test:latest'
// }

// stage("kubernetes deployment"){
// sh 'kubectl apply -f deployment.yml'
// }
// }
// }
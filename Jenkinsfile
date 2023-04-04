pipeline{
    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
    }
    stages{

        stage('Sonarquebe quality check'){
            
            agent{
                docker{
                    image 'maven'
                }
            }
            steps{

                script{
                     withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }

        stage('Sonarqube Quality Check'){
            steps{
                
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
       }
       stage('docker build and push to Nexus repo'){
        steps{
            script{
                withCredentials([string(credentialsId: 'Nexus_pass', variable: 'Nexus_Cred')]) {

                sh '''
                    docker build -t 13.214.30.1:8083/springapp:${VERSION} .
                    docker login -u admin -p $Nexus_Cred 13.214.30.1:8083
                    docker push 13.214.30.1:8083/springapp:${VERSION}
                    docker rmi 13.214.30.1:8083/springapp:${VERSION}

                '''
                }
            }
        }
       }

    }
}
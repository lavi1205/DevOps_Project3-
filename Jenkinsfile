pipeline{
    agent any

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

    }
}
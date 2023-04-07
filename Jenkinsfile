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

        stage('Quality Gate Status'){
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
                    docker build -t 18.142.119.167:8083/springapp:${VERSION} .
                    docker login -u admin -p $Nexus_Cred 18.142.119.167:8083
                    docker push 18.142.119.167:8083/springapp:${VERSION}
                    docker rmi 18.142.119.167:8083/springapp:${VERSION}

                '''
                }
            }
        }
       }
       stage('Identifying missconfi using datree in helm charts'){
        steps{
            script{
                 dir('kubernetes/myapp/'){
                    withEnv(['DATREE_TOKEN = 32ff472a-2473-43e4-9bdd-db6686aa49de']) {
                    sh 'helm datree test .'
                    }
                 }

                    
    
                }
            }
        }
        stage('Push Helm chare to Nexus repo'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'Nexus_pass', variable: 'Nexus_Cred')]){
                        dir('kubernetes/'){
                            sh'''
                            helmversion=$(helm show chart myapp | grep version | cut -d: -f 2 | tr -d ' ')
                            tar -czvf myapp-${helmversion}.tgz myapp/
                            curl -u admin:$Nexus_Cred http://18.142.119.167:8081/repository/helm-repo/ --upload-file myapp-${helmversion}.tgz -v
                            '''
                    }
                  }

                }
            }
        }
       }

    
        post{
		    always{
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "thinhphamthe874@gmail.com";  
		    }
        }
}


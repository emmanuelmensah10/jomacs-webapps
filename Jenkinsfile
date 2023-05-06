//Declarative Script
pipeline{
    //agent { label "node1" }
    //agent none
    agent any
    tools{
        maven "maven3.8.8"
    }
    
    stages{
        
        stage ("1. Cloning from github"){
            steps{
                sh "echo Git cloning fromm github started"
                git credentialsId: 'github', url: 'https://github.com/isaacsnipe/jomacs-webapps.git'
                sh "echo Git clone completed"
            }
        }
        
        stage ("2. Building with Maven tool"){
            steps{
                sh "echo cleaning and building artifact"
                sh "mvn clean package"
                sh "echo building completed"
            }
        }
        
        stage ("3. Scanning and testing artifact"){
            steps{
                sh "echo scanning artifact using Sonarqube"
                sh "mvn sonar:sonar"
                sh "echo scanning completed"
            }
        }
        
        stage ("4. Storing artifact in Nexus"){
            steps{
                sh "echo storing artifacts in nexus server"
                sh "mvn deploy"
                sh "echo storing artifact completed"
            }
        }
        
        stage ("5. Deploy artifact to UAT on tomcat server"){
            steps{
                sh "echo Deploying to tomcat UAT server"
                deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://172.31.17.184:8080')], contextPath: null, war: 'target/*.war'
                sh "echo Deploying complete"
            }
        }
        
        stage ("6. Pending PM Approval"){
            agent { label "node1" }
            steps{
                timeout(time:2, unit:'DAYS'){
                    input message: "Waiting for PM approval to GO LIVE"
                }
            }
        }
        
        stage ("7. Deploying to prod env"){
            steps{
                sh "echo Deploying to Production env"
                deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://172.31.17.184:8080')], contextPath: null, war: 'target/*.war'
                sh "echo Deploying complete"
            }
        }
        
        stage ("8. Email Notification"){
            agent { label "node1" }
            steps{
                sh "echo Email on successful deployment"
                emailext body: 'Features released to live server A', subject: 'Feature release to live', to: 'info@erhk.org'
                sh "echo Email sent"
            }
        }
    }
}

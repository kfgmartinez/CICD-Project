pipeline{
    agent{
        node{
            label 'maven'
        }
    }
    environment {
        PATH = "/opt/apache-maven-3.9.4/bin:$PATH"
    }
    stages{
        stage ('BUILD'){
            steps{
                echo '-------------------UNIT TEST-------------------'
                sh 'mvn clean deploy -Dmaven.test.skip.=true'
                echo '-------------------UNIT COMPLETED-------------------'
            }
        }
        stage('TEST'){
            steps{
                echo '-------------------UNIT TEST-------------------'
                sh 'mvn surefire-report:report'
                echo '-------------------UNIT COMPLETED-------------------'
            }
        }

        stage('SonarQube analysis') {
        environment{
            scannerHome = tool 'twitter-sonar-scanner'
        }
            steps{
                withSonarQubeEnv('twitter-sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}

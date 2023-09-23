pipeline{
    agent{
        node{
            label 'maven'
        }
    }
    
    stages{
        stage ('BUILD'){
            steps{
                sh 'mvn clean deploy'
            }
        }
    }
}

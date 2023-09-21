pipeline{
    agent{
        node{
            label "maven"
        }
    }
    
    stages{
        stage ('Clone-Code'){
            steps{
                gitbranch: 'main', url: "https://github.com/kfgmartinez/CICD-Project.git"
            }
        }
    }
}
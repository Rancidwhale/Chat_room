pipeline {
    agent any
    tools{
        maven 'mvn'
    }
    stages {
        stage('Git SCM') {
            steps {
                git 'https://github.com/Rancidwhale/Chat_room.git' 
            }
        }
        stage('Build'){
            steps{
                sh 'mvn package'
            }
        }
        
        
    }
}

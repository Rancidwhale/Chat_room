pipeline {
    agent any
    stages {
        stage('Git') {
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

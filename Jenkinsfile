pipeline{
    agent { label 'slave1' }

    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'git-ssh', url: 'git@github.com:Rancidwhale/Chat_room.git'
            }
        }
        stage(' Build') {
            steps {
                sh 'mvn package'
            }
        }

    }
    post{
        always {
            emailext(
                to: 'muhammadabdullah3602@gmail.com',
                subject: 'Build Status : ${BUILD_STATUS} of Build Number : ${BUILD_NUMBER}',
                body: 'this is the build status for this build',
                attachLog: true
            )
        }
    }   
}
//comment 
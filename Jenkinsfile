pipeline {
   agent any
   tools {
    maven 'mvn'
   }
   stages {
      stage('git checkout') {
        steps {
            git 'https://github.com/Rancidwhale/Chat_room.git'
        }
      }
      stage('build') {
        steps {
            sh 'mvn package'
        }
      }
    }
    post {
        always {
            emailtext(
                to: 'muhammadabdullah3602@gmail.com',
                subject: 'Build ${BUILD_NUMBER} - ${BUILD_STATUS}',
                body: 'The build has completed with status: ${BUILD_STATUS}',
                attachLog: true
            )
        }
    }
}    
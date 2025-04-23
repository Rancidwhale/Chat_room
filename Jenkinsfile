def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger'
    ]

pipeline{
    agent any
    environment{
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages{
        stage('git'){
            steps{
                git 'https://github.com/Rancidwhale/Chat_room.git'
            }
        }
        stage('docker image'){
            steps{
                script{
                    sh 'docker build -t abdullah77044/chatroom-2 .'
                }
            }
        }
        stage('Code Analysis'){
            steps{
                withSonarQubeEnv('sonar-slave'){
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Chat_Room \
                    -Dsonar.java.binaries=. \
                    -Dsonar.projectKey=Chat_Room'''
                }
            }
        }
        stage('docker push'){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'docker-cred'){
                        sh 'docker push abdullah77044/chatroom-2'
                    }
                }
            }
        }
        stage('deploy'){
            steps{
                script{
                    sh 'docker run -itd -p 8081:8080 abdullah77044/chatroom-2'
                }
            }
        }
    }
    post {
        always {
            echo 'slack Notification.'
            slackSend channel: '#demo',
            color: COLOR_MAP [currentBuild.currentResult],
            message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URl}"
            
        }
    }
}
//comment
// pipeline{
//     agent any
//     stages{
//         stage('git'){
//             steps{
//                 git 'https://github.com/Rancidwhale/Chat_room.git'
//             }
//         }
//         stage('docker image'){
//             steps{
//                 script{
//                     sh 'docker build -t abdullah77044/chatroom-2 .'
//                 }
//             }
//         }
        // stage('docker push'){
        //     steps{
        //         script{
        //             withDockerRegistry(credentialsId: 'fe43025c-38ee-4ef6-aba0-da7ef52ef72a'){
        //                 sh 'docker push abdullah77044/chatroom-2'
        //             }
        //         }
        //     }
        // }
//         stage('deploy'){
//             steps{
//                 script{
//                     sh 'docker run -itd -p 8081:8080 abdullah77044/chatroom-2'
//                 }
//             }
//         }
//     }
// }
// pipeline{
//     agent any

//     stages{
//         stage(' SCM'){
//             steps{
//                 git credentialsId: 'git-cred', url: 'https://github.com/Rancidwhale/Chat_room.git'
//             }
//         }
//         stage(' Build') {
//             steps {
//                 sh 'mvn clean package'
//             }
//         }

//     }
//     post{
//         always {
//             emailext(
//                 to: 'muhammadabdullah3602@gmail.com',
//                 subject: 'Build Status : ${BUILD_STATUS} of Build Number : ${BUILD_NUMBER}',
//                 body: 'this is the build status for this build',
//                 attachLog: true
//             )
//         }
//     }   
// }

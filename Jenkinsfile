def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger'
    ]

pipeline{
    agent any
    environment {
        SCANNER_HOME=tool 'sqube-scanner'
        TMDB_V3_API_KEY = credentials('tmdb-api-key')
        IMAGE_NAME = "chatroom" // Name of the image created in Jenkins
        CONTAINER_NAME = "chatroom" // Name of the container created in Jenkins
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git 'https://github.com/Rancidwhale/Chat_room.git'
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sqube-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=DevSecOps-Project \
                    -Dsonar.projectKey=DevSecOps-Project'''
                }
            }
        }
       
        stage('OWASP FS SCAN') {
             steps {
             withCredentials([string(credentialsId: 'nvd-api-key', variable: 'NVD_API_KEY')]) {
            dependencyCheck additionalArguments: "--scan ./ --disableYarnAudit --disableNodeAudit --nvdApiKey ${NVD_API_KEY}", odcInstallation: 'DP-Check'
             }
            dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
       }

        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"     
            }
        }
        stage('Clean Up Docker Resources') {
            steps {
                script {
                    // Remove the specific container
                    sh '''
                    if docker ps -a --format '{{.Names}}' | grep -q $CONTAINER_NAME; then
                        echo "Stopping and removing container: $CONTAINER_NAME"
                        docker stop $CONTAINER_NAME
                        docker rm $CONTAINER_NAME
                    else
                        echo "Container $CONTAINER_NAME does not exist."
                    fi
                    '''

                    // Remove the specific image
                    sh '''
                    if docker images -q $IMAGE_NAME; then
                        echo "Removing image: $IMAGE_NAME"
                        docker rmi -f $IMAGE_NAME
                    else
                        echo "Image $IMAGE_NAME does not exist."
                    fi
                    '''
                }
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                    sh 'docker build --build-arg TMDB_V3_API_KEY=$TMDB_V3_API_KEY -t $IMAGE_NAME .'
                }
            }
        }
        stage("TRIVY"){
            steps{
                sh "trivy image $IMAGE_NAME > trivyimage.txt"
            }
        }
        stage('Deploy to container'){
            steps{
                sh 'docker run -itd --name $CONTAINER_NAME -p 8081:8080 $IMAGE_NAME'
            }
        }
    }
post {
     always {
        emailext attachLog: true,
            subject: "'${currentBuild.result}'",
            body: "Project: ${env.JOB_NAME}<br/>" +
                "Build Number: ${env.BUILD_NUMBER}<br/>" +
                "URL: ${env.BUILD_URL}<br/>",
            to: 'muhammadabdullah3602@gmail.com',                               
            attachmentsPattern: 'trivyfs.txt,trivyimage.txt'
        }
    }
}


// pipeline{
//     agent any
//     environment{
//         SCANNER_HOME = tool 'sonar-scanner'
//     }
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
//         stage('Code Analysis'){
//             steps{
//                 withSonarQubeEnv('sonar-slave'){
//                     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Chat_Room \
//                     -Dsonar.java.binaries=. \
//                     -Dsonar.projectKey=Chat_Room'''
//                 }
//             }
//         }
//         stage('docker push'){
//             steps{
//                 script{
//                     withDockerRegistry(credentialsId: 'docker-cred'){
//                         sh 'docker push abdullah77044/chatroom-2'
//                     }
//                 }
//             }
//         }
//         stage('deploy'){
//             steps{
//                 script{
//                     sh 'docker run -itd -p 8081:8080 abdullah77044/chatroom-2'
//                 }
//             }
//         }
//     }
//     post {
//         always {
//             echo 'slack Notification.'
//             slackSend channel: '#demo',
//             color: COLOR_MAP [currentBuild.currentResult],
//             message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URl}"
            
//         }
//     }
// }
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

pipeline {
    environment {
        DockerhubUri = 'https://index.docker.io/v1/'
        DockerhubCred = 'Dockerhub'
        DockerhubBuildTag = 'pwang009/azure-vote-app:latest'
    }
    agent any

    stages {
        stage('Verify Branch feature1') {
            steps {
                echo "$GIT_BRANCH"
                }
        }
        stage('Docker Build') {
            steps {
                sh(script: 'docker images -a')
                sh(script: '''
                cd azure-vote
                docker build -t azure-vote-app .
                cd ..
                ''')
            }
        }
        stage('Test App') {
            steps {
                sh(script: '''
                docker-compose up -d
                sh scripts/test_container.sh
                ''')
                }
            post {
                success { echo "app started fine!" }
                failure { echo "app starting failed!"}
            }
        }
        stage('Shut down App') {
            steps {
                echo "$STAGE_NAME"
                sh(script: '''
                docker-compose down
                ''')
            }
        }
        stage('Push Container') {
            steps {
                echo "$STAGE_NAME"
                echo "Workspace is $WORKSPACE"
                dir("$WORKSPACE/azure-vote") {
                    script {
                        docker.withRegistry(DockerhubUri, DockerhubCred) {
                            def image = docker.build(DockerhubBuildTag)
                            image.Push()
                        }
                    }
                }
            }
        }
        stage('Remove Unused docker image') {
            steps{
                echo "$STAGE_NAME"
                sh "docker rmi $DockerhubBuildTag"
           }
        }
    }
}

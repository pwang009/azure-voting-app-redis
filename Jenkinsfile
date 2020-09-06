pipeline {
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
                sh(script: '''
                docker-compose down -d
                ''')
                }
        }
    }
}

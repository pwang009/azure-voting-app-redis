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
    }
}

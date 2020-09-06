pipeline {
    agent any

    stages {
        stage('Verify Branch feature1') {
            steps {
                echo "$GIT_BRANCH"
                }
        }
        stage('echo a meesage') {
            steps {
                sh(script: 'echo "hello world!"')
                }
        }
    }
}

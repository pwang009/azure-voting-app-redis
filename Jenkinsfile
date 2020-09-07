pipeline {
    environment {
        DockerhubUri = 'https://index.docker.io/v1/'
        DockerhubCred = 'Dockerhub'
        DockerhubBuildTag = 'pwang009/azure-vote-app'
    }
    agent any
    stages {
        // stage('Building image') {
        //     steps {
        //         dir("$WORKSPACE/azure-vote") {
        //             script {
        //                 image = docker.build DockerhubBuildTag + ":$BUILD_NUMBER"
        //             }
        //         }
        //     }
        // }
        stage('Deploy Image') {
            steps {
                script {
                    dir("$WORKSPACE/azure-vote") {
                        def image = docker.build DockerhubBuildTag + ":$BUILD_NUMBER"
                    }
                    docker.withRegistry( '', DockerhubCred ) {
                    image.push()
                    }
                }
            }
        }
    }
}

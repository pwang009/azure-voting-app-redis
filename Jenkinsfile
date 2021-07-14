pipeline {
    environment {
        DockerhubUri = 'https://index.docker.io/v1/'
        DockerhubCred = 'Dockerhub'
        DockerhubBuildTag = 'pwang009/azure-vote-app:latest'
    }
    agent any
    stages {
        stage('Build and Push Image') {
            steps {
                script {
                    dir("$WORKSPACE/azure-vote") {
                        image = docker.build DockerhubBuildTag 
                        docker.withRegistry( '', DockerhubCred ) {
                            image.push()
                        }
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                dir("$WORKSPACE") {
                sh """
                    echo $USER
                    echo "Starting deployment"
                    kubectl config use-context local@kubernetes
                    export KUBECONFIG=~/.kube/local:~/.kube/mini
                    /usr/local/bin/kubectl apply -f ./azure-vote-all-in-one-redis.yaml 
                   """
                }
            }
        }
    }
}

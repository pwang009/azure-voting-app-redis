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
                    export KUBECONFIG=/var/lib/jenkins/.kube/local:/var/lib/jenkins/.kube/mini
                    /usr/local/bin/kubectl config use-context local@kubernetes
                    /usr/local/bin/kubectl delete -f ./azure-vote-all-in-one-redis.yaml 
                    /usr/local/bin/kubectl apply -f ./azure-vote-all-in-one-redis.yaml 
                   """
                }
            }
        }
    }
}

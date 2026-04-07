pipeline {
agent any

environment {
    IMAGE_NAME = "node-nginx-app"
    CONTAINER_NAME = "node-nginx-container"
}

stages {

    stage('Checkout') {
        steps {
            checkout scm
        }
    }

    stage('Build Docker Image') {
        steps {
            script {
                sh "docker build -t $IMAGE_NAME ."
            }
        }
    }

    stage('Stop Old Container') {
        steps {
            script {
                sh "docker stop $CONTAINER_NAME || true"
                sh "docker rm $CONTAINER_NAME || true"
            }
        }
    }

    stage('Run New Container') {
        steps {
            script {
                sh "docker run -d -p 3000:80 --name $CONTAINER_NAME $IMAGE_NAME"
            }
        }
    }
}

post {
    success {
        echo "App running on port 3000 🚀"
    }
    failure {
        echo "Deployment Failed ❌"
    }
}

}

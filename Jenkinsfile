pipeline {
    agent any

    environment {
        IMAGE_NAME = "sherry31/my-project"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    def dockerImage = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}", "--no-cache .")
                    dockerImage.tag("latest")

                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
}

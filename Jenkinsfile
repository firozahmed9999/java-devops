pipeline {
    agent any

    tools {
        maven 'Maven3'   // must match Maven name in Jenkins
        jdk 'Java17'     // must match JDK name in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/firozahmed9999/java-devops.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        // Docker build stage (disabled for now, will enable later)
        stage('Docker Build & Push') {
            when {
                expression { return false }
            }
            steps {
                script {
                    dockerImage = docker.build("firoz/calculator-ui:${BUILD_NUMBER}")
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}

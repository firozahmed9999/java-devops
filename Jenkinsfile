pipeline {
    agent any
    tools {
        maven 'Maven3'
        jdk 'Java17'
    }
    environment {
        SONAR_TOKEN = credentials('sonarqube-token')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/firozahmed9999/java-devops.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('MySonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=java-devops -Dsonar.host.url=http://<YOUR-SONARQUBE-SERVER-IP>:9000 -Dsonar.login=${SONAR_TOKEN}'
                }
            }
        }

        stage('Package') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        def dockerImage = docker.build("firozahmed9999/java-application:${BUILD_NUMBER}")
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
}

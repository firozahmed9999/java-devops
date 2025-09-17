pipeline {
    agent any

    tools {
        maven 'Maven3'  // configure in Jenkins
        jdk 'Java11'    // configure in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/firoz/java-calculator-devops.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('MySonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    dockerImage = docker.build("firoz/calculator-ui:${BUILD_NUMBER}")
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to Container') {
            steps {
                sh 'docker run -d -p 8080:8080 firoz/calculator-ui:${BUILD_NUMBER}'
            }
        }
    }
}

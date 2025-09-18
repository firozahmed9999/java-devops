pipeline {
    agent any
    tools {
        maven 'Maven3'
        jdk 'Java17'
    }
    environment {
        SONAR_TOKEN = credentials('sonarqube-token')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/firozahmed9999/java-devops.git'
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
                    sh 'mvn sonar:sonar -Dsonar.projectKey=java-devops -Dsonar.host.url=http://54.91.225.252:9000 -Dsonar.login=${SONAR_TOKEN}'
                }
            }
        }

        stage('Package') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }
}

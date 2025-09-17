pipeline {
    agent any

    tools {
        maven 'Maven3'   // must match Maven installation name in Jenkins
        jdk 'Java11'     // must match JDK installation name in Jenkins
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
                withSonarQubeEnv('MySonarQube') { // name from Jenkins config
                    sh 'mvn sonar:sonar'
                }
            }
        }
    }
}

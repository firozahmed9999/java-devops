pipeline {
    agent any

    environment {
        // Tools installed in Jenkins
        MAVEN_HOME = tool 'Maven3'
        JAVA_HOME = tool 'Java17'

        // Credentials from Jenkins -> Manage Jenkins -> Credentials
        SONAR_TOKEN = credentials('sonar-token')                // Secret text
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Username + Token
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/firozahmed9999/java-devops.git'
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
                    sh """
                        mvn sonar:sonar \
                          -Dsonar.projectKey=java-devops-calculator \
                          -Dsonar.host.url=http://54.91.225.252:9000 \
                          -Dsonar.login=$SONAR_TOKEN
                    """
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    sh """
                        echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                        docker build -t firozahmed9999/java-application:latest .
                        docker push firozahmed9999/java-application:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}

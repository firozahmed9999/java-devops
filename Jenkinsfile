pipeline {
    agent any

    environment {
        // Tools installed in Jenkins
        MAVEN_HOME = tool 'Maven3'
        JAVA_HOME = tool 'Java17'

        // Credentials from Jenkins
        SONAR_TOKEN = credentials('sonar-token')                
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') 
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
                sh '$MAVEN_HOME/bin/mvn clean package -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('MySonarQube') {
                    sh """
                        $MAVEN_HOME/bin/mvn sonar:sonar \
                          -Dsonar.projectKey=java-devops-calculator \
                          -Dsonar.host.url=http://54.91.225.252:9000 \
                          -Dsonar.token=$SONAR_TOKEN
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

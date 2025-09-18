pipeline {
    agent any

    environment {
        // Credentials
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        SONAR_TOKEN = credentials('sonar-token')

        // Docker Image Name
        DOCKER_IMAGE = "firozahmed9999/java-application"
    }

    tools {
        jdk 'Java17'        // use the JDK you configured in Jenkins
        maven 'Maven3'      // use the Maven you configured in Jenkins
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

        stage('Package') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    sh """
                        echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                        docker build -t $DOCKER_IMAGE:latest .
                        docker push $DOCKER_IMAGE:latest
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed!"
        }
        success {
            echo "✅ Build, SonarQube analysis, and Docker push successful!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}

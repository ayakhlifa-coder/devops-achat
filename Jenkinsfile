pipeline {
    agent any

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
        PATH = "/usr/lib/jvm/java-21-openjdk-amd64/bin:/usr/share/maven/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ayakhlifa-coder/devops-achat.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Deploy to Nexus') {
            steps {
                sh 'mvn deploy -DskipTests'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'sudo docker build -t achat-app .'
            }
        }
        stage('Docker Run') {
            steps {
                sh 'sudo docker stop achat-container || true'
                sh 'sudo docker rm achat-container || true'
                sh 'sudo docker run -d -p 8089:8089 --name achat-container achat-app'
            }
        }
    }

    post {
        success {
            echo 'Build reussi!'
        }
        failure {
            echo 'Build echoue!'
        }
    }
}

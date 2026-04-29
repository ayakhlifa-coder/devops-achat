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
    }

    post {
        success {
            echo 'Build réussi!'
        }
        failure {
            echo 'Build échoué!'
        }
    }
}

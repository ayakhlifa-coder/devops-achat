pipeline {
    agent any
    
    environment {
        JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
        M2_HOME = '/usr/share/maven'
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
                sh 'mvn package -DskipTests'
            }
        }
    }
}

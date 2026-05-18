pipeline {
    agent any
    environment {
        JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
        PATH = "/usr/lib/jvm/java-21-openjdk-amd64/bin:/usr/share/maven/bin:${env.PATH}"
        SONAR_TOKEN = credentials('sonarqube-token')
        NEXUS_PASSWORD = credentials('nexus-password')
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
                sh 'mvn deploy -DskipTests -Dusername=admin -Dpassword=${NEXUS_PASSWORD}'
            }
        }
        stage('Trivy FS Scan') {
            steps {
                sh 'trivy fs --scanners vuln,secret --severity CRITICAL,HIGH,MEDIUM --format json --output trivy-fs-report.json .'
            }
        }
        stage('Trivy Image Scan') {
            steps {
                sh 'trivy image --severity CRITICAL,HIGH,MEDIUM --format json --output trivy-image-report.json achat-app:latest'
            }
        }
        stage('OWASP Dependency Check') {
            steps {
                sh 'mvn org.owasp:dependency-check-maven:check'
            }
        }
    }
}

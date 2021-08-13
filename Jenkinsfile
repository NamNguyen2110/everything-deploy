pipeline {
    agent any
    stages {
        stage('Build jar') {
            steps {
                withMaven(maven: 'mvn') {
                    sh 'mvn clean package -DskipTests=true'
                }
            }
        }
        stage('Test') {
             steps {
                 withMaven(maven: 'mvn') {
                     sh 'mvn test'
                 }
             }
        }

    }
}

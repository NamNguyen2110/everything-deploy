pipeline {
    agent any
    environment {
         REPO_REGISTRY_HOST     = '35.240.198.195'
         REPO_REGISTRY_PORT     = '3004'
         IMAGE_NAME             = 'test-jenkins'
         IMAGE_VERSION          = '1.0'
    }
    stages {
        stage('Build jar') {
            steps {
                withMaven(maven: 'mvn') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }
    }
}

pipeline {
    agent any
    environment {
          DOCKER_IMAGE_NAME  = 'namnguyen2110/test-deploy'
          DOCKER_IMAGE_TAG   = '1.0.0'
          PORT               = '8084'
          CONTAINER_NAME     = 'everything-deploy'
    }
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
        stage('Build image') {
            steps {
                withDockerRegistry(credentialsId: 'DOCKER_HUB', url: 'https://index.docker.io/v1/'){
                   sh 'docker build --cache-from ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} --tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .'
                    sh 'docker push $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG'
                }
            }
        }
//         stage('Push to Docker hub') {
//             steps {
//                 withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId:'DOCKER_REGISTRY', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
//                     sh 'docker login -u $USERNAME -p $PASSWORD'
//                     sh 'docker push $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG'
//                 }
//             }
//         }
    }
}

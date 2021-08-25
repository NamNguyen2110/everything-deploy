pipeline {
    agent any
    environment {
          DOCKER_IMAGE_NAME  = 'namnguyen2110/everything-deploy'
          DOCKER_TAG         = '${GIT_BRANCH.tokenize('/').pop()}-${GIT_COMMIT.substring(0,7)}'
          PORT               = '8084'
          CONTAINER_NAME     = 'everything-deploy'
    }
    tools {dockerTool  "docker" }
    stages {
        stage('Build jar') {
            steps {
                withMaven(maven: 'mvn') {
                    sh 'mvn clean package -DskipTests=true'
                    stash includes: 'target/*.jar', name: 'targetfiles'
                }
            }
        }
        stage('Build image') {
            steps {
                     unstash 'targetfiles'
                     sh 'docker build --cache-from ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} --tag ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} .'
            }
        }
        stage('Push to Docker hub') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                    sh 'docker push $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                }
            }
        }
    }
}

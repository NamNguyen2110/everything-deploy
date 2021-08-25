pipeline {
    agent any
    environment {
          DOCKER_IMAGE_NAME  = 'namnguyen2110/everything-deploy'
          DOCKER_TAG         = '1.0.1'
          PORT               = '8084'
          CONTAINER_NAME     = 'everything-deploy'
          REMOTE_USER        = 'root'
          REMOTE_HOST          = '167.71.222.10'
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
        stage('Deploy to server') {
            steps {
                sshagent(['ssh-key']) {
                    sh 'ssh -o StrictHostKeyChecking=no -l $REMOTE_USER $REMOTE_HOST docker image rm -f $DOCKER_IMAGE_NAME:$DOCKER_TAG 2> /dev/null'
                    sh 'ssh -o StrictHostKeyChecking=no -l $REMOTE_USER $REMOTE_HOST docker pull $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG'
                    sh 'ssh -o StrictHostKeyChecking=no -l $REMOTE_USER $REMOTE_HOST docker container rm -f $CONTAINER_NAME || true'
                    sh 'ssh -o StrictHostKeyChecking=no -l $REMOTE_USER $REMOTE_HOST docker run -d -p $PORT:$PORT --name $CONTAINER_NAME $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                }
            }
        }
    }
}

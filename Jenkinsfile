pipeline {
  agent any

  environment {
    IMAGE_NAME = "custom-nginx"
    IMAGE_TAG  = "${BUILD_NUMBER}"
    DOCKER_REPO = "sandipkhot96"
  }

  stages {

    stage('Clone Repository') {
      steps {
        git branch: 'main',
            url: 'https://github.com/sandipkhot96-ops/Ngnix-Sandip.git'
      }
    }

    stage('Build NGINX Docker Image') {
      steps {
        sh '''
          echo "Building image: ${IMAGE_NAME}:${IMAGE_TAG}"
          docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
        '''
      }
    }

    stage('Verify Image') {
      steps {
        sh 'docker images | grep ${IMAGE_NAME}'
      }
    }

    stage('Tag & Push Docker Image') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo "Logging into Docker Hub"
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

            echo "Tagging image"
            docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}

            echo "Pushing image to Docker Hub"
            docker push ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
          '''
        }
      }
    }
  }

  post {
    success {
      echo "✅ Image built and pushed successfully: ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}"
    }
  }
}

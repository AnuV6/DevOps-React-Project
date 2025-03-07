pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "devops-react"
        DOCKER_TAG = "${BUILD_NUMBER}"
        DOCKER_FULL_IMAGE = "${DOCKER_IMAGE}:${DOCKER_TAG}"
        CONTAINER_NAME = "devops-react-container"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh 'npm test -- --watchAll=false'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_FULL_IMAGE} ."
                sh "docker tag ${DOCKER_FULL_IMAGE} ${DOCKER_IMAGE}:latest"
            }
        }
        
        stage('Deploy') {
            steps {
                // Stop and remove existing container if it exists
                sh '''
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                '''
                
                // Run the new container
                sh "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${DOCKER_FULL_IMAGE}"
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            // Clean up old images to save disk space
            sh "docker image prune -f"
        }
    }
}
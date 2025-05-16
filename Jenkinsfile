pipeline {
    agent any

    environment {
        APP_IMAGE = "task1jenkins_app"
        NGINX_IMAGE = "task1jenkins_nginx"
        NETWORK_NAME = "jenkinstask1"
    }

    stages {
        stage('Security Scan') {
            steps {
            echo "Running Trivy filescan..."
            sh '''
            trivy fs --formatjson -o trivy-fs-report.json .
            '''
        }
            post {
                always {
                    archiveArtifacts artifacts: 'trivy-fs-report.json', fingerprint: true
                }
            }
        }
        stage('Build') {
            steps {
                echo "Building Docker images..."
                sh 'docker build -t $APP_IMAGE -f Dockerfile .'
                sh 'docker build -t $NGINX_IMAGE -f Dockerfile.nginx .'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying app and nginx..."
                script {
                    sh '''
                    # Clean up any exisiting containers
                    docker rm -f flask-app || true
                    docker rm -f nginx || true
                    

                    # Create network if it doesn't exist
                    docker network create jenkinstask1 || true

                    # Run app container
                    docker run -d --name flask-app --network jenkinstask1 -p 5500:5500 $APP_IMAGE

                    # Run nginx container
                    docker run -d --name nginx --network jenkinstask1 -p 80:80 $NGINX_IMAGE
                    '''
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleanup: No action required'
        }
    }
}
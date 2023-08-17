pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Build the Docker image
		sh '''
		#!/bin/bash
		cd web-app
		echo "This is $(pwd)"
  		docker build -t web-app-image:${env.BUILD_ID} .
		'''
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                // Deploy the Docker image to a staging server
                sh 'docker save web-app-image:${env.BUILD_ID} | ssh student@10.10.10.151 "docker load"'
                sh 'ssh student@10.10.10.151 "docker stop web-app || true"'
                sh 'ssh student@10.10.10.151 "docker rm web-app || true"'
                sh 'ssh student@10.10.10.151 "docker run -d --name web-app -p 8080:80 web-app-image:${env.BUILD_ID}"'
            }
        }

        stage('Deploy to Production') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                // Deploy to production (similar to staging but on a different server)
                sh 'docker save web-app-image:${env.BUILD_ID} | ssh student@10.10.10.150 "docker load"'
                sh 'ssh student@10.10.10.150 "docker stop web-app || true"'
                sh 'ssh student@10.10.10.150 "docker rm web-app || true"'
                sh 'ssh student@10.10.10.150 "docker run -d --name web-app -p 80:80 web-app-image:${env.BUILD_ID}"'
            }
        }
    }

    post {
        always {
            // Clean up Docker images and containers
            sh 'docker rmi web-app-image:${env.BUILD_ID}'
            sh 'docker system prune -f'
        }
    }
}


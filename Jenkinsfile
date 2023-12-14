pipeline {
   agent any

   environment {
       DOCKER_USERNAME = credentials('username')
       DOCKER_PASSWORD = credentials('password')
   }

   stages {
       stage('Build Docker Image') {
           steps {
               script {
                   withCredentials([string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                    string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                       sh "docker build -t $DOCKER_USERNAME/jenkins:${currentBuild.number} ."
                       sh "docker build -t $DOCKER_USERNAME/jenkins:latest ."
                   }
               }
           }
       }

       stage('Docker Login') {
           steps {
               script {
                   withCredentials([string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                    string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                       sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                   }
               }
           }
       }

       stage('Docker Push') {
           steps {
               script {
                   withCredentials([string(credentialsId: 'username', variable: 'DOCKER_USERNAME'),
                                    string(credentialsId: 'password', variable: 'DOCKER_PASSWORD')]) {
                       sh "docker push $DOCKER_USERNAME/jenkins:${currentBuild.number}"
                       sh 'docker push $DOCKER_USERNAME/jenkins:latest'
                   }
               }
           }
       }
   }

   post {
       success {
           script {
               sh 'docker rmi $(docker images -q)'
           }
           echo 'Docker image build, login, push, and local image cleanup successful!'
       }

       failure {
           echo 'One or more stages failed. Check the logs for details.'
       }
   }
}

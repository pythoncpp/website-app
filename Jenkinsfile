pipeline {
    agent any
    stages {
        stage('docker image build') {
            steps {
                echo "building the image with build number ${BUILD_NUMBER}"
                sh 'docker build -t amitksunbeam/website-app:${BUILD_NUMBER} .'
            }
        }

        stage('push docker image') {
            steps {
                withCredentials([string(credentialsId: 'DOCKERHUB_TOKEN', variable: 'DOCKERHUB_TOKEN')]) {
                    echo "login to the docker"
                    sh 'echo ${DOCKERHUB_TOKEN} | docker login -u amitksunbeam --password-stdin'

                    echo "pushing the image to dockerhub"
                    sh 'docker image push amitksunbeam/website-app:${BUILD_NUMBER}'
                }
            }
        }

        stage('update deployment file') {
            steps {
                // replace the latest tag with the BUILD_NUMBER
                sh "sed -i 's/website-app:.*/website-app:${BUILD_NUMBER}/g' deployment.yaml"
            }
        }

        stage('commit the deployment file') {
            steps {
                withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'GITHUB_TOKEN')]) {
                    sh 'git config --global user.email "pythoncpp@gmail.com"'
                    sh 'git config --global user.name "amit kulkarni"'
                    sh 'git add deployment.yaml'
                    sh 'git commit -m "updated deployment file with build number ${BUILD_NUMBER}"'
                    sh 'git push https://${GITHUB_TOKEN}@github.com/pythoncpp/website-app HEAD:main'
                }
            }
        }
            
    }
}
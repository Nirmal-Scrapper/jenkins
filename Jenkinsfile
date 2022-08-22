pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'curl -fsSL https://get.docker.com -o get-docker.sh'
                // sh 'sudo sh get-docker.sh'
                sh 'sudo apt-get install docker-compose -y'
                sh 'sudo sh mm.sh'
                def test_results = true
            }
        }
        stage('deploy') {
            steps {
                if (test_results == true) {
                    sh 'sudo sh nn.sh'
                }
            }
        }

        stage('post-build') {
            steps {
                sh 'sudo aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws/p3t0m4x7'
                sh 'sudo docker tag mysq public.ecr.aws/p3t0m4x7/dock_task_mysql:latest'
                sh 'sudo docker push public.ecr.aws/p3t0m4x7/dock_task_mysql:latest'
                sh 'sudo docker tag nod public.ecr.aws/p3t0m4x7/dock_task:latest'
                sh 'sudo docker push public.ecr.aws/p3t0m4x7/dock_task:latest'
            }
        }
    }
}

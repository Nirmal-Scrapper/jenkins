pipeline {
    agent { label 'ec2' }
    environment {
        TEST_RESULTS = true
    }
    stages {
        stage('build') {
            steps {
                script {
                    try {
                        // echo "${TEST_RESULTS}"
                        sh 'curl -fsSL https://get.docker.com -o get-docker.sh'
                        sh 'sudo sh get-docker.sh'
                        sh 'sudo apt-get install docker-compose -y'
                        sh 'sudo sh build.sh'
                        sh 'sudo sh rm.sh'
                    }
                    catch (Exception ex) {
                        TEST_RESULTS = false
                        print(ex)
                    }
                }
            }
        }
        // stage('deploy') {
            // when {
            //     expression {
            //         TEST_RESULTS
            //     }
            // }

            // steps {
                // echo "${env.TEST_RESULTS}"
                // echo "${TEST_RESULTS}"
        //         script {
        //             print(TEST_RESULTS)
        //             if (TEST_RESULTS) {
        //                 sh 'sudo sh deploy.sh'
        //             }
        //         }
        //     }
        // }

        stage('post-build') {
            steps {
                sh 'sudo aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws/p3t0m4x7'
                sh 'sudo docker tag mysq public.ecr.aws/p3t0m4x7/dock_task_mysql:latest'
                sh 'sudo docker push public.ecr.aws/p3t0m4x7/dock_task_mysql:latest'
                sh 'sudo docker tag nod 877969058937.dkr.ecr.us-east-1.amazonaws.com/nirmal_nod:latest'
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 877969058937.dkr.ecr.us-east-1.amazonaws.com'
                sh 'sudo docker push 877969058937.dkr.ecr.us-east-1.amazonaws.com/nirmal_nod:latest'
            }
        }
    }
}

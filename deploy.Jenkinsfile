pipeline {
    agent { label 'ec2' }
    environment {
        TEST_RESULTS = true
    }
    parameters {
        string(name: 'BUILD', defaultValue: '')
    }
    stages {
        stage('sdad') {
            steps {
                input message: 'Should we continue?', ok :'Yes'
            }
        }
        stage('deploy') {
            steps {
                script {
                    try {
                        echo "${params.BUILD}"
                        echo "${env.BUILD}"
                        echo "${BUILD}"
                        echo "${TEST_RESULTS}"

                        sh 'sudo aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws/p3t0m4x7'
                        sh "sudo docker pull public.ecr.aws/p3t0m4x7/dock_task_mysql:${env.BUILD}"
                        sh "sudo docker tag public.ecr.aws/p3t0m4x7/dock_task_mysql:${env.BUILD} dock_task_mysql"
                        sh 'sudo aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 877969058937.dkr.ecr.us-east-1.amazonaws.com'
                        sh "sudo docker pull 877969058937.dkr.ecr.us-east-1.amazonaws.com/nirmal_nod:${env.BUILD}"
                        sh "sudo docker tag 877969058937.dkr.ecr.us-east-1.amazonaws.com/nirmal_nod:${env.BUILD} nod"
                        sh 'sudo sh rm.sh'
                        sh 'sudo sh deploy.sh'
                    }
                catch (Exception ex) {
                        TEST_RESULTS = false
                        print(ex)
                }
                }
            }
        }

        stage('clean') {
            steps {
                sh "docker rmi public.ecr.aws/p3t0m4x7/dock_task_mysql:${env.BUILD}"
                sh "docker rmi 877969058937.dkr.ecr.us-east-1.amazonaws.com/nirmal_nod:${env.BUILD}"
                sh 'rm .env'
            }
        }
    }
}

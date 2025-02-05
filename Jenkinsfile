pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    stages{
        stage('Checkout SCM'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/laura-eng-sys/jenkins-terraform.git']])
                }
            }
        }
        stage('Initializing s3'){
            steps{
                script{
                    dir('modules/s3-creation'){
                         sh 'terraform init'
                    }
                }
            }
        }
        stage('Validating s3'){
            steps{
                script{
                    dir('modules/s3-creation'){
                         sh 'terraform validate'
                    }
                }
            }
        }
        stage('terraform plan s3'){
            steps{
                script{
                    dir('modules/s3-creation'){
                         sh 'terraform plan'
                    }
                }
            }
        }
         stage('terraform apply s3'){
            steps{
                script{
                    dir('modules/s3-creation'){
                         sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
        stage('terraform destroy s3'){
            steps{
                script{
                    dir('modules/s3-creation'){
                         sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
        stage('Create ec2 initialize terraform'){
            steps{
                script{
                    dir('ec2-creation'){
                         sh 'terraform init'
                    }
                }
            }
        }
        stage('Validating ec2'){
            steps{
                script{
                    dir('ec2-creation'){
                         sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the ec2-infrastructure'){
            steps{
                script{
                    dir('ec2-creation'){
                         sh 'terraform plan'
                    }
                    input(message: "Approve?", ok: "proceed")
                }
            }
        }
    }
}

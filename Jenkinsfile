pipeline {
    agent any

    environment {
         AWS_ACCESS_KEY_ID     = credentials('my-aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('my-aws-secret-key')
        AWS_DEFAULT_REGION    = 'us-west-2' // Set your target AWS region
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
              //git url: 'https://github.com/devopslearnc/terraform.git', branch: 'main'
            }
        }

        stage('Terraform Version Check') {
            steps {
                sh 'terraform --version'
            }
        }
        

       stage('Terraform Init & Plan') {
            steps {
                dir('bmw/strata/dev') {
                    sh 'terraform init'
                    sh 'terraform plan'
                    //sh 'terraform plan-target=module.bmw_dev_vpc'
                }
            }
       }
    }
}

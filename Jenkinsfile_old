pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Automatically uses the Git repo configured in the Jenkins job settings
                checkout scm
              //git url: 'https://github.com/devopslearnc/terraform.git', branch: 'main'
            }
        }

        stage('Terraform Version Check') {
            steps {
                sh 'terraform --version'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
    }
}

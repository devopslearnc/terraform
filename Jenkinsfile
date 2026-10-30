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

       stage('Terraform Init & Plan') {
            steps {
                // The 'dir' block automatically switches into the specified folder 
                // for all commands executed inside its steps block
                dir('bmw/strata/dev') {
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
    }
}

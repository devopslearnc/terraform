pipeline {
    agent any

    //environment {
       // AWS_CREDENTIALS = credentials('aws-int')
        //AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        //AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key-id')
      //  AWS_DEFAULT_REGION    = 'us-west-2' // Set your target AWS region
    //}

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
                withCredentials([awsCredentials(credentialsId: 'aws-int', 
                                                accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                                                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')])
                // The 'dir' block automatically switches into the specified folder 
                // for all commands executed inside its steps block
                dir('bmw/strata/dev') {
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
       }
    }
}

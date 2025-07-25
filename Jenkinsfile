// Forcing a change to be detected
pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select the Terraform action to perform')
        // This example is for the structure with dev/prod environments
        // If your main.tf is in the root, remove the dir() blocks below
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Select the environment to target')
    }

    stages {
        stage('Checkout') {
            steps {
                // IMPORTANT: Replace the URL below with the actual URL of YOUR Git repository
                git 'https://github.com/Kaustubh-tech17/terraform-devops.git'
            }
        }

        stage('Terraform Execution') {
            steps {
                // This step securely loads the AWS credentials you configured in Jenkins
                withCredentials([aws(credentialsId: 'aws-terraform-creds')]) {
                    // The 'aws-terraform-creds' ID must match the one you created in Jenkins

                    // This block changes the directory to the correct environment (dev or prod)
                    dir("environments/${params.ENVIRONMENT}") {

                        // The following stages run inside the selected environment's directory

                        stage('Terraform Init') {
                            sh 'terraform init -input=false'
                        }

                        stage('Terraform Plan') {
                            sh 'terraform plan -out=tfplan -input=false'
                        }

                        stage('Approval') {
                            // This stage is only active when the ACTION is 'apply'
                            when {
                                expression { params.ACTION == 'apply' }
                            }
                            steps {
                                // This step pauses the pipeline and waits for a user to click "Proceed"
                                input message: "Review the plan. Ready to APPLY changes to the ${params.ENVIRONMENT} environment?"
                            }
                        }

                        stage('Terraform Apply or Destroy') {
                            script {
                                if (params.ACTION == 'apply') {
                                    sh 'terraform apply -auto-approve tfplan'
                                } else {
                                    input message: "This will DESTROY the ${params.ENVIRONMENT} environment. Are you sure?"
                                    sh 'terraform destroy -auto-approve'
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            // This always runs at the end to clean the workspace for the next build
            cleanWs()
        }
    }
}

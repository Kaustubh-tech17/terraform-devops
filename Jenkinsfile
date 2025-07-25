pipeline {
    agent any

    // This block makes sure the Terraform command is available in your pipeline
    tools {
        // The name 'Terraform-latest' must match the name you configure
        // in Manage Jenkins > Tools. If you haven't configured one, this is a good time to do so.
        // Or, you can remove this 'tools' block if Terraform is already installed on your agent.
        terraform 'Terraform-latest'
    }

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select the Terraform action to perform')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Select the environment to target')
    }

    stages { // The one, main stages block

        stage('Checkout') {
            steps {
                // IMPORTANT: Make sure this URL is correct
                git 'https://github.com/Kaustubh-tech17/terraform-devops.git'
            }
        }

        stage('Terraform Init') {
            steps {
                // Securely load credentials for this stage
                withCredentials([aws(credentialsId: 'aws-terraform-creds')]) {
                    // Change to the correct directory for this stage
                    dir("environments/${params.ENVIRONMENT}") {
                        sh 'terraform init -input=false'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([aws(credentialsId: 'aws-terraform-creds')]) {
                    dir("environments/${params.ENVIRONMENT}") {
                        sh 'terraform plan -out=tfplan -input=false'
                    }
                }
            }
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
            steps {
                withCredentials([aws(credentialsId: 'aws-terraform-creds')]) {
                    dir("environments/${params.ENVIRONMENT}") {
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

    post {
        always {
            // This always runs at the end to clean the workspace for the next build
            cleanWs()
        }
    }
}

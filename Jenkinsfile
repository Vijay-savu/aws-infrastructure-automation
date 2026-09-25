pipeline {
  agent { label 'linux-docker' }

  environment {
    AWS_DEFAULT_REGION = 'us-east-1'
    TF_IN_AUTOMATION    = 'true'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Validate') {
      steps {
        dir('terraform') {
          sh 'terraform fmt -check -recursive'
          sh 'terraform init -backend=false'
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
          dir('terraform') {
            sh 'terraform plan -out=tfplan'
          }
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        dir('docker') {
          sh 'docker build --tag three-tier-app:${BUILD_NUMBER} .'
          sh 'docker tag three-tier-app:${BUILD_NUMBER} three-tier-app:latest'
        }
      }
    }

    stage('Approve Infrastructure Changes') {
      steps {
        input message: 'Apply the Terraform plan?', ok: 'Apply'
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials'],
          string(credentialsId: 'database-password', variable: 'TF_VAR_db_password')
        ]) {
          dir('terraform') {
            sh 'terraform apply -auto-approve tfplan'
          }
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
          dir('ansible') {
            sh 'ansible-galaxy collection install -r requirements.yml'
            sh 'export ANSIBLE_SSM_BUCKET=$(terraform -chdir=../terraform output -raw ansible_ssm_bucket_name); ansible-playbook playbooks/deploy.yml'
          }
        }
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'terraform/tfplan', allowEmptyArchive: true
      cleanWs()
    }
  }
}

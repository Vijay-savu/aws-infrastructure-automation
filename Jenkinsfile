pipeline {
  agent any

  stages {
    stage('Terraform Validate') {
      steps {
        dir('terraform') {
          powershell 'terraform fmt -check; terraform init -backend=false; terraform validate'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        dir('docker') {
          powershell 'docker build -t three-tier-app:latest .'
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        dir('ansible') {
          powershell '$env:ANSIBLE_SSM_BUCKET = (terraform -chdir=../terraform output -raw ansible_ssm_bucket_name); ansible-galaxy collection install -r requirements.yml; ansible-playbook playbooks/deploy.yml'
        }
      }
    }
  }
}

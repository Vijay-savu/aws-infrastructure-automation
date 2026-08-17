# aws-infrastructure-automation

# AWS DevOps Infrastructure Automation

This project is a simple AWS DevOps project where I automated the process of creating infrastructure, setting up an EC2 server, and deploying a web application.

I used Terraform for infrastructure, Ansible for server configuration, Docker for running the application, and GitHub Actions for automatic deployment.

## Technologies Used

- AWS EC2
- Terraform
- Ansible
- Docker
- Docker Compose
- GitHub Actions
- Git
- GitHub

## What I Built

The project creates an AWS environment using Terraform.

The infrastructure includes:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 instance

After creating the EC2 instance, I used Ansible to connect to the server and install Docker and the required packages.

The application is then containerized using Docker and Docker Compose.

## CI/CD

I also added a GitHub Actions workflow for automatic deployment.

Whenever I push changes to the `main` branch:

1. GitHub Actions starts the workflow.
2. The repository is checked out.
3. SSH is configured using GitHub Secrets.
4. GitHub Actions connects to the EC2 server.
5. The latest code is pulled from GitHub.
6. Docker Compose builds the application.
7. The new container is started.

## Project Structure

```text
aws-infrastructure-automation/
│
├── .github/
│   └── workflows/
│       └── main.yml
│
├── ansible/
│   ├── inventory/
│   │   └── hosts
│   └── playbooks/
│       ├── install-docker.yml
│       └── deploy-app.yml
│
├── app/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── index.html
│
├── terraform/
│   ├── main.tf
│   └── provider.tf
│
├── scripts/
│
├── .gitignore
└── README.md

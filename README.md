# New Relic Repo

This repository contains a basic Flask application that serves a "Hello, World!" message, along with Terraform code to host this application on AWS using ECS Fargate.

## Table of Contents

- [Project Overview](#project-overview)
- [Terraform Resources](#terraform-resources)
- [Continuous Integration (CI)](#continuous-integration-ci)
- [Continuous Deployment (CD)](#continuous-deployment-cd)


## Project Overview

This project demonstrates the deployment of a simple Flask application using AWS services. The application is containerized using Docker and deployed on AWS ECS Fargate, utilizing Infrastructure as Code (IaC) principles with Terraform.

## Terraform resources


The `terraform` folder contains the code necessary to deploy a containerized application on AWS using ECS (Elastic Container Service). This configuration utilizes Infrastructure as Code (IaC) principles to manage AWS resources effectively.

### Resources Created

The Terraform configuration creates the following AWS resources:

1. **VPC**: A Virtual Private Cloud (VPC) to provide an isolated network for your resources.
2. **Subnets**: 
   - Two subnets are created to ensure high availability and fault tolerance. These subnets will host the ECS tasks.
3. **Internet Gateway**: An Internet Gateway is created to allow communication between the resources in the VPC and the internet.
4. **Route Table**: A route table is defined and associated with the subnets. This table manages the routing of traffic within the VPC and to the internet via the Internet Gateway.
5. **Security Group**: A security group is created for the ECS cluster, controlling inbound and outbound traffic to ensure secure access to the services.
6. **ECS Cluster**: An ECS cluster is set up to manage the deployment and scaling of your containerized applications.
7. **Task Definition**: A task definition is specified, detailing how the containers should run, including configurations like CPU and memory requirements.
8. **ECS Service**: An ECS service is created to manage the running instances of the task definition, ensuring the desired number of tasks are running.
9. **IAM Role**: A role is assigned to the task definition, providing the necessary permissions for the containers to interact with AWS services.

# Workflows
1. .github/workflows/CI.yaml 
2. .github/workflows/CD.yaml

## Continuous Integration (CI)

The CI pipeline is triggered automatically on every commit or push to the repository. 
It make use of a reusable CI workflow -> https://github.com/TanishGuleria/new-relic-reusable-flow which includes the following steps:

1. **Docker Image Creation**: Builds a Docker image for the Flask application.(With service code commit-id as image name)
2. **Container Scanning**: Scans the Docker image for vulnerabilities to ensure security.
3. **Container Testing**: Runs tests on the Docker container to verify that the application behaves as expected.
4. **Terraform Validation**: Validates the Terraform code to check for errors.
5. **Infrastructure as Code (IaC) Scans**: Performs security scans on the Terraform configuration.
6. **Push Image to Artifactory**: If all previous steps succeed, the Docker image is pushed to a common Artifactory.(Dummy step)

Upon successful completion of the CI pipeline, the CD workflow is automatically triggered. with inputs `environment = inf` This workflow deploys the application to the infrastructure defined in the Terraform code for the `inf` environment only.

## Continuous Deployment (CD)

The CD workflow is triggered based on the inputs provided and handles the deployment (Just Terraform Plan ) across different environments features:

It make use of a reusable CD workflow -> https://github.com/TanishGuleria/new-relic-reusable-flow  with the following features:

- **Environment Selection**: Allows deployment to different environments (inf, dev, qa, prod).
- **Branch Specification**: Specifies which branch to deploy the service Terraform code from.
- **Hotfix Targeting**: Supports deploying to a single target environment for hotfixes.
- **Approvals Controle For prod Deployment**: Supports deploying to a target environment for hotfixes.

## Secrets

The workflow also requires several secrets to manage AWS credentials securely along with github token, These secrets are stored in repository secrets with dummy values:

- **PAT_TOKEN**: Personal access token for repository access
- **inf_AWS_ACCESS_KEY_ID**: AWS access key for the integration environment 
- **inf_AWS_SECRET_ACCESS_KEY**: AWS secret key for the integration environment 
- **dev_AWS_ACCESS_KEY_ID**: AWS access key for the development environment 
- **dev_AWS_SECRET_ACCESS_KEY**: AWS secret key for the development environment 
- **qa_AWS_ACCESS_KEY_ID**: AWS access key for the quality assurance environment 
- **qa_AWS_SECRET_ACCESS_KEY**: AWS secret key for the quality assurance environment 
- **prod_AWS_ACCESS_KEY_ID**: AWS access key for the production environment 
- **prod_AWS_SECRET_ACCESS_KEY**: AWS secret key for the production environment 









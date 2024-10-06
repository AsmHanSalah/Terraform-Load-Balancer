Here’s a detailed and readable README file for a repository containing a load balancer project with Terraform based on the architecture you provided.

---

# Load Balancer Project with Terraform

## Overview

This project demonstrates how to set up a scalable and reliable load balancer architecture on AWS using Terraform. The architecture includes multiple availability zones, public and private subnets, and utilizes an Internet Gateway for external access.

### Architecture Diagram

![Architecture Diagram](load.jpg)

### Key Components

- **VPC (Virtual Private Cloud):** A dedicated virtual network to isolate resources.
- **Internet Gateway:** Allows communication between instances in the VPC and the internet.
- **Public Subnets:** Contains resources that need to be accessible from the internet, such as a load balancer.
- **Private Subnets:** Hosts backend services like application servers that should not be directly accessible from the internet.
- **Nginx Load Balancer:** Distributes incoming traffic to multiple backend servers for improved performance and reliability.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (version 1.x or higher)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions
- An AWS account

## Getting Started

Follow these instructions to set up the load balancer architecture using Terraform.

### 1. Clone the Repository

```bash
git https://github.com/AsmHanSalah/Terraform-Load-Balancer.git
cd Terraform-Load-Balancer
```

### 2. Configure AWS Credentials

Ensure your AWS credentials are configured. You can set them up using the AWS CLI:

```bash
aws configure
```

### 3. Review Terraform Configuration Files

The main Terraform configuration files include:

- **main.tf:** Contains the primary infrastructure resources.
- **variables.tf:** Defines input variables used in the project.
- **outputs.tf:** Specifies the output values from the Terraform run.
- **terraform.tfvars:** Optional file for setting variable values.

### 4. Initialize Terraform

Initialize your Terraform workspace to download necessary provider plugins:

```bash
terraform init
```

### 5. Plan the Deployment

Run the Terraform plan to review the resources that will be created:

```bash
terraform plan
```

### 6. Apply the Configuration

Deploy the infrastructure using the apply command:

```bash
terraform apply
```

Confirm the action by typing `yes` when prompted.

### 7. Access the Load Balancer

Once the deployment is complete, Terraform will output the URL of the load balancer. You can use this URL to access your application.

### 8. Clean Up Resources

To delete all resources created by this project, run:

```bash
terraform destroy
```

Confirm the action by typing `yes` when prompted.

## Customization

You can customize the following parameters in `variables.tf` and `terraform.tfvars`:

- **region:** Specify the AWS region for deployment.
- **instance_type:** Define the type of EC2 instance for backend servers.
- **vpc_cidr:** Set the CIDR block for the VPC.

## Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Terraform documentation for infrastructure as code.
- AWS documentation for best practices in VPC and load balancing.

---

Feel free to adjust the sections according to your specific project details or requirements!

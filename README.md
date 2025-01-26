# Spotify Terraform

I enjoy following the latest popular tracks for an artist which Spotify supports on its app but it is limited to the top 10 tracks which often isn't sufficient. Thus, I am building this project to automatically create a playlist containing the current top 50 tracks for a given artist (using Beethoven, refreshing every 24 hours as example). Thanks to @conradludgate for creating this Spotify provider on Terraform. Full documentation for this provider can be found [here](https://registry.terraform.io/providers/conradludgate/spotify/latest/docs).

I am using this project as an opportunity to further explore the world of Cloud Engineering and DevOps. Thus, the aims of this project are to:
- Deploy all components using IaC (Terraform) as opposed to using a visual console
- Package everything as a Docker image so it can be run anywhere. Saving Kubernetes for a future project with more containers
- Do as much as possible via CLI but use Docker Desktop for learning purposes
- Ansible for automation
- Use EFS
- VPCs and Subnets
- Use AWS Secrets Manager to store sensitive information (e.g. IDs and keys)


The plan is to create a Docker image that includes Terraform and any necessary dependencies. The Docker container can then be used to execute Terraform commands.

I will use SNS to notify me via email if the pipeline fails.

## Deployment Instructions

To build the container, run `docker-compose up -d` which invokes `docker-compose.yml`. Docker Compose has been used because there is a dependency on `spotify-auth-proxy` which must be authenticated first.

## Learnings

### Containers
- Use Alpine base image where possible to reduce container size. Though, may cause compatability issues
- Use ECR push commands to push Docker Container to ECR

### git

#### gitignore
Use a `.gitignore` file for anything you don't want in your repo. In this case, we are ignoring the .terraform directory as this contains the Docker container files.

#### set-upstream
`git push -u origin main` means push to the main branch on the remote repo (the one stored on git). `origin` is the default name for the remote repo.

`-u` or `--set-upstream` is used when a new branch has just been created locally because it doesn't yet exist on the remote repo. git versions newer than 2.3.7 shouldn't require this command.

`Error: An error occurred trying to start process '/usr/bin/bash' with working directory '/home/runner/work/spotify-terraform/spotify-terraform/src'. No such file or directory`

Fix: explicitly set the shell to bash

```
      - name: Terraform Init
        id: init
        shell: bash
        run: terraform init

      - name: Terraform Plan
        id: plan
        shell: bash
        run: terraform plan -no-color

      - name: Terraform Apply
        shell: bash
        run: terraform apply -auto-approve
```

#### Branch conflicts

1. `git pull origin main --no-rebase`: merge local changes with remote changes

2. `git pull origin main --rebase`: apply local changes on top of the remote branch

3. `git pull origin main --ff-only`: fast-forward (your branch must be up to date with the remote branch and you only want to pull if there are no conflicts)

### Networking
We need an Internet Gateway to connects a VPC to the internet.
NAT Gateway means we can give our container internet access without assigning it a public IP.
To use the Gateways, a Route Table is used.

VPC is defined in `vpc.tf`.

Following general basic practice, I am going to 2 public and 2 private subnets split across 2 Availability Zones to ensure uptime in eu-west-2 region (closest to user base location).

A CIDR block is a collection of IP addresses that share the same network prefix and number of bits. `0.0.0.0/0` means all IPs. `WW.XX.YY.ZZ/32` means one IP.

### Ansible

## Resources used
[Create a Spotify playlist with Terraform](https://developer.hashicorp.com/terraform/tutorials/community-providers/spotify-playlist)

[How to Run a Cron Job Inside a Docker Container](https://www.youtube.com/watch?v=hBZmAB5GxVg)

[Docker Compose](https://docs.docker.com/compose/) to run multiple containers with dependencies.

[Networking Fundamentals to Deploy Containers in AWS](https://www.youtube.com/watch?v=UQtNuzF1_Dc)

[How to Deploy an AWS ECS Cluster with Terraform [Tutorial]](https://spacelift.io/blog/terraform-ecs)

[DevOps Project - AWS, Terraform, Ansible (Dynamic inventory!), Jenkins, GitHub, & RabbitMQ](https://www.youtube.com/watch?v=SmgS-kyhadI)

[AWS Hands-On: Automate AWS Infra Deployment using Terraform and GitHub Actions](https://www.youtube.com/watch?v=scecLqTeP3k)

## Improvements / future learnings
- Implement Docker Layers to further reduce container size
- Play around with Ansible playbooks which have more options than GitHub Actions as open-source
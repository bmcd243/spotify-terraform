# Spotify Terraform

I enjoy following the latest popular tracks for an artist which Spotify supports on its app but it is limited to the top 10 tracks which often isn't sufficient. Thus, I am building this project to automatically create a playlist containing the current top 50 tracks for a given artist (using Beethoven, refreshing every 24 hours as example). Thanks to @conradludgate for creating this Spotify provider on Terraform. Full documentation for this provider can be found [here](https://registry.terraform.io/providers/conradludgate/spotify/latest/docs).

I am using this project as an opportunity to further explore the world of Cloud Engineering and DevOps. Thus, the aims of this project are to:
- Deploy all components using IaC (Terraform) as opposed to using a visual console
- Package everything as a Docker image so it can be run anywhere. Saving Kubernetes for a future project with more containers.
- Do as much as possible via CLI but use Docker Desktop for learning purposes.
- Ansible for automation (CI/CD)
- Use EFS
- VPCs and Subnets
- Use AWS Secrets Manager to store sensitive information (e.g. IDs and keys)


The plan is to create a Docker image that includes Terraform and any necessary dependencies. The Docker container can then be used to execute Terraform commands.

I will use SNS to notify me via email if the pipeline fails.

## Instructions

To build the container, run `docker-compose up -d` which invokes `docker-compose.yml`. Docker Compose has been used because there is a dependency on `spotify-auth-proxy` which must be authenticated first.

## Learnings

### gitignore
Use a `.gitignore` file for anything you don't want in your repo. In this case, we are ignoring the .terraform directory as this contains the Docker container files.

### Branch conflicts

1. `git pull origin main --no-rebase`: merge local changes with remote changes

2. `git pull origin main --rebase`: apply local changes on top of the remote branch

3. `git pull origin main --ff-only`: fast-forward (your branch must be up to date with the remote branch and you only want to pull if there are no conflicts)


## Resources used
[Create a Spotify playlist with Terraform](https://developer.hashicorp.com/terraform/tutorials/community-providers/spotify-playlist)

[How to Run a Cron Job Inside a Docker Container](https://www.youtube.com/watch?v=hBZmAB5GxVg)

[Docker Compose](https://docs.docker.com/compose/) to run multiple containers with dependencies.
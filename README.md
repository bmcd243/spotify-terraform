# Spotify Terraform

I enjoy following the latest popular tracks for an artist which Spotify supports on its app but it is limited to the top 10 tracks which often isn't sufficient. Thus, I am building this project to automatically create a playlist containing the current top 100 tracks for a given artist (using Beethoven as example). Thanks to @conradludgate for creating this Spotify provider on Terraform. Full documentation for this provider can be found [here](https://registry.terraform.io/providers/conradludgate/spotify/latest/docs).

I am using this project as an opportunity to further explore the world of Cloud Engineering and DevOps. Thus, the aims of this project are to:
- Deploy all components using IaC (Terraform) as opposed to using a visual console
- Package everything as a Docker image (Kubernetes?)
- Use 
- Do as much as possible via CLI instead of using AWS Management Console
- Ansible for automation (CI/CD)
- Use EFS
- VPCs and Subnets
- Use AWS Secrets Manager to store sensitive information (e.g. IDs and keys)


The plan is to create a Docker image that includes Terraform and any necessary dependencies. The Docker container can then be used to execute Terraform commands.

I will use SNS to notify me via email if the pipeline fails.
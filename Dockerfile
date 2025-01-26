# Specify the base image
FROM hashicorp/terraform:latest

# Install dependencies (-y runs in non-interactive mode so user doesn't need to select yes)
RUN apk add --no-cache curl bash openrc
RUN apk add --no-cache cronie

# Set working directory
WORKDIR /app

# Copy Terraform files to the image
COPY .env /app/.env

RUN export $(cat /app/.env | xargs)

# Run Terraform initialization
RUN terraform init

# Add a cron job to run Terraform every day at midnight
RUN echo "0 0 * * * cd /app && terraform apply -auto-approve >> /var/log/terraform_cron.log 2>&1" > /etc/cron.d/terraform_cron

# Give execution rights
RUN chmod 0644 /etc/cron.d/terraform_cron
RUN crontab /etc/cron.d/terraform_cron

# Start both cron and the Spotify auth proxy in parallel (there can only be 1 command for a container)
# Using ENTRYPOINT instead of CMD as the latter can be overwritten
# cron job is being run in the foreground (with -f). This means that if the cron job stops, so does the docker container. You can test this by running `service cron stop` which terminate both the cron job and the container
ENTRYPOINT spotify-auth-proxy --port 27228 & cron - f

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "executable" ]
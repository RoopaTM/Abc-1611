# Stage 1 Base Stage
FROM ubuntu:22.04 AS base

# Install cron and other necessary utilities
RUN apt-get update && \
    apt-get install -y cron sudo && \
    apt-get clean

# Create the 'abc' user and set up the directory with specific permissions
RUN useradd -m abc && \
    mkdir -p /home/abc/Test && \
    chown -R abc:abc /home/abc/Test

# Set the working directory to /home/abc
WORKDIR /home/abc


#--------------- Intermediate Stage -------------------------
# Intermediate Stage - This stage handles copying the shell script and setting up cron job
FROM base AS intermediate

# Switch to root user for copying files and setting permissions
USER root

# Copy the shell script into the container
COPY ./shell_script.sh /home/abc/

# Make the shell script executable
RUN chmod +x /home/abc/shell_script.sh

# Set up a cron job to run the script with input '1' (create) every minute
RUN (echo "* * * * * /home/abc/shell_script.sh 1 >> /home/abc/cron.log 2>&1") | crontab -u abc -


#--------------- Stage 3: Clean-up Stage ------------------------
# Stage 3: Clean-up Stage - Run the script with input '0' as abc user
FROM intermediate AS cleanup

# Set user to 'abc'
USER abc

# Manually trigger the shell script with input '0' (clean-up)
RUN echo "Running clean-up script" && /home/abc/shell_script.sh 0 >> /home/abc/cron.log 2>&1


#--------------- Stage 4: Create Stage --------------------------
# Stage 4: Create Stage - Run the script with input '1' as abc user
FROM intermediate AS create

# Set user to 'abc'
USER abc

# Manually trigger the shell script with input '1' (create)
RUN echo "Running create script" && /home/abc/shell_script.sh 1 >> /home/abc/cron.log 2>&1


#--------------- Final Stage ------------------------------
# Final Stage - Run cron in the foreground (so the cron job continues to run)
FROM create AS final

# Start cron in the foreground
CMD ["cron", "-f"]


#Base image
FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
#Install AWS cli for cloudwatch logging
RUN apt-get install awscli -y
RUN apt-get install python3-pip python-dev -y
# Configure AWS-Cli with clougwatch IAM role
RUN aws configure set aws_access_key_id ${LOGGER_AWS_ACCESS_KEY_ID} --profile mafia_cloud_watch_logger \ 
    && aws configure set --profile default \ 
    && aws_secret_access_key ${LOGGER_AWS_ACCESS_KEY_SECRET} --profile mafia_cloud_watch_logger \
    && aws configure set region "us-east-1" --profile mafia_cloud_watch_logger 


COPY ./mafia/ /home/ubuntu/app
WORKDIR /home/ubuntu/app/
RUN pip install -r requirements.txt
CMD python3 mafia.py 5

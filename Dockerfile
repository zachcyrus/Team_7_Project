#Base image
FROM ubuntu:latest
### Setting up envs and secrets
ARG DEBIAN_FRONTEND=noninteractive
ARG LOGGER_AWS_ACCESS_KEY_ID
ARG LOGGER_AWS_ACCESS_KEY_SECRET
ENV LOGGER_AWS_ACCESS_KEY_ID=${LOGGER_AWS_ACCESS_KEY_ID:-NOT_DEFINED}
ENV LOGGER_AWS_ACCESS_KEY_SECRET=${LOGGER_AWS_ACCESS_KEY_SECRET:-NOT_DEFINED}
ENV MONGO_DB_URI='foobar'
RUN apt-get update && apt-get upgrade -y
#Install AWS cli for cloudwatch logging
RUN apt-get install awscli -y
RUN apt-get install python3-pip python-dev -y
# Configure AWS-Cli with clougwatch IAM role
RUN aws configure set aws_access_key_id ${LOGGER_AWS_ACCESS_KEY_ID} --profile default \ 
    && aws configure set aws_secret_access_key ${LOGGER_AWS_ACCESS_KEY_SECRET} --profile default \
    && aws configure set region "us-east-1" --profile default 


COPY ./mafia/ /home/ubuntu/app
WORKDIR /home/ubuntu/app/
RUN pip install -r requirements.txt
CMD python3 mafia.py 5

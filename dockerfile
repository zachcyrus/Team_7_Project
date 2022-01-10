#Base image from dockerhub
FROM ubuntu:latest
#./mafia directory from repository into app directory in the environment
COPY ./mafia/ /home/ubuntu/app
RUN apt-get update && apt-get upgrade -y
Run apt-get install python3-pip python-dev -y
#changes workdir of environment to the app directory
WORKDIR /home/ubuntu/app/
#runs pip to install needed dependencies in requirements.txt
RUN pip install -r requirements.txt
CMD python3 mafia.py 5

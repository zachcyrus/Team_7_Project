#Base image from dockerhub
FROM ubuntu:latest
#./mafia directory from repository into app directory in the environment
COPY ./mafia/ /home/ubuntu/app
RUN apt-get update && apt-get upgrade -y
Run apt-get install python3-pip python-dev -y
RUN ~/xray-daemon$ curl https://s3.dualstack.us-east-1.amazonaws.com/aws-xray-assets.us-east-1/xray-daemon/aws-xray-daemon-linux-3.x.zip -o ./aws-xray-daemon-linux-3.x.zip
RUN ~/xray-daemon$ unzip -o aws-xray-daemon-linux-3.x.zip -d .
RUN COPY xray /usr/bin/xray-daemon
CMD xray-daemon -f /var/log/xray-daemon.log &

#changes workdir of environment to the app directory
WORKDIR /home/ubuntu/app/
#runs pip to install needed dependencies in requirements.txt
RUN pip install -r requirements.txt

CMD python3 mafia.py 5

#Base image from dockerhub
FROM ubuntu:latest
#./mafia directory from repository into app directory in the environment
COPY ./mafia/ /home/ubuntu/app
RUN apt-get update && apt-get upgrade -y
RUN apt-get install python3-pip python-dev -y
RUN apt-get update && apt-get install -y --force-yes --no-install-recommends apt-transport-https curl ca-certificates wget && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
RUN wget https://s3.us-east-2.amazonaws.com/aws-xray-assets.us-east-2/xray-daemon/aws-xray-daemon-3.x.deb
RUN dpkg -i aws-xray-daemon-3.x.deb
CMD ["/usr/bin/xray", "--bind=0.0.0.0:2000", "--bind-tcp=0.0.0.0:2000", "&"]
EXPOSE 2000/udp
EXPOSE 2000/tcp
#changes workdir of environment to the app directory
WORKDIR /home/ubuntu/app/
#runs pip to install needed dependencies in requirements.txt
RUN pip install -r requirements.txt

CMD python3 mafia.py 5

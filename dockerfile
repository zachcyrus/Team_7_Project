#Base image
FROM ubuntu:latest
COPY ./mafia/ /home/ubuntu/app
RUN apt-get update && apt-get upgrade -y
Run apt-get install python3-pip python-dev -y
WORKDIR /home/ubuntu/app/
RUN pip install -r requirements.txt
CMD python3 mafia.py 5

<!-- TABLE OF CONTENTS -->
<h1 align="center">Mafia Application</h1>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="https://i.pinimg.com/736x/97/53/2c/97532cc6bf6af4ef60ef08fb5ebc5abc.jpg" alt="Logo" width="300" height="300">
  </a>

  <h3 align="center">Mafia Application</h3>

</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-mafia">About Mafia</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Prerequisites and Installation Guide</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#local-installation">Local Installation</a></li>
        <li><a href="#docker-installation">Docker Installation</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## About Mafia

Mafia is a social deduction game, created by Dimitry Davidoff in 1986. The game models a conflict between two groups: an informed minority (the mafia team), and an uninformed majority (the Residents). At the start of the game, each player is secretly assigned a role affiliated with one of these teams. The game has two alternating phases:




## Built With 

* [Python](https://www.python.org/)

* [Python Flask](https://flask.palletsprojects.com/en/2.0.x/)






## Getting Started

### Prerequisites 


### Local installation:

1. Git clone this repository. 
    ```
    git clone https://github.com/zachcyrus/Team_7_Project.git
    ```


2. Change directory to the location of the repository.

    ```
    cd ./Team_7_Project
    ```

3. Change directory to mafia (this is where the application is located). 

    ```
    cd ./mafia
    ```

4. Create a virtual environment (the method for this will change if you're on Windows)

    ```
     # For Mac/Linux OS
    python3 -m venv venv
    ```

    ```
    # For Windows OS
    python -m venv venv
    ```
 
5. Activate the virtual environment 

    ```
    # For Mac/Linux OS
    source ./venv/bin/activate
    ```

    ```
    # For Windows OS
    .\venv\Scripts\activate
    ```

6. Install the python dependencies 

    ```
    pip install -r requirements.txt
    ```

7. Run the application 

    ```
    # For Mac/Linux OS
    python3 ./mafia.py 5
    ``` 

    ```
    # For Windows OS
    python ./mafia.py 5
    ```

### Docker Installation

0. Make sure you have Docker installed and running if not go [here](https://docs.docker.com/get-docker/). 

1. Change directory to root of repository

    ```
    cd Team_7_Project
    ```

2. Build the docker image based off the dockerfile in the root of the repository 

    ```
    docker build --build-arg LOGGER_AWS_ACCESS_KEY_ID={your_aws_access_key_kid} --build-arg LOGGER_AWS_ACCESS_KEY_SECRET={your_aws_access_key_secret} -t local_mafia_app:latest . 
    ```

3. Run a docker container based off the local_mafia_app image. 

    ```
    docker run --name  mafia_container -d -p 5000:5000 local_mafia_app:latest
    ```

4. Go to localhost:5000 in your browser to see the application running

5. When done kill the container 

    ```
    docker kill mafia_container
    ```

## Roadmap

- [x] Terraform Load balancer
- [x] Update README
- [ ] Terraform all infrastructure possible
- [ ] Add a database 
- [ ] Add multiple rooms feature


## Current Contributors


[![Linkedin Badge](https://img.shields.io/badge/-Brittney%20Jones-blue?style=flat-square&logo=Linkedin&logoColor=white&)](https://www.linkedin.com/in/brittney-r-jones/)[![Github Badge](https://img.shields.io/badge/Brittney%20Jones-grey?logo=github&logoColor=white)](https://github.com/bjones519)[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/cloudposse.svg?style=social&label=Follow%20Brittney)](https://twitter.com/belledenuit19)


[![Linkedin Badge](https://img.shields.io/badge/-Zachary%20Cyrus-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/zach-cyrus/)[![Github Badge](https://img.shields.io/badge/Zachary%20Cyrus-grey?logo=github&logoColor=white)](https://github.com/zachcyrus)[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/cloudposse.svg?style=social&label=Follow%20Zach)](https://twitter.com/thezachstack)

[![Linkedin Badge](https://img.shields.io/badge/-Sai%20Ho%20Yip-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/saihoyip/)[![Github Badge](https://img.shields.io/badge/Sai%20Ho%20Yip-grey?logo=github&logoColor=white)](https://github.com/SaiHoYip)[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/cloudposse.svg?style=social&label=Follow%20The%20Above)](https://twitter.com/belledenuit19)

![Linkedin Badge](https://img.shields.io/badge/-Mohamed%20Hassan-blue?style=flat-square&logo=Linkedin&logoColor=white)[![Github Badge](https://img.shields.io/badge/Mohamed%20Hassan-grey?logo=github&logoColor=white)](hhttps://github.com/Mohamed24444)[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/cloudposse.svg?style=social&label=Follow%20The%20Above^2)](https://twitter.com/thezachstack)



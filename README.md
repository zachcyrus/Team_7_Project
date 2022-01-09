### Local installation:

1. Git clone this repository. 
    ```
    git clone https://github.com/zachcyrus/Team_7_Project.git
    ```

2. Change directory to the location of the repository and mafia application.

    ```
    cd ./Team_7_Project/mafia
    ```

3. Create a virtual environment

    ```
     # For Mac/Linux OS
    python3 -m venv venv
    ```

    ```
    # For Windows OS
    python -m venv venv
    ```
    

4. Activate the virtual environment

    ```
    # For Mac/Linux OS
    source ./venv/bin/activate
    ```

    ```
    # For Windows OS
    .\venv\Scripts\activate
    ```

5. Install the python dependencies 

    ```
    pip install -r requirements.txt
    ```

6. Run the application 

    ```
    # For Mac/Linux OS
    python3 ./mafia.py 5
    ``` 

    ```
    # For Windows OS
    python ./mafia.py 5
    ```

### Run with Docker instead 

0. Make sure you have Docker installed and running if not go [here](https://docs.docker.com/get-docker/). 

1. Change directory to root of repository

    ```
    cd Team_7_Project
    ```

2. Build the docker image based off the dockerfile in the root of the repository 

    ```
    docker build -t local_mafia_app . 
    ```

3. Run a docker container based off the local_mafia_app image. 

    ```
    docker run --name  mafia_container -d -p 5000:5000 local_mafia_app
    ```

4. Go to localhost:5000 in your browser to see the application running

5. When done kill the container 

    ```
    docker kill mafia_container
    ```

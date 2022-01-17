from flask import (Blueprint, request, render_template)
import bcrypt
# The game v2 route has to do a lot: 
# Login and logout users 
# Route users to a game based off id in the database 
# Database which keeps track of rooms 
#from mafia.database import mongo

game_v2 = Blueprint('game_v2_route', __name__, template_folder='templates', url_prefix='/game_v2')

@game_v2.route('/login', methods= ["POST", "GET"] )
def login_route():
    if request.method == "POST":
        user_name = request.form.get('username')
        password = request.form.get("password")
        
        ## search for user within mongodb database 
        
    if request.method == "GET":
        return render_template('login.html')
    
    
@game_v2.route('/signup', methods= ["POST", "GET"] )
def signup_route():
    if request.method == "POST":
        user_name = request.form.get('username')
        password = request.form.get('password')
        
        ## check if user is found or not
        
        found_username = mongo.db.users.find_one({"name":user_name})
        
        if found_username:
            error_message = "A username like that already exits, please choose another"
            ## Return template with that popup error in bootstrap
        
        ## Username is not found and a password was entered
        else:
            hashed_password = bcrypt.hashpw(password.encode('utf-8', bcrypt.gensalt()))
            new_user_entry = {
                "user_name": user_name,
                "password": hashed_password
            }
            
            ## save user_name and password into the database
            
            mongo.db.users.insert_one(new_user_entry)
            
            print(user_name + "signed up")
            
            return({
                "success": "User signed up"
            })
            
    elif request.method == "GET":
        return render_template('signup.html')
            
        
        
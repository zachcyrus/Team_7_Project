from sys import argv
from os import environ
from random import randrange, shuffle
from flask import Flask, render_template, url_for, request, redirect
from flask_httpauth import HTTPBasicAuth
from mafia_params import *
from database import mongo
from dotenv import load_dotenv

def create_app():
    app = Flask(__name__)
    app.config["MONGO_URI"] = environ.get('MONGO_DB_URI')
    mongo.init_app(app)
    auth = HTTPBasicAuth()
    auth_GOD = HTTPBasicAuth()
    preshared_key = ""
    id = 0
    nPlayers = 0
    roles = []
    ip2role_index_name = {}
    nComments = 0
    comments_ordered = []
    
    from routes.game_v2 import game_v2
    #app.register_blueprint(game_v2, url_prefix='/game_v2')

    @auth.verify_password
    def verify_password(username, password):
        if len(username) > 0:
            return username
        return None

    ## Index page with instructions

    @app.route('/')
    def instructions_page():
        return render_template('instructions.html')


    ## Login Page 
    @app.route('/login', methods=["GET","POST"])
    def login_route():
        if request.method == "POST":
            if request.form['name'] and request.form['password'] != '':
                return redirect(url_for('game_route'))

        else:
            return render_template('login.html')



    ## Route for the actual game 

    @app.route('/game')
    @auth.login_required
    def game_route():
        global id, ip2role_index_name
        username = str(auth.current_user())
        role = ""
        image_name = ""
        ip = str(request.remote_addr)

        if ip in ip2role_index_name.keys():
            return render_template("Player.html", player=ip2role_index_name[ip])
        else:
            if id > nPlayers:
                return render_template("404.html", is_farsi=True)
            role = roles[id]
            ip2role_index_name[ip] = [role,
                                    str(randrange(1, nRoles[role] + 1)),
                                    username,
                                    "alive",
                                    False]
            image_name = role + "_" + str(ip2role_index_name[ip][1])
            print("*" * 20, "New Player","*" * 20)
            toGod = ip + " : " + str(id) + " : " + username +  " --> " + role
            toGod += "/" + role2fa[role]    #TODO: Just in Farsi Mode
            print(toGod)
            id += 1
        return render_template("index.html",
                                image_name=image_name,
                                role_name=role, role_name_fa=role2fa[role],
                                description=descriptions[role], description_fa=descriptions_fa[role],
                                is_farsi=True)


    @auth_GOD.verify_password
    def verify_password_god(username, password):
        if password == preshared_key:
            return username


    @app.route('/GOD')
    @auth_GOD.login_required
    def GOD_PAGE():
        global ip2role_index_name, nComments, comments_ordered
        msg = ""
        if request.args.get("Kill") is not None:
            ip = request.args.get("Kill")
            if ip in ip2role_index_name.keys():
                if ip2role_index_name[ip][3] == "alive":
                    ip2role_index_name[ip][3] = "dead"
                else:
                    ip2role_index_name[ip][3] = "alive"
            else:
                return render_template("404.html", is_farsi=True)
        if request.args.get("Ban") is not None:
            ip = request.args.get("Ban")
            if ip in ip2role_index_name.keys():
                if ip2role_index_name[ip][3] == "alive":
                    ip2role_index_name[ip][3] = "banned"
                elif ip2role_index_name[ip][3] == "banned":
                    ip2role_index_name[ip][3] = "alive"
            else:
                return render_template("404.html", is_farsi=True)
        if request.args.get("Comment") is not None:
            ip = request.args.get("Comment")
            if ip in ip2role_index_name.keys():
                if ip2role_index_name[ip][4] == False:
                    if nComments <= nPlayers // 3:
                        ip2role_index_name[ip][4] = True
                        nComments += 1
                        comments_ordered.append(ip)
                    else:
                        msg = "Error: Out of Comments."
                else:
                    ip2role_index_name[ip][4] = False
                    nComments -= 1
                    comments_ordered.remove(ip)
            else:
                return render_template("404.html", is_farsi=True)
        return render_template("GOD.html", ip2role_index_name=ip2role_index_name,
                            prompt_message=msg, roles={role:roles.count(role) for role in set(roles)},
                            comments=comments_ordered, role2team=role2team)

    
    @app.errorhandler(404) 
    def invalid_route(e):
        return render_template("404.html", is_farsi=True)


    def help_me():
        usage = "-" * 70 + "\n"
        usage += "mafia - Web Server Application For Mafia Game Playing On Local Network \n\n"
        usage += "-" * 70 + "\n"
        usage += "Usage: python3 mafia number_of_players[int]\n"
        usage += "ex: python3 mafia 5\n"
        usage += "this will tell mafia.py that you want a game for 5 people.\n\n"
        usage += "If you've seen a bug here (or any idea that can help us) feel free to open an issue\n"
        usage += "here at : https://github.com/sadrasabouri/mafia/issues"
        print(usage)
        exit()


    def give_me_roles(ordered_roles):
        n = len(ordered_roles)
        if n >= 14:
            ordered_roles[12] = 'Groom'
            ordered_roles[13] = 'Bride'
            if n % 3 == 0:
                ordered_roles[14] = 'Serial Killer'
        if n % 3 != 0:
            try:
                i = ordered_roles.index('Mafia')
                ordered_roles[i] = 'Made Man'
                ordered_roles[2] = 'Reporter'
            except ValueError:
                pass
        if n % 3 == 2:
            try:
                i = ordered_roles.index('Mafia')
                ordered_roles[i] = 'Kind Wife'
            except ValueError:
                pass
        return ordered_roles
    
    
    return app
    

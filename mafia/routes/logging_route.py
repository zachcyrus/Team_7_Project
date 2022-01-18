import watchtower, flask, logging

from flask import (Blueprint, request, render_template, current_app)

from werkzeug.local import LocalProxy

logger = LocalProxy(lambda: current_app.logger)

logging_route = Blueprint('logging_route', __name__, template_folder='templates', url_prefix='/logging_route')

@logging_route.route('/', methods=  ["GET"] )
def test_route():
    if request.method == "GET":
        print('Here is your helpful log')
        logger.info('A user has entered the super secret logging route')
        return render_template('test.html')
    

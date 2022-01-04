### This test will check to make sure all routes return a 200 status code. 

import pytest

from mafia import app

def test_home_page(app, client):
    res = client.get('/')
    assert res.status_code == 200

# This is the configuration file for pytests

import pytest

import mafia as mafia_app


@pytest.fixture
def app():
    yield mafia_app.app.test_client()


@pytest.fixture
def client(app):
    return app
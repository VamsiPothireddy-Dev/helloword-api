import os

from flask import Flask

from app.config import Config


def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)

    if test_config is None:
        app.config.from_object(Config)
        app.config.from_pyfile("config.py", silent=True)
    else:
        app.config.update(test_config)

    from app import views

    app.register_blueprint(views.bp)

    return app

import os

from flask import Blueprint, jsonify, request

bp = Blueprint("api", __name__)


@bp.get("/health")
def health():
    return jsonify({"status": "ok"})


@bp.get("/version")
def version():
    return jsonify({"version": os.environ.get("IMAGE_TAG", "unknown")})


@bp.get("/hello")
def hello():
    name = request.args.get("name", "world")
    return jsonify({"message": f"hello, {name}!"})

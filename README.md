# helloword-api

Minimal Python Flask REST API bootstrap. Exposes `/health`, `/version`, and a sample `/hello` endpoint. No database.

## Prerequisites

- Python 3.12+
- Docker (for deployment)

## Run locally

```bash
cd helloword-api
python -m venv env1
source env1/bin/activate
pip install -r requirements.txt
flask --app app run --port 8000
```

Or with gunicorn:

```bash
gunicorn -w 2 -b 0.0.0.0:8000 wsgi:app
```

## Test

```bash
pytest
```

## Endpoints

| Endpoint | Description |
|---|---|
| `GET /health` | Liveness probe — returns `{"status":"ok"}` |
| `GET /version` | Returns `{"version": "<IMAGE_TAG>"}` |
| `GET /hello?name=X` | Returns `{"message": "hello, X!"}` |

Verify locally:

```bash
curl http://localhost:8000/health
```

## Deployed URL

Through Istio at `https://api.vamsipothireddy.com/helloword-api`:

- Health: `https://api.vamsipothireddy.com/helloword-api/health`
- Version: `https://api.vamsipothireddy.com/helloword-api/version`

The image tag equals the git commit SHA; `IMAGE_TAG` is injected by the Helm chart.

## CI

`.github/workflows/ci.yml` calls the shared reusable pipeline in `VamsiPothireddy-Dev/github-actions`. The repo must have secrets configured (`DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`, `K8S_REPO_TOKEN`, etc.) for the pipeline to build, push the image, and deploy to the `default` namespace.

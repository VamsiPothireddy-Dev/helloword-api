# syntax=docker/dockerfile:1

FROM python:3.12-slim AS builder

ENV PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# Runtime dependencies only (pytest is a dev dependency, excluded from the image).
# Versions match requirements.txt.
RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install "Flask==3.1.3" "gunicorn==23.0.0"


FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"

# Non-root user.
RUN groupadd --system app && useradd --system --gid app --home /app app \
    && mkdir -p /app \
    && chown app:app /app

WORKDIR /app

# Copy only the installed dependencies and application code.
COPY --from=builder /opt/venv /opt/venv
COPY --chown=app:app app ./app
COPY --chown=app:app wsgi.py ./

USER app

EXPOSE 8000

ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", "wsgi:app"]

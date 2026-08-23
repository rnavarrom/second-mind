FROM python:3.12-slim

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Copy the application into the container.
COPY packages/frontend packages/frontend
COPY pyproject.toml uv.lock ./
COPY packages/backend/ packages/backend/

# Install the application dependencies.

RUN uv sync --frozen --no-cache

# Run the application.
 CMD ["/app/.venv/bin/fastapi", "run", "packages/backend/src/backend/main.py", "--port", "80", "--host", "0.0.0.0"]
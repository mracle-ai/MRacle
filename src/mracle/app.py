import logging

from fastapi import (
    FastAPI,
)
from fastapi.middleware.cors import CORSMiddleware

logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger("app")


def create_app() -> FastAPI:
    app = FastAPI()

    # Add cors
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_headers=["Authorization", "Content-Type"],
        expose_headers=["Authorization"],
        allow_methods=["GET", "POST"],
        allow_credentials=True,
        max_age=60 * 60 * 24 * 20,
    )

    return app

import logging

from pydantic_settings import BaseSettings, SettingsConfigDict

logger = logging.getLogger(__name__)


class EnvironmentSettings(BaseSettings):
    """Environment settings from .env file and environment variables.

    Note:
    Even when using a dotenv file, pydantic will still read environment variables as well as
    the dotenv file, environment variables will always take priority over values loaded from a dotenv file

    More info can be found: https://docs.pydantic.dev/latest/concepts/pydantic_settings
    """

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        env_prefix="",
        validate_default=True,
        case_sensitive=False,
        env_ignore_empty=False,
        protected_namespaces=("settings_",),
        extra="ignore",
    )

    # fmt: off
    temp: int
    # fmt: on


env_settings = EnvironmentSettings()

if __name__ == "__main__":
    logger.info(env_settings.model_name)

# If .env file exists, include it and export its variables
ifeq ($(shell test -f .env && echo 1),1)
    include .env
    export
endif

local-run:
	uvicorn src.mracle.app:create_app --host 0.0.0.0 --port ${DEV_DEPLOYMENT_PORT} --reload --factory --log-config ${DATA_DIR}/${LOG_CONFIG_PATH}

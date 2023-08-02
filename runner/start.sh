#!/bin/sh

set -x

random_string() {
	LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c32
}

update_env_file () {
    varname="$1"
    varvalue="$2"
    if ! grep -q "$varname" ./.env; then
        echo "$varname=$varvalue" >> ./.env
    else
        sed -i "/$varname/c $varname=$varvalue" ./.env
    fi
}

cloudron pull /app/data/.env .env

. ./.env

update_env_file DRONE_RPC_HOST "$DRONE_SERVER_HOST"
update_env_file DRONE_RUNNER_CAPACITY "$(nproc)"
update_env_file DRONE_RUNNER_NAME "$(hostname)"

docker compose up -d
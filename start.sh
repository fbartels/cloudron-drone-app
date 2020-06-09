#!/bin/sh

set -x

random_string() {
	LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c32
}

if [ ! -e /app/data/.env ]; then
        cat <<-EOF > "/app/data/.env"
# Custom configuration for drone-server
DRONE_GITEA_SERVER=git.9wd.eu
DRONE_GITEA_CLIENT_ID=xxx
DRONE_GITEA_CLIENT_SECRET=xxx
DRONE_RPC_SECRET=$(random_string)
DRONE_DATABASE_SECRET=$(random_string)
DRONE_SERVER_HOST=$CLOUDRON_APP_DOMAIN
DRONE_DATABASE_DATASOURCE=postgres://$CLOUDRON_POSTGRESQL_USERNAME:$CLOUDRON_POSTGRESQL_PASSWORD@$CLOUDRON_POSTGRESQL_HOST:$CLOUDRON_POSTGRESQL_PORT/$CLOUDRON_POSTGRESQL_DATABASE?sslmode=disable
#DRONE_USER_CREATE=username:felix,admin:true
EOF
fi

# export all values from ".env"
set -a
. /app/data/.env
set +x

if [ ! -e /app/data/README.md ]; then
        cat <<-'EOF' > "/app/data/README.md"
# Hey there!

Configuration for drone is stored in the file called `.env`. After you have made changes to it you can restart just drone-server by running `supervisorctl restart drone-server`.

To work with drone you need to configure a provider in your `.env` file. See https://docs.drone.io/server/overview/ for instructions.
EOF
fi

echo "=> Ensure permissions"
chown -R cloudron:cloudron /run /app/data

exec /usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf --nodaemon -i drone-server

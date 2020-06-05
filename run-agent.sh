#/bin/sh

set -x

random_string() {
	LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c32
}

if [ ! -e .env ]; then
        cat <<-EOF > ".env"
DRONE_RPC_SERVER=https://drone.9wd.eu
DRONE_RPC_SECRET=QdExkSpgVY5RiC783UcqFgt8mvEs0Mid
DRONE_RUNNER_CAPACITY="$(nproc)"
DRONE_RUNNER_NAME="$(hostname)"
EOF
fi
docker-compose up -d
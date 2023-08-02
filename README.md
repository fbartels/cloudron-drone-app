# Drone CI for Cloudron

Run the Drone server on Cloudron and the agents locally.

I use this setup together with a Gitea running on the same Cloudron installation.

## Requirements

- `docker compose` (on the system you want to run the agent on)
- `git`
- `jq`
- `make`
- Cloudron CLI

## Installation

- Run `DOCKER_REPO=your-docker-hub-user make install` to install the Drone server component at `drone.yourdomain.com` (`yourdomain.com` will adapt automatically to your Cloudron setup).
- Run `make exec' to open the app's CLI and modify the `.env' so that it can connect to your Git instance.
  - See https://readme.drone.io/server/provider/gitea/#create-an-oauth-application for information on OAuth registration in Gitea.
  - The drone instance runs at `drone.yourdomain.com` and the redirect URL would be `https://drone.yourdomain.com/login`.
  - The secrets are automatically created and added to the `.env` file.
- Run `cloudron restart` to restart the application and apply your changes.
- Check that your setup works by going to `https://drone.yourdomain.com`.
- If all looks good, run `runner/start.sh' to start the Drone agent on your local machine (it will grab the credentials directly from the installed app).
- Add the drone configuration to your desired repositories

## Tips and tricks

I would also like to share some very useful commands. To install the `drone` CLI, follow the [official docs](https://docs.drone.io/cli/install/).

### Using drone-cli

Go to your [user settings](https://drone.9wd.eu/account) and get the login information

```bash
export DRONE_SERVER=https://drone.9wd.eu
export DRONE_TOKEN=your token
drone info
```

### Running pipelines directly

You can also run pipelines directly from the Drone CLI:

```bash
drone exec --secret-file secrets.txt .drone.yml
```

A template for `secrets.txt`:

```bash
slack_url=https://hooks.slack.com/services/xxxxxxxxxxxx
```

### Adding secrets from the CLI

You can either add secrets via the web interface or use drone directly from your terminal:

```bash
drone secret add -repository username/repository-name --name foo --data bar --allow-pull-request
```

### Trigger build via curl

```bash
curl -X POST -i https://drone.9wd.eu/api/repos/felix/cloudron-drone-app/builds -H "Authorization: Bearer your-token"
```

Get token from https://drone.9wd.eu/account

### Webhooks do not trigger builds in drone?

- Remove the webhook in Gitea
- Go to the Drone dashboard and disable the individual project in the settings.
- re-enable the project
- Go back to Gitea and "test delivery" your new webhook.

## Inspiration

- Setting up a simple, self-hosted & fast CI/CD solution with Drone.io](https://webhookrelay.com/blog/2019/02/11/using-drone-for-simple-selfhosted-ci-cd/)
- Official Drone documentation](https://docs.drone.io/server/provider/gitea/)
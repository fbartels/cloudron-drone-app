# Drone CI for Cloudron

Run the Drone server on Cloudron and the agents locally.

I am using this setup together with a Gitea running on the same Cloudron installation.

## What is Sponsorware?

This project is published as Sponsorware. Which means it is (at first) only available for those that sponsor my work (for example [on Github](https://github.com/sponsors/fbartels)) and therefore allow me to spent time on it. I have collected some thoughs on [Sponsorware on my blog](https://blog.9wd.eu/posts/sponsorware/).

## Requirements

- `docker-compose` (on the system where you want to run the agent)
- `git`
- `jq`
- `make`
- Cloudron CLI

## Installation

- Run `DOCKER_REPO=your-docker-hub-user make install` to install the Drone server component at `drone.yourdomain.com` (`yourdomain.com` automatically adapts to your Cloudron setup)
- Run `make exec` to open the cli of the app and modify `.env` so that it can connect to your Git instance
- Run `cloudron restart` to restart the app and apply your changes
- Verify that your setup works by going to `https://drone.yourdomain.com`
- If all looks good run `runner/start.sh` to start the Drone agent on your local machine (will fetch credentials from the installed app directly)
- Add the Drone configuration to your desired repositories

## Tips and Tricks

I would also like to share some very useful commands. To install `drone` CLI, follow [official docs](https://docs.drone.io/cli/install/).

### Using drone-cli

Go to your [user settings](https://drone.9wd.eu/account) and get login information

```bash
export DRONE_SERVER=https://drone.9wd.eu
export DRONE_TOKEN=your token
drone info
```

### Executing pipelines directly

You can also run pipelines directly with the Drone CLI:

```bash
drone exec --secret-file secrets.txt .drone.yml
```

A template for `secrets.txt`:

```bash
slack_url=https://hooks.slack.com/services/xxxxxxxxxxxx
```

### Adding secrets through CLI

You can either add secrets through the web UI or use drone directly from your terminal:

```bash
drone secret add -repository username/repository-name --name foo --data bar --allow-pull-request
```

### Trigger build via curl

```bash
curl -X POST -i https://drone.9wd.eu/api/repos/felix/cloudron-drone-app/builds -H "Authorization: Bearer your-token"
```

Get token from https://drone.9wd.eu/account

## Inspiration

- [Setting up simple, self-hosted & fast CI/CD solution with Drone.io](https://webhookrelay.com/blog/2019/02/11/using-drone-for-simple-selfhosted-ci-cd/)
- [official Drone documentation](https://docs.drone.io/server/provider/gitea/)

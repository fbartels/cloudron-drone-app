# Drone CI for Cloudron

Run the Drone server on Cloudron and the agents locally.

I am using this setup together with a Gitea running on the same Cloudron installation.

## Requirements

- `docker-compose`
- `git`
- `make`
- Cloudron CLI

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
drone exec --secret-file drone_secrets.yaml .drone.yml
```

A template for `drone-secrets.yaml`:

```yaml
slack_url: https://hooks.slack.com/services/xxxxxxxxxxxx
```

### Adding secrets through CLI

You can either add secrets through the web UI or use drone directly from your terminal:

```bash
drone secret add -repository username/repository-name --name foo --data bar --allow-pull-request
```

## Inspiration

- [Setting up simple, self-hosted & fast CI/CD solution with Drone.io](https://webhookrelay.com/blog/2019/02/11/using-drone-for-simple-selfhosted-ci-cd/)

## TODO

- [*] remove commited secrets
- [*] retrieve rpc secret from cloudron

# Docker `HEALTHCHECK` instruction

Testing the `HEALTHCHECK` instruction. This instruction can be used to check if a service is working and responding properly, even when at a docker level (i.e. `docker ps`) it seems to be OK.

More info at [Docker HEALTHCHECK](https://docs.docker.com/engine/reference/builder/#healthcheck)

## Build the image

```bash
$ docker build -t healthcheck-test:0.1 .
```

## Run a container

```bash
$ docker run --name hc --rm -d healthcheck-test:0.1
```

## Check the containers

```bash
$ docker ps
CONTAINER ID        IMAGE                  COMMAND               CREATED             STATUS                    PORTS               NAMES
132b81a2336c        healthcheck-test:0.1   "/bin/ping 8.8.8.8"   13 seconds ago      Up 12 seconds (healthy)                       hc
```

Note the `healthy` in the STATUS column.

## Make the container becomes ill.

Execute the following command

```bash
$ docker exec hc getSick
```

Wait 15 seconds and check the healthy status again.

```bash
$ docker ps
CONTAINER ID        IMAGE                  COMMAND               CREATED             STATUS                      PORTS               NAMES
132b81a2336c        healthcheck-test:0.1   "/bin/ping 8.8.8.8"   36 seconds ago      Up 36 seconds (unhealthy)                       hc
```

Now note the `unhealthy` in the STATUS column.

## Check the container health status

```bash
$ docker inspect hc -f {{.State.Health.Status}}
unhealthy
```

```bash
$ docker inspect hc
(...)
"State": {
    "Status": "running",
    "Running": true,
    (...)
    "StartedAt": "2019-06-18T20:01:55.74739526Z",
    "FinishedAt": "0001-01-01T00:00:00Z",
    "Health": {
        "Status": "unhealthy",
        "FailingStreak": 5,
        "Log": [
            {
                "Start": "2019-06-18T17:02:25.991621976-03:00",
                "End": "2019-06-18T17:02:26.028726911-03:00",
                "ExitCode": 1,
                "Output": "Service down\n"
            },
            {
                "Start": "2019-06-18T17:02:31.028913613-03:00",
                "End": "2019-06-18T17:02:31.063998029-03:00",
                "ExitCode": 1,
                "Output": "Service down\n"
            },
(...)
```

## Become healthy again

Execute the following command

```bash
$ docker exec hc heal
```

## Summary

```bash
docker run --name hc --rm -d healthcheck-test:0.1
docker inspect hc -f {{.State.Health.Status}}
docker exec hc getSick
# wait 15 seconds
docker inspect hc -f {{.State.Health.Status}}
docker exec hc heal
# wait 5 seconds
docker inspect hc -f {{.State.Health.Status}}
```

# ACS - AI Code Scaffolding

Ever wanted to run AI coding agents in parallel on the same project? Isolate them to run in docker so you can control what they have access to? Now you can!

# Screengrab

<img width="2316" height="1250" alt="image" src="https://github.com/user-attachments/assets/bbb949f7-3156-48d1-8b9b-ca9474db058b" />


## Quickstart

```
git clone https://github.com/nibalizer/acs
cd acs/images/claude
docker build -t clauderunner .
cd -
export PATH=${PATH}:/`pwd`/acs/bin
cd <myproject>
acs start --agent claude .
```

## amp

To use amp

```bash
acs start --agent amp .
```


## claude

To use claude code

```bash
acs start --agent claude .
```

## Connecting services

ACS can connect to an existing docker network to allow it to connect to services e.g. postgres or your app.

```
cd examples/postgres
docker compose -f postgres_service.yaml up -d
docker network ls
acs start --agent amp --network postgres_default .

# in amp
$ ./testdb.sh

```

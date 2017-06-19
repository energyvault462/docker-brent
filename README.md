# Personalized Docker Development Environment

A personalized development environment to include everything needed for Brent's daily development cycle.

# Usage
Isolated environment for testing

```
docker run -it --rm energyvault462/dockerbrent
```
Work in the current host system directory

```
docker run -i -t -v $PWD:/docker energyvault462/dockerbrent
```

Use common configs and keys

```
docker run -it \
-v $HOME/.gitconfig:/home/brent/.gitconfig \
-v $HOME/.ssh:/home/brent/.ssh \
-v /nas:/nas \
-v $PWD:/docker energyvault462/dockerbrent
```

# Purpose

* forceably find and document elements missing from the environment
* encourages proper saving of important work
* garbage is cleaned up through destruction of container

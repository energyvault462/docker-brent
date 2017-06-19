#!/bin/bash

docker run -it -v /home/brent/.gitconfig:/home/brent/.gitconfig \
-v /home/brent/.ssh:/home/brent/.ssh  \
-v /ram:/ram \
-v /log:/log \
-v /nas:/nas energyvault462/brent
#-v $PWD:/docker \




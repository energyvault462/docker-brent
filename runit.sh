#!/bin/bash

docker run -it -v /home/brent/.gitconfig:/home/brent/.gitconfig \
-v /home/brent/.ssh:/home/brent/.ssh  \
-v /ram:/ram \
-v /log:/log \
-v /home/brent/projects:/home/brent/projects \
-v /nas:/nas energyvault462/brent 
#-v $PWD:/docker \




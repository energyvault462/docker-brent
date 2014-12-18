FROM dan9186/devopsbase

MAINTAINER Daniel Hess <dan9186@gmail.com>

# Install custom deps
RUN yum -y update && \
    yum -y upgrade && \
    yum -y install zsh

WORKDIR /root

# Install custom vim settings
RUN git clone --recursive https://github.com/dan9186/Vimderp.git .vim && \
    cd .vim && \
    ./install.sh

# Provide persistent project directory
VOLUME ["/docker"]

ENTRYPOINT ["/bin/zsh"]

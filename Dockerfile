FROM dan9186/devopsbase

MAINTAINER Daniel Hess <dan9186@gmail.com>

# Install custom vim settings
WORKDIR /root
RUN git clone --recursive https://github.com/dan9186/Vimderp.git .vim && \
    cd .vim && \
    ./install.sh

# Provide persistent project directory
VOLUME ["/docker"]

ENTRYPOINT ["/bin/zsh"]

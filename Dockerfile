FROM dan9186/devopsbase

MAINTAINER Daniel Hess <dan9186@gmail.com>

# Install custom deps
RUN yum -y update && \
    yum -y upgrade && \
    yum -y install sudo zsh

# Install customizations into homedir
WORKDIR /root
ENV PATH $HOME:$PATH

# Install custom shell
RUN git clone https://github.com/myzsh/myzsh $HOME/.myzsh && \
    cp $HOME/.myzsh/samples/zshrc.default $HOME/.zshrc

# Install custom vim settings
RUN git clone --recursive https://github.com/dan9186/Vimderp.git .vim && \
    cd .vim && \
    ./install.sh

# Provide persistent project directory
VOLUME ["/docker"]

ENTRYPOINT ["/bin/zsh"]

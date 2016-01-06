FROM dan9186/devopsbase

MAINTAINER Daniel Hess <dan9186@gmail.com>

# Install custom deps
RUN yum -y update && \
    yum -y upgrade && \
    yum -y install sudo zsh

# Create custom user
RUN useradd -ms /bin/zsh dan9186
RUN echo "dan9186 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER dan9186

# Install customizations into homedir
ENV PATH $HOME:$PATH

# Install custom shell
RUN git clone https://github.com/myzsh/myzsh $HOME/.myzsh && \
    cp $HOME/.myzsh/samples/zshrc.default $HOME/.zshrc

# Install custom vim settings
RUN git clone --recursive https://github.com/dan9186/Vimderp.git $HOME/.vim && \
    cd $HOME/.vim && \
    ./install.sh && \
    ./bundle/YouCompleteMe/install.py

# Provide persistent project directory
VOLUME ["/docker"]

ENTRYPOINT ["/bin/zsh"]

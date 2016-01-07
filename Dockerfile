FROM dan9186/devopsbase

MAINTAINER Daniel Hess <dan9186@gmail.com>

# Install custom deps
RUN yum -y update && \
    yum -y upgrade && \
    yum -y install sudo zsh

# Create custom user
RUN useradd -ms /bin/zsh dan9186
RUN echo "dan9186 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set gopath ownership
RUN chown -R dan9186 $GOPATH

ADD zshrc /home/dan9186/.zshrc
RUN chown dan9186 /home/dan9186/.zshrc

# Install customizations into homedir
USER dan9186
ENV PATH $HOME:$PATH
RUN ln -s /gopath $HOME/go

# Install custom shell
RUN git clone https://github.com/myzsh/myzsh $HOME/.myzsh && \
    git clone http://github.com/myzsh/myzsh-golang $HOME/.myzsh/remotes/golang

# Install custom vim settings
RUN git clone --recursive https://github.com/dan9186/Vimderp.git $HOME/.vim && \
    cd $HOME/.vim && \
    ./install.sh && \
    ./bundle/YouCompleteMe/install.py

# Provide persistent project directory
VOLUME ["/docker"]

ENTRYPOINT ["/bin/zsh"]

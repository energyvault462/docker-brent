FROM dan9186/devopsbase

MAINTAINER Daniel Hess <dan9186@gmail.com>

ARG BUILD_DATE
ARG BUILD_NUMBER
ARG VERSION

LABEL org.metadata.build-date=$BUILD_DATE \
	   org.metadata.version=$VERSION.$BUILD_NUMBER \
	   org.metadata.name="Dan9186 Personal Development Environment" \
	   org.metadata.description="A personalized development environment for Dan9186" \
	   org.metadata.url="https://github.com/dan9186/docker-dan9186" \
	   org.metadata.vcs-url="https://github.com/dan9186/docker-dan9186"

# Install custom deps
RUN yum -y update && \
    yum -y upgrade && \
    yum -y install sudo zsh

# Create custom user
RUN useradd -ms /bin/zsh dan9186 && \
	 echo "dan9186 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Custom user installed and handled items
USER dan9186
ENV USER dan9186
ENV PATH $HOME:$PATH

# Install custom shell
RUN git clone https://github.com/myzsh/myzsh $HOME/.myzsh && \
    git clone https://github.com/myzsh/myzsh-golang $HOME/.myzsh/remotes/golang && \
    git clone https://github.com/myzsh/myzsh-timer $HOME/.myzsh/remotes/timer && \
    git clone https://github.com/dan9186/myzsh-dan9186 $HOME/.myzsh/remotes/dan9186

# Install custom vim settings
RUN git clone --recursive https://github.com/dan9186/Vimderp.git $HOME/.vim && \
    cd $HOME/.vim && \
    ./install.sh && \
    ./bundle/YouCompleteMe/install.py --gocode-completer

# Add custom config files
RUN git clone https://github.com/dan9186/dotfiles $HOME/dotfiles && \
	 cd $HOME/dotfiles && \
	 ./install.sh

# Root installed and handled items
# Install versions of Ruby and configs
USER root
RUN /usr/local/rvm/bin/rvm install 2.3.1 && \
	 /usr/local/rvm/bin/rvm rvmrc warning ignore allGemfiles

# Make sure ownership is correct
RUN ln -s /gopath /home/dan9186/go && \
	 chown -R dan9186 /home/dan9186 && \
	 chown -R dan9186 $GOPATH && \
	 chown -R dan9186 /usr/local/rvm

# Provide persistent project directory
VOLUME ["/docker"]

USER dan9186
CMD ["/bin/zsh"]

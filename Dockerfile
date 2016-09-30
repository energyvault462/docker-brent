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

# Add custom configs
COPY ext/zshrc /home/dan9186/.zshrc
COPY ext/gitconfig /home/dan9186/.gitconfig

# Set ownerships
RUN chown -R dan9186 $GOPATH && \
	 chown -R dan9186 /usr/local/rvm && \
	 chown -R dan9186 /home/dan9186

# Install customizations into homedir
USER dan9186
ENV USER dan9186
ENV PATH $HOME:$PATH
RUN ln -s /gopath $HOME/go

# Install custom shell
RUN git clone https://github.com/myzsh/myzsh $HOME/.myzsh && \
    git clone http://github.com/myzsh/myzsh-golang $HOME/.myzsh/remotes/golang

# Install custom vim settings
RUN git clone --recursive https://github.com/dan9186/Vimderp.git $HOME/.vim && \
    cd $HOME/.vim && \
    ./install.sh && \
    ./bundle/YouCompleteMe/install.py --gocode-completer

# Install versions of Ruby
RUN /usr/local/rvm/bin/rvm install 2.2.4 && \
	 /usr/local/rvm/bin/rvm install 2.3.1

# Add rvm configs
RUN /usr/local/rvm/bin/rvm rvmrc warning ignore allGemfiles

# Provide persistent project directory
VOLUME ["/docker"]

ENTRYPOINT ["/bin/zsh"]

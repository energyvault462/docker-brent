FROM dan9186/devopsbase


MAINTAINER Brent Johnson <brentj433@gmail.com>

ARG BUILD_DATE
ARG BUILD_NUMBER
ARG VERSION

LABEL org.metadata.build-date=$BUILD_DATE \
	   org.metadata.version=$VERSION.$BUILD_NUMBER \
	   org.metadata.name="Brent Personal Development Environment" \
	   org.metadata.description="A personalized development environment for Brent" \
	   org.metadata.url="https://github.com/energyvault462/docker-brent" \
	   org.metadata.vcs-url="https://github.com/energyvault462/docker-brent"

# Install custom deps
RUN yum -y update && \
    yum -y upgrade && \
    yum -y install sudo zsh libgemplugin-ruby build-essential nano


RUN pip install -U pytest

# Create custom user
RUN useradd -u 2001 -ms /bin/zsh brent && \
	 echo "brent ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Custom user installed and handled items
USER brent
ENV USER brent
ENV PATH $HOME:$PATH
ENV DOCKER true

# Install custom shell
RUN git clone https://github.com/myzsh/myzsh $HOME/.myzsh
# if uncommenting any below, add follow to above line:  && \
#    git clone https://github.com/myzsh/myzsh-golang $HOME/.myzsh/remotes/golang && \
#    git clone https://github.com/myzsh/myzsh-timer $HOME/.myzsh/remotes/timer && \
#    git clone https://github.com/dan9186/myzsh-dan9186 $HOME/.myzsh/remotes/dan9186

# Install custom vim settings
#RUN git clone --recursive https://github.com/dan9186/Vimderp.git $HOME/.vim && \
#    cd $HOME/.vim && \
#    ./install.sh && \
#    ./bundle/YouCompleteMe/install.py --gocode-completer

# Add custom config files
RUN git clone https://github.com/energyvault462/dotfiles $HOME/dotfiles && \
	 cd $HOME/dotfiles && \
	 ./install.sh

# Root installed and handled items
# Install versions of Ruby and configs
USER root
#RUN /usr/local/rvm/bin/rvm install 2.3.3 && \
#	 /usr/local/rvm/bin/rvm rvmrc warning ignore allGemfiles

RUN /usr/local/rvm/bin/rvm install 2.3.0 && \
         /usr/local/rvm/bin/rvm rvmrc warning ignore allGemfiles

# Make sure ownership is correct
RUN ln -s /gopath /home/brent/go && \
	 chown -R brent /home/brent && \
	 chown -R brent $GOPATH && \
	 chown -R brent /usr/local/rvm

# Install Zsh
USER brent
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh \
      && chsh -s /bin/zsh

# Provide persistent project directory
VOLUME ["/docker"]

WORKDIR  /home/brent
USER brent
CMD ["/bin/zsh"]

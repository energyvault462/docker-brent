FROM dan9186/devopsbase

MAINTAINER dan9186

# Install custom vim settings
RUN git clone --recursive https://github.com/dan9186/Vimderp.git /root/.vim \
    && cd /root/.vim \
    && ./install.sh

# Provide persistent project directory
VOLUME /work

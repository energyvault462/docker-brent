FROM dan9186/devopsbase

VOLUME ["/docker"]

WORKDIR /root
RUN git clone --recursive https://github.com/dan9186/Vimderp.git .vim && \
    cd .vim && \
    ./install.sh

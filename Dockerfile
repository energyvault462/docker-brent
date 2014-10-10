FROM dan9186/devopsbase

#VOLUME /home

#ENV HOME /home

RUN git clone --recursive https://github.com/dan9186/Vimderp.git /root/.vim && cd /root/.vim && ./install.sh

VOLUME /work

FROM myzsh/myzsh

VOLUME /work
VOLUME /root/.ssh

RUN yum update -y && yum -y install curl git mercurial bzr tar vim

RUN git clone --recursive https://github.com/dan9186/Vimderp.git /root/.vim && cd /root/.vim && ./install.sh

RUN mkdir /goroot && mkdir /gopath && curl https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN go get github.com/tools/godep

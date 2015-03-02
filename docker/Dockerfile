FROM ubuntu:12.04

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install python-software-properties
RUN add-apt-repository ppa:hvr/ghc 
RUN apt-get -y update
RUN apt-get -y install cabal-install-1.22 ghc-7.8.4 libsnmp-dev
#RUN cabal-install
RUN export PATH=/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:$PATH; cabal update
ENTRYPOINT export PATH=/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:$PATH; cd /build; cabal install --only-dependencies; cabal build

#ENTRYPOINT /bin/bash

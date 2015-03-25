FROM ubuntu

# 1. Introduction
RUN apt-get -y install git

# 2. Getting the source code
RUN git clone git://github.com/xbmc/xbmc.git $HOME/kodi

# 3. Installing the required Ubuntu packages
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y -s ppa:team-xbmc/xbmc-nightly
RUN add-apt-repository -y ppa:team-xbmc/xbmc-ppa-build-depends
RUN apt-get update
RUN apt-get -y build-dep kodi
RUN add-apt-repository -y -r ppa:team-xbmc/xbmc-nightly
RUN add-apt-repository -y -r ppa:team-xbmc/xbmc-ppa-build-depends
RUN apt-get -y install ccache
RUN apt-get -y install distcc

# 4. How to compile
RUN cd $HOME/kodi; ./bootstrap
RUN cd $HOME/kodi; ./configure
RUN cd $HOME/kodi; make -j2
RUN cd $HOME/kodi; make install

FROM ubuntu:14.04
MAINTAINER Vincent Vigneron <vigneron@info.univ-angers.fr>
RUN apt-get update && apt-get install -y g++ \
	wget \
	cmake \
	man \
	git \
	libqt4-dev
RUN cd /home && mkdir Software && cd Software && wget http://www.gecode.org/download/gecode-4.0.0.tar.gz && tar zxvf gecode-4.0.0.tar.gz && rm -r gecode-4.0.0.tar.gz && cd gecode-4.0.0 && ./configure && make install
ENV LD_LIBRARY_PATH /home/Software/gecode-4.0.0
RUN export LD_LIBRARY_PATH

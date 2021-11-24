FROM javernaut/ffmpeg-android-maker

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  m4
  
RUN apt install -y gnutls-bin=3.6.13-2ubuntu1.6


RUN wget https://ftp.gnu.org/gnu/nettle/nettle-3.4.1.tar.gz && \
tar xvfz nettle-3.4.1.tar.gz && \
cd nettle-3.4.1 && \
./configure --prefix=/usr/local/nettle/3_4_1 --enable-mini-gmp && \
make && \
make install


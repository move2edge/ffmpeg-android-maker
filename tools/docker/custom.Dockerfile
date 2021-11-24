FROM javernaut/ffmpeg-android-maker

RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  m4
  # openssl \
  # libssl-dev 
  
RUN apt install -y gnutls-bin=3.6.13-2ubuntu1.6

# RUN wget https://ftp.gnu.org/gnu/nettle/nettle-3.7.3.tar.gz && \
#   tar -xvf nettle-3.7.3.tar.gz && \
#   cd nettle-3.7.3 && \
#   ./configure --prefix=/usr --disable-static && \
#   make && \
#   make install


RUN wget https://ftp.gnu.org/gnu/nettle/nettle-3.4.1.tar.gz && \
tar xvfz nettle-3.4.1.tar.gz && \
cd nettle-3.4.1 && \
./configure --prefix=/usr/local/nettle/3_4_1 --enable-mini-gmp && \
make && \
make install

RUN ln -s /usr/local/nettle/3_4_1/bin/nettle-hash /usr/local/bin/ && \
ln -s /usr/local/nettle/3_4_1/bin/nettle-lfib-stream /usr/local/bin/ && \
ln -s /usr/local/nettle/3_4_1/bin/nettle-pbkdf2 /usr/local/bin/ && \
ln -s /usr/local/nettle/3_4_1/bin/pkcs1-conv /usr/local/bin/ && \
ln -s /usr/local/nettle/3_4_1/bin/sexp-conv /usr/local/bin/ && \
ln -s /usr/local/nettle/3_4_1/include/nettle /usr/local/include/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libhogweed.a /usr/local/lib/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libhogweed.so /usr/local/lib/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libhogweed.so.5 /usr/local/lib/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libhogweed.so.5.0 /usr/local/lib/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libnettle.a /usr/local/lib/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libnettle.so /usr/local/lib/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libnettle.so.7 /usr/local/lib/ && \
ln -s /usr/local/nettle/3_4_1/lib64/libnettle.so.7.0 /usr/local/lib/ 
# && \
# ln -s /usr/local/nettle/3_4_1/lib64/pkgconfig/hogweed.pc /usr/local/lib/pkgconfig/ && \
# ln -s /usr/local/nettle/3_4_1/lib64/pkgconfig/nettle.pc /usr/local/lib/pkgconfig/

# RUN apt-get install -y --no-install-recommends autoconf nettle-dev
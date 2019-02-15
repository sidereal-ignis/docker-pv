FROM buildpack-deps:stretch

ARG ver="1.6.6"

WORKDIR /root

RUN set -x \
 && curl -fsLO http://www.ivarch.com/programs/sources/pv-${ver}.tar.bz2 \
 && tar xjf pv-${ver}.tar.bz2 \
 && cd pv-${ver} \
 && ./configure \
 && make \
 && mv pv ../ \
 && ../pv --version


FROM gcr.io/distroless/base

COPY --from=0 /root/pv /

ENTRYPOINT [ "/pv" ]


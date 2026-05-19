FROM typst:latest

WORKDIR /data

COPY main.typ /data/main.typ
COPY template /data/template
COPY ref.bib /data/ref.bib
COPY assets /data/assets

RUN typst compile /data/main.typ /data/TFE.pdf

ENTRYPOINT ["tail", "-f", "/dev/null"]
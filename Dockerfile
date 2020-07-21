FROM rocker/r-ver:3.6.3
LABEL maintainer="Author"
LABEL email="author_email@email.com"

ARG WHEN

RUN mkdir /home/project

COPY . /home/project/

# install packages using DESCRIPTION file
RUN cd /home/project/; \
  if [ -f DESCRIPTION ]; \
    then R --quiet -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/${WHEN}')); \
    install.packages('remotes'); \
    remotes::install_deps()"; \
  fi

CMD cd /home/project \
  && Rscript analysis.R

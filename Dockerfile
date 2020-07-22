FROM rocker/verse:3.6.3
LABEL maintainer="Author"
LABEL email="author_email@email.com"

# ---------------------------------------------
# Argument to specify date of R packages
# ---------------------------------------------
ARG WHEN

# ---------------------------------------------
# Install major Linux libraries
# ---------------------------------------------
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    zip \
      unzip

# ---------------------------------------------
# Set up work environment and R library paths
# ---------------------------------------------
ENV NB_USER rstudio

RUN echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron
RUN echo "export PATH=${PATH}" >> ${HOME}/.profile

ENV LD_LIBRARY_PATH /usr/local/lib/R/lib
ENV HOME /home/${NB_USER}
WORKDIR ${HOME}

USER root

# ---------------------------------------------
# Copy files to image, and execute code
# ---------------------------------------------
COPY . ${HOME}

# install packages using DESCRIPTION file
RUN if [ -f DESCRIPTION ]; \
    then R --quiet -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/${WHEN}')); \
    install.packages('remotes'); \
    remotes::install_deps()"; \
  fi

CMD Rscript analysis.R

RUN chown -R ${NB_USER} ${HOME}

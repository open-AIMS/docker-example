FROM username/docker-example
LABEL maintainer="Author"
LABEL email="author_email@email.com"

# This file modified from
# https://github.com/rocker-org/binder/blob/master/Dockerfile
# If extending this image, remember to switch back to USER root to apt-get

USER root

ENV NB_USER rstudio
ENV NB_UID 1000
ENV VENV_DIR /srv/venv
ENV PATH ${VENV_DIR}/bin:$PATH
RUN echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron
RUN echo "export PATH=${PATH}" >> ${HOME}/.profile

RUN apt-get update && \
  apt-get -y install git python3-venv python3-dev && \
  apt-get purge && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Create a venv dir owned by unprivileged user & set up notebook in it
# This allows non-root to install python libraries if required
RUN mkdir -p ${VENV_DIR} && chown -R ${NB_USER} ${VENV_DIR}

USER ${NB_USER}

# Explicitly install a new enough version of pip
RUN python3 -m venv ${VENV_DIR} && \
  pip3 install pip==9.0.1 && \
  pip3 install --no-cache-dir \
  jupyter-rsession-proxy

RUN R --quiet -e "remotes::install_github('IRkernel/IRkernel')" && \
  R --quiet -e "IRkernel::installspec(prefix='${VENV_DIR}')"

CMD jupyter notebook --ip 0.0.0.0

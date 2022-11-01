FROM jupyter/base-notebook:notebook-6.5.1

USER root

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

# RUN adduser --disabled-password \
#     --gecos "Default user" \
#     --uid ${NB_UID} \
#     ${NB_USER}

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN pip install icortex
RUN python -m icortex.kernel.install
# RUN jupyter kernelspec uninstall python3 -y
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}
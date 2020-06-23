FROM circleci/python:3.8.2
MAINTAINER Wesley Kendall <wes.kendall@jyve.com>

# Install git 2.22 from source
RUN sudo apt-get update
RUN sudo apt-get install gettext
RUN cd /usr/src/ && \
    sudo wget https://github.com/git/git/archive/v2.23.0.tar.gz -O git.tar.gz && \
    sudo tar -xf git.tar.gz && \
    cd /usr/src/git-* && \
    sudo make prefix=/usr/local all && \
    sudo make prefix=/usr/local install && \
    sudo make clean && \
    sudo rm -r /usr/src/git*

# Pipx
ENV PATH=/home/circleci/.local/bin:$PATH
RUN pip install --user pipx
RUN pipx install poetry

# The base image comes with python3.8 and python3.7 installed. Manually
# install 3.6 so that we can run tests over python3.6
RUN sudo curl -O https://www.python.org/ftp/python/3.6.10/Python-3.6.10.tgz
RUN sudo tar -xvzf Python-3.6.10.tgz
RUN cd Python-3.6.10 && sudo ./configure --prefix=/usr/
RUN cd Python-3.6.10 && sudo make
RUN cd Python-3.6.10 && sudo make install

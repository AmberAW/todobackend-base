FROM ubuntu:artful

ENV TERM=xterm-256color

# Install Python and required utilities
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python3.5 bzip2 wget python3-dev libmysqlclient-dev gcc

# Install miniconda, update, and create virtual environment
RUN wget https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $HOME/miniconda && \
    export PATH="$HOME/miniconda/bin:$PATH" && \
    conda update --yes conda && \
    conda create --yes --name appenv python=3.5

# Add entrypoint script
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

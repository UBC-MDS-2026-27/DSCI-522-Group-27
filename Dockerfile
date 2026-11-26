# Adapted from docker-uv-renv by Daniel Chen (MIT License)
# https://github.com/chendaniely/docker-uv-renv

# Start from Ubuntu Linux with R installed.
# Use the R version recorded in renv.lock (4.6.1).
FROM rocker/r-ver:4.6.1

# Install the programs the project needs:
# curl downloads files, git/less/nano let you work in a terminal,
# make runs a Makefile, openssh-server lets Positron connect over ssh.
# The lib*-dev packages and pkg-config are system libraries that R packages
# compile against: libuv1-dev (fs), libssl-dev (openssl), zlib1g-dev (haven),
# libcurl4-openssl-dev (curl), libxml2-dev (xml2),
# libfontconfig1-dev + libfreetype-dev (systemfonts),
# libharfbuzz-dev + libfribidi-dev (textshaping),
# libpng-dev, libtiff-dev, libjpeg-dev, libwebp-dev (ragg)
RUN apt-get update && apt-get install --yes \
    curl \
    git \
    less \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libpng-dev \
    libssl-dev \
    libtiff-dev \
    libuv1-dev \
    libwebp-dev \
    libxml2-dev \
    make \
    nano \
    openssh-server \
    pkg-config \
    zlib1g-dev

# Install Quarto (it comes with Typst for PDFs, so no LaTeX).
# dpkg --print-architecture gives amd64 or arm64, to match the computer.
RUN curl --location --output quarto.deb \
    https://github.com/quarto-dev/quarto-cli/releases/download/v1.11.9/quarto-1.11.9-linux-$(dpkg --print-architecture).deb \
  && apt-get install --yes ./quarto.deb \
  && rm quarto.deb

# Your project folder is mounted at /workspace,
# so the packages go in /opt instead
WORKDIR /workspace

# R packages (renv) go in /opt/renv/library
RUN echo "RENV_PATHS_LIBRARY=/opt/renv/library" >> /usr/local/lib/R/etc/Renviron.site
COPY renv.lock .Rprofile ./
COPY renv/activate.R renv/
RUN Rscript -e "renv::restore()"

# On a Linux laptop, remove the # from the next line.
# (sshd wants root to own the key file, but on Linux the mounted one is yours.)
RUN echo "StrictModes no" > /etc/ssh/sshd_config.d/container.conf

RUN mkdir -p /run/sshd

# Start the ssh server when the container starts.
# -D keeps it in the foreground, so the container keeps running.
CMD ["/usr/sbin/sshd", "-D"]
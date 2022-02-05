FROM rocker/rstudio:4.1.1

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    gfortran-7 \
    gcc-7 \
    g++-7 \
    libxml2-dev \
    libglpk40 \
    curl \
    libxt-dev \
    fonts-ipaexfont \
  && apt-get clean

# AWS CLI (if necessary)
COPY --from=amazon/aws-cli:2.4.6 /usr/local /usr/local
COPY --from=amazon/aws-cli:2.4.6 /aws /aws

# Install {renv}
RUN echo "options(repos = c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/centos7/latest'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN Rscript -e "install.packages('renv')"

RUN mkdir -p /home/rstudio/.local/share/renv/cache \
    && chown -R rstudio:rstudio /home/rstudio
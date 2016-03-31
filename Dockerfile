FROM ubuntu:trusty

MAINTAINER Kristian Peters <kpeters@ipb-halle.de>

LABEL Description="Install MetFamily + underlying R shiny-server + relevant bioconductor packages in Docker."



# Environment variables
ENV PACK_R="cba devtools DT FactoMineR htmltools Matrix matrixStats plotrix rCharts rmarkdown shiny shinyBS shinyjs squash stringi tools"
ENV PACK_BIOC="mzR pcaMethods xcms"
ENV PACK_GITHUB=""



# Add cran R backport
RUN apt-get -y install apt-transport-https
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN echo "deb https://cran.uni-muenster.de/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list

# Update & upgrade sources
RUN apt-get -y update
RUN apt-get -y dist-upgrade

# Install r related packages
RUN apt-get -y install texlive-binaries r-base

# Install libraries needed for bioconductor
RUN apt-get -y install netcdf-bin libnetcdf-dev libdigest-sha-perl

# Install development files needed
RUN apt-get -y install git python xorg-dev libglu1-mesa-dev freeglut3-dev libgomp1 libxml2-dev gcc g++ libgfortran-4.8-dev libcurl4-gnutls-dev cmake wget ed libssl-dev

# Clean up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

## Install R packages & bioconductor
##RUN R -e "install.packages(c('shiny','rmarkdown','shinyBS','shinyjs','DT'), repos='https://cran.rstudio.com/')"
##RUN R -e "install.packages(c('squash','FactoMineR','devtools','stringi'), repos='https://cran.rstudio.com/')"
##RUN R -e "install.packages(c('rCharts','cba','matrixStats','Matrix','plotrix','tools','htmltools'), repos='https://cran.rstudio.com/')"
##RUN R -e "source('https://bioconductor.org/biocLite.R'); biocLite(); biocLite(c('xcms','mzR','pcaMethods'));"
##RUN R -e "update.packages(repos='https://cran.rstudio.com/', ask=F)"

# Install R packages
RUN for PACK in $PACK_R; do R -e "install.packages(\"$PACK\", repos='https://cran.rstudio.com/', dep=T, ask=F)"; done

# Install Bioconductor packages
RUN R -e "source('https://bioconductor.org/biocLite.R'); biocLite(\"BiocInstaller\", dep=TRUE, ask=FALSE)"
RUN for PACK in $PACK_BIOC; do R -e "library(BiocInstaller); biocLite(\"$PACK\", ask=FALSE)"; done

# Install other R packages from source
#RUN for PACK in $PACK_GITHUB; do R -e "library('devtools'); install_github(\"$PACK\")"; done

# Install and configure shiny-server
WORKDIR /usr/src
RUN git clone https://github.com/rstudio/shiny-server.git
WORKDIR /usr/src/shiny-server
RUN mkdir tmp
WORKDIR /usr/src/shiny-server/tmp
RUN DIR=`pwd`; PATH=$DIR/../bin:$PATH; PYTHON=`which python`; cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DPYTHON="$PYTHON" ../; make; mkdir ../build; (cd .. && ./bin/npm --python="$PYTHON" rebuild); (cd .. && ./bin/node ./ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js --python="$PYTHON" rebuild)
RUN make install
RUN ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server
RUN useradd -r -m shiny
RUN mkdir -p /var/log/shiny-server
RUN mkdir -p /srv/shiny-server
RUN mkdir -p /var/lib/shiny-server
RUN chown shiny /var/log/shiny-server
RUN mkdir -p /etc/shiny-server
RUN wget https://raw.github.com/rstudio/shiny-server/master/config/upstart/shiny-server.conf -O /etc/init/shiny-server.conf
RUN cp -r /usr/src/shiny-server/samples/* /srv/shiny-server/
RUN wget https://raw.githubusercontent.com/rstudio/shiny-server/master/config/default.config -O /etc/shiny-server/shiny-server.conf

# Development: using internal sources
#ENV VOL="/vol/R/shiny/srv/shiny-server/MetFam"
#RUN mkdir -p $VOL
#VOLUME $VOL
#RUN mv /srv/shiny-server /srv/shiny-server_orig; ln -s $VOL /srv/shiny-server

# Stable: using official github repository
RUN mv /srv/shiny-server /srv/shiny-server_orig
WORKDIR /srv
RUN git clone https://github.com/Treutler/MetFamily
RUN mv MetFamily shiny-server

# Expose port
EXPOSE 3838

# Define Entry point script
WORKDIR /
ENTRYPOINT ["/usr/bin/shiny-server","--pidfile=/var/run/shiny-server.pid"]

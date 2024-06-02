FROM rocker/tidyverse:4.4
LABEL maintainer="Kenyon Ng <work@kenyon.xyz>"

# libfftw3-dev (EBImage), libgdal-dev (s2), libudunits2-dev (units), the rest (sf), libglpk40(igraph)

RUN apt-get update && apt-get install -y --no-install-recommends \
    libfftw3-dev \		
    libgdal-dev \
    libgeos++-dev \
    libproj-dev \
    libsqlite3-dev \ 		
    libudunits2-dev \ 
    libglpk40

RUN Rscript -e 'BiocManager::install(version = "3.19", ask = FALSE)'
RUN Rscript -e 'BiocManager::install("EBImage", version = "3.19")'

RUN install2.r --error \
    s2 \
    sf \
    units

# install FIELDImageR
RUN Rscript -e 'install.packages(c("terra","mapview","sf","stars","caret","mapedit","devtools","dplyr","fields","leafem","leafsync","lwgeom","BiocManager","git2r","exactextractr"))'

RUN installGithub.r OpenDroneMap/FIELDimageR
RUN installGithub.r filipematias23/FIELDimageR.Extra
FROM bioconductor/bioconductor_docker:devel

RUN mkdir /app
RUN cd /app

RUN apt-get update
RUN R -e "BiocManager::install('biomaRt', ask=F)"
RUN R -e "install.packages('multiclassPairs', version='0.4.3')"
RUN R -e "install.packages('readr', version='2.1.5')"
RUN R -e "install.packages('dplyr', version='1.1.4')"
RUN R -e "install.packages('tibble', version='3.2.1')"

WORKDIR /app

COPY ./.build/classifier_run.R /app/classifier_run.R

COPY ./.build/best_model.RDS /app/best_model.RDS

ENTRYPOINT ["Rscript", "/app/classifier_run.R"]



 


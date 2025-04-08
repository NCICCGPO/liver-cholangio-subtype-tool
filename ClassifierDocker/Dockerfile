FROM bioconductor/bioconductor_docker:devel

RUN mkdir /home/analysis
RUN cd /home/analysis

RUN apt-get update
RUN R -e "BiocManager::install('biomaRt', ask=F)"
RUN R -e "install.packages('multiclassPairs', version='0.4.3')"
RUN R -e "install.packages('readr', version='2.1.5')"
RUN R -e "install.packages('dplyr', version='1.1.4')"
RUN R -e "install.packages('tibble', version='3.2.1')"

WORKDIR /home/analysis

COPY classifier_run.R /home/analysis/classifier_run.R

COPY best_model.RDS /home/analysis/best_model.RDS

ENTRYPOINT ["Rscript", "/home/analysis/classifier_run.R"]



 


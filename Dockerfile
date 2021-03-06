FROM nfcore/base:1.9
LABEL authors="Francesco Lescai" \
      description="Docker image containing all software requirements for the nibscbioinformatics/scoop pipeline"

# Install the conda environment
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/nibscbioinformatics-scoop-1.0dev/bin:$PATH

# Dump the details of the installed packages to a file for posterity
RUN conda env export --name nibscbioinformatics-scoop-1.0dev > nibscbioinformatics-scoop-1.0dev.yml

# Humann2 doesn't have an option to pass the utility database apparently
# so downlading it here, size is ok

RUN mkdir -p /opt/databases/humann2_dbs
RUN cd /opt/databases
RUN humann2_databases --download utility_mapping full humann2_dbs

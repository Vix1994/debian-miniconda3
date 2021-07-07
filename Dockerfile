FROM debian:buster-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# RUN sed -i 's#http://deb.debian.org#http://mirrors.163.com#g' /etc/apt/sources.list

RUN apt-get update --fix-missing && \
    apt-get install -y build-essential && \
    apt-get install -y wget && \
    apt-get install -y cron && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ADD ./miniconda3.sh ./miniconda3.sh

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh -O ./miniconda3.sh && \
    apt-get remove -y wget && \
    /bin/bash ./miniconda3.sh -b -p /opt/conda && \
    rm ./miniconda3.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

RUN conda create -n recb python=3.7 && \
    conda clean -ya && \
    echo "conda activate recb" >> ~/.bashrc && \
    conda install mysqlclient && \
    conda install -y Ipython && \
    conda clean -ya

ENTRYPOINT ["/bin/bash"]

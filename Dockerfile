FROM mcr.microsoft.com/powershell
ARG STACKIT_VERSION=0.0.34
RUN apt-get update -y
RUN apt-get install curl jq python3 python3-pip apt-transport-https -y
RUN pip3 install awscli --upgrade --user
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN curl https://github.com/glassechidna/stackit/releases/download/${STACKIT_VERSION}/stackit_${STACKIT_VERSION}_Linux_x86_64.tar.gz -sLo stackit.tar.gz
RUN tar xvzf stackit.tar.gz && \
    mv ./stackit /usr/bin &&\
    chmod a+x /usr/bin/stackit 
RUN apt-get install -y gpg
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/prod.list
RUN mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN chown root:root /etc/apt/sources.list.d/microsoft-prod.list
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install dotnet-sdk-2.2
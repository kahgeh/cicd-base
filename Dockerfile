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
RUN dpkg --purge packages-microsoft-prod && sudo dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install dotnet-sdk-2.2
RUN dotnet tool install -g Amazon.Lambda.Tools
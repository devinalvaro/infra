FROM ubuntu:19.10

ARG user=devin
ARG ssh_pub

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        ssh \
        sudo \
        --no-install-recommends

RUN echo "${user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user} && \
    chmod 0440 /etc/sudoers.d/${user}

RUN useradd -m ${user}
USER ${user}

WORKDIR /home/${user}
ENV USER ${user}

RUN mkdir -p .ssh
RUN echo ${ssh_pub} > .ssh/authorized_keys

COPY ubuntu.sh base.sh .
RUN ./ubuntu.sh && ./base.sh
RUN rm ubuntu.sh base.sh

FROM ubuntu:19.10

ARG user=devin

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        sudo \
        --no-install-recommends

RUN echo "${user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user} && \
    chmod 0440 /etc/sudoers.d/${user}

RUN useradd -m ${user}
WORKDIR /home/${user}
USER ${user}

ENV USER ${user}
COPY base.sh .
RUN ./base.sh
RUN rm base.sh

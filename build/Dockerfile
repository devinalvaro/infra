FROM fedora:31

ARG user=devin
ARG ssh_pub

RUN dnf install -q -y \
        @development-tools \
        @infrastructure-server-environment \
        util-linux-user

RUN echo "${user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user} && \
    chmod 0440 /etc/sudoers.d/${user}

RUN useradd -m ${user}
USER ${user}

WORKDIR /home/${user}
ENV USER ${user}

RUN mkdir -p .ssh
RUN echo ${ssh_pub} > .ssh/authorized_keys

COPY fedora.sh base.sh ./
RUN ./fedora.sh && ./base.sh
RUN rm fedora.sh base.sh

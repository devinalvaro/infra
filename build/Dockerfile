FROM fedora:31

ARG user=devin

RUN dnf install -q -y \
        @development-tools \
        util-linux-user \
        which

RUN echo "${user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user} && \
    chmod 0440 /etc/sudoers.d/${user}

RUN useradd -m ${user}
USER ${user}

WORKDIR /home/${user}
ENV USER ${user}

COPY fedora.sh base.sh ./
RUN ./fedora.sh && ./base.sh
RUN rm fedora.sh base.sh

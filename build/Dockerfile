FROM fedora:31

ARG user=devin

RUN dnf install -q -y \
        # essentials
        @development-tools \
        util-linux-user \
        which \
        # apps
        exa \
        fd-find \
        fish \
        fzf \
        git \
        htop \
        neovim \
        ripgrep \
        wget \
        xclip \
        # langs
        nodejs \
        python-devel \
        # libs
        pkg-config \
        zlib-devel

RUN echo "${user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user} && \
    chmod 0440 /etc/sudoers.d/${user}

RUN useradd -m ${user}
USER ${user}

WORKDIR /home/${user}
ENV USER ${user}

COPY base.sh ./
RUN ./base.sh
RUN rm base.sh

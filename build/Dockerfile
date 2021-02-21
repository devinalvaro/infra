FROM fedora:33

ARG user=devin

RUN dnf update -q -y && dnf install -q -y \
        # essentials \
        @development-tools \
        # apps
        bat \
        exa \
        fd-find \
        fish \
        fzf \
        git \
        neovim \
        ripgrep \
        wget \
        xclip \
        # langs
        elixir erlang \
        nodejs \
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

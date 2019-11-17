FROM devinalvaro/home

RUN apt-get update && apt-get install -y \
            htop \
            pkg-config \
            zlib1g-dev \
            --no-install-recommends

CMD ["fish"]

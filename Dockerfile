FROM ubuntu:18.04

# 1. Add the repo for g++-6 and install ALL dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test \
    && apt-get update && apt-get install -y \
    build-essential \
    gcc-6 \
    g++-6 \
    make \
    libc6-dev \
    libcurl4-openssl-dev \
    git

WORKDIR /app

# 2. Copy the source (this includes your rapidjson folder)
COPY . .

# 3. Compile
# We use 'make clean' to ensure no half-finished 'abominations.o' files are left
RUN cd src && make clean && make
RUN cp src/haven ./haven

EXPOSE 4001

CMD ["./haven", "4001"]

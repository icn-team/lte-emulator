FROM ubuntu:16.04

# Build hicn suite (from source for disabling punting)
WORKDIR /

# Use bash shell
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y apt-transport-https  && rm -rf /var/lib/apt/lists/* && apt-get autoremove -y && apt-get clean
RUN echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.master.ubuntu.xenial.main/ ./" > /etc/apt/sources.list.d/99fd.io.list

# Install LTE packages
RUN apt-get update && apt-get install -y lte-emulator iproute2 arping                           \
  && rm -rf /var/lib/apt/lists/*                                                                \
  && apt-get autoremove -y                                                                      \
  && apt-get clean                                                                              

COPY init.sh .

WORKDIR /
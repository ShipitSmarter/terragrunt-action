# Dockerfile used in execution of Github Action
FROM gruntwork/terragrunt:0.2.0
LABEL maintainer="Gruntwork <info@gruntwork.io>"

ENV MISE_CONFIG_DIR=~/.config/mise
ENV MISE_STATE_DIR=~/.local/state/mise
ENV MISE_DATA_DIR=~/.local/share/mise
ENV MISE_CACHE_DIR=~/.cache/mise
ENV ASDF_HASHICORP_TERRAFORM_VERSION_FILE=.terraform-version

COPY ["./src/main.sh", "/action/main.sh"]

RUN curl -sLO https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip && unzip -o -q awscli-exe-linux-x86_64.zip && ./aws/install && rm -rf awscli-exe-linux-x86_64.zip aws
RUN apt update && apt install -y python3
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

ENTRYPOINT ["/action/main.sh"]

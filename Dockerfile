# Dockerfile used in execution of Github Action
FROM gruntwork/terragrunt:2.1.7
LABEL maintainer="Gruntwork <info@gruntwork.io>"

ENV MISE_CONFIG_DIR=~/.config/mise
ENV MISE_STATE_DIR=~/.local/state/mise
ENV MISE_DATA_DIR=~/.local/share/mise
ENV MISE_CACHE_DIR=~/.cache/mise
ENV ASDF_HASHICORP_TERRAFORM_VERSION_FILE=.terraform-version

COPY ["./src/main.sh", "/action/main.sh"]

RUN curl -sLO https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip && unzip -o -q awscli-exe-linux-x86_64.zip && ./aws/install && rm -rf awscli-exe-linux-x86_64.zip aws \
  && apt update && apt install -y python3 \
  && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
  && /bin/bash -c "rm -rf /opt/az/lib/python3.11/site-packages/azure/mgmt/{compute,web,resource,containerregistry,sql,containerservice} /opt/az/lib/python3.11/site-packages/azure/cli/command_modules/network"
# We're not using those large libraries, so we remove them to save space

ENTRYPOINT ["/action/main.sh"]

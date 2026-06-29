FROM docker.io/oven/bun:1.3.13-alpine

# Use default user: bun:bun (1000:1000).
ARG USER_NAME=bun
ARG PI_VERSION=0.80.2

# Define variables
ENV HOME_DIR="/home/${USER_NAME}"
ENV WORK_DIR="${HOME_DIR}/workdir"
ENV PI_BIN_DIR="${HOME_DIR}/pi-bin"
ENV PI_CFG_DIR="${HOME_DIR}/.pi"

# Create directories with correct permissions
RUN mkdir -p ${WORK_DIR} ${PI_BIN_DIR} ${PI_CFG_DIR} \
 && chown -R ${USER_NAME}:${USER_NAME} ${WORK_DIR} ${PI_BIN_DIR} ${PI_CFG_DIR}

# Install tools
RUN apk add --no-cache \
  bash \
  git \
  curl \
  ripgrep \
  fd \
  ca-certificates

# Set user/group and workdir
USER ${USER_NAME}:${USER_NAME}
WORKDIR ${WORK_DIR}

# Install pi-agent and add it to PATH
RUN cd ${PI_BIN_DIR} && bun add @earendil-works/pi-coding-agent@${PI_VERSION}
ENV PATH=${PI_BIN_DIR}/node_modules/.bin:$PATH

# Define volumes
VOLUME [ "${PI_CFG_DIR}" ]
VOLUME [ "${WORK_DIR}" ]

# Set entrypoint to `pi` binary
ENTRYPOINT ["pi"]

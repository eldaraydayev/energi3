FROM energi3
ADD energi3-v3.1.3-linux-amd64/bin/energi3 /usr/local/bin/energi

ARG ENERGI_VERSION
ARG ENERGI_BIN
ARG ENERGI_CORE_DIR
ARG USER_AND_GROUP_ID=1000
ARG USERNAME=nrgstaker

ENV ENERGI_BIN="${ENERGI_BIN:?}"
ENV ENERGI_CORE_DIR="${ENERGI_CORE_DIR:?}"
ENV STAKER_HOME="${STAKER_HOME:?}"


WORKDIR "${STAKER_HOME}/energi"

RUN addgroup --gid ${USER_AND_GROUP_ID} ${USERNAME} \
  && adduser \
  --uid ${USER_AND_GROUP_ID} ${USERNAME} \
  --ingroup ${USERNAME} \
  --disabled-password; \
  mkdir -p ${ENERGI_CORE_DIR}; \
  chown -R ${USERNAME}:${USERNAME} ${STAKER_HOME}

COPY --chown=${USERNAME}:${USERNAME} [ "energi-core-run.sh", "./" ]
RUN chmod +x ./energi-core-run.sh

USER ${USERNAME}

ENTRYPOINT ["/bin/sh", "energi-core-run.sh"]
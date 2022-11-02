#!/bin/sh

exec ${ENERGI_BIN} \
  --datadir "${ENERGI_CORE_DIR}" \
  --masternode \
  --mine=1 \
  --nousb \
  --maxpeers 128 \
  --verbosity 3
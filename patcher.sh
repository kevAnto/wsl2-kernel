#!/bin/bash
set -euo pipefail

CONFIG_FILE="$1"
TARGET_FILE="$2"
BACKUP_FILE="$(dirname "$2")/config-wsl-backup"

if [[ ! -f "${BACKUP_FILE}" ]]; then
    cp ${TARGET_FILE} ${BACKUP_FILE}
else
    cp ${BACKUP_FILE} ${TARGET_FILE}
fi

echo "Patching ${TARGET_FILE}..."
while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" == \#* ]] && continue

    config_pattern="${line%%=*}"
    config_value="${line#*=}"

    for config_name in $(eval echo ${config_pattern}); do
        echo "=> Set ${config_name}=${config_value}"
        if grep -q "${config_name}" ${TARGET_FILE}; then
            sed -i "s/# ${config_name} is not set/${config_name}=${config_value}/" ${TARGET_FILE}
        else
            echo "${config_name}=${config_value}" >> ${TARGET_FILE}
        fi
    done
done < "${CONFIG_FILE}"
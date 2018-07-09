#!/bin/bash

echo "Going to backup git repositries."
GIT_HOST=http://LOCAL_GIT_REPO

SCRIPT_DIR=$(cd $(dirname $(readlink $0 || echo $0));pwd)
cd ${SCRIPT_DIR}

TODAY=`date +'%Y-%m-%d_%H%M'`
BACKUP_DIR=${SCRIPT_DIR}/${TODAY}

echo "GIT_HOST=${GIT_HOST}"
echo "TODAY=${TODAY}"
echo "BACKUP_DIR=${BACKUP_DIR}/"

GIT_REPOS=$(cat <<<'
  OWNER/REPO_NAME1
  OWNER/REPO_NAME2
  OWNER/REPO_NAME3
  OWNER/REPO_NAME4
')

if [ ! -e "${BACKUP_DIR}" ]; then
  mkdir -p ${BACKUP_DIR}
fi

cd ${BACKUP_DIR}
for GIT_REPO in ${GIT_REPOS}; do
  git clone --mirror ${GIT_HOST}/${GIT_REPO}.git
done
cd ${SCRIPT_DIR}

tar czf GIT_BACKUP_${TODAY}.tar.gz ${TODAY} && rm -rf ${BACKUP_DIR}
ls -ltra ${SCRIPT_DIR}

echo "Bye!"


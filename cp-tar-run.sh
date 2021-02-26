#!/bin/bash

#--------------------------------------------------
REPOSITORY_PATH="/mnt/share/workplace"
ENV_PATH='/var/workplace/share/ENV'
#--------------------------------------------------

REPOSITORIES=$(ls $REPOSITORY_PATH)
if [[ $REPOSITORIES == '' ]];then
    echo "[ERROR] There is no any repository at <$REPOSITORY_PATH>"
    exit 1
fi

echo "[INFO] Your repositories locate in <$REPOSITORY_PATH>"
echo "[INFO] Select your repository:"
select repository in $REPOSITORIES ;do
    if [[ $repository != '' && $REPOSITORIES =~ $repository ]]; then
        echo "[INFO] Your have selected <$repository>"
        break
    fi
done

PROJECTS_PATH="${REPOSITORY_PATH}/${repository}" 

PROJECTS=$(ls ${PROJECTS_PATH})
if [[ $PROJECTS == '' ]];then
    echo "[ERROR] There is no any project at <$PROJECTS_PATH>"
    exit 1
fi

echo "[INFO] Select your project:"
select project in $PROJECTS ;do
    if [[ $project != '' && $PROJECTS =~ $project ]]; then
        echo "[INFO] Your have selected <$project>"
        break
    fi
done

PROJECT_PATH="${PROJECTS_PATH}/${project}"

TARGET_PATH="${PROJECT_PATH}/karaf/target"
TAR_GZ_PATH=$(ls ${TARGET_PATH}/*.tar.gz)
TAR_GZ_NAME=${TAR_GZ_PATH##*/}

if [ -f "${TAR_GZ_PATH}" ]; then
    echo "[INFO] Name of the tar is <${TAR_GZ_NAME}>"
    echo "[INFO] <${TAR_GZ_PATH}> will be decompressed later"
else
    echo "[ERROR] file<${TAR_GZ_PATH}> dosen't exise, please check out it!"
    exit 1
fi

if [ ! -d "${ENV_PATH}/${repository}" ]; then
    mkdir "${ENV_PATH}/${repository}"
    echo "[INFO] make dir <${ENV_PATH}/${repository}>"
fi

RUN_PATH="${ENV_PATH}/${repository}/${project}"

if [ ! -d "${RUN_PATH}" ]; then
    mkdir "${RUN_PATH}"
    echo "[INFO] make dir <${RUN_PATH}>"
else
    rm -rf "${RUN_PATH}"
    echo "[INFO] remove <${RUN_PATH}>"
    mkdir "${RUN_PATH}"
    echo "[INFO] make dir <${RUN_PATH}>"
fi

cp $TAR_GZ_PATH "${RUN_PATH}/${TAR_GZ_NAME}"
echo "[INFO] cp ${RUN_PATH}/${TAR_GZ_NAME}"

TARGET_NAME=$(basename $TAR_GZ_NAME .tar.gz)

echo "[INFO] tar -xzvf ${RUN_PATH}/${TAR_GZ_NAME} -C ${RUN_PATH}/"
su -s /bin/bash -c "mkdir ${RUN_PATH}/${TARGET_NAME}" root
su -s /bin/bash -c "tar -xzvf ${RUN_PATH}/${TAR_GZ_NAME} -C ${RUN_PATH}/${TARGET_NAME} --strip-components 1" root

echo "[INFO] ${RUN_PATH}/${TARGET_NAME}/bin/karaf" debug
"${RUN_PATH}/${TARGET_NAME}/bin/karaf" debug

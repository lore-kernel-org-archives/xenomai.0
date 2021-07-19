From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/3] ci: Remove deploy with ssh
Date: Mon, 19 Jul 2021 16:29:46 +0200
Message-Id: <20210719142947.3034-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210719142947.3034-1-Quirin.Gylstorff@siemens.com>
References: <20210719142947.3034-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

We will use AWS S3 deployment for LAVA Build Artifacts. Therefore
remove the Deployment via ssh as the LAVA Lab is now public
available.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml         |  1 -
 scripts/deploy_for_testing.sh | 51 -----------------------------------
 scripts/run-lava-tests.sh     | 37 +++----------------------
 3 files changed, 4 insertions(+), 85 deletions(-)
 delete mode 100755 scripts/deploy_for_testing.sh

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 362a636..84bbdd4 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -45,7 +45,6 @@ default:
   script:
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-    - if [ -z "${USE_S3_BUCKET}" ]; then scripts/deploy_for_testing.sh ${TARGET}; fi
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
deleted file mode 100755
index 3878e7d..0000000
--- a/scripts/deploy_for_testing.sh
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/sh
-
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019-2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-set -e
-target="$1"
-
-if [ -z "${target}" ]; then
-    exit 1
-fi
-images_dir=build/tmp/deploy/images
-
-if [ -z "${LAVA_SSH_USER}" ] || [ -z "${LAVA_SSH_HOST}" ]  || [ -z "${LAVA_SSH_PORT}" ]; then
-    echo "Lava environment not available or incomplete - do not deploy"
-    exit 0
-fi
-
-lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
-
-isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
-lava_deploy_dir="${LAVA_DEPLOY_DIR:-/var/lib/lava/artifacts}"
-deploy_dir="${lava_deploy_dir}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
-lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
-if [ -n "${CI_PIPELINE_ID}" ]; then
-    ssh -p ${LAVA_SSH_PORT} ${lava_identity} ${lava_ssh_destination} 'install -d -m 755 "'${deploy_dir}'"'
-fi
-#KERNEL
-scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}-vmlinuz \
-    ${lava_ssh_destination}:${deploy_dir}
-# INITRD
-scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}-initrd.img \
-    ${lava_ssh_destination}:${deploy_dir}
-# ROOTFS
-if [ ! -e ${images_dir}/${target}/${isar_base_name}.*.gz  ]; then
-    gzip ${images_dir}/${target}/${isar_base_name}.*
-fi
-scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}.* \
-    ${lava_ssh_destination}:${deploy_dir}
-# DTB
-dtb="${images_dir}/${target}/*.dtb"
-if [ -e ${dtb} ]; then
-    scp -P ${LAVA_SSH_PORT} ${lava_identity} ${dtb} ${lava_ssh_destination}:${deploy_dir}
-fi
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 13fac31..b1b51bb 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -15,36 +15,10 @@ if [ -z "${TARGET}" ]; then
     exit 1
 fi
 
-if [ -n "${LAVA_SSH_HOST}" ]; then
-    echo "use SSH to connect to lava server"
-    # private master with ssh forward access
-    lava_master_port="${LAVA_MASTER_PORT:-28080}"
-    lava_ssh_port="-p ${LAVA_SSH_PORT:-22}"
-    lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
-    lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
-    # open connection for ssh port forwarding
-    ssh -N ${lava_ssh_port} ${lava_identity} -o 'LocalForward localhost:'${lava_master_port}' localhost:80' ${lava_ssh_destination} &
-    ssh_pid="$!"
-    # wait for connection
-    interval=1
-    timeout=60
-    until ss -tulw | grep -q "${lava_master_port}"
-    do
-        if [ ${timeout} -le 0 ]; then
-            echo "could not open connection to LAVA Master"
-            exit 1
-        fi
-        sleep ${interval}
-        timeout=$(( timeout - interval ))
-    done
-    artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
-    lava_master_uri="${LAVA_MASTER_URL:-http://localhost}:${lava_master_port}"
-else
-    # S3 artifacts
-    artifact_url="${LAVA_ARTIFACTS_URL:-https://xenomai-images-artifacts.s3.eu-central-1.amazonaws.com/artifacts}"
-    # public master
-    lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org}"
-fi
+# S3 artifacts
+artifact_url="${LAVA_ARTIFACTS_URL:-https://xenomai-images-artifacts.s3.eu-central-1.amazonaws.com/artifacts}"
+# public master
+lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org}"
 
 echo "connect to lava server: ${lava_master_uri}"
 
@@ -79,9 +53,6 @@ curl --silent "${url}" -o report.xml
 # change return code to generate a error in gitlab-ci if a test is failed
 number_of_fails="$(grep -o "errors=\"[0-9]*\"" report.xml | head -1  | cut -d\" -f2 )"
 
-if [ -n "${ssh_pid}" ];then
-   kill "${ssh_pid}"
-fi
 if [ "${number_of_fails}" -gt "0" ]; then
     exit 1
 fi
-- 
2.20.1



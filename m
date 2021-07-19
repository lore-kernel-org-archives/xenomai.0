From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 2/3] ci: Remove deploy with ssh
Date: Mon, 19 Jul 2021 18:29:48 +0200
Message-Id: <20210719162949.4342-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210719162949.4342-1-Quirin.Gylstorff@siemens.com>
References: <20210719162949.4342-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

We will use AWS S3 deployment for LAVA Build Artifacts. Therefore
remove the Deployment via ssh as the LAVA Lab is now public
available.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml         | 11 +++-----
 scripts/deploy_for_testing.sh | 51 -----------------------------------
 scripts/run-lava-tests.sh     | 37 +++----------------------
 tests/README.md               | 17 +++---------
 4 files changed, 10 insertions(+), 106 deletions(-)
 delete mode 100755 scripts/deploy_for_testing.sh

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 362a636..d80efa1 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -27,29 +27,24 @@ variables:
 default:
   image: ghcr.io/siemens/kas/kas-isar:2.4
 
-# add lavacli to the container and install the ssh keys
-# for the test infrastructure
-.add-lava-ssh-config:
+.add-proxy-config:
   before_script:
     - mkdir -p -m=700 ~/.ssh
     - if [ -n "$https_proxy" ]; then
           echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config;
           chmod 600 ~/.ssh/config;
       fi
-    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
-    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 
 .build:
-  extends: .add-lava-ssh-config
+  extends: .add-proxy-config
   stage: build
   script:
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-    - if [ -z "${USE_S3_BUCKET}" ]; then scripts/deploy_for_testing.sh ${TARGET}; fi
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
-  extends: .add-lava-ssh-config
+  extends: .add-proxy-config
   stage: test
   script:
     - scripts/install-lavacli.sh
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
diff --git a/tests/README.md b/tests/README.md
index e0d50a9..3e17271 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -46,9 +46,9 @@ is used:
                                                                | Target 1 |
                                                             /--|  beagle  |
 +-----------+        +---------+       +---------+    /-----   |  bone    |
-|           |  ssh   | LAVA    |       | LAVA    | ---         +----------+
+|           |        | LAVA    |       | LAVA    | ---         +----------+
 | gitlab-   | ------ | master  |------ | Dis-    | --
-| runner    | tunnel |         |       | patcher | \ \---      +----------+
+| runner    |        |         |       | patcher | \ \---      +----------+
 +-----------+        +---------+       +---------+  \-   \---  | Target 2 |
                                                       \      \-| x86-64   |
                                                        \       |          |
@@ -62,8 +62,7 @@ is used:
 ```
 A test is deployed in the following steps:
 1. gitlab-runner: builds the artifacts
-2. After the build is successful the build artifacts are deployed to the
-   Lava master per scp.
+2. After the build is successful the build artifacts are deployed to a AWS S3 bucket.
 3. The runner sends a lava job description to the LAVA master, who triggers the
 job execution on LAVA Dispatcher.
 
@@ -103,20 +102,10 @@ The following variables are used and set by the ci system:
   - `FTP_PROXY`     : ftp proxy
   - `NO_PROXY`      : no proxy
 
-- SSH settings:
-  - `LAVA_SSH_USER` : ssh user to connect to the LAVA master
-  - `LAVA_SSH_HOST` : ssh host name to connect to the LAVA master
-  - `LAVA_SSH_PORT` : ssh port used for the ssh tunnel
-  - `LAVA_SSH_UPLOAD_KEY`  :  private ssh key to connect to the LAVA master
-  - `LAVA_SSH_KNOWN_HOSTS` : Known hosts to connect via ssh to the host given by `LAVA_SSH_HOST`
-
 - LAVA settings:
   - `LAVA_MASTER_ACCOUNT`  : lava master account name to register lavacli for test execution
   - `LAVA_MASTER_TOKEN`    : token to connect with the lava master
-  - `LAVA_DEPLOY_DIR`    : optional variable to define directory to store the build artifacts
   - `LAVA_ARTIFACTS_URL` : optional variable where to get the artifacts for testing
-  - `LAVA_DEPLOY_DIR`: Directory to deploy the Artifacts in a build. Default /var/lib/lava/artifacts
-  - `LAVA_MASTER_PORT`: PORT to access the LAVA Master
   - `LAVA_MASTER_URL`: URL to the LAVA Master
 
 - General build settings
-- 
2.20.1



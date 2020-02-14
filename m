From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 03/11] scripts: Allow other layers to reuse
 scripts
Date: Fri, 14 Feb 2020 08:32:53 +0100
Message-Id: <20200214073259.1769-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
References: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

- add ssh identity file
- add support for local build
- add variables for IMAGE and DISTRO_NAME to deploy from derived layers
- use sed instead eval to replace placeholders for clarity

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                |  5 +++-
 scripts/deploy_for_testing.sh | 40 ++++++++++++++------------
 scripts/run-lava-tests.sh     | 53 +++++++++++++++++++----------------
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4b3f970..fdc24e1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,6 +20,9 @@ variables:
   no_proxy: "$NO_PROXY"
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
   LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
+  ISAR_IMAGE: demo-image
+  ISAR_DISTRIBUTION: xenomai-demo
+
 default:
   image: kasproject/kas-isar:latest
 
@@ -28,8 +31,8 @@ default:
 .add-lava-ssh-config:
   before_script:
     - mkdir -p -m=700 ~/.ssh
-    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
     - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
+    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
     - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 
 .build:
diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
index f8f71e3..db19e5f 100755
--- a/scripts/deploy_for_testing.sh
+++ b/scripts/deploy_for_testing.sh
@@ -11,37 +11,41 @@
 # SPDX-License-Identifier: MIT
 #
 set -e
-TARGET="$1"
+target="$1"
 
-if [ -z "${TARGET}" ]; then
+if [ -z "${target}" ]; then
     exit -1
 fi
-IMAGES_DIR=build/tmp/deploy/images
+images_dir=build/tmp/deploy/images
 
 if [ -z "${LAVA_SSH_USER}" ] || [ -z "${LAVA_SSH_HOST}" ]  || [ -z "${LAVA_SSH_PORT}" ]; then
     echo "Lava environment not available or incomplete - do not deploy"
     exit 0
 fi
 
-LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
+lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
 
-LAVA_DEPLOY_DIR=${LAVA_DEPLOY_DIR:-"/var/lib/lava/artifacts"}
-DEPLOY_DIR="${LAVA_DEPLOY_DIR}/${CI_PIPELINE_ID}"
-ssh -p ${LAVA_SSH_PORT} ${LAVA_SSH_DESTINATION} 'install -d -m 755 "'${DEPLOY_DIR}'"'
+isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
+lava_deploy_dir="${LAVA_DEPLOY_DIR:-/var/lib/lava/artifacts}"
+deploy_dir="${lava_deploy_dir}/${CI_PIPELINE_ID}"
+lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
+if [ -n "${CI_PIPELINE_ID}" ]; then
+    ssh -p ${LAVA_SSH_PORT} ${lava_identity} ${lava_ssh_destination} 'install -d -m 755 "'${deploy_dir}'"'
+fi
 #KERNEL
-scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-vmlinuz \
-    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
+scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}-vmlinuz \
+    ${lava_ssh_destination}:${deploy_dir}
 # INITRD
-scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-initrd.img \
-    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
+scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}-initrd.img \
+    ${lava_ssh_destination}:${deploy_dir}
 # ROOTFS
-if [ -n ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.*.gz  ]; then
-    gzip ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.*
+if [ -n ${images_dir}/${target}/${isar_base_name}.*.gz  ]; then
+    gzip ${images_dir}/${target}/${isar_base_name}.*
 fi
-scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.* \
-    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
+scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}.* \
+    ${lava_ssh_destination}:${deploy_dir}
 # DTB
-DTB="${IMAGES_DIR}/${TARGET}/*.dtb"
-if [ -e ${DTB} ]; then
-    scp -P ${LAVA_SSH_PORT} ${DTB} ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
+dtb="${images_dir}/${target}/*.dtb"
+if [ -e ${dtb} ]; then
+    scp -P ${LAVA_SSH_PORT} ${lava_identity} ${dtb} ${lava_ssh_destination}:${deploy_dir}
 fi
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 03119f1..59cf14e 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -11,48 +11,53 @@
 #
 set -e
 TARGET=$1
+if [ -z "${TARGET}" ]; then
+    echo "no target was given"
+    exit -1
+fi
 
-LAVA_MASTER_PORT=28080
+lava_master_port="${LAVA_MASTER_PORT:-28080}"
 if [ -n "${LAVA_SSH_PORT}" ]; then
-    LAVA_SSH_PORT="-p ${LAVA_SSH_PORT}"
+    lava_ssh_port="-p ${LAVA_SSH_PORT}"
 fi
-LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
+lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
+lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
 # open connection for ssh port forwarding
-ssh -N ${LAVA_SSH_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_SSH_DESTINATION} &
-SSH_PID=$!
+ssh -N ${lava_ssh_port} ${lava_identity} -o 'LocalForward localhost:'${lava_master_port}' localhost:80' ${lava_ssh_destination} &
+ssh_pid=$!
 # wait for connection
-INTERVAL=1
-TIMEOUT=60
-until ss -tulw | grep -q "${LAVA_MASTER_PORT}"
+interval=1
+timeout=60
+until ss -tulw | grep -q "${lava_master_port}"
 do
-    if [ ${TIMEOUT} -le 0 ]; then
+    if [ ${timeout} -le 0 ]; then
         echo "could not open connection to LAVA Master"
         exit 1
     fi
-    sleep ${INTERVAL}
-    TIMEOUT=$(expr ${TIMEOUT} - ${INTERVAL})
+    sleep ${interval}
+    timeout=$(expr ${timeout} - ${interval})
 done
-LAVA_MASTER_URI=http://localhost:${LAVA_MASTER_PORT}
-
-if [ -z "${TARGET}" ]; then
-    echo "no target was given"
-    exit -1
-fi
-artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
+lava_master_uri=http://localhost:${lava_master_port}
 
 # connect to lava master
-lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${LAVA_MASTER_URI} --username ${LAVA_MASTER_ACCOUNT} default
-
+lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${lava_master_uri} --username ${LAVA_MASTER_ACCOUNT} default
 #generate lava job description from template
+artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
 DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}"
-template=$(cat tests/jobs/xenomai-${TARGET}.yml)
-test_id=$(eval "cat <<EOF ${template}
-EOF" | lavacli jobs submit -)
+job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
+tmp_dir=$(mktemp -d)
+template=${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml
+cp ${job_template_path}-${TARGET}.yml ${template}
+sed -i "s|\${TARGET}|${TARGET}|g" $template
+sed -i "s|\${DEPLOY_URL}|${DEPLOY_URL}|g" $template
+sed -i "s|\${ISAR_IMAGE}|${ISAR_IMAGE}|g" $template
+sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" $template
+test_id=$(lavacli jobs submit ${template})
 lavacli jobs logs ${test_id}
 lavacli results ${test_id}
 # change return code to generate a error in gitlab-ci if a test is failed
 number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l)
-kill ${SSH_PID}
+kill ${ssh_pid}
 if [ "${number_of_fails}" -gt "0" ]; then
     exit 1
 fi
-- 
2.20.1



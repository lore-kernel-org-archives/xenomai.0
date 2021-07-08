From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/4] ci: adapt to public lava-server
Date: Thu,  8 Jul 2021 17:02:59 +0200
Message-Id: <20210708150301.24083-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
References: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
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

Adapt ci scripts to the new lava-server[1].

[1]: https://lava.xenomai.org

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml     |  3 ++-
 scripts/run-lava-tests.sh | 57 ++++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 352e023..96b9c2c 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -22,6 +22,7 @@ variables:
   LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
+  LAVA_TESTS_ENABLED: "true"
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:2.4
@@ -58,7 +59,7 @@ default:
     BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}${TARGET_EXTENSION}"
   only:
     variables:
-      - $LAVA_SSH_USER
+      - $LAVA_TESTS_ENABLED == "true"
 
 .build:qemu-amd64:
   extends: .build
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 764f3a9..e8c7377 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -16,28 +16,36 @@ if [ -z "${TARGET}" ]; then
     exit -1
 fi
 
-lava_master_port="${LAVA_MASTER_PORT:-28080}"
-if [ -n "${LAVA_SSH_PORT}" ]; then
-    lava_ssh_port="-p ${LAVA_SSH_PORT}"
+if [ -n "${LAVA_SSH_HOST}" ]; then
+    echo "use SSH to connect to lava server"
+    # private master with ssh forward access
+    lava_master_port="${LAVA_MASTER_PORT:-28080}"
+    lava_ssh_port="-p ${LAVA_SSH_PORT:-22}"
+    lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
+    lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
+    # open connection for ssh port forwarding
+    ssh -N "${lava_ssh_port}" "${lava_identity}" -o 'LocalForward localhost:'"${lava_master_port}"' localhost:80' "${lava_ssh_destination}" &
+    ssh_pid="$!"
+    # wait for connection
+    interval=1
+    timeout=60
+    until ss -tulw | grep -q "${lava_master_port}"
+    do
+        if [ ${timeout} -le 0 ]; then
+            echo "could not open connection to LAVA Master"
+            exit 1
+        fi
+        sleep ${interval}
+        timeout=$(( timeout - interval ))
+    done
+    artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
+    lava_master_uri="${LAVA_MASTER_URL:-http://localhost}:${lava_master_port}"
+else
+    # S3 artifacts
+    artifact_url="${LAVA_ARTIFACTS_URL:-https://xenomai-images-artifacts.s3.eu-central-1.amazonaws.com/artifacts}"
+    # public master
+    lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org}"
 fi
-lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
-lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
-# open connection for ssh port forwarding
-ssh -N ${lava_ssh_port} ${lava_identity} -o 'LocalForward localhost:'${lava_master_port}' localhost:80' ${lava_ssh_destination} &
-ssh_pid=$!
-# wait for connection
-interval=1
-timeout=60
-until ss -tulw | grep -q "${lava_master_port}"
-do
-    if [ ${timeout} -le 0 ]; then
-        echo "could not open connection to LAVA Master"
-        exit 1
-    fi
-    sleep ${interval}
-    timeout=$(expr ${timeout} - ${interval})
-done
-lava_master_uri=${LAVA_MASTER_URL:-http://localhost}:${lava_master_port}
 
 # connect to lava master
 lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${lava_master_uri} --username ${LAVA_MASTER_ACCOUNT} default
@@ -45,7 +53,6 @@ lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${lava_master_uri} --u
 if [ -n "${USE_GITLAB_ARTIFACTS}" ]; then
     DEPLOY_URL="${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/jobs/${BUILD_JOB_ID}/artifacts/build/tmp/deploy/images/${TARGET}"
 else
-    artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
     DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
 fi
 job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
@@ -61,8 +68,10 @@ test_id=$(lavacli jobs submit ${template})
 lavacli jobs logs ${test_id}
 lavacli results ${test_id}
 # change return code to generate a error in gitlab-ci if a test is failed
-number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l)
-kill ${ssh_pid}
+number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l )
+if [ -n "${ssh_pid}" ];then
+   kill "${ssh_pid}"
+fi
 if [ "${number_of_fails}" -gt "0" ]; then
     exit 1
 fi
-- 
2.20.1



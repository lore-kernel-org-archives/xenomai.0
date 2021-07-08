From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/4] scripts/run_lava_tests.sh: cleanup
 shellcheck warnings
Date: Thu,  8 Jul 2021 17:03:00 +0200
Message-Id: <20210708150301.24083-4-Quirin.Gylstorff@siemens.com>
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

Add missing quotes and simplify statements.
Also add messages to indicate progress.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index e8c7377..72138c3 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -9,11 +9,10 @@
 #
 # SPDX-License-Identifier: MIT
 #
-set -e
 TARGET=$1
 if [ -z "${TARGET}" ]; then
     echo "no target was given"
-    exit -1
+    exit 1
 fi
 
 if [ -n "${LAVA_SSH_HOST}" ]; then
@@ -24,7 +23,7 @@ if [ -n "${LAVA_SSH_HOST}" ]; then
     lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
     lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
     # open connection for ssh port forwarding
-    ssh -N "${lava_ssh_port}" "${lava_identity}" -o 'LocalForward localhost:'"${lava_master_port}"' localhost:80' "${lava_ssh_destination}" &
+    ssh -N ${lava_ssh_port} ${lava_identity} -o 'LocalForward localhost:'${lava_master_port}' localhost:80' ${lava_ssh_destination} &
     ssh_pid="$!"
     # wait for connection
     interval=1
@@ -47,28 +46,36 @@ else
     lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org}"
 fi
 
+echo "connect to lava server: ${lava_master_uri}"
+
 # connect to lava master
-lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${lava_master_uri} --username ${LAVA_MASTER_ACCOUNT} default
+lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}" --username "${LAVA_MASTER_ACCOUNT}" default
 #generate lava job description from template
 if [ -n "${USE_GITLAB_ARTIFACTS}" ]; then
     DEPLOY_URL="${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/jobs/${BUILD_JOB_ID}/artifacts/build/tmp/deploy/images/${TARGET}"
 else
     DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
 fi
+
+echo "Deploy artifacts from '${artifact_url}'"
+
 job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
 tmp_dir=$(mktemp -d)
-template=${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml
-cp ${job_template_path}-${TARGET}.yml ${template}
-sed -i "s|\${TARGET}|${TARGET}|g" $template
-sed -i "s|\${BUILD_ARCH}|${BUILD_ARCH}|g" $template
-sed -i "s|\${DEPLOY_URL}|${DEPLOY_URL}|g" $template
-sed -i "s|\${ISAR_IMAGE}|${ISAR_IMAGE}|g" $template
-sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" $template
-test_id=$(lavacli jobs submit ${template})
-lavacli jobs logs ${test_id}
-lavacli results ${test_id}
+template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
+cp "${job_template_path}-${TARGET}.yml" "${template}"
+sed -i "s|\${TARGET}|${TARGET}|g" "$template"
+sed -i "s|\${BUILD_ARCH}|${BUILD_ARCH}|g" "$template"
+sed -i "s|\${DEPLOY_URL}|${DEPLOY_URL}|g" "$template"
+sed -i "s|\${ISAR_IMAGE}|${ISAR_IMAGE}|g" "$template"
+sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" "$template"
+
+echo "submit lava job"
+
+test_id=$(lavacli jobs submit "${template}")
+lavacli jobs logs "${test_id}"
+lavacli results "${test_id}"
 # change return code to generate a error in gitlab-ci if a test is failed
-number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l )
+number_of_fails="$(lavacli results "${test_id}" | grep -c fail )"
 if [ -n "${ssh_pid}" ];then
    kill "${ssh_pid}"
 fi
-- 
2.20.1



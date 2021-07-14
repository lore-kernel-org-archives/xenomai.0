From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 3/4] scripts/run-lava-tests: replace sed
 with envsubst
Date: Wed, 14 Jul 2021 09:41:54 +0200
Message-Id: <20210714074155.2625-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
References: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
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

This patch incorporates a comment from the mailing list[1].

It simplifies the script.

[1]: https://xenomai.org/pipermail/xenomai/2021-July/045830.html

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index e398afd..44e02fc 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -50,24 +50,22 @@ echo "connect to lava server: ${lava_master_uri}"
 
 # connect to lava master
 lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}" --username "${LAVA_MASTER_ACCOUNT}" default
+
 #generate lava job description from template
 if [ -n "${USE_GITLAB_ARTIFACTS}" ]; then
     DEPLOY_URL="${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/jobs/${BUILD_JOB_ID}/artifacts/build/tmp/deploy/images/${TARGET}"
 else
     DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
 fi
-
+export DEPLOY_URL
 echo "Deploy artifacts from '${artifact_url}'"
 
 job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
 tmp_dir=$(mktemp -d)
 template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
-cp "${job_template_path}-${TARGET}.yml" "${template}"
-sed -i "s|\${TARGET}|${TARGET}|g" "$template"
-sed -i "s|\${BUILD_ARCH}|${BUILD_ARCH}|g" "$template"
-sed -i "s|\${DEPLOY_URL}|${DEPLOY_URL}|g" "$template"
-sed -i "s|\${ISAR_IMAGE}|${ISAR_IMAGE}|g" "$template"
-sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" "$template"
+
+cat "${job_template_path}-${TARGET}.yml" | envsubst > "$template"
+
 
 echo "submit lava job"
 
-- 
2.20.1



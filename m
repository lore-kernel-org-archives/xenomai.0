From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v4 3/8] ci: Drop JOB_TEMPLATE_PATH variable
Date: Fri, 7 Jan 2022 16:02:58 +0100
Message-ID: <e106154ed8c230594e003457d114afc29a7a377e.1641567783.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641567783.git.jan.kiszka@siemens.com>
References: <cover.1641567783.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

That's an interface without a real use case. Dropping it makes live
easier for users that want to understand the setup.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/run-lava-tests.sh | 3 +--
 tests/README.md           | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index c090d83..30a853f 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -32,11 +32,10 @@ export DEPLOY_URL
 
 echo "Deploy artifacts from '${artifact_url}'"
 
-job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
 tmp_dir=$(mktemp -d)
 template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
 
-cat "${job_template_path}-${TARGET}.yml" | envsubst > "$template"
+cat "tests/jobs/xenomai-${TARGET}.yml" | envsubst > "$template"
 
 echo "submit lava job"
 
diff --git a/tests/README.md b/tests/README.md
index 3e17271..24ffb81 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -111,7 +111,6 @@ The following variables are used and set by the ci system:
 - General build settings
   - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
   - `DEPLOY_DIR_EXTENSION`: Extension path to store artifacts for the same target
-  - `JOB_TEMPLATE_PATH`: Path to the test templates - Default tests/jobs/xenomai
   - `TARGET_EXTENSION`: Extension of the build job name
 
 ## LAVA Template variable
-- 
2.31.1



From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 05/11] ci: Add linux-4.4 build and tests
Date: Fri, 14 Feb 2020 08:32:55 +0100
Message-Id: <20200214073259.1769-6-Quirin.Gylstorff@siemens.com>
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

Add a new CI variable DEPLOY_DIR_EXTENSION to differ
between kernel builds for the same target as the kernel
version is not visibly before bootup

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                | 31 ++++++++++++++++++++++++++++++-
 scripts/deploy_for_testing.sh |  4 ++--
 scripts/run-lava-tests.sh     |  4 ++--
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fdc24e1..b8dbbc5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2019 - 2020
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -122,3 +122,32 @@ lava-test:board-x86-64-efi:
   extends: .test
   variables:
     TARGET: x86-64
+
+build:qemu-amd64:linux-4.4:
+  extends: .build
+  variables:
+    TARGET: qemu-amd64
+    LINUX_BUILD_OPTION: ":opt-linux-4.4.yml"
+    DEPLOY_DIR_EXTENSION: "4.4"
+
+lava-test:qemu-amd64:linux-4.4:
+  needs: [ "build:qemu-amd64:linux-4.4" ]
+  extends: .test
+  variables:
+    TARGET: qemu-amd64
+    DEPLOY_DIR_EXTENSION: "4.4"
+
+build:board-x86-64-efi:linux-4.4:
+  extends: .build
+  variables:
+    TARGET: x86-64-efi
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+    LINUX_BUILD_OPTION: ":opt-linux-4.4.yml"
+    DEPLOY_DIR_EXTENSION: "4.4"
+
+lava-test:board-x86-64-efi:linux-4.4:
+  needs: [ "build:board-x86-64-efi:linux-4.4" ]
+  extends: .test
+  variables:
+    TARGET: x86-64
+    DEPLOY_DIR_EXTENSION: "4.4"
diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
index db19e5f..b3d565f 100755
--- a/scripts/deploy_for_testing.sh
+++ b/scripts/deploy_for_testing.sh
@@ -3,7 +3,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2020
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -27,7 +27,7 @@ lava_ssh_destination="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
 
 isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
 lava_deploy_dir="${LAVA_DEPLOY_DIR:-/var/lib/lava/artifacts}"
-deploy_dir="${lava_deploy_dir}/${CI_PIPELINE_ID}"
+deploy_dir="${lava_deploy_dir}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
 lava_identity="-i ${LAVA_SSH_KEY_PATH:-~/.ssh/lava_id_rsa}"
 if [ -n "${CI_PIPELINE_ID}" ]; then
     ssh -p ${LAVA_SSH_PORT} ${lava_identity} ${lava_ssh_destination} 'install -d -m 755 "'${deploy_dir}'"'
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 59cf14e..e02385a 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -2,7 +2,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2020
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -43,7 +43,7 @@ lava_master_uri=http://localhost:${lava_master_port}
 lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${lava_master_uri} --username ${LAVA_MASTER_ACCOUNT} default
 #generate lava job description from template
 artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
-DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}"
+DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
 job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
 tmp_dir=$(mktemp -d)
 template=${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml
-- 
2.20.1



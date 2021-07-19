From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 1/3] ci: Remove artifact deployment
Date: Mon, 19 Jul 2021 18:29:47 +0200
Message-Id: <20210719162949.4342-2-Quirin.Gylstorff@siemens.com>
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

We will use AWS S3 deployment for LAVA CI Artifacts. Therefore
remove the Deployment via gitlab artifacts as the LAVA Lab is now public
available.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci-artifacts.yml            | 13 -----------
 .gitlab-ci.yml                      | 30 +++++++++++++++++++++++--
 ci/artifacts.yml                    | 20 -----------------
 ci/child_pipelines_artifacts.yml    | 34 -----------------------------
 ci/child_pipelines_common.yml       |  9 --------
 ci/child_pipelines_no_artifacts.yml | 34 -----------------------------
 ci/gitlab-ci-base.yml               |  5 ++---
 ci/no-artifacts.yml                 | 13 -----------
 scripts/get-build-id.sh             | 34 -----------------------------
 scripts/run-lava-tests.sh           |  8 ++-----
 10 files changed, 32 insertions(+), 168 deletions(-)
 delete mode 100644 .gitlab-ci-artifacts.yml
 delete mode 100644 ci/artifacts.yml
 delete mode 100644 ci/child_pipelines_artifacts.yml
 delete mode 100644 ci/child_pipelines_no_artifacts.yml
 delete mode 100644 ci/no-artifacts.yml
 delete mode 100755 scripts/get-build-id.sh

diff --git a/.gitlab-ci-artifacts.yml b/.gitlab-ci-artifacts.yml
deleted file mode 100644
index 85345b8..0000000
--- a/.gitlab-ci-artifacts.yml
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-include:
-  - local: '/ci/child_pipelines_artifacts.yml'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a808859..c1eb0b3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,5 +9,31 @@
 # SPDX-License-Identifier: MIT
 #
 
-include:
-  - local: '/ci/child_pipelines_no_artifacts.yml'
+stages:
+  - parent
+
+.parent:
+  stage: parent
+  trigger:
+    strategy: depend
+  rules:
+    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME'
+
+
+stable/v3.0.x:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_0_x.yml'
+
+stable/v3.1.x:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_1_x.yml'
+
+next:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_next.yml'
diff --git a/ci/artifacts.yml b/ci/artifacts.yml
deleted file mode 100644
index ba851cf..0000000
--- a/ci/artifacts.yml
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-variables:
-  USE_GITLAB_ARTIFACTS: "true"
-
-.build:
-  extends: .build-base
-  artifacts:
-    paths:
-    - build/tmp/deploy/images/${TARGET}/
-    expire_in: 1 week
diff --git a/ci/child_pipelines_artifacts.yml b/ci/child_pipelines_artifacts.yml
deleted file mode 100644
index 1dd856c..0000000
--- a/ci/child_pipelines_artifacts.yml
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-include:
-  - local: '/ci/child_pipelines_common.yml'
-
-stable/v3.0.x:
-  extends: .parent
-  trigger:
-    include:
-      - local: '/ci/artifacts.yml'
-      - local: '/ci/xenomai_3_0_x.yml'
-
-stable/v3.1.x:
-  extends: .parent
-  trigger:
-    include:
-      - local: '/ci/artifacts.yml'
-      - local: '/ci/xenomai_3_1_x.yml'
-
-next:
-  extends: .parent
-  trigger:
-    include:
-      - local: '/ci/artifacts.yml'
-      - local: '/ci/xenomai_next.yml'
diff --git a/ci/child_pipelines_common.yml b/ci/child_pipelines_common.yml
index a96a81f..eee53f3 100644
--- a/ci/child_pipelines_common.yml
+++ b/ci/child_pipelines_common.yml
@@ -10,12 +10,3 @@
 # SPDX-License-Identifier: MIT
 #
 
-stages:
-  - parent
-
-.parent:
-  stage: parent
-  trigger:
-    strategy: depend
-  rules:
-    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME'
diff --git a/ci/child_pipelines_no_artifacts.yml b/ci/child_pipelines_no_artifacts.yml
deleted file mode 100644
index c90204d..0000000
--- a/ci/child_pipelines_no_artifacts.yml
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-include:
-  - local: '/ci/child_pipelines_common.yml'
-
-stable/v3.0.x:
-  extends: .parent
-  trigger:
-    include:
-      - local: '/ci/no-artifacts.yml'
-      - local: '/ci/xenomai_3_0_x.yml'
-
-stable/v3.1.x:
-  extends: .parent
-  trigger:
-    include:
-      - local: '/ci/no-artifacts.yml'
-      - local: '/ci/xenomai_3_1_x.yml'
-
-next:
-  extends: .parent
-  trigger:
-    include:
-      - local: '/ci/no-artifacts.yml'
-      - local: '/ci/xenomai_next.yml'
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 7f245e3..362a636 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -39,13 +39,13 @@ default:
     - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
     - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 
-.build-base:
+.build:
   extends: .add-lava-ssh-config
   stage: build
   script:
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-    - if [ -z "${USE_GITLAB_ARTIFACTS}" -a -z "${USE_S3_BUCKET}" ]; then scripts/deploy_for_testing.sh ${TARGET}; fi
+    - if [ -z "${USE_S3_BUCKET}" ]; then scripts/deploy_for_testing.sh ${TARGET}; fi
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
@@ -53,7 +53,6 @@ default:
   stage: test
   script:
     - scripts/install-lavacli.sh
-    - export BUILD_JOB_ID=$(scripts/get-build-id.sh ${BUILD_JOB_NAME})
     - scripts/run-lava-tests.sh ${TARGET}
   variables:
     BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}${TARGET_EXTENSION}"
diff --git a/ci/no-artifacts.yml b/ci/no-artifacts.yml
deleted file mode 100644
index a820f89..0000000
--- a/ci/no-artifacts.yml
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019 - 2021
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-.build:
-  extends: .build-base
diff --git a/scripts/get-build-id.sh b/scripts/get-build-id.sh
deleted file mode 100755
index 1a0dcaa..0000000
--- a/scripts/get-build-id.sh
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2020
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-name=$1
-if [ -z "${name}" ]; then
-    echo "no build name was given"
-    exit -1
-fi
-index=0
-JSON=$(curl -s --header "PRIVATE-TOKEN: ${API_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/pipelines/${CI_PIPELINE_ID}/jobs?scope[]=success"  )
-while build_name=$(echo "${JSON}" | tr '\r\n' ' ' | jq -re ".[${index}].name")
-do
-    if [ "${build_name}" = "${name}" ]; then
-        break
-    fi
-     index=$((index+1))
-done
-id=$(echo "${JSON}"  | tr '\r\n' ' ' | jq -r ".[${index}].id")
-if [ "$id" = "null" ]; then
-    >&2 echo "ERROR: did not find build with name: $name"
-    return 1
-else
-    echo $id
-    return 0
-fi
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 7972279..13fac31 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -52,12 +52,9 @@ echo "connect to lava server: ${lava_master_uri}"
 lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}" --username "${LAVA_MASTER_ACCOUNT}" default
 
 #generate lava job description from template
-if [ -n "${USE_GITLAB_ARTIFACTS}" ]; then
-    DEPLOY_URL="${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/jobs/${BUILD_JOB_ID}/artifacts/build/tmp/deploy/images/${TARGET}"
-else
-    DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
-fi
+DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
 export DEPLOY_URL
+
 echo "Deploy artifacts from '${artifact_url}'"
 
 job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
@@ -66,7 +63,6 @@ template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
 
 cat "${job_template_path}-${TARGET}.yml" | envsubst > "$template"
 
-
 echo "submit lava job"
 
 test_id=$(lavacli jobs submit "${template}")
-- 
2.20.1



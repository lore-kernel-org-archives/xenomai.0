From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 6/9] ci: Consolidate artifacts/no-artifacts
 case
Date: Wed, 12 May 2021 10:32:20 +0200
Message-Id: <52d70d76b72cbd619ed991f29f8b80bc3f866a0d.1620808343.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620808343.git.jan.kiszka@siemens.com>
References: <cover.1620808343.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

By checking for USE_GITLAB_ARTIFACTS, we can share the scripts section.
This leaves the variation to the addition of artifacts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/artifacts.yml      | 6 +-----
 ci/gitlab-ci-base.yml | 8 ++++++++
 ci/no-artifacts.yml   | 7 +------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/ci/artifacts.yml b/ci/artifacts.yml
index d75559a..ba851cf 100644
--- a/ci/artifacts.yml
+++ b/ci/artifacts.yml
@@ -13,11 +13,7 @@ variables:
   USE_GITLAB_ARTIFACTS: "true"
 
 .build:
-  extends: .add-lava-ssh-config
-  stage: build
-  script:
-    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+  extends: .build-base
   artifacts:
     paths:
     - build/tmp/deploy/images/${TARGET}/
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 839f6ea..8adc505 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -38,6 +38,14 @@ default:
     - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
     - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 
+.build-base:
+  extends: .add-lava-ssh-config
+  stage: build
+  script:
+    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+    - if [ -z "${USE_GITLAB_ARTIFACTS}" ]; then scripts/deploy_for_testing.sh ${TARGET}; fi
+
 .test:
   extends: .add-lava-ssh-config
   stage: test
diff --git a/ci/no-artifacts.yml b/ci/no-artifacts.yml
index e652a03..a820f89 100644
--- a/ci/no-artifacts.yml
+++ b/ci/no-artifacts.yml
@@ -10,9 +10,4 @@
 #
 
 .build:
-  extends: .add-lava-ssh-config
-  stage: build
-  script:
-    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh ${TARGET}
+  extends: .build-base
-- 
2.26.2



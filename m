From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 3/8] kas: Introduce kas option file for CI
 builds
Date: Wed, 13 Oct 2021 14:17:27 +0200
Message-Id: <20211013121732.140595-4-florian.bezdeka@siemens.com>
In-Reply-To: <20211013121732.140595-1-florian.bezdeka@siemens.com>
References: <20211013121732.140595-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

For now the difference between the demo and the "ci image" is the
removed sshd-regen-keys. That reduces the (first) boot time especially
on low end CI hardware. Helps to stay within LAVA timeouts.

CI builds will now use that file.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/gitlab-ci-base.yml |  4 ++--
 opt-ci.yml            | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 opt-ci.yml

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 3ea2467..f7cdea5 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -39,8 +39,8 @@ default:
   stage: build
   script:
     - sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
-    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml"
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml
+    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml:opt-ci.yml"
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml:opt-ci.yml
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
diff --git a/opt-ci.yml b/opt-ci.yml
new file mode 100644
index 0000000..08400cc
--- /dev/null
+++ b/opt-ci.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  xenomai-ci: |
+    ROOTFS_POSTPROCESS_COMMAND_remove = "image_postprocess_sshd_key_regen"
+    IMAGE_INSTALL_remove += "sshd-regen-keys"
\ No newline at end of file
-- 
2.31.1



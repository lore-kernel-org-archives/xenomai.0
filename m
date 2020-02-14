From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 11/11] ci: Add target ipc227e for testing 4.4
Date: Fri, 14 Feb 2020 09:28:26 +0100
Message-Id: <20200214082826.23337-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214082826.23337-1-Quirin.Gylstorff@siemens.com>
References: <20200214082826.23337-1-Quirin.Gylstorff@siemens.com>
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

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                             |  4 +-
 recipes-kernel/linux/files/amd64_defconfig |  3 +-
 scripts/run-lava-tests.sh                  |  1 +
 tests/jobs/xenomai-ipc227e.yml             | 74 ++++++++++++++++++++++
 4 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 tests/jobs/xenomai-ipc227e.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 608d5db..a783a6b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -145,7 +145,7 @@ lava-test:board-x86-64-efi:linux-4.4:
   needs: [ "build:board-x86-64-efi:linux-4.4" ]
   extends: .test
   variables:
-    TARGET: x86-64
+    TARGET: ipc227e
     DEPLOY_DIR_EXTENSION: "4.4"
 
 build:board-beaglebone:xenomai-3.0.x:
@@ -175,5 +175,5 @@ lava-test:board-x86-64-efi:xenomai-3.0.x:
   needs: [ "build:board-x86-64-efi:xenomai-3.0.x" ]
   extends: .test
   variables:
-    TARGET: x86-64
+    TARGET: ipc227e
     DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index 9faed52..bc5cd0b 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -1891,7 +1891,8 @@ CONFIG_NET_VENDOR_INTEL=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_E1000E_HWTS=y
-# CONFIG_IGB is not set
+CONFIG_IGB=y
+CONFIG_IGB_HWMON=y
 # CONFIG_IGBVF is not set
 # CONFIG_IXGB is not set
 # CONFIG_IXGBE is not set
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index e02385a..1f502c4 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -49,6 +49,7 @@ tmp_dir=$(mktemp -d)
 template=${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml
 cp ${job_template_path}-${TARGET}.yml ${template}
 sed -i "s|\${TARGET}|${TARGET}|g" $template
+sed -i "s|\${BUILD_ARCH}|${BUILD_ARCH}|g" $template
 sed -i "s|\${DEPLOY_URL}|${DEPLOY_URL}|g" $template
 sed -i "s|\${ISAR_IMAGE}|${ISAR_IMAGE}|g" $template
 sed -i "s|\${ISAR_DISTRIBUTION}|${ISAR_DISTRIBUTION}|g" $template
diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
new file mode 100644
index 0000000..e5a2f35
--- /dev/null
+++ b/tests/jobs/xenomai-ipc227e.yml
@@ -0,0 +1,74 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+job_name: xenomai-test-suite
+device_type: ipc227e
+
+timeouts:
+  job:
+    minutes: 30
+  action:
+    minutes: 20
+  connection:
+    minutes: 2
+priority: medium
+visibility: public
+
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-cof
+  docs-filename: pipeline-xenomai-cof
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tftp
+    kernel:
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      type: bzimage
+    ramdisk:
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      compression: gz
+    nfsrootfs:
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      compression: gz
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 5
+    method: ipxe
+    commands: nfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    timeout:
+      minutes: 30
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
-- 
2.20.1



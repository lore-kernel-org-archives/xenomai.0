From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images 1/2] tests: remove unused test job
Date: Mon, 28 Jun 2021 02:26:23 -0400
Message-Id: <20210628062624.2244-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

Delete minnow test job that does not run anymore.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
deleted file mode 100644
index d5292ff..0000000
--- a/tests/jobs/xenomai-minnow.yml
+++ /dev/null
@@ -1,73 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-job_name: xenomai-test-suite
-device_type: minnowboard-max-E3825
-timeouts:
-  job:
-    minutes: 90
-  action:
-    minutes: 65
-  connection:
-    minutes: 5
-priority: medium
-visibility: public
-
-metadata:
-  # please change these fields when modifying this job for your own tests.
-  docs-source: xenomai-cof
-  docs-filename: pipeline-xenomai-cof
-# ACTION_BLOCK
-actions:
-- deploy:
-    timeout:
-      minutes: 15
-    to: tftp
-    kernel:
-      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
-      type: bzimage
-    ramdisk:
-      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
-      compression: gz
-    nfsrootfs:
-      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
-      compression: gz
-# BOOT_BLOCK
-- boot:
-    timeout:
-      minutes: 5
-    method: grub
-    commands: nfs
-    prompts: ["root@demo:"]
-    auto_login:
-      login_prompt: 'demo login:'
-      username: root
-      password_prompt: 'Password:'
-      password: root
-
-- test:
-    timeout:
-      minutes: 30
-    definitions:
-    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
-      from: git
-      path: lava-test-shell/smoke-tests-basic.yaml
-      name: smoke-tests
-    - repository:
-        metadata:
-          format: Lava-Test Test Definition 1.0
-          name: xenomai-test-suite
-          description: "runs the xenomai test suite"
-        run:
-          steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
-      from: inline
-      path: inline/xenomai-test-suite.yaml
-      name: xenomai-test-suite
-- 
2.17.1



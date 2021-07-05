From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] tests: Remove another unused job description
Message-ID: <e5a72ca4-b003-a091-e586-1084350d11c4@siemens.com>
Date: Mon, 5 Jul 2021 20:02:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Covered by xenomai-x86-64-efi.yml in practice.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/jobs/xenomai-ipc227e.yml | 76 ----------------------------------
 1 file changed, 76 deletions(-)
 delete mode 100644 tests/jobs/xenomai-ipc227e.yml

diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
deleted file mode 100644
index 131415a..0000000
--- a/tests/jobs/xenomai-ipc227e.yml
+++ /dev/null
@@ -1,76 +0,0 @@
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
-device_type: ipc227e
-
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
-    method: ipxe
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
-context:
-  extra_kernel_args: xenomai.supported_cpus=0x7
-- 
2.26.2


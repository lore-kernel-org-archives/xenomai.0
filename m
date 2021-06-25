From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images PATCH V2] tests: restrict realtime cpu
Date: Thu, 24 Jun 2021 22:09:11 -0400
Message-Id: <20210625020911.12444-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

1. If there is no CPU restriction on the bootargs, smokey cpu_affinity
test would be skipped reporting with "no kernel support" for those
without non-RT cpu.
2. delete unused test job.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 034ac99..8117f29 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -71,3 +71,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index f6eb4a4..a439379 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -70,3 +70,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=127
diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
index a5a181c..209c5d4 100644
--- a/tests/jobs/xenomai-ipc227e.yml
+++ b/tests/jobs/xenomai-ipc227e.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=7
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
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index c335292..b35a1a5 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -87,3 +87,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 88fb880..27418ff 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -93,3 +93,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 3e3a8ab..14501b7 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -87,3 +87,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index bc71b75..d1418c1 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=7
-- 
2.17.1



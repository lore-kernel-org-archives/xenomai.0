From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 4/9] kas: Use next as target
Date: Tue, 10 Sep 2019 16:44:54 +0200
Message-Id: <20190910144459.13239-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
References: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
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

For CI testing of the next branch.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml |  6 +++---
 opt-latest.yml | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 opt-latest.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ace8862..0e1d21a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -85,14 +85,14 @@ lava-test:qemu-arm64:
 build:board-hikey:
   stage: build
   script:
-    - kas build kas.yml:board-hikey.yml
+    - kas build kas.yml:board-hikey.yml:opt-latest.yml
 # hikey is currently not part of the testlab
 
 build:board-beaglebone:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-beagle-bone-black.yml:opt-lava-test.yml
+    - kas build kas.yml:board-beagle-bone-black.yml:opt-latest.yml:opt-lava-test.yml
     - scripts/deploy_for_testing.sh beagle-bone-black
 
 lava-test:board-beaglebone:
@@ -109,7 +109,7 @@ build:board-x86-64-efi:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-x86-64-efi.yml:opt-lava-test.yml
+    - kas build kas.yml:board-x86-64-efi.yml:opt-latest.yml:opt-lava-test.yml
     - scripts/deploy_for_testing.sh x86-64-efi
 
 lava-test:board-x86-64-efi:
diff --git a/opt-latest.yml b/opt-latest.yml
new file mode 100644
index 0000000..94381bd
--- /dev/null
+++ b/opt-latest.yml
@@ -0,0 +1,20 @@
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
+
+header:
+  version: 8
+
+# lava uses nfs to deploy the image. For this we need a tarball instead of
+# full image
+
+local_conf_header:
+  xenomai-latest: |
+    PREFERRED_VERSION_xenomai = "next"
-- 
2.20.1



From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 4/4] tests: increase timeouts
Date: Wed,  4 Nov 2020 17:11:54 +0100
Message-Id: <20201104161154.32366-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
References: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
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

Increase the LAVA test timeouts to avoid test aborts due to slow
connections

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/jobs/xenomai-beagle-bone-black.yml | 8 ++++----
 tests/jobs/xenomai-hikey.yml             | 6 +++---
 tests/jobs/xenomai-ipc227e.yml           | 8 ++++----
 tests/jobs/xenomai-minnow.yml            | 8 ++++----
 tests/jobs/xenomai-qemu-amd64.yml        | 8 ++++----
 tests/jobs/xenomai-qemu-arm64.yml        | 8 ++++----
 tests/jobs/xenomai-qemu-armhf.yml        | 8 ++++----
 tests/jobs/xenomai-x86-64-efi.yml        | 8 ++++----
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 91cb138..034ac99 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -13,11 +13,11 @@ device_type: beaglebone-black
 
 timeouts:
   job:
-    minutes: 30
+    minutes: 90
   action:
-    minutes: 20
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
@@ -29,7 +29,7 @@ metadata:
 actions:
 - deploy:
     timeout:
-      minutes: 5
+      minutes: 15
     to: tftp
     kernel:
       url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index b33cef6..f6eb4a4 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -13,11 +13,11 @@ device_type: hikey
 
 timeouts:
   job:
-    minutes: 30
+    minutes: 90
   action:
-    minutes: 20
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
index d283c00..a5a181c 100644
--- a/tests/jobs/xenomai-ipc227e.yml
+++ b/tests/jobs/xenomai-ipc227e.yml
@@ -13,11 +13,11 @@ device_type: ipc227e
 
 timeouts:
   job:
-    minutes: 30
+    minutes: 90
   action:
-    minutes: 20
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
@@ -29,7 +29,7 @@ metadata:
 actions:
 - deploy:
     timeout:
-      minutes: 5
+      minutes: 15
     to: tftp
     kernel:
       url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
index 82c1468..d5292ff 100644
--- a/tests/jobs/xenomai-minnow.yml
+++ b/tests/jobs/xenomai-minnow.yml
@@ -12,11 +12,11 @@ job_name: xenomai-test-suite
 device_type: minnowboard-max-E3825
 timeouts:
   job:
-    minutes: 30
+    minutes: 90
   action:
-    minutes: 20
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
@@ -28,7 +28,7 @@ metadata:
 actions:
 - deploy:
     timeout:
-      minutes: 5
+      minutes: 15
     to: tftp
     kernel:
       url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 68d849f..c335292 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -13,11 +13,11 @@ job_name: QEMU pipeline, xenomai-images-qemu-amd64
 
 timeouts:
   job:
-    minutes: 45
+    minutes: 90
   action:
-    minutes: 5
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
@@ -42,7 +42,7 @@ metadata:
 actions:
 - deploy:
     timeout:
-      minutes: 5
+      minutes: 15
     to: tmpfs
     images:
       kernel:
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index cd0ca9f..88fb880 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -13,11 +13,11 @@ job_name: QEMU pipeline, xenomai-images-qemu-arm64
 
 timeouts:
   job:
-    minutes: 45
+    minutes: 90
   action:
-    minutes: 5
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
@@ -46,7 +46,7 @@ metadata:
 actions:
 - deploy:
     timeout:
-      minutes: 5
+      minutes: 15
     to: tmpfs
     images:
       kernel:
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 18e3bf8..3e3a8ab 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -13,11 +13,11 @@ job_name: QEMU pipeline, xenomai-images-qemu-armhf
 
 timeouts:
   job:
-    minutes: 45
+    minutes: 90
   action:
-    minutes: 5
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
@@ -42,7 +42,7 @@ metadata:
 actions:
 - deploy:
     timeout:
-      minutes: 5
+      minutes: 15
     to: tmpfs
     images:
       kernel:
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index 2471cce..bc71b75 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -13,11 +13,11 @@ device_type: x86
 
 timeouts:
   job:
-    minutes: 30
+    minutes: 90
   action:
-    minutes: 20
+    minutes: 65
   connection:
-    minutes: 2
+    minutes: 5
 priority: medium
 visibility: public
 
@@ -29,7 +29,7 @@ metadata:
 actions:
 - deploy:
     timeout:
-      minutes: 5
+      minutes: 15
     to: tftp
     kernel:
       url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
-- 
2.20.1



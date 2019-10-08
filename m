From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/3] ci: Allow empty Build options
Date: Tue,  8 Oct 2019 15:14:41 +0200
Message-Id: <20191008131442.21295-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191008131442.21295-1-Quirin.Gylstorff@siemens.com>
References: <20191008131442.21295-1-Quirin.Gylstorff@siemens.com>
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

Move seperator into variable to allow empty build options.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7de99ee..0974548 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,7 +18,7 @@ variables:
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
-  BUILD_OPTIONS: "opt-xenomai-next.yml"
+  BUILD_OPTIONS: ":opt-xenomai-next.yml"
 default:
   image: kasproject/kas-isar:latest
 
@@ -34,7 +34,7 @@ build:qemu-amd64:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-qemu-amd64.yml:${BUILD_OPTIONS}
+    - kas build kas.yml:board-qemu-amd64.yml${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh qemu-amd64
 
 lava-test:qemu-amd64:
@@ -52,7 +52,7 @@ build:qemu-armhf:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-qemu-armhf.yml:${BUILD_OPTIONS}
+    - kas build kas.yml:board-qemu-armhf.yml${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh qemu-armhf
 
 lava-test:qemu-armhf:
@@ -70,7 +70,7 @@ build:qemu-arm64:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-qemu-arm64.yml:${BUILD_OPTIONS}
+    - kas build kas.yml:board-qemu-arm64.yml${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh qemu-arm64
 
 lava-test:qemu-arm64:
@@ -88,7 +88,7 @@ build:board-hikey:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-hikey.yml:opt-lava-test.yml:${BUILD_OPTIONS}
+    - kas build kas.yml:board-hikey.yml:opt-lava-test.yml${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh hikey
 # hikey is currently not part of the testlab
 
@@ -96,7 +96,7 @@ build:board-beaglebone:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-beagle-bone-black.yml:opt-lava-test.yml:${BUILD_OPTIONS}
+    - kas build kas.yml:board-beagle-bone-black.yml:opt-lava-test.yml${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh beagle-bone-black
 
 lava-test:board-beaglebone:
@@ -114,7 +114,7 @@ build:board-x86-64-efi:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-x86-64-efi.yml:opt-lava-test.yml:${BUILD_OPTIONS}
+    - kas build kas.yml:board-x86-64-efi.yml:opt-lava-test.yml${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh x86-64-efi
 
 lava-test:board-x86-64-efi:
-- 
2.20.1



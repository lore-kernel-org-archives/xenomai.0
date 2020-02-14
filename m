From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 01/11] ci: remove code duplications
Date: Fri, 14 Feb 2020 08:32:51 +0100
Message-Id: <20200214073259.1769-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
References: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
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
 .gitlab-ci.yml | 130 +++++++++++++++++++++----------------------------
 1 file changed, 55 insertions(+), 75 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 33f97ec..e5dd3c1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2020
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -18,7 +18,8 @@ variables:
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
-  BUILD_OPTIONS: ":opt-xenomai-next.yml:opt-linux-latest.yml"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
 default:
   image: kasproject/kas-isar:latest
 
@@ -30,111 +31,90 @@ default:
     - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
     - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
     - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
-build:qemu-amd64:
+
+.build: &build-job
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-qemu-amd64.yml${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh qemu-amd64
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+    - scripts/deploy_for_testing.sh ${TARGET}
 
-lava-test:qemu-amd64:
+.test: &test-job
   <<: *lava-ssh-key
   stage: lava-test
   script:
     - scripts/install-lavacli.sh
-    - scripts/run-lava-tests.sh qemu-amd64
-  needs: [ "build:qemu-amd64" ]
+    - scripts/run-lava-tests.sh ${TARGET}
   only:
     variables:
       - $LAVA_SSH_USER
 
+
+build:qemu-amd64:
+  <<: *build-job
+  variables:
+    TARGET: qemu-amd64
+
+lava-test:qemu-amd64:
+  needs: [ "build:qemu-amd64" ]
+  <<: *test-job
+  variables:
+    TARGET: qemu-amd64
+
 build:qemu-armhf:
-  <<: *lava-ssh-key
-  stage: build
-  script:
-    - kas build kas.yml:board-qemu-armhf.yml${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh qemu-armhf
+  <<: *build-job
+  variables:
+    TARGET: qemu-armhf
 
 lava-test:qemu-armhf:
-  <<: *lava-ssh-key
-  stage: lava-test
-  script:
-    - scripts/install-lavacli.sh
-    - scripts/run-lava-tests.sh qemu-armhf
   needs: [ "build:qemu-armhf" ]
-  only:
-    variables:
-      - $LAVA_SSH_USER
+  <<: *test-job
+  variables:
+    TARGET: qemu-armhf
 
 build:qemu-arm64:
-  <<: *lava-ssh-key
-  stage: build
-  script:
-    - kas build kas.yml:board-qemu-arm64.yml${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh qemu-arm64
+  <<: *build-job
+  variables:
+    TARGET: qemu-arm64
 
 lava-test:qemu-arm64:
-  <<: *lava-ssh-key
-  stage: lava-test
-  script:
-    - scripts/install-lavacli.sh
-    - scripts/run-lava-tests.sh qemu-arm64
   needs: [ "build:qemu-arm64" ]
-  only:
-    variables:
-      - $LAVA_SSH_USER
+  <<: *test-job
+  variables:
+    TARGET: qemu-arm64
 
 build:board-hikey:
-  <<: *lava-ssh-key
-  stage: build
-  script:
-    - kas build kas.yml:board-hikey.yml:opt-lava-test.yml${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh hikey
-
+  <<: *build-job
+  variables:
+    TARGET: hikey
+    BUILD_OPTIONS: ":opt-lava-test.yml"
 lava-test:board-hikey:
-  <<: *lava-ssh-key
-  stage: lava-test
-  script:
-    - scripts/install-lavacli.sh
-    - scripts/run-lava-tests.sh hikey
   needs: [ "build:board-hikey" ]
-  only:
-    variables:
-      - $LAVA_SSH_USER
-
+  <<: *test-job
+  variables:
+    TARGET: hikey
 
 build:board-beaglebone:
-  <<: *lava-ssh-key
-  stage: build
-  script:
-    - kas build kas.yml:board-beagle-bone-black.yml:opt-lava-test.yml${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh beagle-bone-black
+  <<: *build-job
+  variables:
+    TARGET: beagle-bone-black
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+
 
 lava-test:board-beaglebone:
-  <<: *lava-ssh-key
-  stage: lava-test
-  script:
-    - scripts/install-lavacli.sh
-    - scripts/run-lava-tests.sh beaglebone
   needs: [ "build:board-beaglebone" ]
-  only:
-    variables:
-      - $LAVA_SSH_USER
+  <<: *test-job
+  variables:
+    TARGET: beaglebone
 
 build:board-x86-64-efi:
-  <<: *lava-ssh-key
-  stage: build
-  script:
-    - kas build kas.yml:board-x86-64-efi.yml:opt-lava-test.yml${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh x86-64-efi
+  <<: *build-job
+  variables:
+    TARGET: x86-64-efi
+    BUILD_OPTIONS: ":opt-lava-test.yml"
 
 lava-test:board-x86-64-efi:
-  <<: *lava-ssh-key
-  stage: lava-test
-  script:
-    - scripts/install-lavacli.sh
-    - scripts/run-lava-tests.sh x86-64
   needs: [ "build:board-x86-64-efi" ]
-  only:
-    variables:
-      - $LAVA_SSH_USER
+  <<: *test-job
+  variables:
+    TARGET: x86-64
-- 
2.20.1



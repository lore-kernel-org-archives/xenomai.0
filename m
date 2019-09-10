From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 2/9] ci: Add needs key word
Date: Tue, 10 Sep 2019 16:44:52 +0200
Message-Id: <20190910144459.13239-3-Quirin.Gylstorff@siemens.com>
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

The keyword "needs" was introduced in gitlab 12.2 and allows the
creation of Directed Asylic Graph. This allows to execute tests
without waiting for the complete build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c4dc27f..c75a7e6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -11,6 +11,7 @@
 stages:
   - build
   - lava-test
+
 variables:
   GIT_STRATEGY: clone
   http_proxy: "$HTTP_PROXY"
@@ -43,6 +44,7 @@ lava-test:qemu-amd64:
   stage: lava-test
   script:
      - scripts/run-lava-tests.sh qemu-amd64
+  needs: [ "build:qemu-amd64" ]
   only:
     variables:
       - $LAVA_USER
@@ -58,6 +60,7 @@ lava-test:qemu-armhf:
   stage: lava-test
   script:
     - scripts/run-lava-tests.sh qemu-armhf
+  needs: [ "build:qemu-armhf" ]
   only:
     variables:
       - $LAVA_USER
@@ -74,6 +77,7 @@ lava-test:qemu-arm64:
   stage: lava-test
   script:
     - scripts/run-lava-tests.sh qemu-arm64
+  needs: [ "build:qemu-arm64" ]
   only:
     variables:
       - $LAVA_USER
@@ -96,6 +100,7 @@ lava-test:board-beaglebone:
   stage: lava-test
   script:
     - scripts/run-lava-tests.sh beaglebone
+  needs: [ "build:board-beaglebone" ]
   only:
     variables:
       - $LAVA_USER
@@ -112,6 +117,7 @@ lava-test:board-x86-64-efi:
   stage: lava-test
   script:
     - scripts/run-lava-tests.sh x86-64
+  needs: [ "build:board-x86-64-efi" ]
   only:
     variables:
       - $LAVA_USER
-- 
2.20.1



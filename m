From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 08/11] ci: add new build options
Date: Fri, 14 Feb 2020 08:32:58 +0100
Message-Id: <20200214073259.1769-9-Quirin.Gylstorff@siemens.com>
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
 .gitlab-ci.yml | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 54542b1..608d5db 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -147,3 +147,33 @@ lava-test:board-x86-64-efi:linux-4.4:
   variables:
     TARGET: x86-64
     DEPLOY_DIR_EXTENSION: "4.4"
+
+build:board-beaglebone:xenomai-3.0.x:
+  extends: .build
+  variables:
+    TARGET: beagle-bone-black
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+
+lava-test:board-beaglebone:xenomai-3.0.x:
+  needs: [ "build:board-beaglebone:xenomai-3.0.x" ]
+  extends: .test
+  variables:
+    TARGET: beaglebone
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+
+build:board-x86-64-efi:xenomai-3.0.x:
+  extends: .build
+  variables:
+    TARGET: x86-64-efi
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+
+lava-test:board-x86-64-efi:xenomai-3.0.x:
+  needs: [ "build:board-x86-64-efi:xenomai-3.0.x" ]
+  extends: .test
+  variables:
+    TARGET: x86-64
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-- 
2.20.1



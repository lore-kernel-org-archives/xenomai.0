From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/6] ci: Add 5.15 kernel
Date: Fri, 7 Jan 2022 12:35:34 +0100
Message-ID: <01bfbe81d6425af9715ba0e789c53996b2732d55.1641555334.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641555334.git.jan.kiszka@siemens.com>
References: <cover.1641555334.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 859a12b89b..8a9a631d41 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -178,6 +178,14 @@ variables:
     paths:
       - .ccache
 
+arm-5.15-head:
+  extends: .build
+  variables:
+    ARCH: arm
+    PIPELINE_REV: v5.15.y-dovetail-rebase
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: multi_v7_defconfig
+
 arm-5.10-head:
   extends: .build
   variables:
@@ -186,6 +194,14 @@ arm-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
+arm64-5.15-head:
+  extends: .build
+  variables:
+    ARCH: arm64
+    PIPELINE_REV: v5.15.y-dovetail-rebase
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: defconfig
+
 arm64-5.10-head:
   extends: .build
   variables:
@@ -194,6 +210,14 @@ arm64-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
+x86-5.15-head:
+  extends: .build
+  variables:
+    ARCH: x86
+    PIPELINE_REV: v5.15.y-dovetail-rebase
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: x86_64_defconfig
+
 x86-5.10-head:
   extends: .build
   variables:
-- 
2.31.1



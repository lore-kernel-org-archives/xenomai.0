From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/5] ci: Drop builds for kernels older than 5.10
Date: Thu, 16 Dec 2021 16:48:21 +0100
Message-ID: <72680925e637c673754563d9100362794b045534.1639669704.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1639669704.git.jan.kiszka@siemens.com>
References: <cover.1639669704.git.jan.kiszka@siemens.com>
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
 .gitlab-ci.yml | 56 --------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 76daad792e..e4f35f2c45 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -187,22 +187,6 @@ arm-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm-5.4-release:
-  extends: .build
-  variables:
-    ARCH: arm
-    PIPELINE_REV: ipipe-core-5.4..*-arm-.*
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm.git
-    KERNEL_DEFCONFIG: multi_v7_defconfig
-
-arm-4.19-release:
-  extends: .build
-  variables:
-    ARCH: arm
-    PIPELINE_REV: ipipe-core-4.19..*-arm-.*
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm.git
-    KERNEL_DEFCONFIG: multi_v7_defconfig
-
 arm64-5.10-head:
   extends: .build
   variables:
@@ -211,22 +195,6 @@ arm64-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
-arm64-5.4-release:
-  extends: .build
-  variables:
-    ARCH: arm64
-    PIPELINE_REV: ipipe-core-5.4..*-arm64-.*
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm64.git
-    KERNEL_DEFCONFIG: defconfig
-
-arm64-4.19-cip-release:
-  extends: .build
-  variables:
-    ARCH: arm64
-    PIPELINE_REV: ipipe-core-4.19..*cip.*-arm64-.*
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm64.git
-    KERNEL_DEFCONFIG: defconfig
-
 x86-5.10-head:
   extends: .build
   variables:
@@ -235,30 +203,6 @@ x86-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: x86_64_defconfig
 
-x86-5.4-head:
-  extends: .build
-  variables:
-    ARCH: x86
-    PIPELINE_REV: ipipe-x86-5.4.y
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-x86.git
-    KERNEL_DEFCONFIG: x86_64_defconfig
-
-x86-4.19-cip-head:
-  extends: .build
-  variables:
-    ARCH: x86
-    PIPELINE_REV: ipipe-x86-4.19.y-cip
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-x86.git
-    KERNEL_DEFCONFIG: x86_64_defconfig
-
-x86-4.19-cip-release:
-  extends: .build
-  variables:
-    ARCH: x86
-    PIPELINE_REV: ipipe-core-4.19..*cip.*-x86-.*
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-x86.git
-    KERNEL_DEFCONFIG: x86_64_defconfig
-
 i386-userland:
   extends: .build
   variables:
-- 
2.31.1



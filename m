From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Rename I-pipe URL variable
Message-ID: <5597380b-789c-fd3d-b3a3-e6f1d994e398@siemens.com>
Date: Sun, 18 Jul 2021 10:47:02 +0200
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

Pure cosmetics: We are no longer pulling from a mirror but from the
official source.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8be00c3cec..0d354c04d7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ variables:
   KDIR: "/tmp/kernel"
   USE_CCACHE: "1"
   CCACHE_MAXSIZE: "1G"
-  IPIPE_MIRROR_URL: "https://source.denx.de/Xenomai"
+  IPIPE_URL: "https://source.denx.de/Xenomai"
   DOVETAIL_URL: "https://source.denx.de/Xenomai/linux-dovetail.git"
   GCC_VERSION: "10"
   PACKAGES: "u-boot-tools git make bc bison libelf-dev autotools-dev \
@@ -187,7 +187,7 @@ arm-5.4-release:
   variables:
     ARCH: arm
     PIPELINE_REV: ipipe-core-5.4..*-arm-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-4.19-release:
@@ -195,7 +195,7 @@ arm-4.19-release:
   variables:
     ARCH: arm
     PIPELINE_REV: ipipe-core-4.19..*-arm-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm64-5.10-head:
@@ -211,7 +211,7 @@ arm64-5.4-release:
   variables:
     ARCH: arm64
     PIPELINE_REV: ipipe-core-5.4..*-arm64-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
 arm64-4.19-cip-release:
@@ -219,7 +219,7 @@ arm64-4.19-cip-release:
   variables:
     ARCH: arm64
     PIPELINE_REV: ipipe-core-4.19..*cip.*-arm64-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
 x86-5.10-head:
@@ -235,7 +235,7 @@ x86-5.4-head:
   variables:
     ARCH: x86
     PIPELINE_REV: ipipe-x86-5.4.y
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-4.19-cip-head:
@@ -243,7 +243,7 @@ x86-4.19-cip-head:
   variables:
     ARCH: x86
     PIPELINE_REV: ipipe-x86-4.19.y-cip
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-4.19-cip-release:
@@ -251,7 +251,7 @@ x86-4.19-cip-release:
   variables:
     ARCH: x86
     PIPELINE_REV: ipipe-core-4.19..*cip.*-x86-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 powerpc-4.19-release:
@@ -260,7 +260,7 @@ powerpc-4.19-release:
   variables:
     ARCH: powerpc
     PIPELINE_REV: ipipe-core-4.19..*-ppc32-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-ppc32.git
+    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-ppc32.git
     KERNEL_DEFCONFIG: mpc5200_defconfig
 
 trigger-xenomai-images:
-- 
2.26.2


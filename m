From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Rename some variables
Message-ID: <c5600b02-c8fd-374d-8892-96500dc0c7d3@siemens.com>
Date: Fri, 5 Feb 2021 19:24:25 +0100
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

In preparation of adding dovetail as pipeline flavor.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c6387f6d49..83a8247c72 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2021
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -35,9 +35,9 @@ variables:
     - update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800
     - update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800
     - update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800
-    - REV=$(git ls-remote --tags --head --refs ${IPIPE_KERNEL} | sed -e "s|.*[[:space:]]refs/.*/||" | grep "${IPIPE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
-    - test -n "${REV}" || REV="${IPIPE_REV}"
-    - git clone --depth 1 --branch ${REV} ${IPIPE_KERNEL} ${KDIR}
+    - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s|.*[[:space:]]refs/.*/||" | grep "${PIPELINE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
+    - test -n "${REV}" || REV="${PIPELINE_REV}"
+    - git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
     - case "${ARCH}" in
       "arm64")
       export CROSS_COMPILE=aarch64-linux-gnu-
@@ -169,94 +169,94 @@ arm-5.4-release:
   extends: .build
   variables:
     ARCH: arm
-    IPIPE_REV: ipipe-core-5.4..*-arm-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
+    PIPELINE_REV: ipipe-core-5.4..*-arm-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-4.19-release:
   extends: .build
   variables:
     ARCH: arm
-    IPIPE_REV: ipipe-core-4.19..*-arm-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
+    PIPELINE_REV: ipipe-core-4.19..*-arm-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-4.4-cip-head:
   extends: .build
   variables:
     ARCH: arm
-    IPIPE_REV: ipipe-4.4.y-cip
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
+    PIPELINE_REV: ipipe-4.4.y-cip
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm64-5.4-release:
   extends: .build
   variables:
     ARCH: arm64
-    IPIPE_REV: ipipe-core-5.4..*-arm64-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
+    PIPELINE_REV: ipipe-core-5.4..*-arm64-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
 arm64-4.19-release:
   extends: .build
   variables:
     ARCH: arm64
-    IPIPE_REV: ipipe-core-4.19..*-arm64-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
+    PIPELINE_REV: ipipe-core-4.19..*-arm64-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
 x86-5.4-head:
   extends: .build
   variables:
     ARCH: x86
-    IPIPE_REV: ipipe-x86-5.4.y
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    PIPELINE_REV: ipipe-x86-5.4.y
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-4.19-cip-head:
   extends: .build
   variables:
     ARCH: x86
-    IPIPE_REV: ipipe-x86-4.19.y-cip
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    PIPELINE_REV: ipipe-x86-4.19.y-cip
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-4.19-cip-release:
   extends: .build
   variables:
     ARCH: x86
-    IPIPE_REV: ipipe-core-4.19..*cip.*-x86-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    PIPELINE_REV: ipipe-core-4.19..*cip.*-x86-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-4.14-release:
   extends: .build
   variables:
     ARCH: x86
-    IPIPE_REV: ipipe-core-4.14..*-x86-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    PIPELINE_REV: ipipe-core-4.14..*-x86-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-4.4-cip-head:
   extends: .build
   variables:
     ARCH: x86
-    IPIPE_REV: ipipe-4.4.y-cip
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
+    PIPELINE_REV: ipipe-4.4.y-cip
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-4.4-cip-release:
   extends: .build
   variables:
-     ARCH: x86
-     IPIPE_REV: ipipe-core-4.4..*-cip.*-x86-.*
-     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
-     KERNEL_DEFCONFIG: x86_64_defconfig
+    ARCH: x86
+    PIPELINE_REV: ipipe-core-4.4..*-cip.*-x86-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
+    KERNEL_DEFCONFIG: x86_64_defconfig
 
 powerpc-4.19-release:
   extends: .build
   variables:
     ARCH: powerpc
-    IPIPE_REV: ipipe-core-4.19..*-ppc32-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-ppc32.git
+    PIPELINE_REV: ipipe-core-4.19..*-ppc32-.*
+    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-ppc32.git
     KERNEL_DEFCONFIG: mpc5200_defconfig
-- 
2.26.2


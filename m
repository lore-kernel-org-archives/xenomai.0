From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Drop building for 4.4 and 4.14
Message-ID: <d9ac17ef-7b95-5386-229c-ead87a414f23@siemens.com>
Date: Mon, 8 Mar 2021 14:53:05 +0100
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

The former is not a target for latest Xenomai anymore, and the latter is
unmaintained by now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0e0bc642e..86116327b4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -181,14 +181,6 @@ arm-4.19-release:
     PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm-4.4-cip-head:
-  extends: .build
-  variables:
-    ARCH: arm
-    PIPELINE_REV: ipipe-4.4.y-cip
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
-    KERNEL_DEFCONFIG: multi_v7_defconfig
-
 arm64-5.4-release:
   extends: .build
   variables:
@@ -229,30 +221,6 @@ x86-4.19-cip-release:
     PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
-x86-4.14-release:
-  extends: .build
-  variables:
-    ARCH: x86
-    PIPELINE_REV: ipipe-core-4.14..*-x86-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
-    KERNEL_DEFCONFIG: x86_64_defconfig
-
-x86-4.4-cip-head:
-  extends: .build
-  variables:
-    ARCH: x86
-    PIPELINE_REV: ipipe-4.4.y-cip
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
-    KERNEL_DEFCONFIG: x86_64_defconfig
-
-x86-4.4-cip-release:
-  extends: .build
-  variables:
-    ARCH: x86
-    PIPELINE_REV: ipipe-core-4.4..*-cip.*-x86-.*
-    PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
-    KERNEL_DEFCONFIG: x86_64_defconfig
-
 powerpc-4.19-release:
   extends: .build
   variables:
-- 
2.26.2


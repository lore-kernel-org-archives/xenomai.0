From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] ci: Add 5.4 release builds for arm and arm64, drop 4.14
Message-ID: <10f1fe8d-1c71-08cc-1e18-181b10cb181c@siemens.com>
Date: Fri, 5 Feb 2021 17:36:51 +0100
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 87532a3376..c6387f6d49 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -165,19 +165,19 @@ variables:
     paths:
       - .ccache
 
-arm-4.19-release:
+arm-5.4-release:
   extends: .build
   variables:
     ARCH: arm
-    IPIPE_REV: ipipe-core-4.19..*-arm-.*
+    IPIPE_REV: ipipe-core-5.4..*-arm-.*
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm-4.14-release:
+arm-4.19-release:
   extends: .build
   variables:
     ARCH: arm
-    IPIPE_REV: ipipe-core-4.14..*-arm-.*
+    IPIPE_REV: ipipe-core-4.19..*-arm-.*
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
@@ -189,19 +189,19 @@ arm-4.4-cip-head:
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm64-4.19-release:
+arm64-5.4-release:
   extends: .build
   variables:
     ARCH: arm64
-    IPIPE_REV: ipipe-core-4.19..*-arm64-.*
+    IPIPE_REV: ipipe-core-5.4..*-arm64-.*
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
-arm64-4.14-release:
+arm64-4.19-release:
   extends: .build
   variables:
     ARCH: arm64
-    IPIPE_REV: ipipe-core-4.14..*-arm64-.*
+    IPIPE_REV: ipipe-core-4.19..*-arm64-.*
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
-- 
2.26.2


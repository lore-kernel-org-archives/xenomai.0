From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Add 5.4 release builds for arm and arm64
Message-ID: <a5fc19bc-df67-ba55-7546-fd361ac3fe0d@siemens.com>
Date: Fri, 5 Feb 2021 15:48:29 +0100
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
To: Xenomai <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Greg, should we also drop a kernel version from CI for arm and arm64? 
The 4.14ers?

 .gitlab-ci.yml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 87532a3376..19c24dc88a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -165,6 +165,14 @@ variables:
     paths:
       - .ccache
 
+arm-5.4-release:
+  extends: .build
+  variables:
+    ARCH: arm
+    IPIPE_REV: ipipe-core-5.4..*-arm-.*
+    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
+    KERNEL_DEFCONFIG: multi_v7_defconfig
+
 arm-4.19-release:
   extends: .build
   variables:
@@ -189,6 +197,14 @@ arm-4.4-cip-head:
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
+arm64-5.4-release:
+  extends: .build
+  variables:
+    ARCH: arm64
+    IPIPE_REV: ipipe-core-5.4..*-arm64-.*
+    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
+    KERNEL_DEFCONFIG: defconfig
+
 arm64-4.19-release:
   extends: .build
   variables:
-- 
2.26.2


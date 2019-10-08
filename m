From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Name matrix jobs, update x86 kernel
Message-ID: <82404918-1332-24c8-c2db-618a86c1665a@siemens.com>
Date: Tue, 8 Oct 2019 13:38:06 +0200
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
 .travis.yml | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c07939e9ef..fc1914c000 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -159,57 +159,68 @@ script:
 
 matrix:
   include:
-    - env:
+    - name: "ARM 4.19 release"
+      env:
       - ARCH: arm
         IPIPE_REV: ipipe-core-4.19.55-arm-3
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
-    - env:
+    - name: "ARM 4.14 release"
+      env:
       - ARCH: arm
         IPIPE_REV: ipipe-core-4.14.110-arm-7
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
-    - env:
+    - name: "ARM 4.4-CIP head"
+      env:
       - ARCH: arm
         IPIPE_REV: ipipe-4.4.y-cip
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
-    - env:
+    - name: "ARM64 4.19 release"
+      env:
       - ARCH: arm64
         IPIPE_REV: ipipe-core-4.19.55-arm64-2
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
         KERNEL_DEFCONFIG: defconfig
-    - env:
+    - name: "ARM64 4.14 release"
+      env:
       - ARCH: arm64
         IPIPE_REV: ipipe-core-4.14.78-arm64-2
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
         KERNEL_DEFCONFIG: defconfig
-    - env:
+    - name: "x86 4.19 head"
+      env:
       - ARCH: x86
         IPIPE_REV: ipipe-x86-4.19.y
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
-    - env:
+    - name: "x86 4.19 release"
+      env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.19.66-x86-6
+        IPIPE_REV: ipipe-core-4.19.75-x86-7
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
-    - env:
+    - name: "x86 4.14 release"
+      env:
       - ARCH: x86
         IPIPE_REV: ipipe-core-4.14.128-x86-5
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
-    - env:
+    - name: "x86 4.4-CIP head"
+      env:
       - ARCH: x86
         IPIPE_REV: ipipe-4.4.y-cip
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: x86_64_defconfig
-    - env:
+    - name: "x86 4.4-CIP release"
+      env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.4.188-cip36-x86-17
+        IPIPE_REV: ipipe-core-4.4.192-cip37-x86-18
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: x86_64_defconfig
-    - env:
+    - name: "PowerPC 4.19 release"
+      env:
       - ARCH: powerpc
         IPIPE_REV: ipipe-core-4.19.55-ppc32-1
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-ppc32.git
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


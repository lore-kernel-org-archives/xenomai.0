From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Update x86 kernel versions
Message-ID: <b967151b-4c65-dc48-aecf-e6242fba1aed@siemens.com>
Date: Wed, 3 Jul 2019 00:25:58 +0200
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

4.4 and 4.14 received new releases meanwhile, and we now have a 4.19-x86
branch and release. Drop the 4.14-x86 branch as this version is now in
phase-out, and we should now grow our matrix infinitely.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 3983be0c9e..0e7aa6d10c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -175,12 +175,17 @@ matrix:
         KERNEL_DEFCONFIG: defconfig
     - env:
       - ARCH: x86
-        IPIPE_REV: ipipe-x86-4.14.y
+        IPIPE_REV: ipipe-x86-4.19.y
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.14.111-x86-3
+        IPIPE_REV: ipipe-core-4.19.56-x86-2
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
+        KERNEL_DEFCONFIG: x86_64_defconfig
+    - env:
+      - ARCH: x86
+        IPIPE_REV: ipipe-core-4.14.128-x86-5
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
@@ -190,7 +195,7 @@ matrix:
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.4.176-x86-14
+        IPIPE_REV: ipipe-core-4.4.182-x86-15
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
-- 
2.16.4


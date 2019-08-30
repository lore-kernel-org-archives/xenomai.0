From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Update x86 ipipe releases
Message-ID: <e53dc200-c8eb-172d-866f-abb774185051@siemens.com>
Date: Fri, 30 Aug 2019 20:31:22 +0200
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
 .travis.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a3453b0ff9..da7380cd10 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -164,7 +164,7 @@ matrix:
         KERNEL_DEFCONFIG: multi_v7_defconfig
     - env:
       - ARCH: arm
-        IPIPE_REV: ipipe-4.4.y
+        IPIPE_REV: ipipe-4.4.y-cip
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
     - env:
@@ -179,7 +179,7 @@ matrix:
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.19.56-x86-2
+        IPIPE_REV: ipipe-core-4.19.66-x86-6
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
@@ -189,12 +189,12 @@ matrix:
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
       - ARCH: x86
-        IPIPE_REV: ipipe-4.4.y
+        IPIPE_REV: ipipe-4.4.y-cip
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.4.182-x86-15
+        IPIPE_REV: ipipe-core-4.4.188-cip36-x86-17
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
-- 

2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


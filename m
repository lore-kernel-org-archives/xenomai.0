From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Switch 4.19-x86 to CIP
Message-ID: <83572a5c-a8d0-cd2b-35ae-c2aecfea34eb@siemens.com>
Date: Tue, 14 Jan 2020 18:20:08 +0100
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

Maintenance will continue based on that branch only.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d56b6e494e..589845b179 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -192,16 +192,16 @@ matrix:
         IPIPE_REV: ipipe-core-4.14..*-arm64-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
         KERNEL_DEFCONFIG: defconfig
-    - name: "x86 4.19 head"
+    - name: "x86 4.19-CIP head"
       env:
       - ARCH: x86
-        IPIPE_REV: ipipe-x86-4.19.y
+        IPIPE_REV: ipipe-x86-4.19.y-cip
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
-    - name: "x86 4.19 release"
+    - name: "x86 4.19-CIP release"
       env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.19..*-x86-.*
+        IPIPE_REV: ipipe-core-4.19..*cip.*-x86-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - name: "x86 4.14 release"
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


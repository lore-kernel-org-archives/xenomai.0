From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH stable/v3.1.x] ci: Drop 4.14 from target list
Message-ID: <8a29fa02-b025-0426-befa-ecc6be7a9ed2@siemens.com>
Date: Fri, 10 Sep 2021 10:25:10 +0200
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

This kernel is no longer maintained and will not survive the switch to
gcc-10.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6b77c4ee64..7b99547cdc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -233,14 +233,6 @@ x86-4.19-cip-release:
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
-x86-4.14-release:
-  extends: .build
-  variables:
-    ARCH: x86
-    IPIPE_REV: ipipe-core-4.14..*-x86-.*
-    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
-    KERNEL_DEFCONFIG: x86_64_defconfig
-
 x86-4.4-cip-head:
   extends: .build
   variables:
-- 
2.31.1


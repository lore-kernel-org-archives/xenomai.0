From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Switch arm64 to stable tag
Message-ID: <05fb28c1-7699-f120-9bb4-11462d167a0b@siemens.com>
Date: Mon, 27 May 2019 10:10:24 +0200
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 3dd38b3b6e..3983be0c9e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -170,7 +170,7 @@ matrix:
         KERNEL_DEFCONFIG: multi_v7_defconfig
     - env:
       - ARCH: arm64
-        IPIPE_REV: v4.14.78-split
+        IPIPE_REV: ipipe-core-4.14.78-arm64-2
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
         KERNEL_DEFCONFIG: defconfig
     - env:
-- 
2.16.4


From: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 23 Sep 2018 17:37:24 +0200
Message-Id: <20180923153724.32282-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 2/3] cobalt/arm64: prepare-kernel: Map aarch64 to
 arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Marek Vasut <marex@denx.de>

From: Marek Vasut <marex@denx.de>

Various build systems and also the kernel uses aarch64 to refer to
arm64, map aarch64 and arm64 to the same thing.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 scripts/prepare-kernel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 123b7b4c5..37d7aa7d4 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -278,7 +278,7 @@ while : ; do
    arm)
       linux_arch=arm
       ;;
-   arm64)
+   arm64|aarch64)
       linux_arch=arm64
       ;;
    *)
-- 
2.14.4



From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 8/9] drivers/net/e1000e: Add missing ethtool.h include
Date: Wed, 13 Oct 2021 13:55:52 +0200
Message-Id: <9207083a6ec5c69cbfc71c1e42960d9fbc52b5ad.1634126152.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
References: <cover.1634126152.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed for recent kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000e/e1000.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/drivers/e1000e/e1000.h b/kernel/drivers/net/drivers/e1000e/e1000.h
index 7454c6350a..d6fa3d4839 100644
--- a/kernel/drivers/net/drivers/e1000e/e1000.h
+++ b/kernel/drivers/net/drivers/e1000e/e1000.h
@@ -40,6 +40,7 @@
 #include <linux/pci.h>
 #include <linux/crc32.h>
 #include <linux/if_vlan.h>
+#include <linux/ethtool.h>
 
 #include <rtnet_port.h>
 
-- 
2.31.1



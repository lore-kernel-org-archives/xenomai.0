From: roman.stratiienko@globallogic.com
Subject: [PATCH] rtnet: experimental: 3c59x: fix config name in makefile
Date: Thu,  4 Apr 2019 19:52:18 +0300
Message-Id: <20190404165218.7063-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
This also breaks the build, see:
https://travis-ci.org/devel-opi/xenomai-fork/jobs/515800815#L8087

 kernel/drivers/net/drivers/experimental/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/experimental/Makefile b/kernel/drivers/net/drivers/experimental/Makefile
index ad2317790..5748c2843 100644
--- a/kernel/drivers/net/drivers/experimental/Makefile
+++ b/kernel/drivers/net/drivers/experimental/Makefile
@@ -4,6 +4,6 @@ obj-$(CONFIG_XENO_DRIVERS_NET_DRV_RT2500) += rt2500/
 
 obj-$(CONFIG_XENO_DRIVERS_NET_DRV_E1000_NEW) += e1000/
 
-obj-$(CONFIG_RTNET_DRV_3C59X) += rt_3c59x.o
+obj-$(CONFIG_XENO_DRIVERS_NET_DRV_3C59X) += rt_3c59x.o
 
 rt_3c59x-y := 3c59x.o
-- 
2.17.1



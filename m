From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:10 +0100
Message-Id: <1356096375-29859-6-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 05/10] ipipe: Remove superfluous include file in
	ipipe.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 include/linux/ipipe.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index 11fc093..bcd5d41 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -22,7 +22,6 @@
 #ifndef __LINUX_IPIPE_H
 #define __LINUX_IPIPE_H
 
-#include <linux/spinlock.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
 #include <linux/irq.h>
-- 
1.7.1



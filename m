From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:57 +0200
Message-Id: <20180925103809.4932-21-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 20/32] x86: fix include for drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Henning Schild <henning.schild@siemens.com>

---
 include/linux/gpio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 8ef7fc0ce0f0..41554f9e098d 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -3,6 +3,7 @@
 #define __LINUX_GPIO_H
 
 #include <linux/errno.h>
+#include <linux/ipipe.h>
 
 /* see Documentation/gpio/gpio-legacy.txt */
 
-- 
2.14.4



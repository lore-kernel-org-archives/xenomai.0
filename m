From: roman.stratiienko@globallogic.com
Subject: [PATCH] kernel: cobalt: replace access_ok with corresponding wrappers
Date: Mon, 11 Mar 2019 16:37:21 +0200
Message-Id: <20190311143722.21320-1-roman.stratiienko@globallogic.com>
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

Use access_wok / access_rok wrappers to enable support for kernel v5.0

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---

This patch is also required to support v5.0

 kernel/cobalt/pipe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 0b8f8cbf8..16e85125c 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -28,6 +28,7 @@
 #include <linux/device.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
+#include <asm/xenomai/syscall.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/pipe.h>
@@ -795,7 +796,7 @@ static ssize_t xnpipe_read(struct file *file,
 	ssize_t ret;
 	spl_t s;
 
-	if (!access_ok(VERIFY_WRITE, buf, count))
+	if (!access_wok(buf, count))
 		return -EFAULT;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -903,7 +904,7 @@ static ssize_t xnpipe_write(struct file *file,
 	if (count == 0)
 		return 0;
 
-	if (!access_ok(VERIFY_READ, buf, count))
+	if (!access_rok(buf, count))
 		return -EFAULT;
 
 	xnlock_get_irqsave(&nklock, s);
-- 
2.17.1



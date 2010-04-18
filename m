From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:16:00 +0200
Message-Id: <0271cefff9f8bea23d75808ad7f741139c835f81.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 19/23] native: Convert event registry proc
	file to seq_file
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/native/event.c |   40 +++++++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/ksrc/skins/native/event.c b/ksrc/skins/native/event.c
index 5b2a8b5..d674a89 100644
--- a/ksrc/skins/native/event.c
+++ b/ksrc/skins/native/event.c
@@ -47,18 +47,16 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __event_read_proc(char *page,
-			     char **start,
-			     off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int event_seq_show(struct seq_file *f, void *v)
 {
-	RT_EVENT *event = (RT_EVENT *)data;
-	char *p = page;
-	int len;
+	RT_EVENT *event = (RT_EVENT *)f->private;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
-	p += sprintf(p, "=0x%lx\n", event->value);
+	seq_printf(f, "=0x%lx\n", event->value);
 
 	if (xnsynch_nsleepers(&event->synch_base) > 0) {
 		xnpholder_t *holder;
@@ -74,8 +72,8 @@ static int __event_read_proc(char *page,
 			    (task->wait_args.event.
 			     mode & EV_ANY) ? "any" : "all";
 			unsigned long mask = task->wait_args.event.mask;
-			p += sprintf(p, "+%s (mask=0x%lx, %s)\n",
-				     xnthread_name(sleeper), mask, mode);
+			seq_printf(f, "+%s (mask=0x%lx, %s)\n",
+				   xnthread_name(sleeper), mask, mode);
 			holder =
 			    nextpq(xnsynch_wait_queue(&event->synch_base),
 				   holder);
@@ -84,18 +82,21 @@ static int __event_read_proc(char *page,
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	len = (p - page) - off;
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
+	return 0;
+}
 
-	return len;
+static int event_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, event_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations event_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = event_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __event_pnode = {
@@ -103,8 +104,9 @@ static xnpnode_t __event_pnode = {
 	.dir = NULL,
 	.type = "events",
 	.entries = 0,
-	.read_proc = &__event_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &event_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



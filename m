From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:16:03 +0200
Message-Id: <61ed5c23099e3e841433e28729fa3f6ba2c45d6c.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 22/23] native: Convert queue registry proc
	entry to seq_file
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
 ksrc/skins/native/queue.c |   44 +++++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index 6a71165..72a640d 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -49,19 +49,17 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __queue_read_proc(char *page,
-			     char **start,
-			     off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int queue_seq_show(struct seq_file *f, void *v)
 {
-	RT_QUEUE *q = (RT_QUEUE *)data;
-	char *p = page;
-	int len;
+	RT_QUEUE *q = (RT_QUEUE *)f->private;
 	spl_t s;
 
-	p += sprintf(p, "type=%s:poolsz=%lu:usedmem=%lu:limit=%d:mcount=%d\n",
-		     q->mode & Q_SHARED ? "shared" : "local",
-		     xnheap_usable_mem(&q->bufpool), xnheap_used_mem(&q->bufpool),
-		     q->qlimit, countq(&q->pendq));
+	seq_printf(f, "type=%s:poolsz=%lu:usedmem=%lu:limit=%d:mcount=%d\n",
+		   q->mode & Q_SHARED ? "shared" : "local",
+		   xnheap_usable_mem(&q->bufpool), xnheap_used_mem(&q->bufpool),
+		   q->qlimit, countq(&q->pendq));
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -74,7 +72,7 @@ static int __queue_read_proc(char *page,
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
-			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s\n", xnthread_name(sleeper));
 			holder =
 			    nextpq(xnsynch_wait_queue(&q->synch_base), holder);
 		}
@@ -82,18 +80,21 @@ static int __queue_read_proc(char *page,
 
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
+static int queue_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, queue_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations queue_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = queue_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __queue_pnode = {
@@ -101,8 +102,9 @@ static xnpnode_t __queue_pnode = {
 	.dir = NULL,
 	.type = "queues",
 	.entries = 0,
-	.read_proc = &__queue_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &queue_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



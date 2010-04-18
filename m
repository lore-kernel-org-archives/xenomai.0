From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:59 +0200
Message-Id: <a9f7f75b7c4929f2e7de4c810f2a620a63481570.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 18/23] native: Convert intr registry proc
	files to seq_file
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
 ksrc/skins/native/intr.c |   44 +++++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/ksrc/skins/native/intr.c b/ksrc/skins/native/intr.c
index a69bd46..955c0e3 100644
--- a/ksrc/skins/native/intr.c
+++ b/ksrc/skins/native/intr.c
@@ -58,13 +58,11 @@ static unsigned long __intr_get_hits(RT_INTR *intr)
 
 #ifdef CONFIG_PROC_FS
 
-static int __intr_read_proc(char *page,
-			    char **start,
-			    off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int intr_seq_show(struct seq_file *f, void *v)
 {
-	RT_INTR *intr = (RT_INTR *)data;
-	char *p = page;
-	int len;
+	RT_INTR *intr = (RT_INTR *)f->private;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -73,9 +71,9 @@ static int __intr_read_proc(char *page,
 	{
 		xnpholder_t *holder;
 
-		p += sprintf(p, "hits=%lu, pending=%u, mode=0x%x\n",
-			     __intr_get_hits(intr), intr->pending,
-			     intr->mode);
+		seq_printf(f, "hits=%lu, pending=%u, mode=0x%x\n",
+			   __intr_get_hits(intr), intr->pending,
+			   intr->mode);
 
 		/* Pended interrupt -- dump waiters. */
 
@@ -83,30 +81,33 @@ static int __intr_read_proc(char *page,
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
-			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s\n", xnthread_name(sleeper));
 			holder =
 			    nextpq(xnsynch_wait_queue(&intr->synch_base),
 				   holder);
 		}
 	}
 #else /* !CONFIG_XENO_OPT_PERVASIVE */
-	p += sprintf(p, "hits=%lu\n", __intr_get_hits(intr));
+	seq_printf(f, "hits=%lu\n", __intr_get_hits(intr));
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
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
+static int intr_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, intr_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations intr_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = intr_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __intr_pnode = {
@@ -114,8 +115,9 @@ static xnpnode_t __intr_pnode = {
 	.dir = NULL,
 	.type = "interrupts",
 	.entries = 0,
-	.read_proc = &__intr_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &intr_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



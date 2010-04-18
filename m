From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:57 +0200
Message-Id: <a3bb84c5cca9ccd872df09ce432a3c8ee72c9de2.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 16/23] native: Convert cond registry proc
	entry to the seq_file mechanism
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
 ksrc/skins/native/cond.c |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/ksrc/skins/native/cond.c b/ksrc/skins/native/cond.c
index 86f83ff..081c2af 100644
--- a/ksrc/skins/native/cond.c
+++ b/ksrc/skins/native/cond.c
@@ -50,13 +50,11 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __cond_read_proc(char *page,
-			    char **start,
-			    off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int cond_seq_show(struct seq_file *f, void *v)
 {
-	RT_COND *cond = (RT_COND *)data;
-	char *p = page;
-	int len;
+	RT_COND *cond = (RT_COND *)f->private;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -70,7 +68,7 @@ static int __cond_read_proc(char *page,
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
-			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s\n", xnthread_name(sleeper));
 			holder =
 			    nextpq(xnsynch_wait_queue(&cond->synch_base),
 				   holder);
@@ -79,18 +77,21 @@ static int __cond_read_proc(char *page,
 
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
+static int cond_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cond_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations cond_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = cond_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __cond_pnode = {
@@ -98,8 +99,9 @@ static xnpnode_t __cond_pnode = {
 	.dir = NULL,
 	.type = "condvars",
 	.entries = 0,
-	.read_proc = &__cond_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &cond_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



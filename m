From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:56 +0200
Message-Id: <cd4be84f6d80f35ee36460b8da8ecc24f3e9d66f.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 15/23] native: Convert buffer registry proc
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
 ksrc/skins/native/buffer.c |   46 ++++++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/ksrc/skins/native/buffer.c b/ksrc/skins/native/buffer.c
index 2d364bb..5dc772d 100644
--- a/ksrc/skins/native/buffer.c
+++ b/ksrc/skins/native/buffer.c
@@ -50,21 +50,19 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __buffer_read_proc(char *page,
-			      char **start,
-			      off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int buffer_seq_show(struct seq_file *f, void *v)
 {
-	RT_BUFFER *bf = (RT_BUFFER *)data;
-	char *p = page;
-	int len;
+	RT_BUFFER *bf = (RT_BUFFER *)f->private;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
-	p += sprintf(p, "type=%s:size=%zu:used=%zu\n",
-		     bf->mode & B_PRIO ? "PRIO" : "FIFO",
-		     bf->bufsz,
-		     bf->fillsz);
+	seq_printf(f, "type=%s:size=%zu:used=%zu\n",
+		   bf->mode & B_PRIO ? "PRIO" : "FIFO",
+		   bf->bufsz,
+		   bf->fillsz);
 
 	if (xnsynch_nsleepers(&bf->isynch_base) > 0) {
 		xnpholder_t *holder;
@@ -73,7 +71,7 @@ static int __buffer_read_proc(char *page,
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
-			p += sprintf(p, "+%s (input)\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s (input)\n", xnthread_name(sleeper));
 			holder =
 			    nextpq(xnsynch_wait_queue(&bf->isynch_base),
 				   holder);
@@ -87,7 +85,7 @@ static int __buffer_read_proc(char *page,
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
-			p += sprintf(p, "+%s (output)\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s (output)\n", xnthread_name(sleeper));
 			holder =
 			    nextpq(xnsynch_wait_queue(&bf->osynch_base),
 				   holder);
@@ -96,18 +94,21 @@ static int __buffer_read_proc(char *page,
 
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
+static int buffer_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, buffer_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations buffer_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = buffer_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __buffer_pnode = {
@@ -115,8 +116,9 @@ static xnpnode_t __buffer_pnode = {
 	.dir = NULL,
 	.type = "buffers",
 	.entries = 0,
-	.read_proc = &__buffer_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &buffer_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:58 +0200
Message-Id: <bada447019588b1f5f4b6e003d3d9e57673d3181.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 17/23] native: convert the proc entry for the
	semaphore registry to seq_file
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
 ksrc/skins/native/sem.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/ksrc/skins/native/sem.c b/ksrc/skins/native/sem.c
index 0afea09..f962966 100644
--- a/ksrc/skins/native/sem.c
+++ b/ksrc/skins/native/sem.c
@@ -50,20 +50,18 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __sem_read_proc(char *page,
-			   char **start,
-			   off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int sem_seq_show(struct seq_file *f, void *v)
 {
-	RT_SEM *sem = (RT_SEM *)data;
-	char *p = page;
-	int len;
+	RT_SEM *sem = (RT_SEM *)f->private;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
 	if (xnsynch_nsleepers(&sem->synch_base) == 0)
 		/* Idle/posted semaphore -- dump count. */
-		p += sprintf(p, "=%lu\n", sem->count);
+		seq_printf(f, "=%lu\n", sem->count);
 	else {
 		xnpholder_t *holder;
 
@@ -73,7 +71,7 @@ static int __sem_read_proc(char *page,
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
-			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s\n", xnthread_name(sleeper));
 			holder =
 			    nextpq(xnsynch_wait_queue(&sem->synch_base),
 				   holder);
@@ -82,18 +80,21 @@ static int __sem_read_proc(char *page,
 
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
+static int sem_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sem_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations sem_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = sem_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __sem_pnode = {
@@ -101,8 +102,9 @@ static xnpnode_t __sem_pnode = {
 	.dir = NULL,
 	.type = "semaphores",
 	.entries = 0,
-	.read_proc = &__sem_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &sem_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



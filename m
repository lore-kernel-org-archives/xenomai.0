From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:16:02 +0200
Message-Id: <1a421d4bc2ca86f9d2020986dd537822fd9921c8.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 21/23] native: Convert mutex registry proc
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
 ksrc/skins/native/mutex.c |   42 ++++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/ksrc/skins/native/mutex.c b/ksrc/skins/native/mutex.c
index 6cf7eb1..4f3e9dc 100644
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -53,17 +53,15 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __mutex_read_proc(char *page,
-			     char **start,
-			     off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int mutex_seq_show(struct seq_file *f, void *v)
 {
-	RT_MUTEX *mutex = (RT_MUTEX *)data;
+	RT_MUTEX *mutex = (RT_MUTEX *)f->private;
 #ifdef CONFIG_XENO_FASTSYNCH
 	xnhandle_t lock_state;
 #endif /* CONFIG_XENO_FASTSYNCH */
 	xnthread_t *owner;
-	char *p = page;
-	int len;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -77,42 +75,45 @@ static int __mutex_read_proc(char *page,
 		xnthread_lookup(xnsynch_fast_mask_claimed(lock_state));
 
 	if (!owner && lock_state != XN_NO_HANDLE)
-		p += sprintf(p, "=<DAMAGED HANDLE!>");
+		seq_printf(f, "=<DAMAGED HANDLE!>");
 	else
 #endif /* CONFIG_XENO_FASTSYNCH */
 	if (owner) {
 		/* Locked mutex -- dump owner and waiters, if any. */
 		xnpholder_t *holder;
 
-		p += sprintf(p, "=locked by %s\n", xnthread_name(owner));
+		seq_printf(f, "=locked by %s\n", xnthread_name(owner));
 
 		holder = getheadpq(xnsynch_wait_queue(&mutex->synch_base));
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
 
-			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s\n", xnthread_name(sleeper));
 			holder = nextpq(xnsynch_wait_queue(&mutex->synch_base),
 					holder);
 		}
 	} else
 		/* Mutex unlocked. */
-		p += sprintf(p, "=unlocked\n");
+		seq_printf(f, "=unlocked\n");
 
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
+static int mutex_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mutex_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations mutex_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = mutex_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __mutex_pnode = {
@@ -120,8 +121,9 @@ static xnpnode_t __mutex_pnode = {
 	.dir = NULL,
 	.type = "mutexes",
 	.entries = 0,
-	.read_proc = &__mutex_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &mutex_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



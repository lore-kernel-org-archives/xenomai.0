From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:16:01 +0200
Message-Id: <390d036de9178d8fb6d886d31e6704a342e50087.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 20/23] native: Convert heap registry proc
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
 ksrc/skins/native/heap.c |   50 +++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index 2a5de8c..560cc4b 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -51,21 +51,19 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __heap_read_proc(char *page,
-			    char **start,
-			    off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int heap_seq_show(struct seq_file *f, void *v)
 {
-	RT_HEAP *heap = (RT_HEAP *)data;
-	char *p = page;
-	int len;
+	RT_HEAP *heap = (RT_HEAP *)f->private;
 	spl_t s;
 
-	p += sprintf(p, "type=%s:size=%lu:used=%lu:numaps=%lu\n",
-		     (heap->mode & H_SHARED) == H_SHARED ? "shared" :
-		     (heap->mode & H_MAPPABLE) ? "mappable" : "kernel",
-		     xnheap_usable_mem(&heap->heap_base),
-		     xnheap_used_mem(&heap->heap_base),
-		     heap->heap_base.archdep.numaps);
+	seq_printf(f, "type=%s:size=%lu:used=%lu:numaps=%lu\n",
+		   (heap->mode & H_SHARED) == H_SHARED ? "shared" :
+		   (heap->mode & H_MAPPABLE) ? "mappable" : "kernel",
+		   xnheap_usable_mem(&heap->heap_base),
+		   xnheap_used_mem(&heap->heap_base),
+		   heap->heap_base.archdep.numaps);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -79,8 +77,8 @@ static int __heap_read_proc(char *page,
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
 			size_t size = sleeper->wait_u.buffer.size;
-			p += sprintf(p, "+%s (size=%zd)\n",
-				     xnthread_name(sleeper), size);
+			seq_printf(f, "+%s (size=%zd)\n",
+				   xnthread_name(sleeper), size);
 			holder =
 			    nextpq(xnsynch_wait_queue(&heap->synch_base),
 				   holder);
@@ -89,18 +87,21 @@ static int __heap_read_proc(char *page,
 
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
+static int heap_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, heap_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations heap_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = heap_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __heap_pnode = {
@@ -108,8 +109,9 @@ static xnpnode_t __heap_pnode = {
 	.dir = NULL,
 	.type = "heaps",
 	.entries = 0,
-	.read_proc = &__heap_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &heap_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2



From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:50 +0200
Message-Id: <51bc4594485edde983437b1bd7cbc87c6a51681c.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 09/23] nucleus: Convert heap proc entry to
	seq_file
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

This fixes buffer overflows when large number of heaps are registered.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/heap.c |  121 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index e5dfef0..3891cd3 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -1409,16 +1409,69 @@ void xnheap_destroy_mapped(xnheap_t *heap,
 
 #ifdef CONFIG_PROC_FS
 
-#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+struct heap_seq_iterator {
+	int nentries;
+	struct heap_seq_info {
+		u_long usable_mem;
+		u_long used_mem;
+		u_long page_size;
+		char label[XNOBJECT_NAME_LEN];
+	} heap_info[1];
+};
+
+static void *heap_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct heap_seq_iterator *iter = seq->private;
+
+	if (*pos >= iter->nentries)
+		return NULL;
+
+	return iter->heap_info + *pos;
+}
+
+static void *heap_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct heap_seq_iterator *iter = seq->private;
+
+	++*pos;
 
-static int heap_read_proc(char *page,
-			  char **start,
-			  off_t off, int count, int *eof, void *data)
+	if (*pos >= iter->nentries)
+		return NULL;
+
+	return iter->heap_info + *pos;
+}
+
+static void heap_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static int heap_seq_show(struct seq_file *seq, void *v)
 {
+	struct heap_seq_info *p = v;
+
+	seq_printf(seq, "size=%lu:used=%lu:pagesz=%lu  (%s)\n",
+		   p->usable_mem, p->used_mem, p->page_size, p->label);
+	return 0;
+}
+
+static const struct seq_operations heap_op = {
+	.start	= heap_seq_start,
+	.next	= heap_seq_next,
+	.stop	= heap_seq_stop,
+	.show	= heap_seq_show
+};
+
+static int heap_seq_open(struct inode *inode, struct file *file)
+{
+	struct heap_seq_iterator *iter = NULL;
+	struct heap_seq_info *heap_info;
+	struct seq_file *seq;
 	unsigned long rev;
 	xnholder_t *entry;
 	xnheap_t *heap;
-	int len;
+	int count, err;
 	spl_t s;
 
 	if (!xnpod_active_p())
@@ -1427,17 +1480,38 @@ static int heap_read_proc(char *page,
 	xnlock_get_irqsave(&nklock, s);
 
 restart:
-	len = 0;
+	count = countq(&heapq); /* Cannot be empty (system heap) */
+	rev = heapq_rev;
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	kfree(iter);
+	iter = kmalloc(sizeof(*iter)
+		       + (count - 1) * sizeof(struct heap_seq_info),
+		       GFP_KERNEL);
+	if (!iter)
+		return -ENOMEM;
+
+	err = seq_open(file, &heap_op);
+	if (err) {
+		kfree(iter);
+		return err;
+	}
+
+	iter->nentries = 0;
+
+	xnlock_get_irqsave(&nklock, s);
 
 	entry = getheadq(&heapq);
 	while (entry) {
 		heap = container_of(entry, xnheap_t, stat_link);
-		len += sprintf(page + len,
-			       "size=%lu:used=%lu:pagesz=%lu  (%s)\n",
-			       xnheap_usable_mem(heap),
-			       xnheap_used_mem(heap),
-			       xnheap_page_size(heap),
-			       heap->label);
+		heap_info = &iter->heap_info[iter->nentries++];
+
+		heap_info->usable_mem = xnheap_usable_mem(heap);
+		heap_info->used_mem = xnheap_used_mem(heap);
+		heap_info->page_size = xnheap_page_size(heap);
+		memcpy(heap_info->label, heap->label,
+		       sizeof(heap_info->label));
 
 		rev = heapq_rev;
 
@@ -1451,22 +1525,23 @@ restart:
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	len -= off;
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
+	seq = file->private_data;
+	seq->private = iter;
 
-	return len;
+	return 0;
 }
 
+static const struct file_operations heap_operations = {
+	.owner		= THIS_MODULE,
+	.open		= heap_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private,
+};
+
 void xnheap_init_proc(void)
 {
-	rthal_add_proc_leaf("heap", &heap_read_proc, NULL, NULL,
-			    rthal_proc_root);
+	rthal_add_proc_seq("heap", &heap_operations, 0, rthal_proc_root);
 }
 
 void xnheap_cleanup_proc(void)
-- 
1.6.0.2



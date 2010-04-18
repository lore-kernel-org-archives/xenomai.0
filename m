From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:53 +0200
Message-Id: <d3300b750889b53e9e7f709fb3acc24ce9f8a2b0.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 12/23] nucleus: Convert apc proc file to the
	seq_file mechanism
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

Same procedure as last year, Miss Sophie?
Same procedure as every year, James.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/arch/generic/hal.c |   99 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 72 insertions(+), 27 deletions(-)

diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index ca221b5..c97659a 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -771,47 +771,92 @@ static struct file_operations faults_seq_operations = {
 	.release	= seq_release_private,
 };
 
-static int apc_read_proc(char *page,
-                         char **start,
-                         off_t off, int count, int *eof, void *data)
+static inline void *apc_seq_find_valid_pos(loff_t *pos)
 {
-    int len = 0, cpu, apc;
-    char *p = page;
+	while (!(*pos > BITS_PER_LONG) &&
+	       !test_bit(*pos - 1, &rthal_apc_map)) {
+		(*pos)++;
+	}
 
-    p += sprintf(p, "APC ");
+	if (*pos > BITS_PER_LONG) {
+		return NULL;
+	}
 
-    for_each_online_cpu(cpu) {
-        p += sprintf(p, "         CPU%d", cpu);
-    }
+	return pos;
+}
 
-    for (apc = 0; apc < BITS_PER_LONG; apc++) {
-        if (!test_bit(apc, &rthal_apc_map))
-            continue;           /* Not hooked. */
+static void *apc_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	/* The header is valid, naturally */
+	if (*pos == 0)
+		return pos;
 
-        p += sprintf(p, "\n%3d: ", apc);
+	return apc_seq_find_valid_pos(pos);
+}
+
+static void apc_seq_stop(struct seq_file *f, void *v)
+{
+	/* Nothing to do */
+}
+
+static void *apc_seq_next(struct seq_file *f, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return apc_seq_find_valid_pos(pos);
+}
+
+static int apc_seq_show(struct seq_file *f, void *v)
+{
+	unsigned int i = *(loff_t *) v;
+	unsigned int apc, cpu;
+
+	if (i == 0) {
+		seq_puts(f, "APC ");
+		for_each_online_cpu(cpu) {
+			seq_printf(f, "        CPU%u", cpu);
+		}
+		seq_putc(f, '\n');
+
+		return 0;
+	}
+
+	apc = i - 1;
+
+        seq_printf(f, "%3d: ", apc);
 
         for_each_online_cpu(cpu) {
-            p += sprintf(p, "%12lu", rthal_apc_table[apc].hits[cpu]);
+            seq_printf(f, "%12lu", rthal_apc_table[apc].hits[cpu]);
         }
 
 	if (rthal_apc_table[apc].name)
-	    p += sprintf(p, "    (%s)", rthal_apc_table[apc].name);
-    }
+	    seq_printf(f, "    (%s)", rthal_apc_table[apc].name);
 
-    p += sprintf(p, "\n");
+	seq_putc(f, '\n');
 
-    len = p - page - off;
-    if (len <= off + count)
-        *eof = 1;
-    *start = page + off;
-    if (len > count)
-        len = count;
-    if (len < 0)
-        len = 0;
+	return 0;
+}
 
-    return len;
+static struct seq_operations apc_seq_ops = {
+	.start  = apc_seq_start,
+	.next   = apc_seq_next,
+	.stop   = apc_seq_stop,
+	.show   = apc_seq_show,
+};
+
+static int apc_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &apc_seq_ops);
 }
 
+static struct file_operations apc_seq_operations = {
+	.open           = apc_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
+
 struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
                                            read_proc_t rdproc,
                                            write_proc_t wrproc,
@@ -869,7 +914,7 @@ static int rthal_proc_register(void)
 	rthal_add_proc_leaf("hal", &hal_read_proc, NULL, NULL, rthal_proc_root);
 	rthal_add_proc_seq("faults", &faults_seq_operations, 0,
 			   rthal_proc_root);
-	rthal_add_proc_leaf("apc", &apc_read_proc, NULL, NULL, rthal_proc_root);
+	rthal_add_proc_seq("apc", &apc_seq_operations, 0, rthal_proc_root);
 
 	rthal_nmi_proc_register();
 
-- 
1.6.0.2



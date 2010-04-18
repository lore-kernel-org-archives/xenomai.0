From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:52 +0200
Message-Id: <446c51e387f476f8ceef28e92cf02931a3a57046.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 11/23] nucleus: Convert faults proc entry to
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

The entries depend on the number of CPUs and can thus overflow a single page.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/arch/generic/hal.c |  148 +++++++++++++++++++++++++++++++++++++----------
 1 files changed, 118 insertions(+), 30 deletions(-)

diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index c2239ca..ca221b5 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -47,6 +47,7 @@
 #include <asm/xenomai/hal.h>
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #endif /* CONFIG_PROC_FS */
 #include <stdarg.h>
 
@@ -642,46 +643,133 @@ static int hal_read_proc(char *page,
     return len;
 }
 
-static int faults_read_proc(char *page,
-                            char **start,
-                            off_t off, int count, int *eof, void *data)
+struct faults_seq_iterator {
+	unsigned int nentries;
+	struct faults_seq_info {
+		unsigned int trap;
+	} faults_info[0];
+};
+
+static int __faults_seq_open(struct inode *inode,
+			     struct file *file, struct seq_operations *ops)
 {
-    int len = 0, cpu, trap;
-    char *p = page;
+	struct faults_seq_iterator *iter = NULL;
+	struct faults_seq_info *faults_info;
+	struct seq_file *seq;
+	unsigned int ntraps = 0;
+	unsigned int trap;
+	int err;
+
+	for (trap = 0; rthal_fault_labels[trap] != NULL; trap++) {
+		if (!*rthal_fault_labels[trap])
+			continue;
+		ntraps++;
+	}
 
-    p += sprintf(p, "TRAP ");
+	iter = kmalloc(sizeof(*iter)
+		       + ntraps * sizeof(struct faults_seq_info),
+		       GFP_KERNEL);
+	if (!iter)
+		return -ENOMEM;
 
-    for_each_online_cpu(cpu) {
-        p += sprintf(p, "        CPU%d", cpu);
-    }
+	err = seq_open(file, ops);
 
-    for (trap = 0; rthal_fault_labels[trap] != NULL; trap++) {
+	if (err) {
+		kfree(iter);
+		return err;
+	}
 
-        if (!*rthal_fault_labels[trap])
-            continue;
+	iter->nentries = 0;
 
-        p += sprintf(p, "\n%3d: ", trap);
+	for (trap = 0; rthal_fault_labels[trap] != NULL; trap++) {
+		if (!*rthal_fault_labels[trap])
+			continue;
 
-        for_each_online_cpu(cpu) {
-            p += sprintf(p, "%12u", rthal_realtime_faults[cpu][trap]);
-        }
+		faults_info = &iter->faults_info[iter->nentries++];
 
-        p += sprintf(p, "    (%s)", rthal_fault_labels[trap]);
-    }
+		faults_info->trap = trap;
+	}
 
-    p += sprintf(p, "\n");
+	seq = file->private_data;
+	seq->private = iter;
 
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
+static void *faults_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct faults_seq_iterator *iter = seq->private;
+
+	if (*pos > iter->nentries)
+		return NULL;
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	return iter->faults_info + *pos - 1;
 }
+static void *faults_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct faults_seq_iterator *iter = seq->private;
+
+	(*pos)++;
+
+	if (*pos > iter->nentries)
+		return NULL;
+
+	return iter->faults_info + *pos - 1;
+}
+
+static void faults_seq_stop(struct seq_file *f, void *v)
+{
+	/* Nothing to do */
+}
+
+static int faults_seq_show(struct seq_file *f, void *v)
+{
+	unsigned int cpu;
+	struct faults_seq_info *p = v;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(f, "TRAP ");
+
+		for_each_online_cpu(cpu) {
+			seq_printf(f, "        CPU%d\n", cpu);
+		}
+	}
+	else {
+		seq_printf(f, "%3d: ", p->trap);
+
+		for_each_online_cpu(cpu) {
+			seq_printf(f, "%12u",
+				   rthal_realtime_faults[cpu][p->trap]);
+		}
+
+		seq_printf(f, "    (%s)\n", rthal_fault_labels[p->trap]);
+	}
+
+	return 0;
+}
+
+static struct seq_operations faults_op = {
+	.start	= faults_seq_start,
+	.next	= faults_seq_next,
+	.stop	= faults_seq_stop,
+	.show	= faults_seq_show
+};
+
+static int faults_seq_open(struct inode *inode, struct file *file)
+{
+	return __faults_seq_open(inode, file, &faults_op);
+}
+
+static struct file_operations faults_seq_operations = {
+	.owner		= THIS_MODULE,
+	.open		= faults_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private,
+};
 
 static int apc_read_proc(char *page,
                          char **start,
@@ -779,8 +867,8 @@ static int rthal_proc_register(void)
 	wrap_proc_dir_entry_owner(rthal_proc_root);
 
 	rthal_add_proc_leaf("hal", &hal_read_proc, NULL, NULL, rthal_proc_root);
-	rthal_add_proc_leaf("faults",
-			    &faults_read_proc, NULL, NULL, rthal_proc_root);
+	rthal_add_proc_seq("faults", &faults_seq_operations, 0,
+			   rthal_proc_root);
 	rthal_add_proc_leaf("apc", &apc_read_proc, NULL, NULL, rthal_proc_root);
 
 	rthal_nmi_proc_register();
-- 
1.6.0.2



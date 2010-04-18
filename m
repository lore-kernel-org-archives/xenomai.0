From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:51 +0200
Message-Id: <e866125b4390585adf2fca793310a19608df2153.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 10/23] nucleus: Convert irq proc entry to
	seqfile
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

On a system with many CPUs, the size of the data can exceed
a single page.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/intr.c |  149 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 90 insertions(+), 59 deletions(-)

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index a6de4ea..79fa3e4 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -984,27 +984,27 @@ int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
 #ifdef CONFIG_PROC_FS
 
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/ctype.h>
 
-static int format_irq_proc(unsigned int irq, char *str)
+static void format_irq_proc(unsigned int irq, struct seq_file *f)
 {
 	xnintr_t *intr;
-	char *p = str;
 	spl_t s;
 
 	if (rthal_virtual_irq_p(irq)) {
-		p += sprintf(p, "         [virtual]");
-		return p - str;
+		seq_puts(f, "         [virtual]");
+		return;
 	} else if (irq == XNARCH_TIMER_IRQ) {
-		p += sprintf(p, "         [timer]");
-		return p - str;
+		seq_puts(f, "         [timer]");
+		return ;
 #ifdef CONFIG_SMP
 	} else if (irq == RTHAL_SERVICE_IPI0) {
-		p += sprintf(p, "         [IPI]");
-		return p - str;
+		seq_puts(f, "         [IPI]");
+		return;
 	} else if (irq == RTHAL_CRITICAL_IPI) {
-		p += sprintf(p, "         [critical sync]");
-		return p - str;
+		seq_puts(f, "         [critical sync]");
+		return;
 #endif /* CONFIG_SMP */
 	}
 
@@ -1012,61 +1012,17 @@ static int format_irq_proc(unsigned int irq, char *str)
 
 	intr = xnintr_shirq_first(irq);
 	if (intr) {
-		strcpy(p, "        "); p += 8;
+		seq_puts(f, "        ");
 
 		do {
-			*p = ' '; p += 1;
-			strcpy(p, intr->name); p += strlen(intr->name);
+			seq_putc(f, ' ');
+			seq_printf(f, "%s", intr->name);
 
 			intr = xnintr_shirq_next(intr);
 		} while (intr);
 	}
 
 	xnlock_put_irqrestore(&intrlock, s);
-
-	return p - str;
-}
-
-static int irq_read_proc(char *page,
-			 char **start,
-			 off_t off, int count, int *eof, void *data)
-{
-	int len = 0, cpu, irq;
-	char *p = page;
-
-	p += sprintf(p, "IRQ ");
-
-	for_each_online_cpu(cpu) {
-		p += sprintf(p, "        CPU%d", cpu);
-	}
-
-	for (irq = 0; irq < XNARCH_NR_IRQS; irq++) {
-		if (rthal_irq_handler(&rthal_domain, irq) == NULL)
-			continue;
-
-		p += sprintf(p, "\n%3d:", irq);
-
-		for_each_online_cpu(cpu) {
-			p += sprintf(p, "%12lu",
-				     rthal_cpudata_irq_hits(&rthal_domain, cpu,
-							    irq));
-		}
-
-		p += format_irq_proc(irq, p);
-	}
-
-	p += sprintf(p, "\n");
-
-	len = p - page - off;
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
-
-	return len;
 }
 
 #ifdef CONFIG_SMP
@@ -1094,6 +1050,75 @@ static int affinity_read_proc(char *page,
 	return len;
 }
 
+static void *irq_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	/*
+	 * Note: Position 0 is the header, so we need to
+	 * use <= instead of <
+	 */
+	return (*pos <= XNARCH_NR_IRQS) ? pos : NULL;
+}
+
+static void irq_seq_stop(struct seq_file *f, void *v)
+{
+	/* Nothing to do */
+}
+
+static void *irq_seq_next(struct seq_file *f, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	if (*pos > XNARCH_NR_IRQS)
+		return NULL;
+
+	return pos;
+}
+
+static int irq_seq_show(struct seq_file *f, void *v)
+{
+	unsigned int i = *(loff_t *) v;
+	unsigned int irq, cpu;
+
+	if (i == 0) {
+		seq_puts(f, "IRQ ");
+		for_each_online_cpu(cpu) {
+			seq_printf(f, "        CPU%u", cpu);
+		}
+		seq_putc(f, '\n');
+
+		return 0;
+	}
+
+	irq = i - 1;
+	if (rthal_irq_handler(&rthal_domain, irq) == NULL)
+		return 0;
+
+	seq_printf(f, "%3d:", irq);
+
+	for_each_online_cpu(cpu) {
+		seq_printf(f, "%12lu",
+			   rthal_cpudata_irq_hits(&rthal_domain, cpu,
+						  irq));
+	}
+
+	format_irq_proc(irq, f);
+	seq_putc(f, '\n');
+
+	return 0;
+}
+
+static struct seq_operations irq_seq_ops = {
+	.start	= irq_seq_start,
+	.next	= irq_seq_next,
+	.stop	= irq_seq_stop,
+	.show	= irq_seq_show,
+};
+
+static int irq_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &irq_seq_ops);
+}
+
 static int affinity_write_proc(struct file *file,
 			       const char __user * buffer,
 			       unsigned long count, void *data)
@@ -1124,10 +1149,16 @@ static int affinity_write_proc(struct file *file,
 }
 #endif /* CONFIG_SMP */
 
+static struct file_operations irq_seq_operations = {
+	.open		= irq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 void xnintr_init_proc(void)
 {
-	rthal_add_proc_leaf("irq", &irq_read_proc, NULL, NULL,
-			    rthal_proc_root);
+	rthal_add_proc_seq("irq", &irq_seq_operations, 0, rthal_proc_root);
 #ifdef CONFIG_SMP
 	rthal_add_proc_leaf("affinity", &affinity_read_proc,
 			    &affinity_write_proc, NULL, rthal_proc_root);
-- 
1.6.0.2



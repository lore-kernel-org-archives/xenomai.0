From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [dovetail][RFC PATCH 5/5] kernel/irq/proc: Implement
 /proc/interrupt_log_times
Date: Tue,  2 Nov 2021 17:09:55 +0100
Message-Id: <20211102160955.3067995-5-florian.bezdeka@siemens.com>
In-Reply-To: <20211102160955.3067995-1-florian.bezdeka@siemens.com>
References: <20211102160955.3067995-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Show the maximum time an interrupt stayed in the IRQ log on each CPU.
Heavily inspired by show_interrupts().

Both logs (inband as well as out of band) are taken into account and
are visible now.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

The coverletter has an example of how this file looks like on the
affected machine.

Especially the timing values for the "Out-of-band LAPIC timer interrupt" 
IRQ have significant values. I already tried to trace that, but as
already written in the cover-letter: The problem disappears once tracing
is enabled.

Any ideas?

 fs/proc/interrupts.c      |  8 ++++++
 include/linux/interrupt.h |  1 +
 kernel/irq/proc.c         | 53 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cbf09..4d075b1b5e18 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -34,9 +34,17 @@ static const struct seq_operations int_seq_ops = {
 	.show  = show_interrupts
 };
 
+static const struct seq_operations int_logtime_seq_ops = {
+	.start = int_seq_start,
+	.next  = int_seq_next,
+	.stop  = int_seq_stop,
+	.show  = show_pipeline_log_times
+};
+
 static int __init proc_interrupts_init(void)
 {
 	proc_create_seq("interrupts", 0, NULL, &int_seq_ops);
+	proc_create_seq("interrupt_log_times", 0, NULL, &int_logtime_seq_ops);
 	return 0;
 }
 fs_initcall(proc_interrupts_init);
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0c6656b32278..f6a7a7bae593 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -809,6 +809,7 @@ u64 irq_timings_next_event(u64 now);
 
 struct seq_file;
 int show_interrupts(struct seq_file *p, void *v);
+int show_pipeline_log_times(struct seq_file *p, void *v);
 int arch_show_interrupts(struct seq_file *p, int prec);
 
 extern int early_irq_init(void);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 13ddb3d28e9c..43c59bd043fc 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -457,6 +457,59 @@ int __weak arch_show_interrupts(struct seq_file *p, int prec)
 # define ACTUAL_NR_IRQS nr_irqs
 #endif
 
+int show_pipeline_log_times(struct seq_file *p, void *v)
+{
+	int i = *(loff_t *) v, cpu;
+	unsigned long flags, any_count = 0;
+	struct irqaction *action;
+	struct irq_desc *desc;
+	struct pipe_stats *oob_stats, *ib_stats;
+
+	if (i > ACTUAL_NR_IRQS)
+		return 0;
+
+	rcu_read_lock();
+	desc = irq_to_desc(i);
+	if (!desc || irq_settings_is_hidden(desc))
+		goto out;
+
+	if (desc->ib_stats && desc->oob_stats)
+		for_each_online_cpu(cpu) {
+			ib_stats = per_cpu_ptr(desc->ib_stats, cpu);
+			oob_stats = per_cpu_ptr(desc->oob_stats, cpu);
+
+			any_count |= ib_stats->max_log_time;
+			any_count |= oob_stats->max_log_time;
+		}
+
+	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+		goto out;
+
+	seq_printf(p, "IRQ %6d: ", i);
+	for_each_online_cpu(cpu) {
+		ib_stats = per_cpu_ptr(desc->ib_stats, cpu);
+		oob_stats = per_cpu_ptr(desc->oob_stats, cpu);
+		seq_printf(p, "%6llu/%-2llu ",
+			   ib_stats ? ib_stats->max_log_time / 1000 : 0,
+			   oob_stats ? oob_stats->max_log_time / 1000 : 0);
+	}
+
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	action = desc->action;
+	if (action) {
+		seq_printf(p, " %s", action->name);
+		while ((action = action->next) != NULL)
+			seq_printf(p, ", %s", action->name);
+	}
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	seq_putc(p, '\n');
+out:
+	rcu_read_unlock();
+
+	return 0;
+}
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	static int prec;
-- 
2.30.2



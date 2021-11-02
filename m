From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [dovetail][RFC PATCH 4/5] kernel/irq/proc: Integrate post/pull/merge
 counters into /proc/interrupts
Date: Tue,  2 Nov 2021 17:09:54 +0100
Message-Id: <20211102160955.3067995-4-florian.bezdeka@siemens.com>
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

For each CPU the following IRQ information will be shown:
  - inband post counter
  - inband pull counter
  - inband merge counter
  - Linux accounting (unmodified)
  - out of band post counter
  - out of band pull counter
  - out of band merge counter

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

The cover letter has an example attached. As expected the out-of-band
values are always 0. Only IRQ 61 was merged once.

When booting up with idle=poll the problem is gone, but I can see that many
timer IRQs (IRQ0) are merged.

The number of "Local timer interrupts" matches the number of 
"Out-of-band LAPIC timer interrupt"

 kernel/irq/proc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 210c5009d7a9..13ddb3d28e9c 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -465,6 +465,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	int i = *(loff_t *) v, j;
 	struct irqaction *action;
 	struct irq_desc *desc;
+	struct pipe_stats *oob_stats, *ib_stats;
 
 	if (i > ACTUAL_NR_IRQS)
 		return 0;
@@ -479,7 +480,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 		seq_printf(p, "%*s", prec + 8, "");
 		for_each_online_cpu(j)
-			seq_printf(p, "CPU%-8d", j);
+			seq_printf(p, "CPU%-12d", j);
 		seq_putc(p, '\n');
 	}
 
@@ -496,9 +497,20 @@ int show_interrupts(struct seq_file *p, void *v)
 		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);
-	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ?
-					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
+	for_each_online_cpu(j) {
+		ib_stats = per_cpu_ptr(desc->ib_stats, j);
+		oob_stats = per_cpu_ptr(desc->oob_stats, j);
+		seq_printf(p, "%u/%u/%u-%u-%u/%u/%u  ",
+			   ib_stats ? ib_stats->post_cnt : 0,
+			   ib_stats ? ib_stats->pull_cnt : 0,
+			   ib_stats ? ib_stats->post_merge_cnt : 0,
+			   desc->kstat_irqs ?
+				   *per_cpu_ptr(desc->kstat_irqs, j) :
+					 0,
+			   oob_stats ? oob_stats->post_cnt : 0,
+			   oob_stats ? oob_stats->pull_cnt : 0,
+			   oob_stats ? oob_stats->post_merge_cnt : 0);
+	}
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
-- 
2.30.2



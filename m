From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [dovetail][RFC PATCH 3/5] kernel/irq/pipeline: Instrument
 irq_post_stage and pull_next_irq
Date: Tue,  2 Nov 2021 17:09:53 +0100
Message-Id: <20211102160955.3067995-3-florian.bezdeka@siemens.com>
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

 - Remember how often an IRQ was posted into and pulled from the IRQ log
 - Measure the time between push and pull
 - Count how often we merge IRQs
   (multiple post events before pulling again)

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/pipeline.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index f64d731e8db1..7fcc03b74459 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -592,10 +592,18 @@ static inline bool irq_post_check(struct irq_stage *stage, unsigned int irq)
 
 #if __IRQ_STAGE_MAP_LEVELS == 4
 
+static inline struct pipe_stats __percpu *get_stage_stats(struct irq_stage *s,
+							  struct irq_desc *desc)
+{
+	return this_cpu_ptr(s->index == 0 ? desc->ib_stats : desc->oob_stats);
+}
+
 /* Must be called hard irqs off. */
 void irq_post_stage(struct irq_stage *stage, unsigned int irq)
 {
 	struct irq_stage_data *p = this_staged(stage);
+	struct irq_desc *desc = irq_to_cached_desc(irq);
+	struct pipe_stats __percpu *stats = get_stage_stats(stage, desc);
 	int l0b, l1b, l2b;
 
 	if (irq_post_check(stage, irq))
@@ -605,10 +613,20 @@ void irq_post_stage(struct irq_stage *stage, unsigned int irq)
 	l1b = irq / (BITS_PER_LONG * BITS_PER_LONG);
 	l2b = irq / BITS_PER_LONG;
 
+	if (test_bit(irq, p->log.map->flat)
+	    && test_bit(l2b, p->log.map->index_2)
+	    && test_bit(l1b, p->log.map->index_1)
+	    && test_bit(l0b, &p->log.index_0))
+		stats->post_merge_cnt++;
+	else
+		stats->post_time = local_clock();
+
 	__set_bit(irq, p->log.map->flat);
 	__set_bit(l2b, p->log.map->index_2);
 	__set_bit(l1b, p->log.map->index_1);
 	__set_bit(l0b, &p->log.index_0);
+
+	stats->post_cnt++;
 }
 EXPORT_SYMBOL_GPL(irq_post_stage);
 
@@ -619,6 +637,9 @@ EXPORT_SYMBOL_GPL(irq_post_stage);
 static inline int pull_next_irq(struct irq_stage_data *p)
 {
 	unsigned long l0m, l1m, l2m, l3m;
+	struct irq_desc *desc;
+	struct pipe_stats __percpu *stats;
+	u64 core_time, max_log_time, diff;
 	int l0b, l1b, l2b, l3b;
 	unsigned int irq;
 
@@ -660,6 +681,19 @@ static inline int pull_next_irq(struct irq_stage_data *p)
 		}
 	}
 
+	desc = irq_to_cached_desc(irq);
+	stats = get_stage_stats(p->stage, desc);
+
+	core_time = local_clock();
+	stats->pull_time = core_time;
+	stats->pull_cnt++;
+
+	max_log_time = stats->max_log_time;
+	diff = core_time - stats->post_time;
+
+	if (diff > max_log_time)
+		stats->max_log_time = diff;
+
 	return irq;
 }
 
-- 
2.30.2



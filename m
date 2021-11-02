From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [dovetail][RFC PATCH 2/5] kernel/irq/irqdesc: Extend struct irq_desc
 with a few cpu specific members
Date: Tue,  2 Nov 2021 17:09:52 +0100
Message-Id: <20211102160955.3067995-2-florian.bezdeka@siemens.com>
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

Extend the struct and make sure all members are initialized / cleaned
up properly. All new members will be used by the following patches.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/linux/irqdesc.h | 11 +++++++++++
 kernel/irq/irqdesc.c    | 24 ++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index f134909335c8..3b8dc874c225 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -17,6 +17,15 @@ struct irq_desc;
 struct irq_domain;
 struct pt_regs;
 
+struct pipe_stats {
+	u64 		post_time;
+	u64 		pull_time;
+	u64 		max_log_time;
+	unsigned int 	post_cnt;
+	unsigned int 	pull_cnt;
+	unsigned int 	post_merge_cnt;
+};
+
 /**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
@@ -102,6 +111,8 @@ struct irq_desc {
 	int			parent_irq;
 	struct module		*owner;
 	const char		*name;
+	struct pipe_stats __percpu 	*oob_stats;
+	struct pipe_stats __percpu	*ib_stats;
 } ____cacheline_internodealigned_in_smp;
 
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 47c70b48b8df..7bb2f065ba27 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -101,6 +101,16 @@ static inline void
 desc_smp_init(struct irq_desc *desc, int node, const struct cpumask *affinity) { }
 #endif
 
+static void desc_pipe_stats_init(struct pipe_stats *ps)
+{
+	ps->post_time = 0;
+	ps->pull_time = 0;
+	ps->max_log_time = 0;
+	ps->post_cnt = 0;
+	ps->pull_cnt = 0;
+	ps->post_merge_cnt = 0;
+}
+
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 			      const struct cpumask *affinity, struct module *owner)
 {
@@ -123,8 +133,11 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
+		desc_pipe_stats_init(per_cpu_ptr(desc->ib_stats, cpu));
+		desc_pipe_stats_init(per_cpu_ptr(desc->oob_stats, cpu));
+	}
 	desc_smp_init(desc, node, affinity);
 }
 
@@ -396,7 +409,10 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 		return NULL;
 	/* allocate based on nr_cpu_ids */
 	desc->kstat_irqs = alloc_percpu(unsigned int);
-	if (!desc->kstat_irqs)
+	desc->oob_stats = alloc_percpu(struct pipe_stats);
+	desc->ib_stats = alloc_percpu(struct pipe_stats);
+
+	if (!desc->kstat_irqs || !desc->oob_stats || !desc->ib_stats)
 		goto err_desc;
 
 	if (alloc_masks(desc, node))
@@ -415,6 +431,8 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
 
 err_kstat:
 	free_percpu(desc->kstat_irqs);
+	free_percpu(desc->oob_stats);
+	free_percpu(desc->ib_stats);
 err_desc:
 	kfree(desc);
 	return NULL;
@@ -426,6 +444,8 @@ static void irq_kobj_release(struct kobject *kobj)
 
 	free_masks(desc);
 	free_percpu(desc->kstat_irqs);
+	free_percpu(desc->oob_stats);
+	free_percpu(desc->ib_stats);
 	kfree(desc);
 }
 
-- 
2.30.2



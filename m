From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 5/6] genirq: irq_pipeline: export oob status to
 /proc/interrupts
Date: Thu, 22 Jul 2021 11:48:58 +0200
Message-Id: <20210722094859.3580166-6-rpm@xenomai.org>
In-Reply-To: <20210722094859.3580166-1-rpm@xenomai.org>
References: <20210722094859.3580166-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/irq/proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 7c5cd42df3b93e7..1428d83d7da8658 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -518,6 +518,9 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_printf(p, " %*s", prec, "");
 #ifdef CONFIG_GENERIC_IRQ_SHOW_LEVEL
 	seq_printf(p, " %-8s", irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge");
+#endif
+#ifdef CONFIG_IRQ_PIPELINE
+	seq_printf(p, " %-3s", irq_settings_is_oob(desc) ? "oob" : "");
 #endif
 	if (desc->name)
 		seq_printf(p, "-%-8s", desc->name);
-- 
2.31.1



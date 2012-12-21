From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:07 +0100
Message-Id: <1356096375-29859-3-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 02/10] ipipe: Harden clocks used by ftrace and perf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Convert local_irq_save/restore into hw variates in those cpu/sched_clock
paths that are used by ftrace and perf. We don't want to trace them to
reduce the overhead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/sched/clock.c       |    6 ++++--
 kernel/trace/trace_clock.c |    4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c685e31..67cad6f 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -216,7 +216,9 @@ u64 sched_clock_cpu(int cpu)
 	struct sched_clock_data *scd;
 	u64 clock;
 
+#ifndef CONFIG_IPIPE
 	WARN_ON_ONCE(!irqs_disabled());
+#endif
 
 	if (sched_clock_stable)
 		return sched_clock();
@@ -293,9 +295,9 @@ u64 cpu_clock(int cpu)
 	u64 clock;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save_notrace();
 	clock = sched_clock_cpu(cpu);
-	local_irq_restore(flags);
+	hard_local_irq_restore_notrace(flags);
 
 	return clock;
 }
diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 3947835..4e297ad 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -83,7 +83,7 @@ u64 notrace trace_clock_global(void)
 	int this_cpu;
 	u64 now;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save_notrace();
 
 	this_cpu = raw_smp_processor_id();
 	now = cpu_clock(this_cpu);
@@ -109,7 +109,7 @@ u64 notrace trace_clock_global(void)
 	arch_spin_unlock(&trace_clock_struct.lock);
 
  out:
-	local_irq_restore(flags);
+	hard_local_irq_restore_notrace(flags);
 
 	return now;
 }
-- 
1.7.1



From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:38:07 +0200
Message-Id: <20180925103809.4932-31-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 30/32] x86: ipipe: remove 32bit support from
 shared context switch code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 arch/x86/kernel/process_32.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 2bada263542c..0568f909ec70 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -235,11 +235,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	struct fpu *next_fpu = &next->fpu;
 	int cpu = raw_smp_processor_id();
 	struct tss_struct *tss = &per_cpu(cpu_tss_rw, cpu);
-	int slope = ipipe_get_domain_slope_hook(prev_p, next_p);
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	switch_fpu_prepare(prev_fpu, cpu, slot);
+	switch_fpu_prepare(prev_fpu, cpu);
 
 	/*
 	 * Save away %gs. No need to save %fs, as it was saved on the
@@ -300,7 +299,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (prev->gs | next->gs)
 		lazy_load_gs(next->gs);
 
-	switch_fpu_finish(next_fpu, cpu, slope);
+	switch_fpu_finish(next_fpu, cpu);
 
 	this_cpu_write(current_task, next_p);
 
-- 
2.14.4



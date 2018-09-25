From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:12 +0200
Message-Id: <20180925102716.4492-8-rpm@xenomai.org>
In-Reply-To: <20180925102716.4492-1-rpm@xenomai.org>
References: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 07/11] arm64: ipipe: turn hard irqs on when
 leaving the idle state
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

As required to mimic the original behavior when interrupt pipelining
is in effect.
---
 arch/arm64/kernel/process.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index e958102fc69b..395a024d0ca3 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -73,36 +73,6 @@ EXPORT_SYMBOL_GPL(pm_power_off);
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
-#ifdef CONFIG_IPIPE
-static void __ipipe_halt_root(void)
-{
-	struct ipipe_percpu_domain_data *p;
-
-	/*
-	 * Emulate idle entry sequence over the root domain, which is
-	 * stalled on entry.
-	 */
-	hard_local_irq_disable();
-
-	p = ipipe_this_cpu_root_context();
-	__clear_bit(IPIPE_STALL_FLAG, &p->status);
-
-	if (unlikely(__ipipe_ipending_p(p)))
-		__ipipe_sync_stage();
-	else {
-		cpu_do_idle();
-	}
-}
-
-#else /* !CONFIG_IPIPE */
-
-static void __ipipe_halt_root(void)
-{
-	cpu_do_idle();
-}
-
-#endif /* !CONFIG_IPIPE */
-
 /*
  * This is our default idle handler.
  */
@@ -113,10 +83,8 @@ void arch_cpu_idle(void)
 	 * tricks
 	 */
 	trace_cpu_idle_rcuidle(1, smp_processor_id());
-	if (!need_resched())
-		__ipipe_halt_root();
 	cpu_do_idle();
-	local_irq_enable();
+	local_irq_enable_full();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
-- 
2.14.4



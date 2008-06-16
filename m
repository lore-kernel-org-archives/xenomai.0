Message-ID: <48568E78.5000606@domain.hid>
Date: Mon, 16 Jun 2008 18:02:00 +0200
From: Pierangelo Masarati <masarati@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060304000304010704030606"
Subject: [Adeos-main]  latency fix for 2.6.25?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------060304000304010704030606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear ADEOS users,

2.6.25 seems to show abnormal latencies on hardware that showed good 
performances up to 2.6.24.  We think we traced down the issue to x86's 
process_xx.c, which disappeared after regressing default_idle() to 
2.6.24.  The related changes are described in the attached patch.

Sincerely, p.


--------------060304000304010704030606
Content-Type: text/x-patch;
 name="process_xx-2.6.25.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="process_xx-2.6.25.patch"

--- process_32.c.orig	2008-04-17 04:49:44.000000000 +0200
+++ process_32.c	2008-06-16 09:38:20.000000000 +0200
@@ -111,20 +111,25 @@ void default_idle(void)
 		 */
 		smp_mb();
 
-		local_irq_disable();
+		local_irq_disable_hw();
 		if (!need_resched()) {
+#ifndef CONFIG_IPIPE
 			ktime_t t0, t1;
 			u64 t0n, t1n;
 
 			t0 = ktime_get();
 			t0n = ktime_to_ns(t0);
+#endif
 			safe_halt();	/* enables interrupts racelessly */
+#ifndef CONFIG_IPIPE
 			local_irq_disable();
 			t1 = ktime_get();
 			t1n = ktime_to_ns(t1);
 			sched_clock_idle_wakeup_event(t1n - t0n);
-		}
-		local_irq_enable();
+			local_irq_enable(); /* This will force enable_hw as well. */
+#endif
+		} else
+			local_irq_enable_hw();
 		current_thread_info()->status |= TS_POLLING;
 	} else {
 		/* loop is done by the caller */
@@ -203,6 +208,7 @@ void cpu_idle(void)
 				play_dead();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+ 			ipipe_suspend_domain();
 			idle();
 		}
 		tick_nohz_restart_sched_tick();
@@ -269,6 +275,11 @@ static int __cpuinit mwait_usable(const 
 
 void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
+#ifdef CONFIG_IPIPE
+#define default_to_mwait force_mwait
+#else
+#define default_to_mwait 1
+#endif
 	static int selected;
 
 	if (selected)
@@ -284,7 +295,7 @@ void __cpuinit select_idle_routine(const
 		 * Skip, if setup has overridden idle.
 		 * One CPU supports mwait => All CPUs supports mwait
 		 */
-		if (!pm_idle) {
+		if (!pm_idle && default_to_mwait) {
 			printk(KERN_INFO "using mwait in idle threads.\n");
 			pm_idle = mwait_idle;
 		}
--- process_64.c.orig	2008-04-17 04:49:44.000000000 +0200
+++ process_64.c	2008-06-16 09:38:20.000000000 +0200
@@ -53,6 +53,8 @@
 
 asmlinkage extern void ret_from_fork(void);
 
+asmlinkage extern void thread_return(void);
+
 unsigned long kernel_thread_flags = CLONE_VM | CLONE_UNTRACED;
 
 unsigned long boot_option_idle_override = 0;
@@ -105,20 +107,25 @@ void default_idle(void)
 	 * test NEED_RESCHED:
 	 */
 	smp_mb();
-	local_irq_disable();
+	local_irq_disable_hw();
 	if (!need_resched()) {
+#ifndef CONFIG_IPIPE
 		ktime_t t0, t1;
 		u64 t0n, t1n;
 
 		t0 = ktime_get();
 		t0n = ktime_to_ns(t0);
+#endif
 		safe_halt();	/* enables interrupts racelessly */
+#ifndef CONFIG_IPIPE
 		local_irq_disable();
 		t1 = ktime_get();
 		t1n = ktime_to_ns(t1);
 		sched_clock_idle_wakeup_event(t1n - t0n);
-	}
-	local_irq_enable();
+		local_irq_enable(); /* This will force enable_hw as well. */
+#endif
+	} else
+		local_irq_enable_hw();
 	current_thread_info()->status |= TS_POLLING;
 }
 
@@ -185,6 +192,7 @@ void cpu_idle(void)
 			 */
 			local_irq_disable();
 			enter_idle();
+ 			ipipe_suspend_domain();
 			idle();
 			/* In many cases the interrupt that ended idle
 			   has already called exit_idle. But some idle
@@ -265,6 +273,11 @@ static int __cpuinit mwait_usable(const 
 
 void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 {
+#ifdef CONFIG_IPIPE
+#define default_to_mwait force_mwait
+#else
+#define default_to_mwait 1
+#endif
 	static int selected;
 
 	if (selected)
@@ -280,7 +293,7 @@ void __cpuinit select_idle_routine(const
 		 * Skip, if setup has overridden idle.
 		 * One CPU supports mwait => All CPUs supports mwait
 		 */
-		if (!pm_idle) {
+ 		if (!pm_idle && default_to_mwait) {
 			printk(KERN_INFO "using mwait in idle threads.\n");
 			pm_idle = mwait_idle;
 		}
@@ -483,6 +496,7 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.sp = (unsigned long) childregs;
 	p->thread.sp0 = (unsigned long) (childregs+1);
 	p->thread.usersp = me->thread.usersp;
+ 	p->thread.rip = (unsigned long) thread_return;
 
 	set_tsk_thread_flag(p, TIF_FORK);
 
@@ -602,7 +616,7 @@ __switch_to(struct task_struct *prev_p, 
 {
 	struct thread_struct *prev = &prev_p->thread,
 				 *next = &next_p->thread;
-	int cpu = smp_processor_id();
+	int cpu = raw_smp_processor_id();
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
 	/* we're going to use this soon, after a few expensive things */

--------------060304000304010704030606--


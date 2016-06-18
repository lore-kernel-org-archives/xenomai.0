Date: Sat, 18 Jun 2016 19:20:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160618172041.GF18433@hermes.click-hack.org>
References: <20160618130822.GB18433@hermes.click-hack.org>
 <8e8bb173-eda9-bab4-6236-634da1e396cb@xenomai.org>
 <20160618135235.GE18433@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160618135235.GE18433@hermes.click-hack.org>
Subject: Re: [Xenomai] ftrace dispatch function broken on 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sat, Jun 18, 2016 at 03:52:35PM +0200, Gilles Chanteperdrix wrote:
> On Sat, Jun 18, 2016 at 03:21:40PM +0200, Philippe Gerum wrote:
> > On 06/18/2016 03:08 PM, Gilles Chanteperdrix wrote:
> > > Hi Philippe,
> > > 
> > > it seems since I-pipe commit
> > > b115c4094d734e19fa7a96be1bf3958b3d244b8b on the ipipe-3.18 branch:
> > >     Revert "ipipe: Register function tracer for direct and exclusive invocation"
> > >     
> > >     This reverts commit e00888b4aae45d9b84698a62079dde14c9be5fd3.
> > >     
> > >     We now have an I-pipe-compatible dispatching function for ftrace.
> > > 
> > > The ftrace dispatching function causes the following warning at
> > > boot on x86_32 with all warnings/debugs enabled:
> > > [    4.730812] I-pipe: head domain Xenomai registered.
> > > [    4.737967] I-pipe: Detected illicit call from head domain 'Xenomai'
> > > [    4.737967]         into a regular Linux service
> > > 
> > > Because it calls preempt_disable(), which is not safe to be called
> > > form root domain, when runnning over 2.6.x on an architecture such
> > > as x86_32 which does not have IPIPE_HAVE_SAFE_THREAD_INFO.
> > > 
> > > Should we make the ftrace dispatching function really I-pipe
> > > compatible by calling ipipe_preempt_disable() in that case instead?
> > > or should we make the patch revert conditional to !IPIPE_LEGACY or
> > > IPIPE_HAVE_SAFE_THREAD_INFO (but that would make only the I-pipe
> > > tracer work in that case).
> > > 
> > 
> > I would go for the change which has the lesser impact on the mainline
> > code; that would be option #1.
> 
> Ok, now I get:
> 
>    12.958818] I-pipe: Detected stalled head domain, probably caused by a bug.
> [   12.958818]         A critical section may have been left unterminated.
> 
> I guess in the following sequence:
> 
> #define hard_preempt_disable()				\
> 	({						\
> 		unsigned long __flags__;		\
> 		__flags__ = hard_local_irq_save();	\
> 		if (__ipipe_root_p)			\
> 			preempt_disable();		\
> 		__flags__;				\
> 	})
> 
> preempt_disable() gets called with the head domain stalled, while
> current domain is root, and ipipe_root_only() treats this as an
> error.

So, I have disabled context checking around the call to
preempt_disable(), see the following patch, but the tracer overhead
becomes huge.

diff --git a/include/linux/ipipe_base.h b/include/linux/ipipe_base.h
index a37358c..4ea7499 100644
--- a/include/linux/ipipe_base.h
+++ b/include/linux/ipipe_base.h
@@ -311,6 +311,8 @@ static inline void __ipipe_report_cleanup(struct mm_struct *mm) { }
 
 static inline void __ipipe_init_taskinfo(struct task_struct *p) { }
 
+#define hard_preempt_disable_notrace()	({ preempt_disable_notrace(); 0; })
+#define hard_preempt_enable_notrace(flags) ({ preempt_enable_notrace(); (void)(flags); })
 #define hard_preempt_disable()		({ preempt_disable(); 0; })
 #define hard_preempt_enable(flags)	({ preempt_enable(); (void)(flags); })
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7fdf00b..216c0c9 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -126,23 +126,52 @@ do { \
 #endif /* CONFIG_PREEMPT_COUNT */
 
 #ifdef CONFIG_IPIPE
-#define hard_preempt_disable()				\
-	({						\
-		unsigned long __flags__;		\
-		__flags__ = hard_local_irq_save();	\
-		if (__ipipe_root_p)			\
-			preempt_disable();		\
-		__flags__;				\
+#define hard_preempt_disable_notrace()					\
+	({								\
+		unsigned long __flags__;				\
+		__flags__ = hard_local_irq_save_notrace();		\
+		if (__ipipe_root_p) {					\
+			int __state__ = ipipe_disable_context_check();	\
+			preempt_disable_notrace();			\
+			ipipe_restore_context_check(__state__);		\
+		}							\
+		__flags__;						\
 	})
 
-#define hard_preempt_enable(__flags__)			\
-	do {						\
-		if (__ipipe_root_p) {			\
-			preempt_enable_no_resched();	\
-			hard_local_irq_restore(__flags__);	\
-			preempt_check_resched();	\
-		} else					\
-			hard_local_irq_restore(__flags__);	\
+#define hard_preempt_enable_notrace(__flags__)				\
+	do {								\
+		if (__ipipe_root_p) {					\
+			int __state__ = ipipe_disable_context_check();	\
+			preempt_enable_no_resched_notrace();		\
+			ipipe_restore_context_check(__state__);		\
+			hard_local_irq_restore_notrace(__flags__);	\
+			preempt_check_resched();			\
+		} else							\
+			hard_local_irq_restore_notrace(__flags__);	\
+	} while (0)
+
+#define hard_preempt_disable()						\
+	({								\
+		unsigned long __flags__;				\
+		__flags__ = hard_local_irq_save();			\
+		if (__ipipe_root_p) {					\
+			int __state__ = ipipe_disable_context_check();	\
+			preempt_disable();				\
+			ipipe_restore_context_check(__state__);		\
+		}							\
+		__flags__;						\
+	})
+
+#define hard_preempt_enable(__flags__)					\
+	do {								\
+		if (__ipipe_root_p) {					\
+			int __state__ = ipipe_disable_context_check();	\
+			preempt_enable_no_resched();			\
+			ipipe_restore_context_check(__state__);		\
+			hard_local_irq_restore(__flags__);		\
+			preempt_check_resched();			\
+		} else							\
+			hard_local_irq_restore(__flags__);		\
 	} while (0)
 
 #elif defined(MODULE)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2a324bc..424e743 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4877,11 +4877,44 @@ static struct ftrace_ops control_ops = {
 	INIT_OPS_HASH(control_ops)
 };
 
+#if !defined(CONFIG_IPIPE_LEGACY) || defined(CONFIG_IPIPE_HAVE_SAFE_THREAD_INFO)
+static inline unsigned long ipipe_ftrace_preempt_disable(void)
+{
+	preempt_disable();
+	return 0;
+}
+
+static inline void ipipe_ftrace_preempt_enable(unsigned long flags)
+{
+#ifdef CONFIG_IPIPE
+	if (hard_irqs_disabled() || !__ipipe_root_p)
+		/*
+		 * Nothing urgent to schedule here. At latest the timer tick
+		 * will pick up whatever the tracing functions kicked off.
+		 */
+		preempt_enable_no_resched_notrace();
+	else
+#endif
+		preempt_enable_notrace();
+}
+#else /* legacy && !safe thread_info */
+static inline unsigned long ipipe_ftrace_preempt_disable(void)
+{
+	return hard_preempt_disable_notrace();
+}
+
+static inline void ipipe_ftrace_preempt_enable(unsigned long flags)
+{
+	hard_preempt_enable_notrace(flags);
+}
+#endif /* legacy && !safe thread_info */
+
 static inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *ignored, struct pt_regs *regs)
 {
 	struct ftrace_ops *op;
+	unsigned long flags;
 	int bit;
 
 	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
@@ -4892,7 +4925,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	 * Some of the ops may be dynamically allocated,
 	 * they must be freed after a synchronize_sched().
 	 */
-	preempt_disable_notrace();
+	flags = ipipe_ftrace_preempt_disable();
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		if (ftrace_ops_test(op, ip, regs)) {
 			if (FTRACE_WARN_ON(!op->func)) {
@@ -4903,16 +4936,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		}
 	} while_for_each_ftrace_op(op);
 out:
-#ifdef CONFIG_IPIPE
-	if (hard_irqs_disabled() || !__ipipe_root_p)
-		/*
-		 * Nothing urgent to schedule here. At latest the timer tick
-		 * will pick up whatever the tracing functions kicked off.
-		 */
-		preempt_enable_no_resched_notrace();
-	else
-#endif
-		preempt_enable_notrace();
+	ipipe_ftrace_preempt_enable(flags);
 	trace_clear_recursion(bit);
 }
 


-- 
					    Gilles.
https://click-hack.org


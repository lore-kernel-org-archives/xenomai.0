MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="QUIqWf9P86"
Content-Transfer-Encoding: 7bit
Message-ID: <18260.29573.817255.968962@domain.hid>
Date: Mon, 3 Dec 2007 22:22:13 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D375F08@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D375D6B@slcmail.slc.mew.int>
	<2ff1a98a0711270657y63482de1ref80ba849f172918@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375D71@domain.hid>
	<18259.5205.292521.503167@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375ECE@slcmail.slc.mew.int>
	<2ff1a98a0712030235vfc316b8nff4b1e422db82c96@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEC@slcmail.slc.mew.int>
	<2ff1a98a0712030552y1c9b10b8p54730d45f6245906@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375EEE@slcmail.slc.mew.int>
	<18260.25837.479943.881970@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D375F08@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] wathcdog
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org


--QUIqWf9P86
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Steven Seeger wrote:
 > > Ok. We can send the signal only to threads which are part of the same
 > > application as the faulting thread.
 > 
 > That would be a big help! At least then we can report which application
 > had the fault. We have a few applications that work together. 

Here it comes.


--QUIqWf9P86
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-wdog-signal.2.diff"
Content-Transfer-Encoding: 7bit

Index: include/native/task.h
===================================================================
--- include/native/task.h	(revision 3237)
+++ include/native/task.h	(working copy)
@@ -51,7 +51,8 @@
 #define T_NOSIG    XNASDI     /**< See #XNASDI    */ 
 #define T_SHIELD   XNSHIELD   /**< See #XNSHIELD  */ 
 #define T_WARNSW   XNTRAPSW   /**< See #XNTRAPSW  */ 
-#define T_RPIOFF   XNRPIOFF   /**< See #XNRPIOFF  */ 
+#define T_RPIOFF   XNRPIOFF   /**< See #XNRPIOFF  */
+#define T_SIGWDG   XNSIGWDG   /**< See #XNSIGWDG  */
 #define T_PRIMARY  0x00000200	/* Recycle internal bits status which */
 #define T_JOINABLE 0x00000400	/* won't be passed to the nucleus.  */
 /*! @} */ /* Ends doxygen-group native_task_status */
Index: include/posix/pthread.h
===================================================================
--- include/posix/pthread.h	(revision 3237)
+++ include/posix/pthread.h	(working copy)
@@ -161,6 +161,7 @@
 #define PTHREAD_WARNSW     XNTRAPSW
 #define PTHREAD_LOCK_SCHED XNLOCK
 #define PTHREAD_RPIOFF     XNRPIOFF
+#define PTHREAD_SIG_WDG    XNSIGWDG
 #define PTHREAD_PRIMARY    XNTHREAD_STATE_SPARE1
 
 #define PTHREAD_INOAUTOENA  XN_ISR_NOENABLE
Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 3237)
+++ include/nucleus/thread.h	(working copy)
@@ -57,6 +57,8 @@
 #define XNSHIELD  0x00010000 /**< IRQ shield is enabled (shadow only) */
 #define XNTRAPSW  0x00020000 /**< Trap execution mode switches */
 #define XNRPIOFF  0x00040000 /**< Stop priority coupling (shadow only) */
+#define XNSIGWDG  0x00080000 /**< Get signaled upon watchdog action (shadow
+			      * only) */
 
 #define XNFPU     0x00100000 /**< Thread uses FPU */
 #define XNSHADOW  0x00200000 /**< Shadow thread */
@@ -92,7 +94,7 @@
 }
 
 #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD)
-#define XNTHREAD_MODE_BITS    (XNLOCK|XNRRB|XNASDI|XNSHIELD|XNTRAPSW|XNRPIOFF)
+#define XNTHREAD_MODE_BITS    (XNLOCK|XNRRB|XNASDI|XNSHIELD|XNTRAPSW|XNRPIOFF|XNSIGWDG)
 
 /* These state flags are available to the real-time interfaces */
 #define XNTHREAD_STATE_SPARE0  0x10000000
Index: include/nucleus/pod.h
===================================================================
--- include/nucleus/pod.h	(revision 3237)
+++ include/nucleus/pod.h	(working copy)
@@ -196,6 +196,10 @@
 	atomic_counter_t timerlck;	/*!< Timer lock depth.  */
 #endif	/* __KERNEL__ */
 
+#if defined(CONFIG_XENO_OPT_WATCHDOG) && defined(CONFIG_XENO_OPT_PERVASIVE)
+	xnqueue_t uswdg_handlers; /*!< User space watchdog handlers. */
+#endif /* CONFIG_XENO_OPT_WATCHDOG && CONFIG_XENO_OPT_PERVASIVE */
+
 #ifdef __XENO_SIM__
 	void (*schedhook) (xnthread_t *thread, xnflags_t mask);	/*!< Internal scheduling hook. */
 #endif	/* __XENO_SIM__ */
Index: ksrc/skins/posix/thread.c
===================================================================
--- ksrc/skins/posix/thread.c	(revision 3237)
+++ ksrc/skins/posix/thread.c	(working copy)
@@ -617,6 +617,8 @@
  *   secondary mode;
  * - PTHREAD_WARNSW, when set, cause the signal SIGXCPU to be sent to the
  *   current thread, whenever it involontary switches to secondary mode;
+ * - PTHREAD_SIG_WDG, when set, causes the signal SIGRTMAX to be sent to the
+ *   current thread when a thread is killed by the watchdog;
  * - PTHREAD_PRIMARY, cause the migration of the current thread to primary
  *   mode.
  *
@@ -641,7 +643,7 @@
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	if (xnthread_test_state(cur, XNSHADOW))
-		valid_flags |= XNTHREAD_STATE_SPARE1 | XNSHIELD | XNTRAPSW | XNRPIOFF;
+		valid_flags |= XNTHREAD_STATE_SPARE1 | XNSHIELD | XNTRAPSW | XNRPIOFF | XNSIGWDG;
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
 	/* XNTHREAD_STATE_SPARE1 is used for primary mode switch. */
Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(revision 3237)
+++ ksrc/skins/native/task.c	(working copy)
@@ -1422,6 +1422,9 @@
  * mode. This feature is useful to detect unwanted migrations to the
  * Linux domain.
  *
+ * - When set, T_SIGWDG causes the SIGRTMAX signal to be sent to the
+ * current user-space task whenever a thread is killed by the watchdog.
+ *
  * - T_RPIOFF disables thread priority coupling between Xenomai and
  * Linux schedulers. This bit prevents the root Linux thread from
  * inheriting the priority of the running shadow Xenomai thread. Use
@@ -1484,7 +1487,7 @@
 	}
 
 	if (((clrmask | setmask) &
-	     ~(T_LOCK | T_RRB | T_NOSIG | T_SHIELD | T_WARNSW)) != 0)
+	     ~(T_LOCK | T_RRB | T_NOSIG | T_SHIELD | T_WARNSW | T_SIGWDG)) != 0)
 		return -EINVAL;
 
 	if (!xnpod_primary_p())
Index: ksrc/nucleus/timer.c
===================================================================
--- ksrc/nucleus/timer.c	(revision 3237)
+++ ksrc/nucleus/timer.c	(working copy)
@@ -792,7 +792,7 @@
 		base->timerq_rev++;
 		xnlock_put_irqrestore(&nklock, s);
 	}
-#endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
+#endif /* CONFIG_XENO_OPT_STATS */
 
 	xnarch_init_display_context(timer);
 }
@@ -831,7 +831,7 @@
 #ifdef CONFIG_XENO_OPT_STATS
 	removeq(&xntimer_base(timer)->timerq, &timer->tblink);
 	xntimer_base(timer)->timerq_rev++;
-#endif /* CONFIG_XENO_OPT_TIMING_PERIODIC */
+#endif /* CONFIG_XENO_OPT_STATS */
 	xnlock_put_irqrestore(&nklock, s);
 }
 
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 3237)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -144,6 +144,66 @@
 
 #ifdef CONFIG_XENO_OPT_WATCHDOG
 
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+struct xnpod_uswdg_handler {
+	xnthread_t *thread;
+	xnholder_t link;
+
+#define link2user_handler(laddr) \
+	container_of(laddr, struct xnpod_uswdg_handler, link)
+};
+
+static struct xnpod_uswdg_handler *xnpod_search_uswdg_handler(xnthread_t *thread)
+{
+	xnholder_t *holder;
+
+	for (holder = getheadq(&nkpod->uswdg_handlers);
+	     holder; holder = nextq(&nkpod->uswdg_handlers, holder)) {
+		struct xnpod_uswdg_handler *handler = link2user_handler(holder);
+		if (handler->thread == thread)
+			return handler;
+	}
+	return NULL;
+}
+
+static void xnpod_add_uswdg_handler(xnthread_t *thread)
+{
+	struct xnpod_uswdg_handler *handler;
+	if (xnpod_search_uswdg_handler(thread))
+		return;
+	handler = (struct xnpod_uswdg_handler *) xnmalloc(sizeof(*handler));
+	handler->thread = thread;
+	inith(&handler->link);
+	appendq(&nkpod->uswdg_handlers, &handler->link);
+}
+
+static void xnpod_del_uswdg_handler(xnthread_t *thread)
+{
+	struct xnpod_uswdg_handler *handler = xnpod_search_uswdg_handler(thread);
+	if (!handler)
+		return;
+	removeq(&nkpod->uswdg_handlers, &handler->link);
+	xnfree(handler);
+}
+
+static void xnpod_trigger_uswdg_handlers(xnthread_t *thread)
+{
+	struct mm_struct *mm; 
+	xnholder_t *holder;
+
+	mm = xnthread_user_task(thread) ? xnthread_user_task(thread)->mm : NULL;
+
+	for (holder = getheadq(&nkpod->uswdg_handlers);
+	     holder; holder = nextq(&nkpod->uswdg_handlers, holder)) {
+		struct xnpod_uswdg_handler *handler = link2user_handler(holder);
+		if (!mm || xnthread_user_task(handler->thread)->mm == mm)
+			xnshadow_send_sig(handler->thread, SIGRTMAX, 0);
+	}
+}
+#else /* !CONFIG_XENO_OPT_PERVASIVE */
+#define xnpod_trigger_uswdg_handlers(thread) do { } while(0)
+#endif /* !CONFIG_XENO_OPT_PERVASIVE */
+
 /*! 
  * @internal
  * \fn void xnpod_watchdog_handler(xntimer_t *timer)
@@ -170,6 +230,7 @@
 			   thread, xnthread_name(thread));
 		xnprintf("watchdog triggered -- killing runaway thread '%s'\n",
 			 xnthread_name(thread));
+		xnpod_trigger_uswdg_handlers(thread);
 		xnpod_delete_thread(thread);
 		xnpod_reset_watchdog(sched);
 	}
@@ -270,6 +331,10 @@
 	xnarch_atomic_set(&pod->timerlck, 0);
 #endif /* __KERNEL__ */
 
+#if defined(CONFIG_XENO_OPT_WATCHDOG) && defined(CONFIG_XENO_OPT_PERVASIVE)
+	initq(&pod->uswdg_handlers);
+#endif /* CONFIG_XENO_OPT_WATCHDOG && CONFIG_XENO_OPT_PERVASIVE */
+	
 #ifdef __XENO_SIM__
 	pod->schedhook = NULL;
 #endif /* __XENO_SIM__ */
@@ -1071,6 +1136,14 @@
 	if (!(oldmode & XNRRB) && xnthread_test_state(thread, XNRRB))
 		thread->rrcredit = thread->rrperiod;
 
+#if defined(CONFIG_XENO_OPT_WATCHDOG) && defined(CONFIG_XENO_OPT_PERVASIVE)
+	if (clrmask & XNSIGWDG)
+		xnpod_del_uswdg_handler(thread);
+
+	if (setmask & XNSIGWDG)
+		xnpod_add_uswdg_handler(thread);
+#endif /* CONFIG_XENO_OPT_WATCHDOG && CONFIG_XENO_OPT_PERVASIVE */
+
 	xnlock_put_irqrestore(&nklock, s);
 
 #ifdef CONFIG_XENO_OPT_ISHIELD
@@ -1175,6 +1248,9 @@
 	 * the startup barrier.
 	 */
 
+	if (xnthread_test_state(thread, XNSIGWDG))
+		xnpod_del_uswdg_handler(thread);
+
 	if (xnthread_user_task(thread) != NULL &&
 	    !xnthread_test_state(thread, XNDORMANT) &&
 	    !xnpod_current_p(thread)) {

--QUIqWf9P86
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit



 > 
 > > To be completely fair, Linux has the same problem: kernel-space has
 > > pids, user-space has pthread_t, and there is no way to make a
 > > correspondance between the two. The glibc probably has a way, but
 > there
 > > is no public service that makes this available to the user. Xenomai is
 > > not different from Linux with regard to this issue.
 > 
 > Yes, but Linux is not pretending to blend the existence of kernel and
 > userspace threads. :)
 >  
 > > Even if we used skin-level (note that the watchdog notification
 > > mechanism is done at nucleus level for now) services to try and return
 > a
 > > thread/task identifier to the user-space, by the time the watchdog
 > > signal get serviced, this identifier would have become invalid, since
 > > the watchdog kills the faulting thread.
 > 
 > Well, if the userspace program could register a watchdog handler for
 > each thread it creates, then it could store a void* with that handler
 > that's passed back to the userspace application. This handler would have
 > special meaning to that application, and so the correct behavior can be
 > performed. 
 > 
 > > The only way I see to solve your issue is to maintain, in your
 > > application, a list of running threads, and upon notification from the
 > > watchdog, poll each thread (using rt_task_inquire(task, NULL) with
 > > native or pthread_kill(thread, 0) with posix) in order to find which
 > one
 > > was killed.
 > 
 > What I suggested above makes the list unnecessary. The only reason this
 > may have to be done at skin level is because the nucleus can't call a
 > userspace handler. But, the skin could set up a queue and a thread that
 > waits on a message from the nucleus saying that a thread was killed, and
 > then the it could pass data back that is meaningful to the skin
 > (userspace handler and void* argument) for each registered handler, and
 > the skin could then call the appropriate function.
 > 
 > What do you think?

It is becoming awfully complicated for a very simple feature such as
xenomai watchdog. You are talking about adding at least a new syscall
(if not one by skin) to pass an opaque pointer to kernel-space.

-- 


					    Gilles Chanteperdrix.
--QUIqWf9P86--


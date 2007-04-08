From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] rt_heap return codes
Date: Sun, 8 Apr 2007 12:31:11 +0100
References: <200704080000.12934.paul_c@domain.hid> <4618262C.50006@domain.hid>
In-Reply-To: <4618262C.50006@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/JNGG7xc3S4nmul"
Message-Id: <200704081231.11244.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_/JNGG7xc3S4nmul
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 08 April 2007 00:15, Jan Kiszka wrote:
> [/usr/include/asm-generic/errno.h]
> #define EWOULDBLOCK =A0 =A0 EAGAIN

/me kicks backside for not reading the source..

> > Also noted that rt_heap_delete() returns -EBUSY if another task holds a
> > valid heap descriptor - Undocumented, but well worth having as it can be
> > used to prevent the RT_HEAP memory from disappearing (either by a module
> > unloading, or user space app terminating).
>
> Feel free to provide a patch to enhance the doc.

Attached, one patch documenting the -EBUSY return code along with a few min=
or=20
spelling/syntax corrections.


Regards, Paul.



--Boundary-00=_/JNGG7xc3S4nmul
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="native_doc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="native_doc.diff"

Index: include/rtdm/rtdm_driver.h
===================================================================
--- include/rtdm/rtdm_driver.h	(revision 2365)
+++ include/rtdm/rtdm_driver.h	(working copy)
@@ -519,7 +519,7 @@ static inline nanosecs_abs_t rtdm_clock_
  *
  * @param code_block Commands to be executed atomically
  *
- * @note It is not allowed to leave the code block explicitely by using
+ * @note It is not allowed to leave the code block explicitly by using
  * @c break, @c return, @c goto, etc. This would leave the global lock held
  * during the code block execution in an inconsistent state. Moreover, do not
  * embed complex operations into the code bock. Consider that they will be
Index: include/asm-i386/bits/pod.h
===================================================================
--- include/asm-i386/bits/pod.h	(revision 2365)
+++ include/asm-i386/bits/pod.h	(working copy)
@@ -106,7 +106,7 @@ static inline void xnarch_switch_to(xnar
 		   thread which has previously requested I/O permissions. We
 		   don't want the unexpected latencies induced by lazy update
 		   from the GPF handler to bite shadow threads that
-		   explicitely told the kernel that they would need to perform
+		   explicitly told the kernel that they would need to perform
 		   raw I/O ops. */
 
 		wrap_switch_iobitmap(prev, rthal_processor_id());
Index: sim/vm/thread.h
===================================================================
--- sim/vm/thread.h	(revision 2365)
+++ sim/vm/thread.h	(working copy)
@@ -106,7 +106,7 @@ private:
 
     MvmTimer *timer;
 
-    MvmSynchro *pendSynchro;	// explicitely pended synchro
+    MvmSynchro *pendSynchro;	// explicitly pended synchro
 
     MvmSynchro *sigSynchro;	// last signaled synchro
 
Index: sim/scope/tcl/datawatch.tcl
===================================================================
--- sim/scope/tcl/datawatch.tcl	(revision 2365)
+++ sim/scope/tcl/datawatch.tcl	(working copy)
@@ -914,7 +914,7 @@ proc DataDisplay:updateLocalData {debugf
 
     foreach expr $displayList {
 	if {[lsearch $hiddenList $expr] != -1} {
-	    # expr was explicitely undisplayed -- ignore it
+	    # expr was explicitly undisplayed -- ignore it
 	    continue
 	}
 
Index: sim/scope/tcl/debugger.tcl
===================================================================
--- sim/scope/tcl/debugger.tcl	(revision 2365)
+++ sim/scope/tcl/debugger.tcl	(working copy)
@@ -1465,7 +1465,7 @@ proc Debugger:notifyBreak {context locat
 
 	# If a break condition has been raised, ensure the display is
 	# in sync with the execution path, unless the current view
-	# as been explicitely locked on a given thread. To
+	# as been explicitly locked on a given thread. To
 	# achieve this, just switch the focus of the operating frame
 	# to "system".  Setting the focus to the destination value
 	# prior to pick the "system" entry from the focus combo
Index: ksrc/skins/uitron/task.c
===================================================================
--- ksrc/skins/uitron/task.c	(revision 2365)
+++ ksrc/skins/uitron/task.c	(working copy)
@@ -399,7 +399,7 @@ ER chg_pri(ID tskid, PRI tskpri)
 	if (tskpri == TPRI_INI)
 		tskpri = ui_denormalized_prio(xnthread_initial_priority(&task->threadbase));
 
-	/* uITRON specs explicitely states: "If the priority specified is
+	/* uITRON specs explicitly states: "If the priority specified is
 	   the same as the current priority, the task will still be moved
 	   behind other tasks of the same priority". This allows for
 	   manual round-robin. Cool! :o) */
Index: ksrc/skins/native/task.c
===================================================================
--- ksrc/skins/native/task.c	(revision 2365)
+++ ksrc/skins/native/task.c	(working copy)
@@ -178,7 +178,7 @@ void __native_task_pkg_cleanup(void)
  * platform. This flag is forced for user-space tasks.
  *
  * - T_SUSP causes the task to start in suspended mode. In such a
- * case, the thread will have to be explicitely resumed using the
+ * case, the thread will have to be explicitly resumed using the
  * rt_task_resume() service for its execution to actually begin.
  *
  * - T_CPU(cpuid) makes the new task affine to CPU # @b cpuid. CPU
@@ -2148,7 +2148,7 @@ int rt_task_reply(int flowid, RT_TASK_MC
  * platform. This flag is forced for user-space tasks.
  *
  * - T_SUSP causes the task to start in suspended mode. In such a
- * case, the thread will have to be explicitely resumed using the
+ * case, the thread will have to be explicitly resumed using the
  * rt_task_resume() service for its execution to actually begin.
  *
  * - T_CPU(cpuid) makes the new task affine to CPU # @b cpuid. CPU
Index: ksrc/skins/native/heap.c
===================================================================
--- ksrc/skins/native/heap.c	(revision 2365)
+++ ksrc/skins/native/heap.c	(working copy)
@@ -336,6 +336,9 @@ int rt_heap_create(RT_HEAP *heap, const 
  *
  * @return 0 is returned upon success. Otherwise:
  *
+ * - -EBUSY is returned if @a heap is in use by another process and the
+ * descriptor is not destroyed.
+ *
  * - -EINVAL is returned if @a heap is not a heap descriptor.
  *
  * - -EIDRM is returned if @a heap is a deleted heap descriptor.
@@ -797,7 +800,7 @@ int rt_heap_inquire(RT_HEAP *heap, RT_HE
  * This user-space only service unbinds the calling task from the heap
  * object previously retrieved by a call to rt_heap_bind().
  *
- * Unbinding from a heap when it is no more needed is especially
+ * Unbinding from a heap when it is no longer needed is especially
  * important in order to properly release the mapping resources used
  * to attach the heap memory to the caller's address space.
  *
Index: ksrc/skins/native/snippets/shared_mem.c
===================================================================
--- ksrc/skins/native/snippets/shared_mem.c	(revision 2365)
+++ ksrc/skins/native/snippets/shared_mem.c	(working copy)
@@ -36,7 +36,7 @@ int main (int argc, char *argv[])
 void cleanup (void)
 
 {
-    /* We need to unbind explicitely from the heap in order to
+    /* We need to unbind explicitly from the heap in order to
        properly release the underlying memory mapping. Exiting the
        process unbinds all mappings automatically. */
     rt_heap_unbind(&heap_desc);
Index: ksrc/skins/native/snippets/msg_queue.c
===================================================================
--- ksrc/skins/native/snippets/msg_queue.c	(revision 2365)
+++ ksrc/skins/native/snippets/msg_queue.c	(working copy)
@@ -41,7 +41,7 @@ void consumer (void *cookie)
 	rt_queue_free(&q_desc,msg);
 	}
 
-    /* We need to unbind explicitely from the queue in order to
+    /* We need to unbind explicitly from the queue in order to
        properly release the underlying memory mapping. Exiting the
        process unbinds all mappings automatically. */
 
Index: ksrc/skins/rtdm/drvlib.c
===================================================================
--- ksrc/skins/rtdm/drvlib.c	(revision 2365)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -318,7 +318,7 @@ EXPORT_SYMBOL(rtdm_task_join_nrt);
  * @return 0 on success, otherwise:
  *
  * - -EINTR is returned if calling task has been unblock by a signal or
- * explicitely via rtdm_task_unblock().
+ * explicitly via rtdm_task_unblock().
  *
  * - -EPERM @e may be returned if an illegal invocation environment is
  * detected.
@@ -360,7 +360,7 @@ EXPORT_SYMBOL(rtdm_task_sleep);
  * @return 0 on success, otherwise:
  *
  * - -EINTR is returned if calling task has been unblock by a signal or
- * explicitely via rtdm_task_unblock().
+ * explicitly via rtdm_task_unblock().
  *
  * - -EPERM @e may be returned if an illegal invocation environment is
  * detected.
@@ -647,7 +647,7 @@ EXPORT_SYMBOL(rtdm_event_signal);
  * @return 0 on success, otherwise:
  *
  * - -EINTR is returned if calling task has been unblock by a signal or
- * explicitely via rtdm_task_unblock().
+ * explicitly via rtdm_task_unblock().
  *
  * - -EIDRM is returned if @a event has been destroyed.
  *
@@ -690,7 +690,7 @@ EXPORT_SYMBOL(rtdm_event_wait);
  * within the specified amount of time.
  *
  * - -EINTR is returned if calling task has been unblock by a signal or
- * explicitely via rtdm_task_unblock().
+ * explicitly via rtdm_task_unblock().
  *
  * - -EIDRM is returned if @a event has been destroyed.
  *
@@ -862,7 +862,7 @@ void rtdm_sem_destroy(rtdm_sem_t *sem);
  * @return 0 on success, otherwise:
  *
  * - -EINTR is returned if calling task has been unblock by a signal or
- * explicitely via rtdm_task_unblock().
+ * explicitly via rtdm_task_unblock().
  *
  * - -EIDRM is returned if @a sem has been destroyed.
  *
@@ -908,7 +908,7 @@ EXPORT_SYMBOL(rtdm_sem_down);
  * value is currently not positive.
  *
  * - -EINTR is returned if calling task has been unblock by a signal or
- * explicitely via rtdm_task_unblock().
+ * explicitly via rtdm_task_unblock().
  *
  * - -EIDRM is returned if @a sem has been destroyed.
  *
@@ -1542,7 +1542,7 @@ static int rtdm_do_mmap(rtdm_user_info_t
  * rtdm_iomap_to_user() instead.
  *
  * @note RTDM supports two models for unmapping the user memory range again.
- * One is explicite unmapping via rtdm_munmap(), either performed when the
+ * One is explicit unmapping via rtdm_munmap(), either performed when the
  * user requests it via an IOCTL etc. or when the related device is closed.
  * The other is automatic unmapping, triggered by the user invoking standard
  * munmap() or by the termination of the related process. To track release of
@@ -1607,7 +1607,7 @@ EXPORT_SYMBOL(rtdm_mmap_to_user);
  * detected.
  *
  * @note RTDM supports two models for unmapping the user memory range again.
- * One is explicite unmapping via rtdm_munmap(), either performed when the
+ * One is explicit unmapping via rtdm_munmap(), either performed when the
  * user requests it via an IOCTL etc. or when the related device is closed.
  * The other is automatic unmapping, triggered by the user invoking standard
  * munmap() or by the termination of the related process. To track release of
Index: ksrc/skins/rtdm/core.c
===================================================================
--- ksrc/skins/rtdm/core.c	(revision 2365)
+++ ksrc/skins/rtdm/core.c	(working copy)
@@ -875,7 +875,7 @@ int rt_dev_socket(int protocol_family, i
  *
  * @note Killing a real-time task that is blocked on some device operation can
  * lead to stalled file descriptors. To avoid such scenarios, always close the
- * device before explicitely terminating any real-time task which may use it.
+ * device before explicitly terminating any real-time task which may use it.
  * To cleanup a stalled file descriptor, send its number to the @c open_fildes
  * /proc entry, e.g. via
  * @code #> echo 3 > /proc/xenomai/rtdm/open_fildes @endcode
Index: ksrc/arch/generic/hal.c
===================================================================
--- ksrc/arch/generic/hal.c	(revision 2365)
+++ ksrc/arch/generic/hal.c	(working copy)
@@ -573,7 +573,7 @@ int rthal_apc_free(int apc)
  * domain gets back in control.
  *
  * When posted from the Linux domain, the APC handler is fired as soon
- * as the interrupt mask is explicitely cleared by some kernel
+ * as the interrupt mask is explicitly cleared by some kernel
  * code. When posted from the Xenomai domain, the APC handler is
  * fired as soon as the Linux domain is resumed, i.e. after Xenomai has
  * completed all its pending duties.
Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 2365)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -764,7 +764,7 @@ static inline void xnpod_switch_zombie(x
  * the nucleus behaviour regarding the created thread:
  *
  * - XNSUSP creates the thread in a suspended state. In such a case,
- * the thread will have to be explicitely resumed using the
+ * the thread will have to be explicitly resumed using the
  * xnpod_resume_thread() service for its execution to actually begin,
  * additionally to issuing xnpod_start_thread() for it. This flag can
  * also be specified when invoking xnpod_start_thread() as a starting
@@ -897,7 +897,7 @@ int xnpod_init_thread(xnthread_t *thread
  * See xnpod_schedule() for more on this.
  *
  * - XNSUSP makes the thread start in a suspended state. In such a
- * case, the thread will have to be explicitely resumed using the
+ * case, the thread will have to be explicitly resumed using the
  * xnpod_resume_thread() service for its execution to actually begin.
  *
  * @param imask The interrupt mask that should be asserted when the
@@ -1074,7 +1074,7 @@ void xnpod_restart_thread(xnthread_t *th
 	/* Release all ownerships held by the thread on synch. objects */
 	xnsynch_release_all_ownerships(thread);
 
-	/* If the task has been explicitely suspended, resume it. */
+	/* If the task has been explicitly suspended, resume it. */
 	if (xnthread_test_state(thread, XNSUSP))
 		xnpod_resume_thread(thread, XNSUSP);
 
@@ -1835,7 +1835,7 @@ void xnpod_renice_thread_inner(xnthread_
 		    thread->wchan != NULL &&
 		    !testbits(thread->wchan->status, XNSYNCH_DREORD))
 			/* Renice the pending order of the thread inside its wait
-			   queue, unless this behaviour has been explicitely
+			   queue, unless this behaviour has been explicitly
 			   disabled for the pended synchronization object, or the
 			   requested priority has not changed, thus preventing
 			   spurious round-robin effects. */
@@ -2359,7 +2359,7 @@ static inline void xnpod_preempt_current
  * the service causing the state transition. For instance,
  * self-suspension, self-destruction, or sleeping on a synchronization
  * object automatically leads to a call to the rescheduling procedure,
- * therefore the caller does not need to explicitely issue
+ * therefore the caller does not need to explicitly issue
  * xnpod_schedule() after such operations.
  *
  * The rescheduling procedure always leads to a null-effect if it is
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 2365)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -2122,7 +2122,7 @@ static inline void do_sigwake_event(stru
 	/* If we are kicking a shadow thread, make sure Linux won't
 	   schedule in its mate under our feet as a result of running
 	   signal_wake_up(). The Xenomai scheduler must remain in
-	   control for now, until we explicitely relax the shadow
+	   control for now, until we explicitly relax the shadow
 	   thread to allow for processing the pending signals. Make
 	   sure we keep the additional state flags unmodified so that
 	   we don't break any undergoing ptrace. */
Index: doc/txt/vxworks-skin.txt
===================================================================
--- doc/txt/vxworks-skin.txt	(revision 2365)
+++ doc/txt/vxworks-skin.txt	(working copy)
@@ -94,7 +94,7 @@ list. Here are the known variations:
   sleep. This is for instance the case whenever the caller is not a
   VxWorks task, or the scheduler is locked.
 
-- In case the documented VxWorks API does not explicitely handle the
+- In case the documented VxWorks API does not explicitly handle the
   case, calling blocking services outside of any VxWorks task context or
   under scheduler lock, might return the POSIX error value "EPERM".
 
Index: doc/docbook/xenomai/xenomai.xml
===================================================================
--- doc/docbook/xenomai/xenomai.xml	(revision 2365)
+++ doc/docbook/xenomai/xenomai.xml	(working copy)
@@ -467,7 +467,7 @@
 		another thread or service routine while pending on a
 		synchronization resource (e.g. semaphore, message
 		queue). In such a case, the resource is dispatched to
-		it, but it remains suspended until explicitely resumed
+		it, but it remains suspended until explicitly resumed
 		by the proper nucleus service.</para>
 	      </listitem>
 
Index: doc/docbook/xenomai/life-with-adeos.xml
===================================================================
--- doc/docbook/xenomai/life-with-adeos.xml	(revision 2365)
+++ doc/docbook/xenomai/life-with-adeos.xml	(working copy)
@@ -540,7 +540,7 @@
 
       <para>In addition to being able to stall a domain entirely so
       that no interrupt could flow through it anymore until it is
-      explicitely unstalled, Adeos allows to selectively disable, and
+      explicitly unstalled, Adeos allows to selectively disable, and
       conversely re-enable, the actual source of interrupts, at
       hardware level.</para>
 

--Boundary-00=_/JNGG7xc3S4nmul--


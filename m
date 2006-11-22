Message-ID: <4563FA6E.2050405@domain.hid>
Date: Wed, 22 Nov 2006 08:21:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 2/3] reorganise XENO_OPT_DEBUG switches
References: <456236E0.2070405@domain.hid>
In-Reply-To: <456236E0.2070405@domain.hid>
Content-Type: multipart/mixed; boundary="------------080008020409000600080803"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080008020409000600080803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is version 2 with the following changes:

 - rebased on patch 1/3
 - XENO_OPT_WATCHDOG and XENO_OPT_DEBUG_RTDM are default y once
   debugging is enabled
 - more cleanups in ksrc/nucleus/Kconfig

Jan

--------------080008020409000600080803
Content-Type: text/x-patch;
 name="reorganise-opt-debug-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="reorganise-opt-debug-v2.patch"

---
 include/asm-generic/system.h |   53 +++++++++++++----------
 include/nucleus/assert.h     |    2=20
 include/nucleus/bheap.h      |   12 +++--
 include/nucleus/queue.h      |   36 +++++++++-------
 ksrc/nucleus/Config.in       |    4 -
 ksrc/nucleus/Kconfig         |   95 +++++++++++++++++++++---------------=
-------
 ksrc/nucleus/module.c        |   12 ++---
 ksrc/nucleus/pod.c           |   43 +++++++++++--------
 ksrc/nucleus/shadow.c        |   38 +++++++----------
 ksrc/skins/rtdm/Kconfig      |    1=20
 10 files changed, 157 insertions(+), 139 deletions(-)

Index: xenomai/include/nucleus/assert.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/assert.h
+++ xenomai/include/nucleus/assert.h
@@ -22,6 +22,8 @@
=20
 #include <nucleus/compiler.h>
=20
+#define XENO_DEBUG(subsystem)   (CONFIG_XENO_OPT_DEBUG_##subsystem > 0)
+
 #define XENO_ASSERT(subsystem,cond,action)  do { \
     if (unlikely(CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond))) { \
         xnarch_trace_panic_freeze(); \
Index: xenomai/include/nucleus/bheap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/bheap.h
+++ xenomai/include/nucleus/bheap.h
@@ -21,8 +21,14 @@
 #define _XENO_NUCLEUS_BHEAP_H
=20
 #include <nucleus/compiler.h>
+
+/* debug support */
 #include <nucleus/assert.h>
=20
+#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
+#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
+#endif
+
 /* Priority queue implementation, using a binary heap. */
=20
 typedef unsigned long long bheap_key_t;
@@ -53,11 +59,7 @@ typedef struct bheap {
         bheaph_t *elems[sz];                    \
     } name
=20
-#ifdef CONFIG_XENO_OPT_DEBUG_BHEAP
-#define BHEAP_CHECK(heap)   XENO_BUGON(BHEAP, ((heap)->sz =3D=3D 0))
-#else /* !CONFIG_XENO_OPT_DEBUG_BHEAP */
-#define BHEAP_CHECK(heap)   do { } while (0)
-#endif /* CONFIG_XENO_OPT_DEBUG_BHEAP */
+#define BHEAP_CHECK(heap)   XENO_BUGON(QUEUES, ((heap)->sz =3D=3D 0))
=20
 #define bheap_gethead(heap)                     \
 ({                                              \
Index: xenomai/ksrc/nucleus/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Kconfig
+++ xenomai/ksrc/nucleus/Kconfig
@@ -20,9 +20,8 @@ config XENO_OPT_PERVASIVE
 config XENO_OPT_ISHIELD
 	depends on XENO_OPT_PERVASIVE
 	bool "Interrupt shield support"
-	default n
 	help
-=09
+
 	This option builds in the interrupt shield support, which can
 	be further enabled on a thread-by-thread basis. When enabled
 	for a thread, the interrupt shield prevents it from being
@@ -40,9 +39,8 @@ config XENO_OPT_ISHIELD
 config XENO_OPT_RPIDISABLE
 	depends on XENO_OPT_PERVASIVE
 	bool "Disable priority coupling"
-	default n
 	help
-=09
+
 	This option globally disables thread priority coupling between
 	Xenomai and Linux schedulers. Decoupling priority prevents the
 	Linux kernel from inheriting the priority of the associated
@@ -97,13 +95,13 @@ config XENO_OPT_PIPE_NRDEV
 	depends on XENO_OPT_PIPE
 	default 32
 	help
-=09
+
 	Message pipes are bi-directional FIFO communication
 	channels allowing data exchange between real-time kernel
 	threads and regular user-space processes. Pipes natively
 	preserve message boundaries, but can also be used in byte
 	streaming mode from kernel to user-space.
-=09
+
 	This option sets the maximum number of pipe devices supported
 	in the system. Pipe devices are named /dev/rtpN where N is a
 	device minor number ranging from 0 to XENO_OPT_PIPE_NRDEV - 1.
@@ -116,13 +114,13 @@ config XENO_OPT_REGISTRY_NRSLOTS
 	depends on XENO_OPT_REGISTRY
 	default 512
 	help
-=09
+
 	The registry is used by Xenomai skins to bind real-time
 	objects they create to symbolic names, so that these objects
 	can be further retrieved and shared by real-time applications
 	regardless of their runtime space (i.e. kernel or user). Each
 	named object occupies a registry slot.
-=09
+
 	This option sets the maximum number of real-time objects the
 	registry can handle. All skins using the registry share this
 	storage.
@@ -140,16 +138,25 @@ config XENO_OPT_STATS
 	bool "Statistics collection"
 	default y
 	help
-=09
+
 	This option causes the real-time nucleus to collect various
 	per-thread runtime statistics, which are accessible through
 	the /proc/xenomai/stats interface.
=20
 config XENO_OPT_DEBUG
 	bool "Debug support"
-	default n
 	help
-=09
+
+	When enabled, various debugging features can be switched on. They
+	can help to find problems in applications, drivers, and the Xenomai
+	core. XENO_OPT_DEBUG itself does not have any impact on generated
+	code.
+
+config XENO_OPT_DEBUG_NUCLEUS
+	bool "Nucleus Debugging support"
+	depends on XENO_OPT_DEBUG
+	help
+
 	This option activates various debugging checks inside the core
 	system. Doing so adds a significant runtime overhead,
 	worsening the latency figures especially on SMP kernels.
@@ -160,20 +167,17 @@ config XENO_OPT_DEBUG_QUEUES
 	bool "Queue Debugging support"
 	depends on XENO_OPT_DEBUG
 	help
-=09
-	This option activates debugging checks for all queueing
-	operations of the Xenomai core. It adds even more runtime
-	overhead then CONFIG_XENO_OPT_DEBUG, use with care.
=20
-config XENO_OPT_DEBUG_BHEAP
-	bool
-	default y if XENO_OPT_DEBUG
+	This option activates debugging checks for all queueing
+	operations of the Xenomai core. It adds heavy runtime overhead,
+	use with care.
=20
 config XENO_OPT_WATCHDOG
 	bool "Watchdog support"
-	default n
+	depends on XENO_OPT_DEBUG
+	default y
 	help
-=09
+
 	This option activates a watchdog aimed at detecting runaway
 	real-time threads. If enabled, the watchdog triggers after 4
 	seconds of uninterrupted real-time activity without Linux
@@ -186,7 +190,6 @@ menu "Timing"
=20
 config XENO_OPT_TIMING_PERIODIC
 	bool "Use periodic timer hardware"
-	default n
 	help
 	WARNING: This value must be <=3D CONFIG_HZ.
=20
@@ -283,9 +286,8 @@ menu "Scalability"
=20
 config XENO_OPT_SCALABLE_SCHED
 	bool "O(1) scheduler"
-	default n
 	help
-=09
+
 	This option causes a multi-level priority queue to be
 	used in the real-time thread scheduler, so that it operates
 	in constant-time regardless of the number of _concurrently
@@ -296,9 +298,9 @@ config XENO_OPT_SCALABLE_SCHED
 	better with lower memory footprints.
=20
 choice
-        prompt "Timer indexing method"
-        default XENO_OPT_TIMER_LIST
-        help
+	prompt "Timer indexing method"
+	default XENO_OPT_TIMER_LIST
+	help
=20
 	This option allows to select the underlying data structure
 	which is going to be used for ordering the outstanding
@@ -307,20 +309,20 @@ choice
 	data structure is always used, regardless of this option.
=20
 config XENO_OPT_TIMER_LIST
-        bool "Linear"
-        help
+	bool "Linear"
+	help
=20
-        Use a linked list. Albeit O(N), this simple data structure is
-        particularly efficient when only a few timers (< 10) may be
-        concurrently outstanding at any point in time.
+	Use a linked list. Albeit O(N), this simple data structure is
+	particularly efficient when only a few timers (< 10) may be
+	concurrently outstanding at any point in time.
=20
 config XENO_OPT_TIMER_HEAP
-        bool "Tree"
-        help
+	bool "Tree"
+	help
=20
-        Use a binary heap. This data structure is efficient when a
-        high number of software timers may be concurrently
-        outstanding at any point in time.
+	Use a binary heap. This data structure is efficient when a
+	high number of software timers may be concurrently
+	outstanding at any point in time.
=20
 config XENO_OPT_TIMER_WHEEL
 	bool "Hash"
@@ -329,8 +331,8 @@ config XENO_OPT_TIMER_WHEEL
 	Use a hash table. Timers operations using this data structure
 	should have an O(1) complexity if the timers follow two=20
 	conditions:
-        - timers expiration dates do not collide too much;
-        - there is at least one periodic timer using a period near=20
+	- timers expiration dates do not collide too much;
+	- there is at least one periodic timer using a period near
 	the wheel step (around 100000 ns by default).
=20
 endchoice
@@ -339,9 +341,9 @@ config XENO_OPT_TIMER_HEAP_CAPACITY
 	int "Binary heap capacity"
 	depends on XENO_OPT_TIMER_HEAP
 	default 256
-        help=20
+	help
=20
-        Set the maximum number of timers in the nucleus timers list.
+	Set the maximum number of timers in the nucleus timers list.
=20
 config XENO_OPT_TIMER_WHEEL_STEP
 	int "Timer wheel step"
@@ -359,9 +361,8 @@ menu "Shared interrupts"
=20
 config XENO_OPT_SHIRQ_LEVEL
 	bool "Level-triggered interrupts"
-	default n
 	help
-=09
+
 	Enables support for shared level-triggered interrupts, so that
 	multiple real-time interrupt handlers are allowed to control
 	dedicated hardware devices which are configured to share
@@ -369,7 +370,6 @@ config XENO_OPT_SHIRQ_LEVEL
=20
 config XENO_OPT_SHIRQ_EDGE
 	bool "Edge-triggered interrupts"
-	default n
 	help
=20
 	Enables support for shared edge-triggered interrupts, so that
@@ -387,7 +387,7 @@ config XENO_OPT_FILTER_EVIRQ
 	bool "Disable IRQ-related tracepoints"
 	default y if XENO_OPT_FILTER_EVALL=3Dy
 	help
-=09
+
 	When LTT support is active, this option disables tracepoints
 	inside real-time interrupt handlers.
=20
@@ -395,7 +395,7 @@ config XENO_OPT_FILTER_EVTHR
 	bool "Disable thread-related tracepoints"
 	default y if XENO_OPT_FILTER_EVALL=3Dy
 	help
-=09
+
 	When LTT support is active, this option disables tracepoints
 	inside most thread-related services.
=20
@@ -403,15 +403,14 @@ config XENO_OPT_FILTER_EVSYS
 	bool "Disable syscall-related tracepoints"
 	default y if XENO_OPT_FILTER_EVALL=3Dy
 	help
-=09
+
 	When LTT support is active, this option disables tracepoints
 	inside the shadow syscall dispatcher.
=20
 config XENO_OPT_FILTER_EVALL
 	bool "Disable all tracepoints"
-	default n
 	help
-=09
+
 	This option disables all LTT tracepoints inside Xenomai.
=20
 endmenu
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -55,6 +55,13 @@
 #include <asm/xenomai/syscall.h>
 #include <asm/xenomai/bits/shadow.h>
=20
+/* debug support */
+#include <nucleus/assert.h>
+
+#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
+#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
+#endif
+
 int nkthrptd;
=20
 int nkerrptd;
@@ -486,12 +493,11 @@ static void schedule_linux_call(int type
 	struct __lostagerq *rq =3D &lostagerq[cpuid];
 	spl_t s;
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
-	if (!p)
+	XENO_ASSERT(NUCLEUS, p,
 		xnpod_fatal("schedule_linux_call() invoked "
 			    "with NULL task pointer (req=3D%d, arg=3D%d)?!", type,
 			    arg);
-#endif /* CONFIG_XENO_OPT_DEBUG */
+		);
=20
 	splhigh(s);
 	reqnum =3D rq->in;
@@ -628,13 +634,11 @@ int xnshadow_harden(void)
 	   fail; the caller will have to process this signal anyway. */
=20
 	if (rthal_current_domain =3D=3D rthal_root_domain) {
-#ifdef CONFIG_XENO_OPT_DEBUG
-		if (!signal_pending(this_task)
-		    || this_task->state !=3D TASK_RUNNING)
+		if (XENO_DEBUG(NUCLEUS) && (!signal_pending(this_task)
+		    || this_task->state !=3D TASK_RUNNING))
 			xnpod_fatal
 			    ("xnshadow_harden() failed for thread %s[%d]",
 			     thread->name, xnthread_user_pid(thread));
-#endif /* CONFIG_XENO_OPT_DEBUG */
 		return -ERESTARTSYS;
 	}
=20
@@ -688,10 +692,7 @@ void xnshadow_relax(int notify)
 	int cprio;
 	spl_t s;
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
-	if (testbits(thread->status, XNROOT))
-		xnpod_fatal("xnshadow_relax() called from the Linux domain");
-#endif /* CONFIG_XENO_OPT_DEBUG */
+	XENO_BUGON(NUCLEUS, testbits(thread->status, XNROOT));
=20
 	/* Enqueue the request to move the running shadow from the Xenomai
 	   domain to the Linux domain.  This will cause the Linux task
@@ -721,11 +722,9 @@ void xnshadow_relax(int notify)
=20
 	splexit(s);
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
-	if (rthal_current_domain !=3D rthal_root_domain)
+	if (XENO_DEBUG(NUCLEUS) && rthal_current_domain !=3D rthal_root_domain)=

 		xnpod_fatal("xnshadow_relax() failed for thread %s[%d]",
 			    thread->name, xnthread_user_pid(thread));
-#endif /* CONFIG_XENO_OPT_DEBUG */
=20
 	cprio =3D thread->cprio < MAX_RT_PRIO ? thread->cprio : MAX_RT_PRIO - 1=
;
 	rthal_reenter_root(get_switch_lock_owner(),
@@ -883,10 +882,9 @@ void xnshadow_unmap(xnthread_t *thread)
 	struct task_struct *p;
 	unsigned muxid, magic;
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
-	if (!testbits(xnpod_current_sched()->status, XNKCOUT))
+	if (XENO_DEBUG(NUCLEUS) &&
+	    !testbits(xnpod_current_sched()->status, XNKCOUT))
 		xnpod_fatal("xnshadow_unmap() called from invalid context");
-#endif /* CONFIG_XENO_OPT_DEBUG */
=20
 	p =3D xnthread_archtcb(thread)->user_task;	/* May be !=3D current */
=20
@@ -1708,8 +1706,7 @@ static inline void do_schedule_event(str
 #endif /* CONFIG_XENO_OPT_RPIDISABLE */
 			newrprio =3D XNPOD_ROOT_PRIO_BASE;	/* Decouple priority scales. */
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
-		{
+		if (XENO_DEBUG(NUCLEUS)) {
 			xnflags_t status =3D threadin->status;
 			int sigpending =3D signal_pending(next);
=20
@@ -1717,7 +1714,7 @@ static inline void do_schedule_event(str
 				xnarch_trace_panic_freeze();
 				show_stack(xnthread_user_task(threadin), NULL);
 				xnpod_fatal
-				    ("Hardened thread %s[%d] running in Linux domain?! (status=3D0x%=
lx, sig=3D%d, prev=3D%s[%d])",
+				    ("Hardened thread %s[%d] running in Linux"" domain?! (status=3D0=
x%lx, sig=3D%d, prev=3D%s[%d])",
 				     threadin->name, next->pid, status,
 				     sigpending, prev->comm, prev->pid);
 			} else if (!(next->ptrace & PT_PTRACED) &&
@@ -1733,7 +1730,6 @@ static inline void do_schedule_event(str
 				     sigpending, prev->comm, prev->pid);
 			}
 		}
-#endif /* CONFIG_XENO_OPT_DEBUG */
=20
 #ifdef CONFIG_XENO_OPT_ISHIELD
 		reset_shield(threadin);
Index: xenomai/include/nucleus/queue.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/queue.h
+++ xenomai/include/nucleus/queue.h
@@ -24,6 +24,13 @@
 #include <nucleus/types.h>
 #include <nucleus/core.h>
=20
+/* debug support */
+#include <nucleus/assert.h>
+
+#ifndef CONFIG_XENO_OPT_DEBUG_QUEUES
+#define CONFIG_XENO_OPT_DEBUG_QUEUES 0
+#endif
+
 /* Basic element holder */
=20
 typedef struct xnholder {
@@ -62,28 +69,28 @@ typedef struct xnqueue {
=20
     xnholder_t head;
     int elems;
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defi=
ned(CONFIG_SMP)
+#if defined(__KERNEL__) && XENO_DEBUG(QUEUES) && defined(CONFIG_SMP)
     xnlock_t lock;
-#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
+#endif /* __KERNEL__ && XENO_DEBUG(QUEUES) && CONFIG_SMP */
=20
 } xnqueue_t;
=20
-#if defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defined(CONFIG_SMP)
+#if XENO_DEBUG(QUEUES) && defined(CONFIG_SMP)
 #define DECLARE_XNQUEUE(q) xnqueue_t q =3D { { &(q).head, &(q).head }, 0=
, XNARCH_LOCK_UNLOCKED }
-#else /* !(CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP) */
+#else /* !(XENO_DEBUG(QUEUES) && CONFIG_SMP) */
 #define DECLARE_XNQUEUE(q) xnqueue_t q =3D { { &(q).head, &(q).head }, 0=
 }
-#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
+#endif /* XENO_DEBUG(QUEUES) && CONFIG_SMP */
=20
 static inline void initq (xnqueue_t *qslot)
 {
     inith(&qslot->head);
     qslot->elems =3D 0;
-#if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_DEBUG_QUEUES) && defi=
ned(CONFIG_SMP)
+#if defined(__KERNEL__) && XENO_DEBUG(QUEUES) && defined(CONFIG_SMP)
     xnlock_init(&qslot->lock);
-#endif /* __KERNEL__ && CONFIG_XENO_OPT_DEBUG_QUEUES && CONFIG_SMP */
+#endif /* __KERNEL__ && XENO_DEBUG(QUEUES) && CONFIG_SMP */
 }
=20
-#ifdef CONFIG_XENO_OPT_DEBUG_QUEUES
+#if XENO_DEBUG(QUEUES)
=20
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
=20
@@ -178,7 +185,7 @@ do { \
    dth(__holder);				\
    --(__qslot)->elems; })
=20
-#else /* !CONFIG_XENO_OPT_DEBUG_QUEUES */
+#else /* !XENO_DEBUG(QUEUES) */
=20
 static inline void insertq (xnqueue_t *qslot,
 			    xnholder_t *head,
@@ -212,7 +219,7 @@ static inline void removeq (xnqueue_t *q
     --qslot->elems;
 }
=20
-#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES */
+#endif /* XENO_DEBUG(QUEUES) */
=20
 static inline xnholder_t *getheadq (xnqueue_t *qslot)
 {
@@ -762,13 +769,12 @@ static inline xnpholder_t *getmlq(xnmlqu
     queue =3D &mlqslot->queue[idx];
     holder =3D getq(queue);
=20
-#ifdef CONFIG_XENO_OPT_DEBUG_QUEUES
-    if (!holder)
+    XENO_ASSERT(QUEUES, holder,
         xnpod_fatal("corrupted multi-level queue, qslot=3D%p at %s:%d",
                     mlqslot,
 		    __FILE__,__LINE__);
-#endif /* CONFIG_XENO_OPT_DEBUG_QUEUES */
-       =20
+        );
+
     hi =3D idx / BITS_PER_LONG;
     lo =3D idx % BITS_PER_LONG;
=20
@@ -779,7 +785,7 @@ static inline xnpholder_t *getmlq(xnmlqu
 	if (mlqslot->lomap[hi] =3D=3D 0)
 	    __clrbits(mlqslot->himap,1 << hi);
     }
-   =20
+
     return (xnpholder_t *)holder;
 }
=20
Index: xenomai/ksrc/nucleus/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/Config.in
+++ xenomai/ksrc/nucleus/Config.in
@@ -32,10 +32,10 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" !=3D "n" ]
 	bool 'Statistics collection' CONFIG_XENO_OPT_STATS
 	bool 'Debug support' CONFIG_XENO_OPT_DEBUG
 	if [ "$CONFIG_XENO_OPT_DEBUG" =3D "y" ]; then
+		bool 'Nucleus Debugging support' CONFIG_XENO_OPT_DEBUG_NUCLEUS
 		bool 'Queue Debugging support' CONFIG_XENO_OPT_DEBUG_QUEUES
-		define_bool CONFIG_XENO_OPT_DEBUG_BHEAP y
+		bool 'Watchdog support' CONFIG_XENO_OPT_WATCHDOG
 	fi
-	bool 'Watchdog support' CONFIG_XENO_OPT_WATCHDOG
=20
 	bool 'Enable periodic timer support' CONFIG_XENO_OPT_TIMING_PERIODIC
 	if [ "$CONFIG_XENO_OPT_TIMING_PERIODIC" =3D "y" ]; then
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -44,6 +44,13 @@
 #include <nucleus/stat.h>
 #include <asm/xenomai/bits/pod.h>
=20
+/* debug support */
+#include <nucleus/assert.h>
+
+#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
+#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
+#endif
+
 /* NOTE: We need to initialize the globals: remember that this code
    also runs over user-space VMs... */
=20
@@ -192,7 +199,7 @@ static int xnpod_fault_handler(xnarch_fl
 	   stepping properly. */
=20
 	if (xnpod_shadow_p()) {
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 		if (!xnarch_fault_um(fltinfo)) {
 			xnarch_trace_panic_freeze();
 			xnprintf
@@ -209,7 +216,7 @@ static int xnpod_fault_handler(xnarch_fl
 			     xnarch_fault_trap(fltinfo),
 			     xnarch_fault_pc(fltinfo),
 			     xnthread_user_pid(thread));
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(NUCLEUS) */
 		if (xnarch_fault_pf_p(fltinfo))
 			/* The page fault counter is not SMP-safe, but it's a
 			   simple indicator that something went wrong wrt memory
@@ -1020,10 +1027,10 @@ void xnpod_restart_thread(xnthread_t *th
 	if (!testbits(thread->status, XNSTARTED))
 		return;		/* Not started yet or not restartable. */
=20
-#if defined(CONFIG_XENO_OPT_DEBUG) || defined(__XENO_SIM__)
+#if XENO_DEBUG(NUCLEUS) || defined(__XENO_SIM__)
 	if (testbits(thread->status, XNROOT | XNSHADOW))
 		xnpod_fatal("attempt to restart a user-space thread");
-#endif /* CONFIG_XENO_OPT_DEBUG || __XENO_SIM__ */
+#endif /* XENO_DEBUG(NUCLEUS) || __XENO_SIM__ */
=20
 	xnlock_get_irqsave(&nklock, s);
=20
@@ -1210,10 +1217,10 @@ void xnpod_delete_thread(xnthread_t *thr
 	xnsched_t *sched;
 	spl_t s;
=20
-#if defined(CONFIG_XENO_OPT_DEBUG) || defined(__XENO_SIM__)
+#if XENO_DEBUG(NUCLEUS) || defined(__XENO_SIM__)
 	if (testbits(thread->status, XNROOT))
 		xnpod_fatal("attempt to delete the root thread");
-#endif /* CONFIG_XENO_OPT_DEBUG || __XENO_SIM__ */
+#endif /* XENO_DEBUG(NUCLEUS) || __XENO_SIM__ */
=20
 #ifdef __XENO_SIM__
 	if (nkpod->schedhook)
@@ -1363,14 +1370,14 @@ void xnpod_suspend_thread(xnthread_t *th
 	xnsched_t *sched;
 	spl_t s;
=20
-#if defined(CONFIG_XENO_OPT_DEBUG) || defined(__XENO_SIM__)
+#if XENO_DEBUG(NUCLEUS) || defined(__XENO_SIM__)
 	if (testbits(thread->status, XNROOT))
 		xnpod_fatal("attempt to suspend root thread %s", thread->name);
=20
 	if (thread->wchan && wchan)
 		xnpod_fatal("thread %s attempts a conjunctive wait",
 			    thread->name);
-#endif /* CONFIG_XENO_OPT_DEBUG || __XENO_SIM__ */
+#endif /* XENO_DEBUG(NUCLEUS) || __XENO_SIM__ */
=20
 	xnlock_get_irqsave(&nklock, s);
=20
@@ -1379,11 +1386,11 @@ void xnpod_suspend_thread(xnthread_t *th
 	sched =3D thread->sched;
=20
 	if (thread =3D=3D sched->runthread) {
-#if defined(CONFIG_XENO_OPT_DEBUG) || defined(__XENO_SIM__)
+#if XENO_DEBUG(NUCLEUS) || defined(__XENO_SIM__)
 		if (sched =3D=3D xnpod_current_sched() && xnpod_locked_p())
 			xnpod_fatal
 			    ("suspensive call issued while the scheduler was locked");
-#endif /* CONFIG_XENO_OPT_DEBUG || __XENO_SIM__ */
+#endif /* XENO_DEBUG(NUCLEUS) || __XENO_SIM__ */
=20
 		xnsched_set_resched(sched);
 	}
@@ -2309,9 +2316,9 @@ void xnpod_schedule(void)
 {
 	xnthread_t *threadout, *threadin, *runthread;
 	xnsched_t *sched;
-#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_DEBUG)
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	int need_resched;
-#endif /* CONFIG_SMP || CONFIG_XENO_OPT_DEBUG */
+#endif /* CONFIG_SMP || XENO_DEBUG(NUCLEUS) */
 	spl_t s;
 #ifdef __KERNEL__
 #ifdef CONFIG_XENO_OPT_PERVASIVE
@@ -2339,7 +2346,7 @@ void xnpod_schedule(void)
 			 xnarch_user_pid(xnthread_archtcb(runthread)) : -1,
 			 xnthread_current_priority(runthread));
=20
-#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_DEBUG)
+#if defined(CONFIG_SMP) || XENO_DEBUG(NUCLEUS)
 	need_resched =3D xnsched_tst_resched(sched);
 #endif
 #ifdef CONFIG_SMP
@@ -2350,15 +2357,15 @@ void xnpod_schedule(void)
 		xnarch_send_ipi(xnsched_resched_mask());
 		xnsched_clr_mask(sched);
 	}
-#ifndef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 	if (!need_resched)
 		goto signal_unlock_and_exit;
=20
 	xnsched_set_resched(sched);
-#else /* !CONFIG_XENO_OPT_DEBUG */
+#else /* !XENO_DEBUG(NUCLEUS) */
 	if (need_resched)
 		xnsched_set_resched(sched);
-#endif /* !CONFIG_XENO_OPT_DEBUG */
+#endif /* !XENO_DEBUG(NUCLEUS) */
=20
 #endif /* CONFIG_SMP */
=20
@@ -2399,7 +2406,7 @@ void xnpod_schedule(void)
 	threadout =3D runthread;
 	threadin =3D link2thread(sched_getpq(&sched->readyq), rlink);
=20
-#ifdef CONFIG_XENO_OPT_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 	if (!need_resched) {
 		xnprintf
 		    ("xnpod_schedule: scheduler state changed without rescheduling"
@@ -2409,7 +2416,7 @@ void xnpod_schedule(void)
 		show_stack(NULL, NULL);
 #endif
 	}
-#endif /* CONFIG_XENO_OPT_DEBUG */
+#endif /* XENO_DEBUG(NUCLEUS) */
=20
 	__clrbits(threadin->status, XNREADY);
=20
Index: xenomai/include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/system.h
+++ xenomai/include/asm-generic/system.h
@@ -40,6 +40,13 @@
 #include <asm/xenomai/atomic.h>
 #include <nucleus/shadow.h>
=20
+/* debug support */
+#include <nucleus/assert.h>
+
+#ifndef CONFIG_XENO_OPT_DEBUG_NUCLEUS
+#define CONFIG_XENO_OPT_DEBUG_NUCLEUS 0
+#endif
+
 /* Tracer interface */
 #define xnarch_trace_max_begin(v)		rthal_trace_max_begin(v)
 #define xnarch_trace_max_end(v)		rthal_trace_max_end(v)
@@ -104,8 +111,6 @@ typedef struct {
 	0LL,					\
 }
=20
-#define CONFIG_XENO_SPINLOCK_DEBUG  1
-
 #else /* !(CONFIG_SMP && CONFIG_XENO_OPT_DEBUG) */
=20
 typedef struct { atomic_t owner; } xnlock_t;
@@ -220,15 +225,15 @@ static inline int xnarch_setimask (int i
=20
 #ifdef CONFIG_SMP
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 #define xnlock_get(lock) \
     __xnlock_get(lock, __FILE__, __LINE__,__FUNCTION__)
 #define xnlock_get_irqsave(lock,x) \
     ((x) =3D __xnlock_get_irqsave(lock, __FILE__, __LINE__,__FUNCTION__)=
)
-#else /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#else /* !XENO_DEBUG(NUCLEUS) */
 #define xnlock_get(lock)            __xnlock_get(lock)
 #define xnlock_get_irqsave(lock,x)  ((x) =3D __xnlock_get_irqsave(lock))=

-#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* !XENO_DEBUG(NUCLEUS) */
 #define xnlock_clear_irqoff(lock)   xnlock_put_irqrestore(lock,1)
 #define xnlock_clear_irqon(lock)    xnlock_put_irqrestore(lock,0)
=20
@@ -237,7 +242,7 @@ static inline void xnlock_init (xnlock_t
     *lock =3D XNARCH_LOCK_UNLOCKED;
 }
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
=20
 #define XNARCH_DEBUG_SPIN_LIMIT 3000000
=20
@@ -247,10 +252,10 @@ static inline int __xnlock_get (xnlock_t
 				 const char *function)
 {
     unsigned spin_count =3D 0;
-#else /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#else /* !XENO_DEBUG(NUCLEUS) */
 static inline int __xnlock_get (xnlock_t *lock)
 {
-#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* !XENO_DEBUG(NUCLEUS) */
     rthal_declare_cpuid;
     int recursing;
=20
@@ -258,14 +263,14 @@ static inline int __xnlock_get (xnlock_t
 
     recursing =3D (atomic_read(&lock->owner) =3D=3D cpuid);
     if (!recursing) {
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 	    unsigned long long lock_date =3D rthal_rdtsc();
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* XENO_DEBUG(NUCLEUS) */
 	    while(atomic_cmpxchg(&lock->owner, ~0, cpuid) !=3D ~0)
 		    do {
 			    cpu_relax();
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 			    if (++spin_count =3D=3D XNARCH_DEBUG_SPIN_LIMIT) {
 				    rthal_emergency_console();
 				    printk(KERN_ERR
@@ -278,17 +283,17 @@ static inline int __xnlock_get (xnlock_t
 				    for (;;)
 					    cpu_relax();
 			    }
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* XENO_DEBUG(NUCLEUS) */
 		    } while(atomic_read(&lock->owner) !=3D ~0);
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 	    lock->spin_time =3D rthal_rdtsc() - lock_date;
 	    lock->lock_date =3D lock_date;
 	    lock->file =3D file;
 	    lock->function =3D function;
 	    lock->line =3D line;
 	    lock->cpu =3D cpuid;
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* XENO_DEBUG(NUCLEUS) */
         }
=20
     return recursing;
@@ -301,7 +306,7 @@ static inline void xnlock_put (xnlock_t=20
     rthal_load_cpuid();
     if (likely(atomic_read(&lock->owner) =3D=3D cpuid)) {
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
 	    extern xnlockinfo_t xnlock_stats[];
=20
 	    unsigned long long lock_time =3D rthal_rdtsc() - lock->lock_date;
@@ -313,10 +318,10 @@ static inline void xnlock_put (xnlock_t=20
 		    xnlock_stats[cpuid].function =3D lock->function;
 		    xnlock_stats[cpuid].line =3D lock->line;
 	    }
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* XENO_DEBUG(NUCLEUS) */
 	    atomic_set(&lock->owner, ~0);
     }
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
     else {
 	    rthal_emergency_console();
 	    printk(KERN_ERR
@@ -327,31 +332,31 @@ static inline void xnlock_put (xnlock_t=20
 	    for (;;)
 		    cpu_relax();
     }
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* XENO_DEBUG(NUCLEUS) */
 }
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
=20
 static inline spl_t __xnlock_get_irqsave (xnlock_t *lock,
                                           const char *file,
                                           unsigned line,
                                           const char *function)
 {
-#else /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#else /* !XENO_DEBUG(NUCLEUS) */
 static inline spl_t __xnlock_get_irqsave (xnlock_t *lock)
 {
-#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* !XENO_DEBUG(NUCLEUS) */
     unsigned long flags;
=20
     rthal_local_irq_save(flags);
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if XENO_DEBUG(NUCLEUS)
     if (__xnlock_get(lock, file, line, function))
 	    flags |=3D 2;
-#else /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#else /* !XENO_DEBUG(NUCLEUS) */
     if (__xnlock_get(lock))
 	    flags |=3D 2;
-#endif /* !CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* !XENO_DEBUG(NUCLEUS) */
 =09
     return flags;
 }
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -474,7 +474,7 @@ static struct file_operations stat_seq_o
=20
 #endif /* CONFIG_XENO_OPT_STATS */
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
=20
 xnlockinfo_t xnlock_stats[RTHAL_NR_CPUS];
=20
@@ -522,7 +522,7 @@ static int lock_read_proc(char *page,
=20
 EXPORT_SYMBOL(xnlock_stats);
=20
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
=20
 static int latency_read_proc(char *page,
 			     char **start,
@@ -743,9 +743,9 @@ void xnpod_init_proc(void)
 	add_proc_fops("stat", &stat_seq_operations, 0, rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_STATS */
=20
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
 	add_proc_leaf("lock", &lock_read_proc, NULL, NULL, rthal_proc_root);
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
=20
 	add_proc_leaf("latency",
 		      &latency_read_proc,
@@ -787,9 +787,9 @@ void xnpod_delete_proc(void)
 #ifdef CONFIG_XENO_OPT_STATS
 	remove_proc_entry("stat", rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_STATS */
-#ifdef CONFIG_XENO_SPINLOCK_DEBUG
+#if CONFIG_SMP && XENO_DEBUG(NUCLEUS)
 	remove_proc_entry("lock", rthal_proc_root);
-#endif /* CONFIG_XENO_SPINLOCK_DEBUG */
+#endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
 }
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
Index: xenomai/ksrc/skins/rtdm/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/skins/rtdm/Kconfig
+++ xenomai/ksrc/skins/rtdm/Kconfig
@@ -22,6 +22,7 @@ config XENO_OPT_RTDM_FILDES
 config XENO_OPT_DEBUG_RTDM
 	bool "RTDM debugging support"
 	depends on XENO_OPT_DEBUG && XENO_SKIN_RTDM
+	default y
 	help
=20
 	This option activates debugging checks for the RTDM subsystem.

--------------080008020409000600080803--


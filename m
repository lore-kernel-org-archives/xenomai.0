From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 31 Dec 2008 01:19:48 +0100
References: <200808312323.29665.berlemont.hauw@domain.hid>
	<48BCF4D9.8030100@domain.hid>
In-Reply-To: <48BCF4D9.8030100@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kqrWJhbrlOTCTAF"
Message-Id: <200812310119.48242.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] [PATCH 0/2] RTDM in user mode
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_kqrWJhbrlOTCTAF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Il already tried to send this mail to xenomai-core; I have been waiting for=
 it=20
for the past 24 hours. So I tried again with a few changes. Sorry for the=20
noise.

Here are three patches which provide the whole RTDM API to user-land. Thank=
s=20
to these features, driver code can be executed by common user processes.

=A0- As Jan suggested, this first version is a "single process" driver, it =
can=20
only be used (many times) by one process as it runs as library within the=20
context of the user process. The multiple user space contexts implementatio=
n=20
will follow (if you consider it as interesting).

=2D The Linux framework for common Linux services (lists, ioremap(), etc. a=
t=20
least) is not available yet. It will follow.

=2D The RTDM API has not changed... (except the IRQ and NRT sig handlers=20
functions headers...).

=2D The code has been tested thanks to the examples (available in=20
examples/rtdm/user-api / patch n=B02).

Do you find such patches interesting for inclusion ?

Alexis

Patch 0: kernel-side code.

--Boundary-00=_kqrWJhbrlOTCTAF
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="xenomai-rtdm-proposal_p0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xenomai-rtdm-proposal_p0.diff"

 include/rtdm/rtdm.h        |   16 
 include/rtdm/rtdm_driver.h |  781 +++++++++++++++++-------
 include/rtdm/syscall.h     |   61 +
 ksrc/skins/rtdm/drvlib.c   |  613 ++++++++++++++++---
 ksrc/skins/rtdm/internal.h |  149 ++++
 ksrc/skins/rtdm/module.c   |   14 
 ksrc/skins/rtdm/syscall.c  | 1428 ++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 2723 insertions(+), 339 deletions(-)

Index: include/rtdm/rtdm.h
===================================================================
--- include/rtdm/rtdm.h	(revision 4513)
+++ include/rtdm/rtdm.h	(working copy)
@@ -65,6 +65,22 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
+/* --- Kernel compatibility stuff --- */
+
+#define __user
+
+typedef unsigned long rtdm_user_info_t;
+
+struct vm_area_struct {
+	void *vm_private_data;
+};
+
+struct vm_operations_struct {
+	void (*open)(struct vm_area_struct * area);
+	void (*close)(struct vm_area_struct * area);
+};
+
+
 #endif /* !__KERNEL__ */
 
 /*!
Index: include/rtdm/rtdm_driver.h
===================================================================
--- include/rtdm/rtdm_driver.h	(revision 4513)
+++ include/rtdm/rtdm_driver.h	(working copy)
@@ -26,10 +26,7 @@
 #ifndef _RTDM_DRIVER_H
 #define _RTDM_DRIVER_H
 
-#ifndef __KERNEL__
-#error This header is for kernel space usage only. \
-       You are likely looking for rtdm/rtdm.h...
-#endif /* !__KERNEL__ */
+#ifdef __KERNEL__
 
 #include <asm/atomic.h>
 #include <linux/list.h>
@@ -39,7 +36,6 @@
 #include <nucleus/pod.h>
 #include <nucleus/synch.h>
 #include <nucleus/select.h>
-#include <rtdm/rtdm.h>
 
 /* debug support */
 #include <nucleus/assert.h>
@@ -48,6 +44,12 @@
 #define CONFIG_XENO_OPT_DEBUG_RTDM	0
 #endif
 
+#endif /* __KERNEL__ */
+
+#include <rtdm/rtdm.h>
+#include <nucleus/types.h>
+#include <nucleus/sched.h>
+
 struct rtdm_dev_context;
 typedef struct xnselector rtdm_selector_t;
 enum rtdm_selecttype;
@@ -122,6 +124,8 @@
 #define RTDM_DRIVER_PATCH_VER(ver)	((ver) & 0xFF)
 /** @} Driver Versioning */
 
+#ifdef __KERNEL__
+
 /*!
  * @addtogroup rtdmsync
  * @{
@@ -146,6 +150,8 @@
 
 /** @} rtdmsync */
 
+#endif /* __KERNEL__ */
+
 /*!
  * @name Operation Handler Prototypes
  * @{
@@ -375,7 +381,9 @@
 
 	/** Lock counter of context, held while structure is referenced by an
 	 *  operation handler */
+#ifdef __KERNEL__
 	atomic_t close_lock_count;
+#endif /* __KERNEL__ */
 
 	/** Set of active device operation handlers */
 	struct rtdm_operations *ops;
@@ -390,12 +398,15 @@
 	char dev_private[0];
 };
 
+#ifdef __KERNEL__
 struct rtdm_dev_reserved {
 	struct list_head entry;
 	atomic_t refcount;
 	struct rtdm_dev_context *exclusive_context;
 };
+#endif /* __KERNEL__ */
 
+
 /**
  * @brief RTDM device
  *
@@ -457,16 +468,20 @@
 
 	/** Name of /proc entry for the device, must not be NULL */
 	const char *proc_name;
+#ifdef __KERNEL__
 	/** Set to device's /proc root entry after registration, do not modify */
 	struct proc_dir_entry *proc_entry;
+#endif /* __KERNEL__ */
 
 	/** Driver definable device ID */
 	int device_id;
 	/** Driver definable device data */
 	void *device_data;
 
+#ifdef __KERNEL__
 	/** Data stored by RTDM inside a registered device (internal use only) */
 	struct rtdm_dev_reserved reserved;
+#endif /* __KERNEL__ */
 };
 /** @} devregister */
 
@@ -475,6 +490,8 @@
 int rtdm_dev_register(struct rtdm_device *device);
 int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay);
 
+#ifdef __KERNEL__
+
 /* --- inter-driver API --- */
 
 #define rtdm_open		rt_dev_open
@@ -511,7 +528,12 @@
 	atomic_dec(&context->close_lock_count);
 }
 
+#endif /* __KERNEL__ */
+
 /* --- clock services --- */
+
+#ifdef __KERNEL__
+
 struct xntbase;
 extern struct xntbase *rtdm_tbase;
 
@@ -524,6 +546,14 @@
 {
 	return xntbase_ticks2ns(rtdm_tbase, xntbase_get_jiffies(rtdm_tbase));
 }
+
+#else /* !__KERNEL__ */
+
+nanosecs_abs_t rtdm_clock_read(void);
+nanosecs_abs_t rtdm_clock_read_monotonic(void);
+
+#endif /* __KERNEL__ */
+
 #endif /* !DOXYGEN_CPP */
 
 /*!
@@ -531,15 +561,21 @@
  * @{
  */
 
+#ifdef __KERNEL__
+
 int rtdm_select_bind(int fd, rtdm_selector_t *selector,
 		     enum rtdm_selecttype type, unsigned fd_index);
 
+#endif /* __KERNEL__ */
+
 /* --- spin lock services --- */
 /*!
  * @name Global Lock across Scheduler Invocation
  * @{
  */
 
+#ifdef __KERNEL__
+
 /**
  * @brief Execute code block atomically
  *
@@ -591,11 +627,16 @@
 #endif
 /** @} Global Lock across Scheduler Invocation */
 
+#endif /* __KERNEL__ */
+
 /*!
  * @name Spinlock with Preemption Deactivation
  * @{
  */
 
+#ifdef __KERNEL__
+
+
 /**
  * Static lock initialisation
  */
@@ -739,136 +780,137 @@
 	rthal_local_irq_restore(context)
 /** @} Spinlock with Preemption Deactivation */
 
-/** @} rtdmsync */
+#else /* !__KERNEL__ */
 
-/* --- Interrupt management services --- */
-/*!
- * @addtogroup rtdmirq
- * @{
- */
+typedef xnarch_atomic_t rtdm_lock_t;
 
-typedef xnintr_t rtdm_irq_t;
+typedef unsigned long rtdm_lockctx_t;
 
-/*!
- * @anchor RTDM_IRQTYPE_xxx   @name RTDM_IRQTYPE_xxx
- * Interrupt registrations flags
- * @{
- */
-/** Enable IRQ-sharing with other real-time drivers */
-#define RTDM_IRQTYPE_SHARED		XN_ISR_SHARED
-/** Mark IRQ as edge-triggered, relevant for correct handling of shared
- *  edge-triggered IRQs */
-#define RTDM_IRQTYPE_EDGE		XN_ISR_EDGE
-/** @} RTDM_IRQTYPE_xxx */
+#define RTDM_LOCK_UNLOCKED { (0) }
 
-/**
- * Interrupt handler
- *
- * @param[in] irq_handle IRQ handle as returned by rtdm_irq_request()
- *
- * @return 0 or a combination of @ref RTDM_IRQ_xxx flags
- */
-typedef int (*rtdm_irq_handler_t)(rtdm_irq_t *irq_handle);
-
-/*!
- * @anchor RTDM_IRQ_xxx   @name RTDM_IRQ_xxx
- * Return flags of interrupt handlers
- * @{
- */
-/** Unhandled interrupt */
-#define RTDM_IRQ_NONE			XN_ISR_NONE
-/** Denote handled interrupt */
-#define RTDM_IRQ_HANDLED		XN_ISR_HANDLED
-/** @} RTDM_IRQ_xxx */
-
-/**
- * Retrieve IRQ handler argument
- *
- * @param irq_handle IRQ handle
- * @param type Type of the pointer to return
- *
- * @return The argument pointer registered on rtdm_irq_request() is returned,
- * type-casted to the specified @a type.
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Interrupt service routine
- *
- * Rescheduling: never.
- */
-#define rtdm_irq_get_arg(irq_handle, type)	((type *)irq_handle->cookie)
-/** @} rtdmirq */
-
-int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
-		     rtdm_irq_handler_t handler, unsigned long flags,
-		     const char *device_name, void *arg);
-
-#ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
-static inline int rtdm_irq_free(rtdm_irq_t *irq_handle)
+static __inline__ void __rtdm_lock_get(xnarch_atomic_t *lock)
 {
-	return xnintr_detach(irq_handle);
+	unsigned long old;
+	while((old = xnarch_atomic_cmpxchg(lock, 0, 1)) != 0);
 }
 
-static inline int rtdm_irq_enable(rtdm_irq_t *irq_handle)
+static __inline__ void __rtdm_lock_put(xnarch_atomic_t *lock)
 {
-	return xnintr_enable(irq_handle);
+	xnarch_atomic_cmpxchg(lock, 1, 0);
 }
 
-static inline int rtdm_irq_disable(rtdm_irq_t *irq_handle)
-{
-	return xnintr_disable(irq_handle);
-}
-#endif /* !DOXYGEN_CPP */
+int __rtdm_irqsave(rtdm_lockctx_t *context);
+int __rtdm_irqrestore(rtdm_lockctx_t *context);
 
-/* --- non-real-time signalling services --- */
+#define rtdm_lock_init(lock) xnarch_atomic_set(lock, 0)
+#define rtdm_lock_get(lock) __rtdm_lock_get(lock)
+#define rtdm_lock_put(lock) __rtdm_lock_put(lock)
+#define rtdm_lock_get_irqsave(lock, context)	\
+	do {					\
+		__rtdm_irqsave(&(context));	\
+		__rtdm_lock_get(lock);		\
+	}while(0)
+#define rtdm_lock_put_irqrestore(lock, context) \
+	do {					\
+		__rtdm_lock_put(lock);		\
+		__rtdm_irqrestore(&(context));	\
+	}while(0)
+#define rtdm_lock_irqsave(context) __rtdm_irq_save(&(context))
+#define rtdm_lock_irqrestore(context) __rtdm_irq_restore(&(context))
 
+#endif /* __KERNEL__ */
+
+
+/** @} rtdmsync */
+
+
+/* --- task services --- */
 /*!
- * @addtogroup nrtsignal
+ * @addtogroup rtdmtask
  * @{
  */
 
-typedef unsigned rtdm_nrtsig_t;
+typedef struct {
+	xnhandle_t opaque;
+	unsigned long opaque2;
+} rtdm_task_ph_t;
 
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
+
+typedef struct {
+	xnholder_t link;
+#define link2rtdmtask(ln) container_of(ln, rtdm_task_t, link)
+	xnthread_t thread_base;
+#define thread2rtdmtask(tb) container_of(tb, rtdm_task_t, thread_base)
+} rtdm_task_t;
+
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+/* The user task's stack size is set to the common kernel stack size (8KB) */
+#define RTDM_USER_TASK_STACK_SIZE 0x2000
+
+typedef rtdm_task_ph_t rtdm_task_t;
+
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+
 /**
- * Non-real-time signal handler
+ * Real-time task procedure
  *
- * @param[in] nrt_sig Signal handle as returned by rtdm_nrtsig_init()
- * @param[in] arg Argument as passed to rtdm_nrtsig_init()
- *
- * @note The signal handler will run in soft-IRQ context of the non-real-time
- * subsystem. Note the implications of this context, e.g. no invocation of
- * blocking operations.
+ * @param[in,out] arg argument as passed to rtdm_task_init()
  */
-typedef void (*rtdm_nrtsig_handler_t)(rtdm_nrtsig_t nrt_sig, void *arg);
-/** @} nrtsignal */
+typedef void (*rtdm_task_proc_t)(void *arg);
 
+/*!
+ * @anchor taskprio @name Task Priority Range
+ * Maximum and minimum task priorities
+ * @{ */
+#define RTDM_TASK_LOWEST_PRIORITY	XNSCHED_LOW_PRIO
+#define RTDM_TASK_HIGHEST_PRIORITY	XNSCHED_HIGH_PRIO
+/** @} Task Priority Range */
+
+/*!
+ * @anchor changetaskprio @name Task Priority Modification
+ * Raise or lower task priorities by one level
+ * @{ */
+#define RTDM_TASK_RAISE_PRIORITY	(+1)
+#define RTDM_TASK_LOWER_PRIORITY	(-1)
+/** @} Task Priority Modification */
+
+/** @} rtdmtask */
+
+enum rtdm_timer_mode;
+
+int rtdm_task_init(rtdm_task_t *task, const char *name,
+		   rtdm_task_proc_t task_proc, void *arg,
+		   int priority, nanosecs_rel_t period);
+int _rtdm_task_sleep(xnticks_t timeout, xntmode_t mode);
+
+void rtdm_task_busy_sleep(nanosecs_rel_t delay);
+void rtdm_task_destroy(rtdm_task_t *task);
+void rtdm_task_join_nrt(rtdm_task_t *task, unsigned int poll_delay);
+void rtdm_task_set_priority(rtdm_task_t *task, int priority);
+int rtdm_task_set_period(rtdm_task_t *task, nanosecs_rel_t period);
+int rtdm_task_unblock(rtdm_task_t *task);
+rtdm_task_t *rtdm_task_current(void);
+int rtdm_task_wait_period(void);
+int rtdm_task_sleep(nanosecs_rel_t delay);
+int rtdm_task_sleep_abs(nanosecs_abs_t wakeup_date, enum rtdm_timer_mode mode);
+
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
-static inline int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig,
-				   rtdm_nrtsig_handler_t handler, void *arg)
-{
-	*nrt_sig = rthal_alloc_virq();
+/* rtdm_task_sleep_abs shall be used instead */
 
-	if (*nrt_sig == 0)
-		return -EAGAIN;
+#ifdef __KERNEL__ /* temporary */
 
-	rthal_virtualize_irq(rthal_root_domain, *nrt_sig, handler, arg, NULL,
-			     IPIPE_HANDLE_MASK);
-	return 0;
-}
-
-static inline void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig)
+static inline int __deprecated rtdm_task_sleep_until(nanosecs_abs_t wakeup_time)
 {
-	rthal_free_virq(*nrt_sig);
+	return _rtdm_task_sleep(wakeup_time, XN_REALTIME);
 }
 
-static inline void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig)
-{
-	rthal_trigger_irq(*nrt_sig);
-}
+#endif /* __KERNEL */
+
 #endif /* !DOXYGEN_CPP */
 
+
 /* --- timer services --- */
 
 /*!
@@ -876,15 +918,53 @@
  * @{
  */
 
-typedef xntimer_t rtdm_timer_t;
+struct rtdm_timer;
 
 /**
  * Timer handler
  *
  * @param[in] timer Timer handle as returned by rtdm_timer_init()
  */
-typedef void (*rtdm_timer_handler_t)(rtdm_timer_t *timer);
 
+typedef void (*rtdm_timer_handler_t)(struct rtdm_timer *timer);
+
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
+typedef struct {
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+typedef struct rtdm_timer {
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+	xnhandle_t opaque;
+	rtdm_task_ph_t task;
+	rtdm_timer_handler_t handler;
+} rtdm_timer_ph_t;
+
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
+
+typedef struct rtdm_timer {
+	xntimer_t timer_base;
+	rtdm_timer_handler_t handler;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	xnhandle_t handle;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	unsigned long *process_status;
+	unsigned int pending;
+	xnsynch_t synch_base;
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+	xnholder_t rlink;
+#define rlink2timer(ln)	container_of(ln, rtdm_timer_t, rlink)
+	xnqueue_t *rqueue;
+} rtdm_timer_t;
+
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+typedef rtdm_timer_ph_t rtdm_timer_t;
+
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+
 /*!
  * @anchor RTDM_TIMERMODE_xxx   @name RTDM_TIMERMODE_xxx
  * Timer operation modes
@@ -904,14 +984,8 @@
 
 /** @} rtdmtimer */
 
-#ifndef DOXYGEN_CPP /* Avoid broken doxygen output */
-#define rtdm_timer_init(timer, handler, name)		\
-({							\
-	xntimer_init((timer), rtdm_tbase, handler);	\
-	xntimer_set_name((timer), (name));		\
-	0;						\
-})
-#endif /* !DOXYGEN_CPP */
+int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
+		    const char *name);
 
 void rtdm_timer_destroy(rtdm_timer_t *timer);
 
@@ -921,126 +995,220 @@
 void rtdm_timer_stop(rtdm_timer_t *timer);
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
+
+#ifdef __KERNEL__
+
 static inline int rtdm_timer_start_in_handler(rtdm_timer_t *timer,
 					      nanosecs_abs_t expiry,
 					      nanosecs_rel_t interval,
 					      enum rtdm_timer_mode mode)
 {
-	return xntimer_start(timer, xntbase_ns2ticks_ceil(rtdm_tbase, expiry),
+	return xntimer_start(&timer->timer_base, xntbase_ns2ticks_ceil(rtdm_tbase, expiry),
 			     xntbase_ns2ticks_ceil(rtdm_tbase, interval),
 			     (xntmode_t)mode);
 }
 
 static inline void rtdm_timer_stop_in_handler(rtdm_timer_t *timer)
 {
-	xntimer_stop(timer);
+	xntimer_stop(&timer->timer_base);
 }
+
+#else /* !__KERNEL__ */
+
+#define rtdm_timer_start_in_handler(w, x, y, z) rtdm_timer_start(w, x, y, z)
+#define rtdm_timer_stop_in_handler(w, x, y, z) rtdm_timer_stop(w, x, y, z)
+
+#endif /* __KERNEL__ */
+
 #endif /* !DOXYGEN_CPP */
 
-/* --- task services --- */
+
+/* --- Interrupt management services --- */
 /*!
- * @addtogroup rtdmtask
+ * @addtogroup rtdmirq
  * @{
  */
 
-typedef xnthread_t rtdm_task_t;
-
 /**
- * Real-time task procedure
+ * Interrupt handler
  *
- * @param[in,out] arg argument as passed to rtdm_task_init()
+ * @param[in] irq_handle IRQ handle as returned by rtdm_irq_request()
+ *
+ * @return 0 or a combination of @ref RTDM_IRQ_xxx flags
  */
-typedef void (*rtdm_task_proc_t)(void *arg);
+typedef int (*rtdm_irq_handler_t)(void *irq_handle);
 
+typedef struct {
+	xnhandle_t opaque;
+	rtdm_task_ph_t task;
+	rtdm_irq_handler_t handler;
+	void *arg;
+} rtdm_irq_ph_t;
+
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
+
+typedef struct rtdm_irq {
+	xnintr_t intr_base;
+	
+	void *arg;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	xnhandle_t handle;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	unsigned long *process_status;
+	unsigned int pending;
+	xnsynch_t synch_base;
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+	xnholder_t rlink;
+#define rlink2irq(ln) container_of(ln, rtdm_irq_t, rlink)
+	xnqueue_t *rqueue;
+	
+	char name[XNOBJECT_NAME_LEN];	
+} rtdm_irq_t;
+
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+typedef rtdm_irq_ph_t rtdm_irq_t;
+
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+
 /*!
- * @anchor taskprio @name Task Priority Range
- * Maximum and minimum task priorities
- * @{ */
-#define RTDM_TASK_LOWEST_PRIORITY	XNSCHED_LOW_PRIO
-#define RTDM_TASK_HIGHEST_PRIORITY	XNSCHED_HIGH_PRIO
-/** @} Task Priority Range */
+ * @anchor RTDM_IRQTYPE_xxx   @name RTDM_IRQTYPE_xxx
+ * Interrupt registrations flags
+ * @{
+ */
+/** Enable IRQ-sharing with other real-time drivers */
+#define RTDM_IRQTYPE_SHARED		XN_ISR_SHARED
+/** Mark IRQ as edge-triggered, relevant for correct handling of shared
+ *  edge-triggered IRQs */
+#define RTDM_IRQTYPE_EDGE		XN_ISR_EDGE
+/** @} RTDM_IRQTYPE_xxx */
 
 /*!
- * @anchor changetaskprio @name Task Priority Modification
- * Raise or lower task priorities by one level
- * @{ */
-#define RTDM_TASK_RAISE_PRIORITY	(+1)
-#define RTDM_TASK_LOWER_PRIORITY	(-1)
-/** @} Task Priority Modification */
+ * @anchor RTDM_IRQ_xxx   @name RTDM_IRQ_xxx
+ * Return flags of interrupt handlers
+ * @{
+ */
+/** Unhandled interrupt */
+#define RTDM_IRQ_NONE			XN_ISR_NONE
+/** Denote handled interrupt */
+#define RTDM_IRQ_HANDLED		XN_ISR_HANDLED
+/** @} RTDM_IRQ_xxx */
 
-/** @} rtdmtask */
+/**
+ * Retrieve IRQ handler argument
+ *
+ * @param irq_handle IRQ handle
+ * @param type Type of the pointer to return
+ *
+ * @return The argument pointer registered on rtdm_irq_request() is returned,
+ * type-casted to the specified @a type.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Interrupt service routine
+ *
+ * Rescheduling: never.
+ */
 
-int rtdm_task_init(rtdm_task_t *task, const char *name,
-		   rtdm_task_proc_t task_proc, void *arg,
-		   int priority, nanosecs_rel_t period);
-int __rtdm_task_sleep(xnticks_t timeout, xntmode_t mode);
-void rtdm_task_busy_sleep(nanosecs_rel_t delay);
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
 
-#ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
-static inline void rtdm_task_destroy(rtdm_task_t *task)
-{
-	xnpod_delete_thread(task);
-}
+#define rtdm_irq_get_handle(irq_handle) \
+	((rtdm_irq_t *)(((xnintr_t *)irq_handle)->cookie))
+#define rtdm_irq_get_arg(irq_handle, type) \
+	((type *)((rtdm_irq_t *)(((xnintr_t *)irq_handle)->cookie))->arg)
 
-void rtdm_task_join_nrt(rtdm_task_t *task, unsigned int poll_delay);
+#else /* !(__KERNEL__ || __XENO_SIM__) */
 
-static inline void rtdm_task_set_priority(rtdm_task_t *task, int priority)
-{
-	union xnsched_policy_param param = { .rt = { .prio = priority } };
-	xnpod_set_thread_schedparam(task, &xnsched_class_rt, &param);
-	xnpod_schedule();
-}
+#define rtdm_irq_get_arg(irq_handle, type) \
+	((type *)((rtdm_irq_t *)irq_handle)->arg)
 
-static inline int rtdm_task_set_period(rtdm_task_t *task,
-				       nanosecs_rel_t period)
-{
-	if (period < 0)
-		period = 0;
-	return xnpod_set_thread_periodic(task, XN_INFINITE,
-					 xntbase_ns2ticks_ceil
-					 (xnthread_time_base(task), period));
-}
+#endif /* __KERNEL__ || __XENO_SIM__ */
+	
+int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
+		     rtdm_irq_handler_t handler, unsigned long flags,
+		     const char *device_name, void *arg);
+int rtdm_irq_free(rtdm_irq_t *irq_handle);
+int rtdm_irq_enable(rtdm_irq_t *irq_handle);
+int rtdm_irq_disable(rtdm_irq_t *irq_handle);
 
-static inline int rtdm_task_unblock(rtdm_task_t *task)
-{
-	int res = xnpod_unblock_thread(task);
+/** @} rtdmirq */
 
-	xnpod_schedule();
-	return res;
-}
 
-static inline rtdm_task_t *rtdm_task_current(void)
-{
-	return xnpod_current_thread();
-}
+/* --- non-real-time signalling services --- */
+/*!
+ * @addtogroup nrtsignal
+ * @{
+ */
 
-static inline int rtdm_task_wait_period(void)
-{
-	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
-	return xnpod_wait_thread_period(NULL);
-}
+struct rtdm_nrtsig;
 
-static inline int rtdm_task_sleep(nanosecs_rel_t delay)
-{
-	return __rtdm_task_sleep(delay, XN_RELATIVE);
-}
+/**
+ * Non-real-time signal handler
+ *
+ * @param[in] virq Virtual signal
+ * @param[in] arg Argument as passed to rtdm_nrtsig_init()
+ *
+ * @note The signal handler will run in soft-IRQ context of the non-real-time
+ * subsystem. Note the implications of this context, e.g. no invocation of
+ * blocking operations.
+ */
+typedef void (*rtdm_nrtsig_handler_t)(unsigned int virq, void *arg);
 
-static inline int
-rtdm_task_sleep_abs(nanosecs_abs_t wakeup_date, enum rtdm_timer_mode mode)
-{
-	/* For the sake of a consistent API usage... */
-	if (mode != RTDM_TIMERMODE_ABSOLUTE && mode != RTDM_TIMERMODE_REALTIME)
-		return -EINVAL;
-	return __rtdm_task_sleep(wakeup_date, (xntmode_t)mode);
-}
+#ifndef DOXYGEN_CPP
 
-/* rtdm_task_sleep_abs shall be used instead */
-static inline int __deprecated rtdm_task_sleep_until(nanosecs_abs_t wakeup_time)
-{
-	return __rtdm_task_sleep(wakeup_time, XN_REALTIME);
-}
+#if defined(__KERNEL__) || defined(__XENO_SIM__)
+typedef struct {
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+typedef struct rtdm_nrtsig {
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+	xnhandle_t opaque;
+	unsigned long opaque2;
+	rtdm_nrtsig_handler_t handler;
+	unsigned virq;
+	void *arg;
+} rtdm_nrtsig_ph_t;
+
+#if (defined(__KERNEL__) || defined(__XENO_SIM__))
+
+typedef struct rtdm_nrtsig {	
+	unsigned virq;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	xnhandle_t handle;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	atomic_t pending;
+	wait_queue_head_t nrt_synch;
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+	xnholder_t rlink;
+#define rlink2nrtsig(ln) container_of(ln, rtdm_nrtsig_t, rlink)
+	xnqueue_t *rqueue;
+} rtdm_nrtsig_t;
+
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+typedef rtdm_nrtsig_ph_t rtdm_nrtsig_t;
+
+#endif /* __KERNEL__ || __XENO_SIM__ */
+
+int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig, 
+		     rtdm_nrtsig_handler_t handler, void *arg);
+void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig);
+void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
+
 #endif /* !DOXYGEN_CPP */
 
+/** @} nrtsignal */
+
+
 /* --- timeout sequences */
 
 typedef nanosecs_abs_t rtdm_toseq_t;
@@ -1050,10 +1218,30 @@
 /* --- event services --- */
 
 typedef struct {
+	xnhandle_t opaque;
+} rtdm_event_ph_t;
+
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
+
+typedef struct {
 	xnsynch_t synch_base;
 	DECLARE_XNSELECT(select_block);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	xnhandle_t handle;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnholder_t rlink;
+#define rlink2event(ln)	container_of(ln, rtdm_event_t, rlink)
+	xnqueue_t *rqueue;
 } rtdm_event_t;
 
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+typedef rtdm_event_ph_t rtdm_event_t;
+
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+
 #define RTDM_EVENT_PENDING		XNSYNCH_SPARE1
 
 void rtdm_event_init(rtdm_event_t *event, unsigned long pending);
@@ -1067,35 +1255,45 @@
 int rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
 			 rtdm_toseq_t *timeout_seq);
 void rtdm_event_signal(rtdm_event_t *event);
-
 void rtdm_event_clear(rtdm_event_t *event);
+void rtdm_event_pulse(rtdm_event_t *event);
+void rtdm_event_destroy(rtdm_event_t *event);
 
-#ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
+/* Avoid static inline tags for RTDM in doxygen */
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
 void __rtdm_synch_flush(xnsynch_t *synch, unsigned long reason);
+#endif /* (__KERNEL__ || __XENO_SIM__) */
 
-static inline void rtdm_event_pulse(rtdm_event_t *event)
-{
-	trace_mark(xn_rtdm_event_pulse, "event %p", event);
-	__rtdm_synch_flush(&event->synch_base, 0);
-}
+/* --- semaphore services --- */
 
-static inline void rtdm_event_destroy(rtdm_event_t *event)
-{
-	trace_mark(xn_rtdm_event_destroy, "event %p", event);
-	__rtdm_synch_flush(&event->synch_base, XNRMID);
-	xnselect_destroy(&event->select_block);
-}
-#endif /* !DOXYGEN_CPP */
+typedef struct {
+	xnhandle_t opaque;
+} rtdm_sem_ph_t;
 
-/* --- semaphore services --- */
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
 
 typedef struct {
 	unsigned long value;
 	xnsynch_t synch_base;
 	DECLARE_XNSELECT(select_block);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	xnhandle_t handle;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnholder_t rlink;
+#define rlink2sem(ln) container_of(ln, rtdm_sem_t, rlink)
+	xnqueue_t *rqueue;
 } rtdm_sem_t;
 
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+typedef rtdm_sem_ph_t rtdm_sem_t;
+
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+
 void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value);
+void rtdm_sem_destroy(rtdm_sem_t *sem);
 #ifdef CONFIG_XENO_OPT_RTDM_SELECT
 int rtdm_sem_select_bind(rtdm_sem_t *sem, rtdm_selector_t *selector,
 			 enum rtdm_selecttype type, unsigned fd_index);
@@ -1107,50 +1305,92 @@
 		       rtdm_toseq_t *timeout_seq);
 void rtdm_sem_up(rtdm_sem_t *sem);
 
-#ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
-static inline void rtdm_sem_destroy(rtdm_sem_t *sem)
-{
-	trace_mark(xn_rtdm_sem_destroy, "sem %p", sem);
-	__rtdm_synch_flush(&sem->synch_base, XNRMID);
-	xnselect_destroy(&sem->select_block);
-}
-#endif /* !DOXYGEN_CPP */
 
 /* --- mutex services --- */
 
 typedef struct {
+	xnhandle_t opaque;
+} rtdm_mutex_ph_t;
+
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
+
+typedef struct {
 	xnsynch_t synch_base;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	xnhandle_t handle;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnholder_t rlink;
+#define rlink2mutex(ln) container_of(ln, rtdm_mutex_t, rlink)
+	xnqueue_t *rqueue;
 } rtdm_mutex_t;
 
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+typedef rtdm_mutex_ph_t rtdm_mutex_t;
+
+#endif /* (__KERNEL__ || __XENO_SIM__) */
+
 void rtdm_mutex_init(rtdm_mutex_t *mutex);
+void rtdm_mutex_destroy(rtdm_mutex_t *mutex);
+void rtdm_mutex_unlock(rtdm_mutex_t *mutex);
 int rtdm_mutex_lock(rtdm_mutex_t *mutex);
 int rtdm_mutex_timedlock(rtdm_mutex_t *mutex, nanosecs_rel_t timeout,
 			 rtdm_toseq_t *timeout_seq);
 
-#ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
-static inline void rtdm_mutex_unlock(rtdm_mutex_t *mutex)
-{
-	XENO_ASSERT(RTDM, !xnpod_asynch_p(), return;);
+/* --- utility functions --- */
 
-	trace_mark(xn_rtdm_mutex_unlock, "mutex %p", mutex);
+#ifdef __KERNEL__
+#define rtdm_printk(format, ...)	printk(format, ##__VA_ARGS__)
+#else /* !__KERNEL__ */
+#define rtdm_printk(format, ...)	fprintf(stderr, format, ##__VA_ARGS__)
+#endif /* __KERNEL__ */
 
-	if (unlikely(xnsynch_release(&mutex->synch_base) != NULL))
-		xnpod_schedule();
-}
+#define RTDM_PG_DMA 0x1
+#define RTDM_PG_NONCACHED 0x2
+#define RTDM_PG_FLAGS (RTDM_PG_DMA | RTDM_PG_NONCACHED)
 
-static inline void rtdm_mutex_destroy(rtdm_mutex_t *mutex)
-{
-	trace_mark(xn_rtdm_mutex_destroy, "mutex %p", mutex);
+#define RTDM_MAIN_HEAP_SIZE 0x4000
 
-	__rtdm_synch_flush(&mutex->synch_base, XNRMID);
-}
-#endif /* !DOXYGEN_CPP */
+typedef struct {
+	xnhandle_t opaque;
+	caddr_t mapbase;
+	size_t mapsize;
+	caddr_t phybase;
+	/* This field is not used regularly; 
+	   then, we set the other fields on the same cache line */
+	void *opaque2;
+} rtdm_heap_ph_t;
 
-/* --- utility functions --- */
+#if (defined(__KERNEL__) || defined(__XENO_SIM__))
 
-#define rtdm_printk(format, ...)	printk(format, ##__VA_ARGS__)
+typedef struct {
+	xnheap_t heap_base;
+	unsigned long mode;
 
-#ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	xnhandle_t handle;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnholder_t rlink;
+#define rlink2heap(ln) container_of(ln, rtdm_heap_t, rlink)
+	xnqueue_t *rqueue;
+} rtdm_heap_t;
+
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+typedef rtdm_heap_ph_t rtdm_heap_t;
+
+#endif /* __KERNEL__ || __XENO_SIM__ */
+
+int rtdm_heap_init(rtdm_heap_t *heap, unsigned long size, unsigned long flags);
+int rtdm_heap_destroy(rtdm_heap_t *heap);
+void *rtdm_heap_malloc(rtdm_heap_t *heap, size_t size);
+void rtdm_heap_free(rtdm_heap_t *heap, void *ptr);
+
+#if (defined(__KERNEL__) || defined(__XENO_SIM__)) 
+
 static inline void *rtdm_malloc(size_t size)
 {
 	return xnmalloc(size);
@@ -1161,6 +1401,26 @@
 	xnfree(ptr);
 }
 
+#else /* !(__KERNEL__ || __XENO_SIM__) */
+
+extern rtdm_heap_t __main_heap;
+
+static inline void *rtdm_malloc(size_t size)
+{
+	return rtdm_heap_malloc(&__main_heap, size);
+}
+
+static inline void rtdm_free(void *ptr)
+{
+	rtdm_heap_free(&__main_heap, ptr);
+}
+
+#endif /* __KERNEL__ || __XENO_SIM__ */
+
+#ifdef __KERNEL__
+
+#ifndef DOXYGEN_CPP
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
 		      void *src_addr, size_t len,
@@ -1247,4 +1507,53 @@
 		    rtdm_user_info_t *user_info, void *arg,
 		    rtdm_rt_handler_t handler);
 
+#else /* !__KERNEL__ */
+
+#define rtdm_read_user_ok(user_info, ptr, size) ((ptr != NULL) ? 1 : 0)
+#define rtdm_rw_user_ok(user_info, ptr, size) ((ptr != NULL) ? 1 : 0)
+#define rtdm_mmap_to_user(user_info, src_addr, len, prot, pptr, vm_ops, priv) \
+	__rtdm_map_to_user(src_addr, pptr, vm_ops, priv)
+#define rtdm_iomap_to_user(user_info, src_addr, len, prot, pptr, vm_ops, priv) \
+	__rtdm_map_to_user(src_addr, pptr, vm_ops, priv)
+
+static inline int rtdm_copy_from_user(rtdm_user_info_t *user_info,
+				      void *dst, const void __user *src,
+				      size_t size)
+{
+	memcpy(dst, src, size);
+	return 0;
+}
+
+static inline int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info,
+					   void *dst, const void __user *src,
+					   size_t size)
+{
+	return (!rtdm_read_user_ok(user_info, src, size) ||
+		rtdm_copy_from_user(user_info, dst, src, size)) ? -EFAULT : 0;
+}
+
+static inline int rtdm_copy_to_user(rtdm_user_info_t *user_info,
+				    void __user *dst, const void *src,
+				    size_t size)
+{
+	memcpy(dst, src, size);
+	return 0;
+}
+
+static inline int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info,
+					 void __user *dst, const void *src,
+					 size_t size)
+{
+	return (!rtdm_rw_user_ok(user_info, dst, size) ||
+		rtdm_copy_to_user(user_info, dst, src, size)) ? -EFAULT : 0;
+}
+
+int __rtdm_map_to_user(void *src_addr, 
+		       void **pptr,
+		       struct vm_operations_struct *vm_ops, void *vm_private_data);
+
+int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
+
+#endif /* __KERNEL__ */
+
 #endif /* _RTDM_DRIVER_H */
Index: include/rtdm/syscall.h
===================================================================
--- include/rtdm/syscall.h	(revision 4513)
+++ include/rtdm/syscall.h	(working copy)
@@ -35,7 +35,68 @@
 #define __rtdm_write		6
 #define __rtdm_recvmsg		7
 #define __rtdm_sendmsg		8
+#define __rtdm_clock_read       9
+#define __rtdm_clock_read_monotonic 10
+#define __rtdm_task_init        11
+#define __rtdm_task_start       12
+#define __rtdm_task_destroy     13
+#define __rtdm_task_set_priority 14
+#define __rtdm_task_set_period  15
+#define __rtdm_task_wait_period 16
+#define __rtdm_task_unblock     17
+#define __rtdm_task_current     18
+#define __rtdm_task_sleep       19
+#define __rtdm_task_sleep_abs   20
+#define __rtdm_task_join_nrt    21
+#define __rtdm_task_busy_sleep  22
+#define __rtdm_timer_init       23
+#define __rtdm_timer_destroy    24
+#define __rtdm_timer_start      25
+#define __rtdm_timer_stop       26
+#define __rtdm_timer_wait       27
+#define __rtdm_toseq_init       28
+#define __rtdm_event_init       29
+#define __rtdm_event_destroy    30
+#define __rtdm_event_pulse      31
+#define __rtdm_event_signal     32
+#define __rtdm_event_wait       33
+#define __rtdm_event_timedwait  34
+#define __rtdm_event_clear      35
+#define __rtdm_sem_init         36
+#define __rtdm_sem_destroy      37
+#define __rtdm_sem_down         38
+#define __rtdm_sem_timeddown    39
+#define __rtdm_sem_up           40
+#define __rtdm_mutex_init       41
+#define __rtdm_mutex_destroy    42
+#define __rtdm_mutex_unlock     43
+#define __rtdm_mutex_lock       44
+#define __rtdm_mutex_timedlock  45
+#define __rtdm_irq_request      46
+#define __rtdm_irq_free         47
+#define __rtdm_irq_wait         48
+#define __rtdm_irq_save         49
+#define __rtdm_irq_restore      50
+#define __rtdm_nrtsig_init      51
+#define __rtdm_nrtsig_destroy   52
+#define __rtdm_nrtsig_pend      53
+#define __rtdm_nrtsig_wait      54
+#define __rtdm_heap_init        55
+#define __rtdm_heap_destroy     56
+#define __rtdm_heap_malloc      57
+#define __rtdm_heap_free        58
 
+struct rtdm_arg_bulk {
+
+	u_long a1;
+	u_long a2;
+	u_long a3;
+	u_long a4;
+	u_long a5;
+	u_long a6;
+	u_long a7;
+};
+
 #ifdef __KERNEL__
 
 #ifdef __cplusplus
Index: ksrc/skins/rtdm/drvlib.c
===================================================================
--- ksrc/skins/rtdm/drvlib.c	(revision 4513)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -38,8 +38,11 @@
 #include <linux/mman.h>
 #include <linux/highmem.h>
 
+#include <nucleus/registry.h>
 #include <rtdm/rtdm_driver.h>
 
+#include "internal.h"
+
 /*!
  * @ingroup driverapi
  * @defgroup clock Clock Services
@@ -144,52 +147,86 @@
 	struct xnthread_init_attr iattr;
 	int err;
 
+	inith(&task->link);
+
 	iattr.tbase = rtdm_tbase;
 	iattr.name = name;
-	iattr.flags = 0;
+	iattr.flags = (task_proc == NULL) ? XNSHADOW | XNFPU : 0;
 	iattr.ops = NULL;
 	iattr.stacksize = 0;
 	param.rt.prio = priority;
 
-	err = xnpod_init_thread(task, &iattr, &xnsched_class_rt, &param);
-	if (err)
+	err = xnpod_init_thread(&task->thread_base, 
+				&iattr, &xnsched_class_rt, &param);
+	if(err)
 		return err;
 
-#ifdef CONFIG_XENO_FASTSYNCH
+#if (defined(CONFIG_XENO_OPT_REGISTRY) || defined (CONFIG_XENO_OPT_REGISTRY))
 	/* We need an anonymous registry entry to obtain a handle for fast
-	   mutex locking. */
-	err = xnthread_register(task, "");
-	if (err)
+	   mutex locking and for user-space task. */
+	err = xnthread_register(&task->thread_base, "");
+	if(err < 0)
 		goto cleanup_out;
-#endif /* CONFIG_XENO_FASTSYNCH */
+#endif /* CONFIG_XENO_OPT_REGISTRY || CONFIG_XENO_OPT_REGISTRY */
 
 	if (period > 0) {
-		err = xnpod_set_thread_periodic(task, XN_INFINITE,
+		err = xnpod_set_thread_periodic(&task->thread_base, 
+						XN_INFINITE,
 						xntbase_ns2ticks_ceil
 						(rtdm_tbase,  period));
 		if (err)
 			goto cleanup_out;
 	}
 
-	sattr.mode = 0;
-	sattr.imask = 0;
-	sattr.affinity = XNPOD_ALL_CPUS;
-	sattr.entry = task_proc;
-	sattr.cookie = arg;
-	err = xnpod_start_thread(task, &sattr);
-	if (err)
-		goto cleanup_out;
+	if(task_proc != NULL) {
+		sattr.mode = 0;
+		sattr.imask = 0;
+		sattr.affinity = XNPOD_ALL_CPUS;
+		sattr.entry = task_proc;
+		sattr.cookie = arg;
+		err = xnpod_start_thread(&task->thread_base, &sattr);
+		if (err)
+			goto cleanup_out;
+	}
 
-	return 0;
+	return err;
+	
+cleanup_out:
 
-      cleanup_out:
-	xnpod_delete_thread(task);
+	xnpod_delete_thread(&task->thread_base);
 	return err;
 }
 
 EXPORT_SYMBOL(rtdm_task_init);
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
+static void __task_destroy_hook(xnthread_t *thread)
+{	
+	rtdm_task_t *task = thread2rtdmtask(thread);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if(xnthread_handle(&task->thread_base) != XN_NO_HANDLE)
+		xnregistry_remove(xnthread_handle(&task->thread_base));
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	if (xnthread_test_state(thread, XNMAPPED))
+		xnshadow_unmap(thread);
+
+	if (xnthread_test_state(&task->thread_base, XNSHADOW))
+		xnheap_schedule_free(&kheap, task, &task->link);
+}
+
+int rtdm_task_pkg_init(void)
+{
+	xnpod_add_hook(XNHOOK_THREAD_DELETE, &__task_destroy_hook);
+	return 0;
+}
+
+int rtdm_task_pkg_cleanup(void)
+{
+	xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__task_destroy_hook);	
+	return 0;
+}
+
 /**
  * @brief Destroy a real-time task
  *
@@ -208,7 +245,13 @@
  *
  * Rescheduling: never.
  */
-void rtdm_task_destroy(rtdm_task_t *task);
+void rtdm_task_destroy(rtdm_task_t *task)
+{
+	if(task == NULL)
+		return;
+	
+	xnpod_delete_thread(&task->thread_base);
+}
 
 /**
  * @brief Adjust real-time task priority
@@ -228,7 +271,13 @@
  *
  * Rescheduling: possible.
  */
-void rtdm_task_set_priority(rtdm_task_t *task, int priority);
+void rtdm_task_set_priority(rtdm_task_t *task, int priority)
+{
+	union xnsched_policy_param param = { .rt = { .prio = priority } };
+	xnpod_set_thread_schedparam(&task->thread_base, 
+				    &xnsched_class_rt, &param);
+	xnpod_schedule();
+}
 
 /**
  * @brief Adjust real-time task period
@@ -248,7 +297,15 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_task_set_period(rtdm_task_t *task, nanosecs_rel_t period);
+int rtdm_task_set_period(rtdm_task_t *task, nanosecs_rel_t period)
+{
+	if (period < 0)
+		period = 0;
+	return xnpod_set_thread_periodic(&task->thread_base, XN_INFINITE,
+					 xntbase_ns2ticks_ceil
+					 (xnthread_time_base(&task->thread_base), 
+					  period));
+}
 
 /**
  * @brief Wait on next real-time task period
@@ -269,7 +326,11 @@
  *
  * Rescheduling: always, unless a timer overrun occured.
  */
-int rtdm_task_wait_period(void);
+int rtdm_task_wait_period(void)
+{
+	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+	return xnpod_wait_thread_period(NULL);
+}
 
 /**
  * @brief Activate a blocked real-time task
@@ -288,8 +349,14 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_task_unblock(rtdm_task_t *task);
+int rtdm_task_unblock(rtdm_task_t *task)
+{
+	int res = xnpod_unblock_thread(&task->thread_base);
 
+	xnpod_schedule();
+	return res;
+}
+
 /**
  * @brief Get current real-time task
  *
@@ -304,8 +371,13 @@
  *
  * Rescheduling: never.
  */
-rtdm_task_t *rtdm_task_current(void);
+rtdm_task_t *rtdm_task_current(void)
+{
+	xnthread_t *thread = xnpod_current_thread();
 
+	return thread2rtdmtask(thread);
+}
+
 /**
  * @brief Sleep a specified amount of time
  *
@@ -329,7 +401,10 @@
  *
  * Rescheduling: always.
  */
-int rtdm_task_sleep(nanosecs_rel_t delay);
+int rtdm_task_sleep(nanosecs_rel_t delay)
+{
+	return _rtdm_task_sleep(delay, XN_RELATIVE);
+}
 
 /**
  * @brief Sleep until a specified absolute time
@@ -382,11 +457,15 @@
  *
  * Rescheduling: always, unless the specified time already passed.
  */
-int rtdm_task_sleep_abs(nanosecs_abs_t wakeup_time, enum rtdm_timer_mode mode);
+int rtdm_task_sleep_abs(nanosecs_abs_t wakeup_time, enum rtdm_timer_mode mode)
+{
+	/* For the sake of a consistent API usage... */
+	if (mode != RTDM_TIMERMODE_ABSOLUTE && mode != RTDM_TIMERMODE_REALTIME)
+		return -EINVAL;
+	return _rtdm_task_sleep(wakeup_time, (xntmode_t)mode);
+}
 
-#endif /* DOXYGEN_CPP */
-
-int __rtdm_task_sleep(xnticks_t timeout, xntmode_t mode)
+int _rtdm_task_sleep(xnticks_t timeout, xntmode_t mode)
 {
 	xnthread_t *thread = xnpod_current_thread();
 
@@ -399,7 +478,7 @@
 	return xnthread_test_info(thread, XNBREAK) ? -EINTR : 0;
 }
 
-EXPORT_SYMBOL(__rtdm_task_sleep);
+EXPORT_SYMBOL(_rtdm_task_sleep);
 
 /**
  * @brief Wait on a real-time task to terminate
@@ -436,7 +515,7 @@
 
 	xnlock_get_irqsave(&nklock, s);
 
-	while (!xnthread_test_state(task, XNZOMBIE)) {
+	while (!xnthread_test_state(&task->thread_base, XNZOMBIE)) {
 		xnlock_put_irqrestore(&nklock, s);
 
 		msleep(poll_delay);
@@ -486,7 +565,14 @@
  * @{
  */
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
+#ifndef DOXYGEN_CPP
+static void __timer_trampoline(xntimer_t *timer)
+{
+	rtdm_timer_t *rtdmtimer = container_of(timer, rtdm_timer_t, timer_base);
+	rtdmtimer->handler(rtdmtimer);
+}
+#endif /* DOXYGEN_CPP */
+
 /**
  * @brief Initialise a timer
  *
@@ -507,9 +593,36 @@
  * Rescheduling: never.
  */
 int rtdm_timer_init(rtdm_timer_t *timer, rtdm_timer_handler_t handler,
-		    const char *name);
-#endif /* DOXYGEN_CPP */
+		    const char *name) 
+{
+	int err = 0;
+	spl_t s;
 
+	timer->handler = handler;
+	xntimer_init(&timer->timer_base, rtdm_tbase, __timer_trampoline);
+	inith(&timer->rlink);
+	timer->rqueue = &rtdm_get_process()->timerq;
+	xnlock_get_irqsave(&nklock, s);
+	appendq(timer->rqueue, &timer->rlink);
+	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	timer->process_status = &rtdm_get_process()->status;
+	timer->pending = 0;
+	xnsynch_init(&timer->synch_base, XNSYNCH_PRIO, NULL);
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	err = xnregistry_enter("", timer, &timer->handle, NULL);
+	if(err < 0)
+		rtdm_timer_destroy(timer);
+	else
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+		xntimer_set_name(&timer->timer_base, name);
+
+	return err;
+}
+
 /**
  * @brief Destroy a timer
  *
@@ -527,10 +640,29 @@
  */
 void rtdm_timer_destroy(rtdm_timer_t *timer)
 {
+	int rc = 0;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
-	xntimer_destroy(timer);
+
+	removeq(timer->rqueue, &timer->rlink);
+
+	xntimer_destroy(&timer->timer_base);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	rc = xnsynch_destroy(&timer->synch_base);
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if (timer->handle)
+		xnregistry_remove(timer->handle);
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	if (rc == XNSYNCH_RESCHED)
+		/* Some task has been woken up as a result of the deletion:
+		   reschedule now. */
+		xnpod_schedule();
+
 	xnlock_put_irqrestore(&nklock, s);
 }
 
@@ -570,7 +702,8 @@
 	int err;
 
 	xnlock_get_irqsave(&nklock, s);
-	err = xntimer_start(timer, xntbase_ns2ticks_ceil(rtdm_tbase, expiry),
+	err = xntimer_start(&timer->timer_base, 
+			    xntbase_ns2ticks_ceil(rtdm_tbase, expiry),
 			    xntbase_ns2ticks_ceil(rtdm_tbase, interval),
 			    (xntmode_t)mode);
 	xnlock_put_irqrestore(&nklock, s);
@@ -601,7 +734,7 @@
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
-	xntimer_stop(timer);
+	xntimer_stop(&timer->timer_base);
 	xnlock_put_irqrestore(&nklock, s);
 }
 
@@ -751,6 +884,36 @@
  * @{
  */
 
+int rtdm_event_init_inner(rtdm_event_t *event, unsigned long pending)
+{
+	int err;
+	spl_t s;
+
+	trace_mark(xn_rtdm_event_init, "event %p pending %lu", event, pending);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	err = xnregistry_enter("", event, &event->handle, NULL);
+	if(err < 0)
+		return err;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	/* Make atomic for re-initialisation support */
+	xnlock_get_irqsave(&nklock, s);
+
+	inith(&event->rlink);
+	event->rqueue = &rtdm_get_process()->eventq;
+	appendq(event->rqueue, &event->rlink);
+
+	xnsynch_init(&event->synch_base, XNSYNCH_PRIO, NULL);
+	if (pending)
+		xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
+	xnselect_init(&event->select_block);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
 /**
  * @brief Initialise an event
  *
@@ -769,24 +932,11 @@
  */
 void rtdm_event_init(rtdm_event_t *event, unsigned long pending)
 {
-	spl_t s;
-
-	trace_mark(xn_rtdm_event_init, "event %p pending %lu", event, pending);
-
-	/* Make atomic for re-initialisation support */
-	xnlock_get_irqsave(&nklock, s);
-
-	xnsynch_init(&event->synch_base, XNSYNCH_PRIO, NULL);
-	if (pending)
-		xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
-	xnselect_init(&event->select_block);
-
-	xnlock_put_irqrestore(&nklock, s);
+	rtdm_event_init_inner(event, pending);
 }
 
 EXPORT_SYMBOL(rtdm_event_init);
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy an event
  *
@@ -802,8 +952,29 @@
  *
  * Rescheduling: possible.
  */
-void rtdm_event_destroy(rtdm_event_t *event);
+void rtdm_event_destroy(rtdm_event_t *event)
+{
+	spl_t s;
 
+	trace_mark(xn_rtdm_event_destroy, "event %p", event);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if(event->handle != 0)
+		xnregistry_remove(event->handle);
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnlock_get_irqsave(&nklock, s);
+
+	removeq(event->rqueue, &event->rlink);
+	
+	__rtdm_synch_flush(&event->synch_base, XNRMID);
+	xnselect_destroy(&event->select_block);
+	
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(rtdm_event_destroy);
+
 /**
  * @brief Signal an event occurrence to currently listening waiters
  *
@@ -824,9 +995,14 @@
  *
  * Rescheduling: possible.
  */
-void rtdm_event_pulse(rtdm_event_t *event);
-#endif /* DOXYGEN_CPP */
+void rtdm_event_pulse(rtdm_event_t *event)
+{
+	trace_mark(xn_rtdm_event_pulse, "event %p", event);
+	__rtdm_synch_flush(&event->synch_base, 0);
+}
 
+EXPORT_SYMBOL(rtdm_event_pulse);
+
 /**
  * @brief Signal an event occurrence
  *
@@ -1098,6 +1274,35 @@
  * @{
  */
 
+int rtdm_sem_init_inner(rtdm_sem_t *sem, unsigned long value)
+{
+	int err;
+	spl_t s;
+
+	trace_mark(xn_rtdm_sem_init, "sem %p value %lu", sem, value);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	err = xnregistry_enter("", sem, &sem->handle, NULL);
+	if(err < 0)
+		return err;
+#endif /* CONFIG_XENO_OPT_REGISTRY */	
+
+	/* Make atomic for re-initialisation support */
+	xnlock_get_irqsave(&nklock, s);
+
+	inith(&sem->rlink);
+	sem->rqueue = &rtdm_get_process()->semq;
+	appendq(sem->rqueue, &sem->rlink);
+
+	sem->value = value;
+	xnsynch_init(&sem->synch_base, XNSYNCH_PRIO, NULL);
+	xnselect_init(&sem->select_block);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
 /**
  * @brief Initialise a semaphore
  *
@@ -1116,23 +1321,11 @@
  */
 void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value)
 {
-	spl_t s;
-
-	trace_mark(xn_rtdm_sem_init, "sem %p value %lu", sem, value);
-
-	/* Make atomic for re-initialisation support */
-	xnlock_get_irqsave(&nklock, s);
-
-	sem->value = value;
-	xnsynch_init(&sem->synch_base, XNSYNCH_PRIO, NULL);
-	xnselect_init(&sem->select_block);
-
-	xnlock_put_irqrestore(&nklock, s);
+	rtdm_sem_init_inner(sem, value);
 }
 
 EXPORT_SYMBOL(rtdm_sem_init);
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy a semaphore
  *
@@ -1148,9 +1341,29 @@
  *
  * Rescheduling: possible.
  */
-void rtdm_sem_destroy(rtdm_sem_t *sem);
-#endif /* DOXYGEN_CPP */
+void rtdm_sem_destroy(rtdm_sem_t *sem)
+{
+	spl_t s;
 
+	trace_mark(xn_rtdm_sem_destroy, "sem %p", sem);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	removeq(sem->rqueue, &sem->rlink);
+
+	__rtdm_synch_flush(&sem->synch_base, XNRMID);
+	xnselect_destroy(&sem->select_block);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if(sem->handle != 0)
+		xnregistry_remove(sem->handle);
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(rtdm_sem_destroy);
+
 /**
  * @brief Decrement a semaphore
  *
@@ -1379,6 +1592,32 @@
  * @{
  */
 
+int rtdm_mutex_init_inner(rtdm_mutex_t *mutex)
+{
+	int err;
+	spl_t s;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	err = xnregistry_enter("", mutex, &mutex->handle, NULL);
+	if(err < 0)
+		return err;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	/* Make atomic for re-initialisation support */
+	xnlock_get_irqsave(&nklock, s);
+
+	inith(&mutex->rlink);
+	mutex->rqueue = &rtdm_get_process()->mutexq;
+	appendq(mutex->rqueue, &mutex->rlink);
+
+	xnsynch_init(&mutex->synch_base,
+		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, NULL);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
 /**
  * @brief Initialise a mutex
  *
@@ -1400,20 +1639,11 @@
  */
 void rtdm_mutex_init(rtdm_mutex_t *mutex)
 {
-	spl_t s;
-
-	/* Make atomic for re-initialisation support */
-	xnlock_get_irqsave(&nklock, s);
-
-	xnsynch_init(&mutex->synch_base,
-		     XNSYNCH_PRIO | XNSYNCH_PIP | XNSYNCH_OWNER, NULL);
-
-	xnlock_put_irqrestore(&nklock, s);
+	rtdm_mutex_init_inner(mutex);
 }
 
 EXPORT_SYMBOL(rtdm_mutex_init);
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy a mutex
  *
@@ -1429,8 +1659,26 @@
  *
  * Rescheduling: possible.
  */
-void rtdm_mutex_destroy(rtdm_mutex_t *mutex);
+void rtdm_mutex_destroy(rtdm_mutex_t *mutex)
+{
+	spl_t s;
 
+	trace_mark(xn_rtdm_mutex_destroy, "mutex %p", mutex);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	removeq(mutex->rqueue, &mutex->rlink);
+
+	__rtdm_synch_flush(&mutex->synch_base, XNRMID);
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if(mutex->handle != 0)
+		xnregistry_remove(mutex->handle);
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+       
+	xnlock_put_irqrestore(&nklock, s);
+}
+
 /**
  * @brief Release a mutex
  *
@@ -1448,9 +1696,16 @@
  *
  * Rescheduling: possible.
  */
-void rtdm_mutex_unlock(rtdm_mutex_t *mutex);
-#endif /* DOXYGEN_CPP */
+void rtdm_mutex_unlock(rtdm_mutex_t *mutex)
+{
+	XENO_ASSERT(RTDM, !xnpod_asynch_p(), return;);
 
+	trace_mark(xn_rtdm_mutex_unlock, "mutex %p", mutex);
+
+	if (unlikely(xnsynch_release(&mutex->synch_base) != NULL))
+		xnpod_schedule();
+}
+
 /**
  * @brief Request a mutex
  *
@@ -1622,23 +1877,53 @@
 		     const char *device_name, void *arg)
 {
 	int err;
+	spl_t s;
 
-	xnintr_init(irq_handle, device_name, irq_no, handler, NULL, flags);
+	if(device_name)
+		xnobject_copy_name(irq_handle->name, device_name);
+	else
+		xnobject_create_name(irq_handle->name, 
+				     XNOBJECT_NAME_LEN, (void *)irq_handle);
 
-	err = xnintr_attach(irq_handle, arg);
+	irq_handle->arg = arg;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	err = xnregistry_enter(irq_handle->name,
+			       irq_handle, &irq_handle->handle, NULL);
+	if(err < 0)
+		return err;
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	irq_handle->process_status = &rtdm_get_process()->status;
+	irq_handle->pending = 0;
+	xnsynch_init(&irq_handle->synch_base, XNSYNCH_PRIO, NULL);
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+	xnintr_init(&irq_handle->intr_base, 
+		    irq_handle->name, 
+		    irq_no, (xnisr_t)handler, NULL, flags);
+
+	err = xnintr_attach(&irq_handle->intr_base, irq_handle);
 	if (err)
 		return err;
 
-	err = xnintr_enable(irq_handle);
+	err = xnintr_enable(&irq_handle->intr_base);
 	if (err)
-		xnintr_detach(irq_handle);
+		xnintr_detach(&irq_handle->intr_base);
+	else {
+		inith(&irq_handle->rlink);
+		irq_handle->rqueue = &rtdm_get_process()->irq_handleq;
+		xnlock_get_irqsave(&nklock, s);
+		appendq(irq_handle->rqueue, &irq_handle->rlink);
+		xnlock_put_irqrestore(&nklock, s);
+	}
 
 	return err;
 }
 
 EXPORT_SYMBOL(rtdm_irq_request);
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Release an interrupt handler
  *
@@ -1656,8 +1941,22 @@
  *
  * Rescheduling: never.
  */
-int rtdm_irq_free(rtdm_irq_t *irq_handle);
+int rtdm_irq_free(rtdm_irq_t *irq_handle)
+{
+	spl_t s;
 
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if(irq_handle->handle != 0)
+		xnregistry_remove(irq_handle->handle);
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnlock_get_irqsave(&nklock, s);
+	removeq(irq_handle->rqueue, &irq_handle->rlink);		
+	xnlock_put_irqrestore(&nklock, s);
+
+	return xnintr_detach(&irq_handle->intr_base);
+}
+
 /**
  * @brief Enable interrupt line
  *
@@ -1676,7 +1975,10 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_irq_enable(rtdm_irq_t *irq_handle);
+int rtdm_irq_enable(rtdm_irq_t *irq_handle)
+{
+	return xnintr_enable(&irq_handle->intr_base);
+}
 
 /**
  * @brief Disable interrupt line
@@ -1696,13 +1998,13 @@
  *
  * Rescheduling: never.
  */
-int rtdm_irq_disable(rtdm_irq_t *irq_handle);
-#endif /* DOXYGEN_CPP */
+int rtdm_irq_disable(rtdm_irq_t *irq_handle)
+{
+	return xnintr_disable(&irq_handle->intr_base);
+}
 
 /** @} Interrupt Management Services */
 
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
-
 /*!
  * @ingroup driverapi
  * @defgroup nrtsignal Non-Real-Time Signalling Services
@@ -1736,9 +2038,41 @@
  *
  * Rescheduling: never.
  */
-int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig, rtdm_nrtsig_handler_t handler,
-		     void *arg);
+int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig, 
+		     rtdm_nrtsig_handler_t handler, void *arg)
+{
+	int err;
+	spl_t s;
 
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	err = xnregistry_enter("", nrt_sig, &nrt_sig->handle, NULL);
+	if(err < 0)
+		return err;
+#endif /* CONFIG_XENO_OPT_REGISTRY */	
+
+	nrt_sig->virq = rthal_alloc_virq();
+
+	if (nrt_sig->virq == 0) {
+		xnregistry_remove(nrt_sig->handle);		
+		return -EAGAIN;
+	}
+
+	inith(&nrt_sig->rlink);
+	nrt_sig->rqueue = &rtdm_get_process()->nrt_sigq;
+	xnlock_get_irqsave(&nklock, s);
+	appendq(nrt_sig->rqueue, &nrt_sig->rlink);
+	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	atomic_set(&nrt_sig->pending, 0);
+	init_waitqueue_head((&nrt_sig->nrt_synch));
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+	rthal_virtualize_irq(rthal_root_domain, 
+			     nrt_sig->virq, handler, arg, NULL, IPIPE_HANDLE_MASK);
+	return 0;
+}
+
 /**
  * @brief Release a non-realtime signal handler
  *
@@ -1754,8 +2088,22 @@
  *
  * Rescheduling: never.
  */
-void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig);
+void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig)
+{
+	spl_t s;
 
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if(nrt_sig->handle != 0)
+		xnregistry_remove(nrt_sig->handle);
+#endif /* CONFIG_XENO_OPT_REGISTRY */	
+
+	xnlock_get_irqsave(&nklock, s);
+	removeq(nrt_sig->rqueue, &nrt_sig->rlink);
+	xnlock_put_irqrestore(&nklock, s);
+
+	rthal_free_virq(nrt_sig->virq);
+}
+
 /**
  * Trigger non-real-time signal
  *
@@ -1773,17 +2121,78 @@
  * Rescheduling: never in real-time context, possible in non-real-time
  * environments.
  */
-void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
+void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig)
+{
+	rthal_trigger_irq(nrt_sig->virq);
+}
+
 /** @} Non-Real-Time Signalling Services */
 
-#endif /* DOXYGEN_CPP */
-
 /*!
  * @ingroup driverapi
  * @defgroup util Utility Services
  * @{
  */
 
+int rtdm_heap_init(rtdm_heap_t *heap, unsigned long size, unsigned long flags)
+{
+	int err;
+	spl_t s;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	err = xnregistry_enter("", heap, &heap->handle, NULL);
+	if(err < 0)
+		return err;
+#endif /* CONFIG_XENO_OPT_REGISTRY */	
+
+	inith(&heap->rlink);
+	heap->rqueue = &rtdm_get_process()->heapq;
+	xnlock_get_irqsave(&nklock, s);
+	appendq(heap->rqueue, &heap->rlink);
+	xnlock_put_irqrestore(&nklock, s);
+
+	heap->mode = (flags & RTDM_PG_FLAGS);
+
+	err = xnheap_init_mapped(&heap->heap_base,
+				 size, 
+				 ((flags & RTDM_PG_DMA) ? GFP_DMA : 0) |
+				 (flags & RTDM_PG_NONCACHED) ? 
+				 XNHEAP_GFP_NONCACHED : 0);
+
+	return err;
+}
+
+int rtdm_heap_destroy_inner(rtdm_heap_t *heap, void __user * mapaddr)
+{
+	spl_t s;
+
+#ifdef CONFIG_XENO_OPT_REGISTRY
+	if(heap->handle != 0)
+		xnregistry_remove(heap->handle);
+#endif /* CONFIG_XENO_OPT_REGISTRY */
+
+	xnlock_get_irqsave(&nklock, s);
+	removeq(heap->rqueue, &heap->rlink);
+	xnlock_put_irqrestore(&nklock, s);
+
+	return xnheap_destroy_mapped(&heap->heap_base, mapaddr);
+}
+
+int rtdm_heap_destroy(rtdm_heap_t *heap)
+{
+	return rtdm_heap_destroy_inner(heap, NULL);
+}
+
+void *rtdm_heap_malloc(rtdm_heap_t *heap, size_t size)
+{
+	return xnheap_alloc(&heap->heap_base, size);
+}
+
+void rtdm_heap_free(rtdm_heap_t *heap, void *ptr)
+{
+	xnheap_free(&heap->heap_base, ptr);
+}
+
 #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
 struct rtdm_mmap_data {
 	void *src_vaddr;
Index: ksrc/skins/rtdm/internal.h
===================================================================
--- ksrc/skins/rtdm/internal.h	(revision 4513)
+++ ksrc/skins/rtdm/internal.h	(working copy)
@@ -33,6 +33,8 @@
 #define DEF_DEVNAME_HASHTAB_SIZE	256	/* entries in name hash table */
 #define DEF_PROTO_HASHTAB_SIZE		256	/* entries in protocol hash table */
 
+#define PROC_MASK_IRQ 0
+
 struct rtdm_fildes {
 	struct rtdm_dev_context *context;
 };
@@ -43,12 +45,23 @@
 	pid_t pid;
 #endif /* CONFIG_PROC_FS */
 
+	unsigned long status;
+
+	xnqueue_t timerq;
+	xnqueue_t eventq;
+	xnqueue_t semq;	
+	xnqueue_t mutexq;
+	xnqueue_t irq_handleq;
+	xnqueue_t nrt_sigq;
+	xnqueue_t heapq;	
+
 	xnshadow_ppd_t ppd;
 };
 
 DECLARE_EXTERN_XNLOCK(rt_fildes_lock);
 DECLARE_EXTERN_XNLOCK(rt_dev_lock);
 
+extern struct rtdm_process __rtdm_global_process;
 extern int __rtdm_muxid;
 extern struct rtdm_fildes fildes_table[];
 extern int open_fildes;
@@ -87,4 +100,140 @@
 int __init rtdm_proc_init(void);
 void rtdm_proc_cleanup(void);
 
+int rtdm_task_pkg_init(void);
+int rtdm_task_pkg_cleanup(void);
+
+int rtdm_event_init_inner(rtdm_event_t *event, unsigned long pending);
+int rtdm_sem_init_inner(rtdm_sem_t *sem, unsigned long value);
+int rtdm_mutex_init_inner(rtdm_mutex_t *mutex);
+int rtdm_heap_destroy_inner(rtdm_heap_t *heap, void __user * mapaddr);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+
+static inline struct rtdm_process * rtdm_get_process(void)
+{
+	xnshadow_ppd_t *ppd = xnshadow_ppd_get(__rtdm_muxid);
+
+	if(ppd == NULL)
+		return &__rtdm_global_process;
+	
+	return container_of(ppd, struct rtdm_process, ppd);
+}
+
+#define __rtdm_release_obj(obj)			\
+	do {					\
+		xnfree(obj);			\
+	} while(0)
+
+
+#else /* !CONFIG_XENO_OPT_PERVASIVE */
+
+static inline struct rtdm_process * rtdm_get_process(void)
+{
+	return &__rtdm_global_process;
+}
+
+#define __rtdm_release_obj(obj)
+
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+#if XENO_DEBUG(RTDM)
+#define __rtdm_trace_release(__name, __obj)		\
+	xnprintf("RTDM: cleaning up %s 0x%p.\n",		\
+		 __name, __obj)
+#else /* !XENO_DEBUG(RTDM) */
+#define __rtdm_trace_release(__name, __obj)
+#endif /* !XENO_DEBUG(RTDM) */
+
+#define rtdm_flush_rq(__type, __rq, __name)				\
+	do {								\
+		void rtdm_##__name##_destroy(__type *);			\
+		xnholder_t *holder, *nholder;				\
+		__type *obj;						\
+		spl_t s;						\
+		xnlock_get_irqsave(&nklock, s);				\
+		nholder = getheadq(__rq);				\
+		while ((holder = nholder) != NULL) {			\
+			nholder = nextq((__rq), holder);		\
+			xnlock_put_irqrestore(&nklock, s);		\
+			obj = rlink2##__name(holder);			\
+			rtdm_##__name##_destroy(obj);			\
+			__rtdm_trace_release(#__name, obj);		\
+			__rtdm_release_obj(obj);			\
+			xnlock_get_irqsave(&nklock, s);			\
+		}							\
+		xnlock_put_irqrestore(&nklock, s);			\
+	} while(0)
+
+static inline void __rtdm_timer_flush_rq(xnqueue_t *rq)
+{
+	rtdm_flush_rq(rtdm_timer_t, rq, timer);	
+}
+
+static inline void __rtdm_event_flush_rq(xnqueue_t *rq)
+{
+	rtdm_flush_rq(rtdm_event_t, rq, event);	
+}
+
+static inline void __rtdm_sem_flush_rq(xnqueue_t *rq)
+{
+	rtdm_flush_rq(rtdm_sem_t, rq, sem);	
+}
+
+static inline void __rtdm_mutex_flush_rq(xnqueue_t *rq)
+{
+	rtdm_flush_rq(rtdm_mutex_t, rq, mutex);	
+}
+
+static inline void __rtdm_irq_flush_rq(xnqueue_t *rq)
+{
+	int rtdm_irq_free(rtdm_irq_t *irq_handle);
+	xnholder_t *holder, *nholder;
+	rtdm_irq_t *obj;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	nholder = getheadq(rq);
+	while ((holder = nholder) != NULL) {
+		nholder = nextq((rq), holder);
+		xnlock_put_irqrestore(&nklock, s);
+		obj = rlink2irq(holder);
+		rtdm_irq_free(obj);
+		__rtdm_trace_release("interrupt", obj);
+		__rtdm_release_obj(obj);
+		xnlock_get_irqsave(&nklock, s);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+static inline void __rtdm_nrtsig_flush_rq(xnqueue_t *rq)
+{
+	rtdm_flush_rq(rtdm_nrtsig_t, rq, nrtsig);	
+}
+
+static inline void __rtdm_heap_flush_rq(xnqueue_t *rq)
+{
+	int rtdm_heap_destroy(rtdm_heap_t *heap);
+	xnholder_t *holder, *nholder;
+	rtdm_heap_t *obj;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	nholder = getheadq(rq);
+	while ((holder = nholder) != NULL) {
+		nholder = nextq((rq), holder);
+		xnlock_put_irqrestore(&nklock, s);
+		obj = rlink2heap(holder);
+		rtdm_heap_destroy(obj);
+		__rtdm_trace_release("heap", obj);
+		__rtdm_release_obj(obj);
+		xnlock_get_irqsave(&nklock, s);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
 #endif /* _RTDM_INTERNAL_H */
Index: ksrc/skins/rtdm/module.c
===================================================================
--- ksrc/skins/rtdm/module.c	(revision 4513)
+++ ksrc/skins/rtdm/module.c	(working copy)
@@ -37,6 +37,8 @@
 
 #include "rtdm/internal.h"
 
+struct rtdm_process __rtdm_global_process;
+
 MODULE_DESCRIPTION("Real-Time Driver Model");
 MODULE_AUTHOR("jan.kiszka@domain.hid");
 MODULE_LICENSE("GPL");
@@ -56,6 +58,7 @@
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	rtdm_syscall_cleanup();
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+	rtdm_task_pkg_cleanup();
 	xntbase_free(rtdm_tbase);
 	xnpod_shutdown(xtype);
 }
@@ -64,6 +67,14 @@
 {
 	int err;
 
+	initq(&__rtdm_global_process.timerq);
+	initq(&__rtdm_global_process.eventq);
+	initq(&__rtdm_global_process.semq);
+	initq(&__rtdm_global_process.mutexq);
+	initq(&__rtdm_global_process.irq_handleq);
+	initq(&__rtdm_global_process.nrt_sigq);
+	initq(&__rtdm_global_process.heapq);
+
 	err = xnpod_init();
 
 	if (err)
@@ -85,7 +96,10 @@
 		goto cleanup_dev;
 #endif /* CONFIG_PROC_FS */
 
+	rtdm_task_pkg_init();
+
 #ifdef CONFIG_XENO_OPT_PERVASIVE
+
 	err = rtdm_syscall_init();
 	if (err)
 		goto cleanup_proc;
Index: ksrc/skins/rtdm/syscall.c
===================================================================
--- ksrc/skins/rtdm/syscall.c	(revision 4513)
+++ ksrc/skins/rtdm/syscall.c	(working copy)
@@ -19,6 +19,7 @@
 
 #include <nucleus/shadow.h>
 #include <nucleus/ppd.h>
+#include <nucleus/registry.h>
 #include <rtdm/syscall.h>
 
 #include "rtdm/internal.h"
@@ -116,6 +117,1357 @@
 				__xn_reg_arg3(regs));
 }
 
+static int sys_rtdm_clock_read(struct pt_regs *regs)
+{
+	nanosecs_abs_t clock = rtdm_clock_read();
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+			     &clock, sizeof(nanosecs_abs_t)) < 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sys_rtdm_clock_read_monotonic(struct pt_regs *regs)
+{
+	nanosecs_abs_t clock = rtdm_clock_read_monotonic();
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+				  &clock, sizeof(nanosecs_abs_t)) < 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sys_rtdm_task_init(struct pt_regs *regs)
+{
+	int ret;
+	struct rtdm_arg_bulk bulk;
+	struct task_struct *p = current;
+	rtdm_task_t *task;
+	rtdm_task_ph_t ph;
+	char name[XNOBJECT_NAME_LEN];
+	nanosecs_rel_t period;
+
+	/* Check that the freshly created thread has not already
+	   been shadowed */
+	if (xnshadow_thread(p)) {
+		return -EBUSY;
+	}
+
+	if (__xn_safe_copy_from_user(&bulk, (void __user *)__xn_reg_arg1(regs),
+				     sizeof(struct rtdm_arg_bulk))) {
+		return -EFAULT;
+	}
+	
+
+	task = (rtdm_task_t*) xnmalloc(sizeof(rtdm_task_t));
+	if(task == NULL) {
+		return -ENOMEM;
+	}
+
+	xnthread_clear_state(&task->thread_base, XNZOMBIE);
+
+	/* Retrieve the task's name, if need be */
+	if(bulk.a2 != 0) {
+		if(__xn_safe_strncpy_from_user(name, 
+					       (const char __user *)bulk.a2,
+					       XNOBJECT_NAME_LEN - 1) < 0) {
+			ret = -EFAULT;
+			goto out_sys_task_init;
+		}
+
+		name[sizeof(name) - 1] = '\0';
+		strncpy(p->comm, name, sizeof(p->comm));
+		p->comm[sizeof(p->comm) - 1] = '\0';
+	} else
+		*name = '\0';
+
+	/* Retrieve the task's period, if need be */
+	if(bulk.a4 != 0) {
+		if(__xn_safe_copy_from_user(&period, 
+					    (void __user *)bulk.a4,
+					    sizeof(nanosecs_rel_t)) < 0) {
+			ret = -EFAULT;
+			goto out_sys_task_init;
+		}
+	} else
+		period = 0;
+	
+	/* Call the kernel API */
+	ret = rtdm_task_init(task, 
+			     name, 
+			     NULL, 
+			     NULL,
+			     (int) bulk.a3,
+			     period);
+	
+	if(ret < 0)
+		goto out_sys_task_init;
+	
+	ret = xnshadow_map(&task->thread_base, 
+			   (xncompletion_t __user *)bulk.a5,
+			   (unsigned long __user *)bulk.a6);
+	if(ret < 0) {
+		rtdm_task_destroy(task);
+		goto out_sys_task_init;
+	}
+
+	ph.opaque = xnthread_handle(&task->thread_base);
+	ph.opaque2 = bulk.a7;
+	
+	ret = __xn_safe_copy_to_user((void __user *)bulk.a1,
+				     &ph, sizeof(rtdm_task_ph_t));
+
+out_sys_task_init:
+
+	if(ret < 0) {
+		
+		xnshadow_signal_completion((xncompletion_t __user *)bulk.a5, ret);
+
+		/* Task memory could have been released by an indirect call to
+		 * the deletion hook, after xnpod_delete_thread() has been
+		 * issued from rt_task_create() (e.g. upon registration
+		 * error). We avoid double memory release when the XNZOMBIE
+		 * flag is raised, meaning the deletion hook has run, and the
+		 * TCB memory is already scheduled for release. */
+
+		if(task != NULL &&
+		   !xnthread_test_state(&task->thread_base, XNZOMBIE))
+			xnfree(task);
+	}
+
+	return ret;
+
+}
+
+static int sys_rtdm_task_start(struct pt_regs *regs)
+{
+	xnthread_t *thread;
+	struct xnthread_start_attr sattr;
+	rtdm_task_ph_t ph;
+	spl_t s;
+	int err;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_task_ph_t)) < 0)
+		return -EFAULT;
+
+	thread = (xnthread_t *) xnregistry_fetch(ph.opaque);
+
+	if(thread == NULL)
+		return -ESRCH;
+
+	sattr.mode = 0;
+	sattr.imask = 0;
+	sattr.affinity = XNPOD_ALL_CPUS;
+	sattr.entry = NULL;
+	sattr.cookie = NULL;
+
+	xnlock_get_irqsave(&nklock, s);
+	err = xnpod_start_thread(thread, &sattr);
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
+static int sys_rtdm_task_destroy(struct pt_regs *regs)
+{
+	xnthread_t *thread;
+	rtdm_task_t *task;
+	rtdm_task_ph_t ph;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_task_ph_t)) < 0)
+		return -EFAULT;
+
+	thread = (xnthread_t *) xnregistry_fetch(ph.opaque);
+
+	if(thread == NULL)
+		return -ESRCH;
+
+	task = thread2rtdmtask(thread);
+
+	rtdm_task_destroy(task);
+
+	return 0;
+}
+
+static int sys_rtdm_task_set_priority(struct pt_regs *regs)
+{
+	xnthread_t *thread;
+	rtdm_task_t *task;
+	rtdm_task_ph_t ph;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_task_ph_t)) < 0)
+		return -EFAULT;
+
+	thread = (xnthread_t *) xnregistry_fetch(ph.opaque);
+
+	if(thread == NULL)
+		return -ESRCH;
+
+	task = thread2rtdmtask(thread);
+
+	rtdm_task_set_priority(task, __xn_reg_arg2(regs));
+
+	return 0;
+}
+
+static int sys_rtdm_task_set_period(struct pt_regs *regs)
+{
+	xnthread_t *thread;
+	rtdm_task_t *task;
+	rtdm_task_ph_t ph;
+	nanosecs_rel_t period;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_task_ph_t)) < 0)
+		return -EFAULT;
+
+	thread = (xnthread_t *) xnregistry_fetch(ph.opaque);
+
+	if(thread == NULL)
+		return -ESRCH;
+
+	task = thread2rtdmtask(thread);
+
+	if(__xn_safe_copy_from_user(&period, 
+				    (void __user *)__xn_reg_arg2(regs),
+				    sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;
+
+	return rtdm_task_set_period(task, period);
+}
+
+static int sys_rtdm_task_wait_period(struct pt_regs *regs)
+{	
+	return rtdm_task_wait_period();
+}
+
+static int sys_rtdm_task_unblock(struct pt_regs *regs)
+{
+	xnthread_t *thread;
+	rtdm_task_t *task;
+	rtdm_task_ph_t ph;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_task_ph_t)) < 0)
+		return -EFAULT;
+
+	thread = (xnthread_t *) xnregistry_fetch(ph.opaque);
+
+	if(thread == NULL)
+		return -ESRCH;
+
+	task = thread2rtdmtask(thread);
+
+	return rtdm_task_unblock(task);
+}
+
+static int sys_rtdm_task_current(struct pt_regs *regs)
+{
+	rtdm_task_ph_t ph;
+	xnthread_t *thread = xnshadow_thread(current);
+
+	if (!thread || xnthread_get_magic(thread) != RTDM_SKIN_MAGIC)
+		return -ESRCH;
+	
+	ph.opaque = xnthread_handle(thread);
+
+	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), 
+				   &ph, sizeof(rtdm_task_ph_t)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sys_rtdm_task_sleep(struct pt_regs *regs)
+{
+	nanosecs_rel_t delay;
+
+	if(__xn_safe_copy_from_user(&delay, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;				  
+
+	return rtdm_task_sleep(delay);
+}
+
+static int sys_rtdm_task_sleep_abs(struct pt_regs *regs)
+{
+	nanosecs_abs_t delay;
+	enum rtdm_timer_mode mode;
+
+	if(__xn_safe_copy_from_user(&delay, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(nanosecs_abs_t)) < 0)
+		return -EFAULT;
+
+	mode = (enum rtdm_timer_mode) __xn_reg_arg2(regs);
+				  
+	return rtdm_task_sleep_abs(delay, mode);
+}
+
+static int sys_rtdm_task_join_nrt(struct pt_regs *regs)
+{
+	xnthread_t *thread;
+	rtdm_task_t *task;
+	rtdm_task_ph_t ph;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_task_ph_t)) < 0)
+		return -EFAULT;
+
+	thread = (xnthread_t *) xnregistry_fetch(ph.opaque);
+
+	if(thread == NULL)
+		return -ESRCH;
+
+	task = thread2rtdmtask(thread);
+
+	rtdm_task_join_nrt(task, __xn_reg_arg2(regs));
+
+	return 0;
+}
+
+static int sys_rtdm_task_busy_sleep(struct pt_regs *regs)
+{
+	nanosecs_rel_t delay;
+	
+	if(__xn_safe_copy_from_user(&delay, 
+				    (void __user *) __xn_reg_arg1(regs),
+				    sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;
+	
+	rtdm_task_busy_sleep(delay);
+
+	return 0;
+}
+
+void __user_timer_handler(rtdm_timer_t *timer)
+{
+	++timer->pending;
+
+	if(test_bit(PROC_MASK_IRQ, timer->process_status))
+		return;
+
+	xnsynch_flush(&timer->synch_base, 0);
+}
+
+static int sys_rtdm_timer_init(struct pt_regs *regs)
+{
+	char name[XNOBJECT_NAME_LEN];
+	rtdm_timer_ph_t ph;
+	rtdm_timer_t *timer;
+	int ret;
+
+	if(__xn_reg_arg3(regs)) {
+		if(__xn_safe_strncpy_from_user(name,
+					       (const char __user *)__xn_reg_arg3(regs),
+					       XNOBJECT_NAME_LEN - 1) < 0)
+			return -EFAULT;
+
+		name[XNOBJECT_NAME_LEN - 1] = '\0';
+	} else
+		*name = '\0';
+	
+	timer = xnmalloc(sizeof(rtdm_timer_t));
+	if(timer == NULL)
+		return -ENOMEM;
+
+	ret = rtdm_timer_init(timer, &__user_timer_handler, name);
+
+	if(ret == 0) {
+		/* Send back the registry handle to user world thanks to
+		   the placeholder structure */
+		ph.opaque = timer->handle;
+		ph.handler = (rtdm_timer_handler_t)__xn_reg_arg2(regs);
+
+		if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+					  &ph, 
+					  sizeof(rtdm_timer_ph_t)) < 0)
+			ret = -EFAULT;
+
+	} else
+		xnfree(timer);
+	
+	return ret;
+}
+
+static int sys_rtdm_timer_destroy(struct pt_regs *regs)
+{
+	rtdm_timer_ph_t ph;
+	rtdm_timer_t *timer;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_timer_ph_t)))
+		return -EFAULT;
+	
+	timer = xnregistry_fetch(ph.opaque);
+
+	if(timer == NULL)
+		return -ESRCH;
+	
+	rtdm_timer_destroy(timer);
+
+	xnfree(timer);
+	
+	return 0;
+}
+
+static int sys_rtdm_timer_start(struct pt_regs *regs)
+{
+	rtdm_timer_ph_t ph;
+	rtdm_timer_t *timer;
+	nanosecs_abs_t expiry;
+	nanosecs_rel_t interval;
+	int ret;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_timer_ph_t)) < 0)
+		return -EFAULT;
+	
+	timer = xnregistry_fetch(ph.opaque);
+
+	if(timer == NULL)
+		return -ESRCH;
+
+	if(__xn_safe_copy_from_user(&expiry,
+				    (void __user *)__xn_reg_arg2(regs),
+				    sizeof(nanosecs_abs_t)) < 0)
+		return -EFAULT;
+
+	if(__xn_safe_copy_from_user(&interval,
+				    (void __user *)__xn_reg_arg3(regs),
+				    sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;
+
+	ret = rtdm_timer_start(timer, 
+			       expiry, 
+			       interval, 
+			       (enum rtdm_timer_mode) __xn_reg_arg4(regs));
+
+	return ret;
+}
+
+static int sys_rtdm_timer_stop(struct pt_regs *regs)
+{
+	rtdm_timer_ph_t ph;
+	rtdm_timer_t *timer;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_timer_ph_t)) < 0)
+		return -EFAULT;
+	
+	timer = xnregistry_fetch(ph.opaque);
+
+	if(timer == NULL)
+		return -ESRCH;
+
+	rtdm_timer_stop(timer);
+
+	return 0;
+}
+
+static int sys_rtdm_timer_wait(struct pt_regs *regs)
+{
+	xnthread_t *thread = xnpod_current_thread();
+	union xnsched_policy_param param;
+	rtdm_timer_ph_t ph;
+	rtdm_timer_t *timer;
+	int err = 0;
+	spl_t s;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_timer_ph_t)) < 0)
+		return -EFAULT;
+
+	xnlock_get_irqsave(&nklock, s);
+	
+	timer = xnregistry_fetch(ph.opaque);
+
+	if(timer == NULL) {
+		err = -ESRCH;
+		goto unlock_and_exit;
+	}
+
+	if(timer->pending == 0) {
+
+		if (xnthread_base_priority(thread) != XNSCHED_IRQ_PRIO) {
+			/* Boost the waiter above all regular tasks if needed. */
+			param.rt.prio = XNSCHED_IRQ_PRIO;
+			xnpod_set_thread_schedparam(thread, &xnsched_class_rt, &param);
+		}
+		
+		xnsynch_sleep_on(&timer->synch_base, XN_INFINITE, XN_RELATIVE);
+		
+		if (xnthread_test_info(thread, XNRMID))
+			err = -EIDRM;	/* Alarm deleted while pending. */
+		else if (xnthread_test_info(thread, XNBREAK))
+			err = -EINTR;	/* Unblocked. */
+	}
+
+	timer->pending = 0;
+
+unlock_and_exit:
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
+static int sys_rtdm_toseq_init(struct pt_regs *regs)
+{
+	nanosecs_rel_t timeout_ns;
+	rtdm_toseq_t timeout_seq;
+
+	if(__xn_safe_copy_from_user(&timeout_ns,
+				    (void __user *)__xn_reg_arg2(regs),
+				    sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;
+	
+	rtdm_toseq_init(&timeout_seq, timeout_ns);
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+				  &timeout_seq,
+				  sizeof(rtdm_toseq_t)) < 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sys_rtdm_event_init(struct pt_regs *regs)
+{
+	int ret;
+	rtdm_event_ph_t ph;
+	rtdm_event_t *event;
+	
+	event = xnmalloc(sizeof(rtdm_event_t));
+	if(event == NULL)
+		return -ENOMEM;
+
+	ret = rtdm_event_init_inner(event, (unsigned long) __xn_reg_arg2(regs));
+	
+	ph.opaque = event->handle;
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+				  &ph,
+				  sizeof(rtdm_event_ph_t)) < 0)
+		return -EFAULT;
+	
+	if(ret < 0)
+		xnfree(event);
+
+	return  ret;
+}
+
+static int sys_rtdm_event_destroy(struct pt_regs *regs)
+{
+	rtdm_event_ph_t ph;
+	rtdm_event_t *event;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_event_ph_t)) < 0)
+		return -EFAULT;
+	
+	event = xnregistry_fetch(ph.opaque);
+
+	if(event == NULL)
+		return -ESRCH;
+
+	rtdm_event_destroy(event);
+
+	xnfree(event);
+
+	return 0;
+}
+
+static int sys_rtdm_event_pulse(struct pt_regs *regs)
+{
+	rtdm_event_ph_t ph;
+	rtdm_event_t *event;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_event_ph_t)) < 0)
+		return -EFAULT;
+	
+	event = xnregistry_fetch(ph.opaque);
+
+	if(event == NULL)
+		return -ESRCH;
+
+	rtdm_event_pulse(event);
+
+	return 0;
+}
+
+static int sys_rtdm_event_signal(struct pt_regs *regs)
+{
+	rtdm_event_ph_t ph;
+	rtdm_event_t *event;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_event_ph_t)) < 0)
+		return -EFAULT;
+	
+	event = xnregistry_fetch(ph.opaque);
+
+	if(event == NULL)
+		return -ESRCH;
+
+	rtdm_event_signal(event);
+
+	return 0;
+}
+
+static int sys_rtdm_event_wait(struct pt_regs *regs)
+{
+	rtdm_event_ph_t ph;
+	rtdm_event_t *event;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_event_ph_t)) < 0)
+		return -EFAULT;
+	
+	event = xnregistry_fetch(ph.opaque);
+
+	if(event == NULL)
+		return -ESRCH;
+
+	return rtdm_event_wait(event);
+}
+
+static int sys_rtdm_event_timedwait(struct pt_regs *regs)
+{
+	rtdm_event_ph_t ph;
+	rtdm_event_t *event;
+	nanosecs_rel_t timeout;
+	rtdm_toseq_t timeout_seq;
+	int ret;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_event_ph_t)) < 0)
+		return -EFAULT;
+	
+	event = xnregistry_fetch(ph.opaque);
+
+	if(event == NULL)
+		return -ESRCH;
+
+	if (__xn_safe_copy_from_user(&timeout, 
+				     (void __user *)__xn_reg_arg2(regs),
+				     sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;
+
+	if (__xn_safe_copy_from_user(&timeout_seq, 
+				     (void __user *)__xn_reg_arg3(regs),
+				     sizeof(rtdm_toseq_t)) < 0)
+		return -EFAULT;
+
+
+	ret = rtdm_event_timedwait(event, timeout, &timeout_seq);
+
+	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
+				   &timeout_seq,
+				   sizeof(rtdm_toseq_t)) < 0)
+		return -EFAULT;
+	
+	return ret;
+}
+
+static int sys_rtdm_event_clear(struct pt_regs *regs)
+{
+	rtdm_event_ph_t ph;
+	rtdm_event_t *event;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_event_ph_t)) < 0)
+		return -EFAULT;
+	
+	event = xnregistry_fetch(ph.opaque);
+
+	if(event == NULL)
+		return -ESRCH;
+
+	rtdm_event_clear(event);
+
+	return 0;
+}
+
+static int sys_rtdm_sem_init(struct pt_regs *regs)
+{
+	int ret;
+	rtdm_sem_ph_t ph;
+	rtdm_sem_t *sem;
+	
+	sem = xnmalloc(sizeof(rtdm_sem_t));
+	if(sem == NULL)
+		return -ENOMEM;
+
+	ret = rtdm_sem_init_inner(sem, (unsigned long) __xn_reg_arg2(regs));
+	
+	ph.opaque = sem->handle;
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+				  &ph,
+				  sizeof(rtdm_sem_ph_t)) < 0)
+		return -EFAULT;
+
+	if(ret < 0)
+		xnfree(sem);
+	
+	return  ret;
+}
+
+static int sys_rtdm_sem_destroy(struct pt_regs *regs)
+{
+	rtdm_sem_ph_t ph;
+	rtdm_sem_t *sem;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_sem_ph_t)) < 0)
+		return -EFAULT;
+	
+	sem = xnregistry_fetch(ph.opaque);
+
+	if(sem == NULL)
+		return -ESRCH;
+
+	rtdm_sem_destroy(sem);
+
+	xnfree(sem);
+
+	return 0;
+}
+
+static int sys_rtdm_sem_down(struct pt_regs *regs)
+{
+	rtdm_sem_ph_t ph;
+	rtdm_sem_t *sem;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_sem_ph_t)) < 0)
+		return -EFAULT;
+	
+	sem = xnregistry_fetch(ph.opaque);
+
+	if(sem == NULL)
+		return -ESRCH;
+
+	return rtdm_sem_down(sem);
+}
+
+static int sys_rtdm_sem_timeddown(struct pt_regs *regs)
+{
+	rtdm_sem_ph_t ph;
+	rtdm_sem_t *sem;
+	nanosecs_rel_t timeout;
+	rtdm_toseq_t timeout_seq;
+	int ret;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_sem_ph_t)) < 0)
+		return -EFAULT;
+	
+	sem = xnregistry_fetch(ph.opaque);
+
+	if(sem == NULL)
+		return -ESRCH;
+
+	if (__xn_safe_copy_from_user(&timeout, 
+				     (void __user *)__xn_reg_arg2(regs),
+				     sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;
+
+	if (__xn_safe_copy_from_user(&timeout_seq, 
+				     (void __user *)__xn_reg_arg3(regs),
+				     sizeof(rtdm_toseq_t)) < 0)
+		return -EFAULT;
+
+	ret = rtdm_sem_timeddown(sem, timeout, &timeout_seq);
+
+	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
+				   &timeout_seq,
+				   sizeof(rtdm_toseq_t)) < 0)
+		return -EFAULT;
+
+	return ret;
+}
+
+static int sys_rtdm_sem_up(struct pt_regs *regs)
+{
+	rtdm_sem_ph_t ph;
+	rtdm_sem_t *sem;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_sem_ph_t)) < 0)
+		return -EFAULT;
+	
+	sem = xnregistry_fetch(ph.opaque);
+
+	if(sem == NULL)
+		return -ESRCH;
+
+	rtdm_sem_up(sem);
+	
+	return 0;
+}
+
+static int sys_rtdm_mutex_init(struct pt_regs *regs)
+{
+	int ret;
+	rtdm_mutex_ph_t ph;
+	rtdm_mutex_t *mutex;
+	
+	mutex = xnmalloc(sizeof(rtdm_mutex_t));
+	if(mutex == NULL)
+		return -ENOMEM;
+
+	ret = rtdm_mutex_init_inner(mutex);
+	
+	ph.opaque = mutex->handle;
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+				  &ph,
+				  sizeof(rtdm_mutex_ph_t)) < 0)
+		return -EFAULT;
+
+	if(ret < 0)
+		xnfree(mutex);
+	
+	return  ret;
+
+}
+
+static int sys_rtdm_mutex_destroy(struct pt_regs *regs)
+{
+	rtdm_mutex_ph_t ph;
+	rtdm_mutex_t *mutex;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_mutex_ph_t)) < 0)
+		return -EFAULT;
+	
+	mutex = xnregistry_fetch(ph.opaque);
+
+	if(mutex == NULL)
+		return -ESRCH;
+
+	rtdm_mutex_destroy(mutex);
+
+	xnfree(mutex);
+
+	return 0;
+}
+
+static int sys_rtdm_mutex_unlock(struct pt_regs *regs)
+{
+	rtdm_mutex_ph_t ph;
+	rtdm_mutex_t *mutex;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_mutex_ph_t)) < 0)
+		return -EFAULT;
+	
+	mutex = xnregistry_fetch(ph.opaque);
+
+	if(mutex == NULL)
+		return -ESRCH;
+
+	rtdm_mutex_unlock(mutex);
+
+	return 0;
+}
+
+static int sys_rtdm_mutex_lock(struct pt_regs *regs)
+{
+	rtdm_mutex_ph_t ph;
+	rtdm_mutex_t *mutex;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_mutex_ph_t)) < 0)
+		return -EFAULT;
+	
+	mutex = xnregistry_fetch(ph.opaque);
+
+	if(mutex == NULL)
+		return -ESRCH;
+	
+	return rtdm_mutex_lock(mutex);
+}
+
+static int sys_rtdm_mutex_timedlock(struct pt_regs *regs)
+{
+	rtdm_mutex_ph_t ph;
+	rtdm_mutex_t *mutex;
+	nanosecs_rel_t timeout;
+	rtdm_toseq_t timeout_seq;
+	int ret;
+
+	if (__xn_safe_copy_from_user(&ph, 
+				     (void __user *)__xn_reg_arg1(regs),
+				     sizeof(rtdm_mutex_ph_t)) < 0)
+		return -EFAULT;
+	
+	mutex = xnregistry_fetch(ph.opaque);
+
+	if(mutex == NULL)
+		return -ESRCH;
+
+	if (__xn_safe_copy_from_user(&timeout, 
+				     (void __user *)__xn_reg_arg2(regs),
+				     sizeof(nanosecs_rel_t)) < 0)
+		return -EFAULT;
+
+	if (__xn_safe_copy_from_user(&timeout_seq, 
+				     (void __user *)__xn_reg_arg3(regs),
+				     sizeof(rtdm_toseq_t)) < 0)
+		return -EFAULT;
+
+	ret = rtdm_mutex_timedlock(mutex, timeout, &timeout_seq);
+
+	if (__xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
+				   &timeout_seq,
+				   sizeof(rtdm_toseq_t)) < 0)
+		return -EFAULT;
+
+	return ret;	
+	
+}
+
+int __user_irq_handler(void *arg)
+{
+	rtdm_irq_t *irq_handle = rtdm_irq_get_handle(arg);
+
+	++irq_handle->pending;
+
+	if(test_bit(PROC_MASK_IRQ, irq_handle->process_status))
+		return RTDM_IRQ_HANDLED;
+
+	/* Wake up the user-side sleepers */ 
+	if (xnsynch_nsleepers(&irq_handle->synch_base) > 0)
+		xnsynch_flush(&irq_handle->synch_base, 0);
+
+	return RTDM_IRQ_HANDLED;	
+}
+
+static int sys_rtdm_irq_request(struct pt_regs *regs)
+{
+	int err;
+	rtdm_irq_ph_t ph;
+	rtdm_irq_t *irq_handle;
+	char name[XNOBJECT_NAME_LEN];
+	
+	if(__xn_safe_strncpy_from_user(name, 
+				       (const char __user *)__xn_reg_arg3(regs),
+				       XNOBJECT_NAME_LEN - 1) < 0) {
+		return -EFAULT;
+	}
+
+	irq_handle = xnmalloc(sizeof(rtdm_irq_t));
+	if(irq_handle == NULL)
+		return -ENOMEM;	
+
+	err = rtdm_irq_request(irq_handle, 
+			       (unsigned int)__xn_reg_arg2(regs),
+			       __user_irq_handler, 0, name, irq_handle);
+	if(err < 0) {
+		goto out_irq_request;
+	}
+
+	ph.opaque = irq_handle->handle;
+	
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), 
+				  &ph, sizeof(rtdm_irq_ph_t)) < 0) {
+		rtdm_irq_free(irq_handle);
+		err = -EFAULT;
+	}
+	
+out_irq_request:
+	
+	if(err < 0)
+		xnfree(irq_handle);
+
+	return err;
+}
+
+static int sys_rtdm_irq_free(struct pt_regs *regs)
+{
+	rtdm_irq_ph_t ph;
+	rtdm_irq_t *irq_handle;
+	int err = 0;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_irq_ph_t)) < 0)
+		return -EFAULT;
+
+	irq_handle = xnregistry_fetch(ph.opaque);
+
+	if(irq_handle == NULL)
+		return -ESRCH;
+
+	rtdm_irq_free(irq_handle);
+
+	xnfree(irq_handle);
+
+	return err;
+}
+
+static int sys_rtdm_irq_wait(struct pt_regs *regs)
+{
+	xnthread_t *thread = xnpod_current_thread();
+	union xnsched_policy_param param;
+	rtdm_irq_ph_t ph;
+	rtdm_irq_t *irq_handle;
+	int err = 0;
+	spl_t s;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_irq_ph_t)) < 0)
+		return -EFAULT;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	irq_handle = xnregistry_fetch(ph.opaque);
+
+	if(irq_handle == NULL) {
+		err = -ESRCH;
+		goto unlock_and_exit;
+	}
+
+	if(irq_handle->pending == 0) {
+		if (xnthread_base_priority(thread) != XNSCHED_IRQ_PRIO) {
+			/* Boost the waiter above all regular tasks if needed. */
+			param.rt.prio = XNSCHED_IRQ_PRIO;
+			xnpod_set_thread_schedparam(thread, &xnsched_class_rt, &param);
+		}
+
+		xnsynch_sleep_on(&irq_handle->synch_base, XN_INFINITE, XN_RELATIVE);
+
+		if (xnthread_test_info(thread, XNRMID))
+			err = -EIDRM;	/* IRQ deleted while pending. */
+		else if (xnthread_test_info(thread, XNBREAK))
+			err = -EINTR;	/* Unblocked. */
+		else
+			err = irq_handle->pending;
+	} else
+		err = irq_handle->pending;
+	
+	irq_handle->pending = 0;
+
+unlock_and_exit:
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
+static int sys_rtdm_irq_save(struct pt_regs *regs)
+{
+	rtdm_lockctx_t context;
+
+	context = (rtdm_lockctx_t) test_and_set_bit(PROC_MASK_IRQ, 
+						    &rtdm_get_process()->status);
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), 
+				  &context, sizeof(rtdm_lockctx_t)) < 0) {
+		return -EFAULT;
+	}
+	
+	return 0;
+}
+
+static int sys_rtdm_irq_restore(struct pt_regs *regs)
+{
+	spl_t s;
+	xnholder_t *holder, *nholder;
+	rtdm_irq_t *obj_irq;
+	rtdm_timer_t *obj_timer;
+	rtdm_lockctx_t context;
+
+	if(__xn_safe_copy_to_user(&context, 
+				  (void __user *)__xn_reg_arg1(regs), 
+				  sizeof(rtdm_lockctx_t)) < 0) {
+		return -EFAULT;
+	}	
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if(context == 0)
+		clear_bit(PROC_MASK_IRQ, &rtdm_get_process()->status);
+
+	nholder = getheadq(&rtdm_get_process()->irq_handleq);
+	while ((holder = nholder) != NULL) {
+		obj_irq = rlink2irq(holder);
+		if(obj_irq->pending)
+			xnsynch_flush(&obj_irq->synch_base, 0);
+		nholder = nextq((&rtdm_get_process()->irq_handleq), holder);
+	}
+
+	nholder = getheadq(&rtdm_get_process()->timerq);
+	while ((holder = nholder) != NULL) {
+		obj_timer = rlink2timer(holder);
+		if(obj_timer->pending)
+			xnsynch_flush(&obj_timer->synch_base, 0);
+		nholder = nextq((&rtdm_get_process()->timerq), holder);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return 0;
+}
+
+void __user_nrtsig_handler(unsigned int virq, void *arg)
+{
+	rtdm_nrtsig_t *nrt_sig = (rtdm_nrtsig_t *)arg;
+
+	atomic_inc(&nrt_sig->pending);
+
+	/* Wake up the NRT user-side sleepers */ 
+	wake_up_interruptible(&nrt_sig->nrt_synch);
+}
+
+static int sys_rtdm_nrtsig_init(struct pt_regs *regs)
+{
+	int err;
+	rtdm_nrtsig_ph_t ph;
+	rtdm_nrtsig_t *nrt_sig;
+	
+	nrt_sig = xnmalloc(sizeof(rtdm_nrtsig_t));
+	if(nrt_sig == NULL)
+		return -ENOMEM;	
+
+	err = rtdm_nrtsig_init(nrt_sig, 
+			       __user_nrtsig_handler, nrt_sig);
+	if(err < 0) {
+		goto out_nrtsig_init;
+	}
+
+	ph.opaque = nrt_sig->handle;
+	ph.virq = nrt_sig->virq;
+	
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs), 
+				  &ph, sizeof(rtdm_nrtsig_ph_t)) < 0) {
+		rtdm_nrtsig_destroy(nrt_sig);
+		err = -EFAULT;
+	}
+	
+out_nrtsig_init:
+	
+	if(err < 0)
+		xnfree(nrt_sig);
+
+	return err;
+}
+
+static int sys_rtdm_nrtsig_destroy(struct pt_regs *regs)
+{
+	rtdm_nrtsig_ph_t ph;
+	rtdm_nrtsig_t *nrt_sig;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_nrtsig_ph_t)) < 0)
+		return -EFAULT;
+
+	nrt_sig = xnregistry_fetch(ph.opaque);
+
+	if(nrt_sig == NULL)
+		return -ESRCH;
+
+	rtdm_nrtsig_destroy(nrt_sig);
+
+	xnfree(nrt_sig);
+
+	return 0;
+}
+
+static int sys_rtdm_nrtsig_pend(struct pt_regs *regs)
+{
+	rtdm_nrtsig_ph_t ph;
+	rtdm_nrtsig_t *nrt_sig;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_nrtsig_ph_t)) < 0)
+		return -EFAULT;
+
+	nrt_sig = xnregistry_fetch(ph.opaque);
+
+	if(nrt_sig == NULL)
+		return -ESRCH;
+	
+	rtdm_nrtsig_pend(nrt_sig);
+
+	return 0;
+}
+
+static int sys_rtdm_nrtsig_wait(struct pt_regs *regs)
+{
+	int err;
+	rtdm_nrtsig_ph_t ph;
+	rtdm_nrtsig_t *nrt_sig;
+
+	if(__xn_safe_copy_from_user(&ph, 
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_nrtsig_ph_t)) < 0)
+		return -EFAULT;
+
+	nrt_sig = xnregistry_fetch(ph.opaque);
+
+	if(nrt_sig == NULL)
+		return -ESRCH;
+
+	err = wait_event_interruptible(nrt_sig->nrt_synch, 
+				       atomic_read(&nrt_sig->pending) != 0);
+	if(err == 0)
+		atomic_dec(&nrt_sig->pending);
+
+	return err;
+}
+
+static int sys_rtdm_heap_init(struct pt_regs *regs)
+{
+	int err;
+	rtdm_heap_ph_t ph;
+	rtdm_heap_t *heap;
+
+	heap = xnmalloc(sizeof(rtdm_heap_t));
+	if(heap == NULL)
+		return -ENOMEM;
+
+	err = rtdm_heap_init(heap, 
+			     (unsigned long) __xn_reg_arg2(regs), 
+			     (unsigned long) __xn_reg_arg3(regs));
+	if(err < 0)
+		goto out_heap_init;
+
+	ph.opaque = heap->handle;
+	ph.opaque2 = &heap->heap_base;
+	ph.mapsize = xnheap_extentsize(&heap->heap_base);
+	if(heap->mode & RTDM_PG_DMA)
+		ph.phybase = 
+			(caddr_t) virt_to_phys(heap->heap_base.archdep.heapbase);
+
+	if(__xn_safe_copy_to_user((void __user *)__xn_reg_arg1(regs),
+				  &ph, sizeof(rtdm_heap_ph_t)) < 0) {
+		rtdm_heap_destroy(heap);
+		err = -EFAULT;
+	}
+
+out_heap_init:
+	if(err < 0)
+		xnfree(heap);
+
+	return err;
+}
+
+static int sys_rtdm_heap_destroy(struct pt_regs *regs)
+{	
+	rtdm_heap_ph_t ph;       
+	rtdm_heap_t *heap;
+	int err;
+
+	if(__xn_safe_copy_from_user(&ph,
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_heap_ph_t)) < 0)
+		return -EFAULT;
+
+	heap = xnregistry_fetch(ph.opaque);
+
+	if(heap == NULL)
+		return -ESRCH;
+
+	err = rtdm_heap_destroy_inner(heap, (void __user *)ph.mapbase);
+	if(err < 0)
+		return err;
+
+	xnfree(heap);
+	
+	return err;
+}
+
+static int sys_rtdm_heap_malloc(struct pt_regs *regs)
+{
+	rtdm_heap_ph_t ph;
+	rtdm_heap_t *heap;
+	void *block;
+
+	if(__xn_safe_copy_from_user(&ph,
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_heap_ph_t)) < 0)
+		return -EFAULT;
+
+	heap = xnregistry_fetch(ph.opaque);
+
+	if(heap == NULL)
+		return -ESRCH;
+
+	block = rtdm_heap_malloc(heap, (size_t) __xn_reg_arg2(regs));
+	
+	if(block != NULL) {
+		block = ph.mapbase + xnheap_mapped_offset(&heap->heap_base, block);
+	} else
+		return -ENOMEM;
+
+	if(__xn_safe_copy_to_user((void __user *) __xn_reg_arg3(regs),
+			     &block, sizeof(void *)) < 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sys_rtdm_heap_free(struct pt_regs *regs)
+{
+	rtdm_heap_ph_t ph;
+	rtdm_heap_t *heap;
+	void *block = (void *)__xn_reg_arg2(regs);
+
+	if(__xn_safe_copy_from_user(&ph,
+				    (void __user *)__xn_reg_arg1(regs),
+				    sizeof(rtdm_heap_ph_t)) < 0)
+		return -EFAULT;
+
+	heap = xnregistry_fetch(ph.opaque);
+
+	if(heap == NULL)
+		return -ESRCH;
+
+	block = xnheap_mapped_address(&heap->heap_base,
+				      (caddr_t) block - ph.mapbase);
+
+	rtdm_heap_free(heap, block);
+
+	return 0;
+}
+
 static void *rtdm_skin_callback(int event, void *data)
 {
 	struct rtdm_process *process;
@@ -131,12 +1483,30 @@
 		process->pid = current->pid;
 #endif /* CONFIG_PROC_FS */
 
+		process->status = 0;
+
+		initq(&process->timerq);
+		initq(&process->eventq);
+		initq(&process->semq);
+		initq(&process->mutexq);
+		initq(&process->irq_handleq);
+		initq(&process->nrt_sigq);
+		initq(&process->heapq);
+
 		return &process->ppd;
 
 	case XNSHADOW_CLIENT_DETACH:
 		process = container_of((xnshadow_ppd_t *) data,
 				       struct rtdm_process, ppd);
 
+		__rtdm_timer_flush_rq(&process->timerq);
+		__rtdm_event_flush_rq(&process->eventq);
+		__rtdm_sem_flush_rq(&process->semq);
+		__rtdm_mutex_flush_rq(&process->mutexq);
+		__rtdm_irq_flush_rq(&process->irq_handleq);
+		__rtdm_nrtsig_flush_rq(&process->nrt_sigq);
+		__rtdm_heap_flush_rq(&process->heapq);
+
 		cleanup_owned_contexts(process);
 
 		xnarch_free_host_mem(process, sizeof(*process));
@@ -162,6 +1532,62 @@
 	    {sys_rtdm_recvmsg, __xn_exec_current | __xn_exec_adaptive},
 	[__rtdm_sendmsg] =
 	    {sys_rtdm_sendmsg, __xn_exec_current | __xn_exec_adaptive},
+	[__rtdm_clock_read] = {sys_rtdm_clock_read, __xn_exec_any},
+	[__rtdm_clock_read_monotonic] = 
+	    {sys_rtdm_clock_read_monotonic, __xn_exec_any},
+	[__rtdm_task_init] = {sys_rtdm_task_init, __xn_exec_init},
+	[__rtdm_task_start] = {sys_rtdm_task_start, __xn_exec_any},
+	[__rtdm_task_destroy] = {sys_rtdm_task_destroy, __xn_exec_conforming},
+	[__rtdm_task_set_priority] = 
+	    {sys_rtdm_task_set_priority, __xn_exec_any},
+	[__rtdm_task_set_period] = {sys_rtdm_task_set_period, __xn_exec_any},
+	[__rtdm_task_wait_period] = 
+	    {sys_rtdm_task_wait_period, __xn_exec_primary},
+	[__rtdm_task_unblock] = {sys_rtdm_task_unblock, __xn_exec_any},
+	[__rtdm_task_current] = {sys_rtdm_task_current, __xn_exec_primary},
+	[__rtdm_task_sleep] = {sys_rtdm_task_sleep, __xn_exec_primary},
+	[__rtdm_task_sleep_abs] = {sys_rtdm_task_sleep_abs, __xn_exec_primary},
+	[__rtdm_task_join_nrt] = {sys_rtdm_task_join_nrt, __xn_exec_lostage},
+	[__rtdm_task_busy_sleep] = {sys_rtdm_task_busy_sleep, __xn_exec_any},
+	[__rtdm_timer_init] = {sys_rtdm_timer_init, __xn_exec_any},
+	[__rtdm_timer_destroy] = {sys_rtdm_timer_destroy, __xn_exec_any},
+	[__rtdm_timer_start] = {sys_rtdm_timer_start, __xn_exec_any},
+	[__rtdm_timer_stop] = {sys_rtdm_timer_stop, __xn_exec_any},
+	[__rtdm_timer_wait] = {sys_rtdm_timer_wait, __xn_exec_primary},
+	[__rtdm_toseq_init] = {sys_rtdm_toseq_init, __xn_exec_any},
+	[__rtdm_event_init] = {sys_rtdm_event_init, __xn_exec_any},
+	[__rtdm_event_destroy] = {sys_rtdm_event_destroy, __xn_exec_any},
+	[__rtdm_event_pulse] = {sys_rtdm_event_pulse, __xn_exec_primary},
+	[__rtdm_event_signal] = {sys_rtdm_event_signal, __xn_exec_any},
+	[__rtdm_event_wait] = {sys_rtdm_event_wait, __xn_exec_primary},
+	[__rtdm_event_timedwait] = 
+	    {sys_rtdm_event_timedwait, __xn_exec_primary},
+	[__rtdm_event_clear] = {sys_rtdm_event_clear, __xn_exec_primary},	
+	[__rtdm_sem_init] = {sys_rtdm_sem_init, __xn_exec_any},
+	[__rtdm_sem_destroy] = {sys_rtdm_sem_destroy, __xn_exec_any},
+	[__rtdm_sem_down] = {sys_rtdm_sem_down, __xn_exec_primary},
+	[__rtdm_sem_timeddown] = {sys_rtdm_sem_timeddown, __xn_exec_primary},
+	[__rtdm_sem_up] = {sys_rtdm_sem_up, __xn_exec_any},
+	[__rtdm_mutex_init] = {sys_rtdm_mutex_init, __xn_exec_any},
+	[__rtdm_mutex_destroy] = {sys_rtdm_mutex_destroy, __xn_exec_any},
+	[__rtdm_mutex_unlock] = {sys_rtdm_mutex_unlock, __xn_exec_primary},
+	[__rtdm_mutex_lock] = {sys_rtdm_mutex_lock, __xn_exec_primary},
+	[__rtdm_mutex_timedlock] = 
+	    {sys_rtdm_mutex_timedlock, __xn_exec_primary},
+	[__rtdm_irq_request] = {sys_rtdm_irq_request, __xn_exec_any},
+	[__rtdm_irq_free] = {sys_rtdm_irq_free, __xn_exec_any},
+	[__rtdm_irq_wait] = {sys_rtdm_irq_wait, __xn_exec_any},
+	[__rtdm_irq_save] = {sys_rtdm_irq_save, __xn_exec_any},
+	[__rtdm_irq_restore] = {sys_rtdm_irq_restore, __xn_exec_any},
+	[__rtdm_nrtsig_init] = {sys_rtdm_nrtsig_init, __xn_exec_init},
+	[__rtdm_nrtsig_destroy] = {sys_rtdm_nrtsig_destroy, __xn_exec_any},
+	[__rtdm_nrtsig_pend] = {sys_rtdm_nrtsig_pend, __xn_exec_primary},
+	[__rtdm_nrtsig_wait] = {sys_rtdm_nrtsig_wait, __xn_exec_lostage},
+	[__rtdm_heap_init] = {sys_rtdm_heap_init, __xn_exec_init},
+	[__rtdm_heap_destroy] = {sys_rtdm_heap_destroy, __xn_exec_lostage},
+	[__rtdm_heap_malloc] = {sys_rtdm_heap_malloc, __xn_exec_conforming},
+	[__rtdm_heap_free] = {sys_rtdm_heap_free, __xn_exec_any},	
+	
 };
 
 static struct xnskin_props __props = {
@@ -170,7 +1596,7 @@
 	.nrcalls = sizeof(__systab) / sizeof(__systab[0]),
 	.systab = __systab,
 	.eventcb = &rtdm_skin_callback,
-	.timebasep = NULL,
+	.timebasep = &rtdm_tbase,
 	.module = THIS_MODULE
 };
 

--Boundary-00=_kqrWJhbrlOTCTAF--



From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XZdRoUSlaT"
Content-Transfer-Encoding: 7bit
Message-ID: <18330.24475.393726.783857@domain.hid>
Date: Fri, 25 Jan 2008 23:15:55 +0100
In-Reply-To: <18330.24340.328727.760936@domain.hid>
References: <18330.24340.328727.760936@domain.hid>
Subject: [Xenomai-core] [PATCH 2/4] modification of rtdm events and
	semaphores
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--XZdRoUSlaT
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


This patch is IMO the most questionable of the whole set. It creates two
new RTDM objects, the selectable events and selectable semaphores, that
may be used for RTDM file descriptors to support select. It also adds
two services rtdm_select_event_bind, and rtdm_select_sem_bind, which
will allow to bind these objects with a struct xnselector.

What make it questionable is that it does this without adding new
services for the two new types, but rather uses the
__builtin_compatible_p() trick to allow using rtdm_event_* and
rtdm_sem_* services with the two new types.

The patch also adds a new method to the RTDM device ops, which will be
called (for instance by the posix skin), in order to bind an RTDM device
with a struct xnselector.

---
 include/rtdm/rtdm.h        |    4
 include/rtdm/rtdm_driver.h |  148 +++++++++++++-
 ksrc/skins/rtdm/core.c     |   26 ++
 ksrc/skins/rtdm/device.c   |   10 +
 ksrc/skins/rtdm/drvlib.c   |  446 ++++++++++++++++++++++++++++++++++-----------
 5 files changed, 512 insertions(+), 122 deletions(-)


--XZdRoUSlaT
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-select-rtdm.diff"
Content-Transfer-Encoding: 7bit

--- include/rtdm/rtdm_driver.h	(revision 3441)
+++ include/rtdm/rtdm_driver.h	(working copy)
@@ -38,6 +38,7 @@
 #include <nucleus/heap.h>
 #include <nucleus/pod.h>
 #include <nucleus/synch.h>
+#include <nucleus/select.h>
 #include <rtdm/rtdm.h>
 
 /* debug support */
@@ -262,6 +263,11 @@ typedef ssize_t (*rtdm_sendmsg_handler_t
 typedef int (*rtdm_rt_handler_t)(struct rtdm_dev_context *context,
 				 rtdm_user_info_t *user_info, void *arg);
 
+typedef int (*rtdm_select_bind_handler_t)(struct rtdm_dev_context *context,
+					  struct xnselector *selector,
+					  unsigned type,
+					  unsigned index);
+
 /**
  * Device operations
  */
@@ -304,6 +310,8 @@ struct rtdm_operations {
 	/** Transmit message handler for non-real-time context (optional) */
 	rtdm_sendmsg_handler_t sendmsg_nrt;
 	/** @} Message-Oriented Device Operations */
+
+	rtdm_select_bind_handler_t select_bind;
 };
 
 struct rtdm_devctx_reserved {
@@ -1004,30 +1012,92 @@ typedef struct {
 	xnsynch_t synch_base;
 } rtdm_event_t;
 
-#define RTDM_EVENT_PENDING		XNSYNCH_SPARE1
+typedef struct {
+	rtdm_event_t event;
+	struct xnselect select_block;
+} rtdm_select_event_t;
 
-void rtdm_event_init(rtdm_event_t *event, unsigned long pending);
-int rtdm_event_wait(rtdm_event_t *event);
-int rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
-			 rtdm_toseq_t *timeout_seq);
-void rtdm_event_signal(rtdm_event_t *event);
+#define RTDM_EVENT_PENDING		XNSYNCH_SPARE1
 
-void rtdm_event_clear(rtdm_event_t *event);
+#ifndef TYPE_EQUAL
+#define TYPE_EQUAL(object, type) \
+    __builtin_types_compatible_p(typeof(object), type *)
+#endif /* !TYPE_EQUAL */
+
+#define PICK_VOIDEVENTOP(op, object, args...)				\
+    do {								\
+	if (TYPE_EQUAL((object), rtdm_event_t))				\
+	    _rtdm_event_##op((rtdm_event_t *)(object), ##args);		\
+	else if (TYPE_EQUAL((object), rtdm_select_event_t))		\
+	    _rtdm_select_event_##op((rtdm_select_event_t *)(object), ##args); \
+    } while (0)
+
+#define PICK_INTEVENTOP(op, object, args...)				\
+    ({									\
+	int err = -ENOSYS;						\
+	if (TYPE_EQUAL((object), rtdm_event_t))				\
+	    err = _rtdm_event_##op((rtdm_event_t *)(object), ##args);	\
+	else if (TYPE_EQUAL((object), rtdm_select_event_t))		\
+	    err = _rtdm_select_event_##op((rtdm_select_event_t *)(object), ##args); \
+	err;								\
+    })
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
+void _rtdm_event_init(rtdm_event_t *event, unsigned long pending);
+void _rtdm_select_event_init(rtdm_select_event_t *event, unsigned long pending);
+#define rtdm_event_init(event, pending) PICK_VOIDEVENTOP(init, event, pending)
+
+int rtdm_select_event_bind(rtdm_select_event_t *event,
+			   struct xnselector *selector,
+			   unsigned type,
+			   unsigned bit_index);
+
+int _rtdm_event_wait(rtdm_event_t *event);
+int _rtdm_select_event_wait(rtdm_select_event_t *event);
+#define rtdm_event_wait(event) PICK_INTEVENTOP(wait, event)
+
+int _rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
+			  rtdm_toseq_t *timeout_seq);
+int _rtdm_select_event_timedwait(rtdm_select_event_t *event,
+				 nanosecs_rel_t timeout,
+				 rtdm_toseq_t *timeout_seq);
+#define rtdm_event_timedwait(event, timeout, timeout_seq) \
+	PICK_INTEVENTOP(timedwait, event, timeout, timeout_seq)
+
+void _rtdm_event_signal(rtdm_event_t *event);
+void _rtdm_select_event_signal(rtdm_select_event_t *event);
+#define rtdm_event_signal(event) PICK_VOIDEVENTOP(signal, event)
+
+void _rtdm_event_clear(rtdm_event_t *event);
+void _rtdm_select_event_clear(rtdm_select_event_t *event);
+#define rtdm_event_clear(event) PICK_VOIDEVENTOP(clear, event)
+
 void __rtdm_synch_flush(xnsynch_t *synch, unsigned long reason);
 
-static inline void rtdm_event_pulse(rtdm_event_t *event)
+static inline void _rtdm_event_pulse(rtdm_event_t *event)
 {
 	trace_mark(xn_rtdm_event_pulse, "event %p", event);
 	__rtdm_synch_flush(&event->synch_base, 0);
 }
 
-static inline void rtdm_event_destroy(rtdm_event_t *event)
+static inline void _rtdm_select_event_pulse(rtdm_select_event_t *event)
+{
+	_rtdm_event_pulse(&event->event);
+}
+#define rtdm_event_pulse(event) PICK_VOIDEVENTOP(pulse, event)
+
+static inline void _rtdm_event_destroy(rtdm_event_t *event)
 {
 	trace_mark(xn_rtdm_event_destroy, "event %p", event);
 	__rtdm_synch_flush(&event->synch_base, XNRMID);
 }
+
+static inline void _rtdm_select_event_destroy(rtdm_select_event_t *event)
+{
+	xnselect_destroy(&event->select_block);
+	_rtdm_event_destroy(&event->event);
+}
+#define rtdm_event_destroy(event) PICK_VOIDEVENTOP(destroy, event);
 #endif /* !DOXYGEN_CPP */
 
 /* --- semaphore services --- */
@@ -1037,18 +1107,66 @@ typedef struct {
 	xnsynch_t synch_base;
 } rtdm_sem_t;
 
-void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value);
-int rtdm_sem_down(rtdm_sem_t *sem);
-int rtdm_sem_timeddown(rtdm_sem_t *sem, nanosecs_rel_t timeout,
-		       rtdm_toseq_t *timeout_seq);
-void rtdm_sem_up(rtdm_sem_t *sem);
+typedef struct {
+	rtdm_sem_t sem;
+	struct xnselect select_block;
+} rtdm_select_sem_t;
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
-static inline void rtdm_sem_destroy(rtdm_sem_t *sem)
+#define PICK_VOIDSEMOP(op, object, args...)				\
+    do {								\
+	if (TYPE_EQUAL((object), rtdm_sem_t))				\
+	    _rtdm_sem_##op((rtdm_sem_t *)(object), ##args);		\
+	else if (TYPE_EQUAL((object), rtdm_select_sem_t))		\
+	    _rtdm_select_sem_##op((rtdm_select_sem_t *)(object), ##args); \
+    } while (0)
+
+#define PICK_INTSEMOP(op, object, args...)				\
+    ({									\
+	int err = -ENOSYS;						\
+	if (TYPE_EQUAL((object), rtdm_sem_t))				\
+	    err = _rtdm_sem_##op((rtdm_sem_t *)(object), ##args);	\
+	else if (TYPE_EQUAL((object), rtdm_select_sem_t))		\
+	    err = _rtdm_select_sem_##op((rtdm_select_sem_t *)(object), ##args);	\
+	err;								\
+    })
+
+void _rtdm_sem_init(rtdm_sem_t *sem, unsigned long value);
+void _rtdm_select_sem_init(rtdm_select_sem_t *sem, unsigned long value);
+#define rtdm_sem_init(sem, value) PICK_VOIDSEMOP(init, sem, value)
+
+int rtdm_select_sem_bind(rtdm_select_sem_t *sem,
+			 struct xnselector *selector,
+			 unsigned type,
+			 unsigned bit_index);
+
+int _rtdm_sem_down(rtdm_sem_t *sem);
+int _rtdm_select_sem_down(rtdm_select_sem_t *sem);
+#define rtdm_sem_down(sem) PICK_INTSEMOP(down, sem)
+
+int _rtdm_sem_timeddown(rtdm_sem_t *sem, nanosecs_rel_t timeout,
+		       rtdm_toseq_t *timeout_seq);
+int _rtdm_select_sem_timeddown(rtdm_select_sem_t *sem, nanosecs_rel_t timeout,
+			       rtdm_toseq_t *timeout_seq);
+#define rtdm_sem_timeddown(sem, timeout, timeout_seq) \
+	PICK_INTSEMOP(timeddown, sem, timeout, timeout_seq)
+
+void _rtdm_sem_up(rtdm_sem_t *sem);
+void _rtdm_select_sem_up(rtdm_select_sem_t *sem);
+#define rtdm_sem_up(sem) PICK_VOIDSEMOP(up, sem)
+
+static inline void _rtdm_sem_destroy(rtdm_sem_t *sem)
 {
 	trace_mark(xn_rtdm_sem_destroy, "sem %p", sem);
 	__rtdm_synch_flush(&sem->synch_base, XNRMID);
 }
+
+static inline void _rtdm_select_sem_destroy(rtdm_select_sem_t *sem)
+{
+	xnselect_destroy(&sem->select_block);
+	_rtdm_sem_destroy(&sem->sem);
+}
+#define rtdm_sem_destroy(sem) PICK_VOIDSEMOP(destroy, sem)
 #endif /* !DOXYGEN_CPP */
 
 /* --- mutex services --- */
--- include/rtdm/rtdm.h	(revision 3441)
+++ include/rtdm/rtdm.h	(working copy)
@@ -247,6 +247,10 @@ ssize_t __rt_dev_recvmsg(rtdm_user_info_
 			 struct msghdr *msg, int flags);
 ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info, int fd,
 			 const struct msghdr *msg, int flags);
+struct xnselector;
+int __rt_dev_select_bind(int fd,
+			 struct xnselector *selector,
+			 unsigned type, unsigned index);
 #endif /* __KERNEL__ */
 
 /* Define RTDM_NO_DEFAULT_USER_API to switch off the default rt_dev_xxx
--- ksrc/skins/rtdm/device.c	(revision 3441)
+++ ksrc/skins/rtdm/device.c	(working copy)
@@ -70,6 +70,14 @@ int rtdm_no_support(void)
 	return -ENOSYS;
 }
 
+int rtdm_select_bind_no_support(struct rtdm_dev_context *context,
+				struct xnselector *selector,
+				unsigned type,
+				unsigned index)
+{
+	return -EBADF;
+}
+  
 static inline int get_name_hash(const char *str, int limit, int hashkey_mask)
 {
 	int hash = 0;
@@ -242,6 +250,8 @@ int rtdm_dev_register(struct rtdm_device
 	SET_DEFAULT_OP_IF_NULL(device->ops, write);
 	SET_DEFAULT_OP_IF_NULL(device->ops, recvmsg);
 	SET_DEFAULT_OP_IF_NULL(device->ops, sendmsg);
+	if (!device->ops.select_bind)
+		device->ops.select_bind = rtdm_select_bind_no_support;
 
 	atomic_set(&device->reserved.refcount, 0);
 	device->reserved.exclusive_context = NULL;
--- ksrc/skins/rtdm/drvlib.c	(revision 3441)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -728,23 +728,7 @@ EXPORT_SYMBOL(rtdm_toseq_init);
  * @{
  */
 
-/**
- * @brief Initialise an event
- *
- * @param[in,out] event Event handle
- * @param[in] pending Non-zero if event shall be initialised as set, 0 otherwise
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Kernel module initialization/cleanup code
- * - Kernel-based task
- * - User-space task (RT, non-RT)
- *
- * Rescheduling: never.
- */
-void rtdm_event_init(rtdm_event_t *event, unsigned long pending)
+void _rtdm_event_init(rtdm_event_t *event, unsigned long pending)
 {
 	spl_t s;
 
@@ -760,10 +744,36 @@ void rtdm_event_init(rtdm_event_t *event
 	xnlock_put_irqrestore(&nklock, s);
 }
 
-EXPORT_SYMBOL(rtdm_event_init);
+EXPORT_SYMBOL(_rtdm_event_init);
+
+void _rtdm_select_event_init(rtdm_select_event_t *event, unsigned long pending)
+{
+	_rtdm_event_init(&event->event, pending);
+	xnselect_init(&event->select_block);
+}
+
+EXPORT_SYMBOL(_rtdm_select_event_init);
 
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
+ * @brief Initialise an event
+ *
+ * @param[in,out] event Event handle
+ * @param[in] pending Non-zero if event shall be initialised as set, 0 otherwise
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Kernel-based task
+ * - User-space task (RT, non-RT)
+ *
+ * Rescheduling: never.
+ */
+void rtdm_event_init(rtdm_event_t *event, unsigned long pending);
+
+/**
  * @brief Destroy an event
  *
  * @param[in,out] event Event handle as returned by rtdm_event_init()
@@ -801,7 +811,6 @@ void rtdm_event_destroy(rtdm_event_t *ev
  * Rescheduling: possible.
  */
 void rtdm_event_pulse(rtdm_event_t *event);
-#endif /* DOXYGEN_CPP */
 
 /**
  * @brief Signal an event occurrence
@@ -823,22 +832,7 @@ void rtdm_event_pulse(rtdm_event_t *even
  *
  * Rescheduling: possible.
  */
-void rtdm_event_signal(rtdm_event_t *event)
-{
-	spl_t s;
-
-	trace_mark(xn_rtdm_event_signal, "event %p", event);
-
-	xnlock_get_irqsave(&nklock, s);
-
-	xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
-	if (xnsynch_flush(&event->synch_base, 0))
-		xnpod_schedule();
-
-	xnlock_put_irqrestore(&nklock, s);
-}
-
-EXPORT_SYMBOL(rtdm_event_signal);
+void rtdm_event_signal(rtdm_event_t *event);
 
 /**
  * @brief Wait on event occurrence
@@ -867,12 +861,7 @@ EXPORT_SYMBOL(rtdm_event_signal);
  *
  * Rescheduling: possible.
  */
-int rtdm_event_wait(rtdm_event_t *event)
-{
-	return rtdm_event_timedwait(event, 0, NULL);
-}
-
-EXPORT_SYMBOL(rtdm_event_wait);
+int rtdm_event_wait(rtdm_event_t *event);
 
 /**
  * @brief Wait on event occurrence with timeout
@@ -910,6 +899,81 @@ EXPORT_SYMBOL(rtdm_event_wait);
  * Rescheduling: possible.
  */
 int rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
+			 rtdm_toseq_t *timeout_seq);
+
+/**
+ * @brief Clear event state
+ *
+ * @param[in,out] event Event handle as returned by rtdm_event_init()
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Interrupt service routine
+ * - Kernel-based task
+ * - User-space task (RT, non-RT)
+ *
+ * Rescheduling: never.
+ */
+void rtdm_event_clear(rtdm_event_t *event);
+#endif /* DOXYGEN_CPP */
+void _rtdm_event_signal(rtdm_event_t *event)
+{
+	spl_t s;
+
+	trace_mark(xn_rtdm_event_signal, "event %p", event);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
+	if (xnsynch_flush(&event->synch_base, 0))
+		xnpod_schedule();
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(_rtdm_event_signal);
+
+void _rtdm_select_event_signal(rtdm_select_event_t *select_event)
+{
+	rtdm_event_t *event = &select_event->event;
+	int resched = 0;
+	spl_t s;
+
+	trace_mark(xn_rtdm_event_signal, "event %p", event);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
+	if (xnsynch_flush(&event->synch_base, 0))
+		resched = 1;
+	if (xnselect_signal(&select_event->select_block, 1))
+		resched = 1;
+	if (resched)
+		xnpod_schedule();
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(_rtdm_select_event_signal);
+
+int _rtdm_event_wait(rtdm_event_t *event)
+{
+	return _rtdm_event_timedwait(event, 0, NULL);
+}
+
+EXPORT_SYMBOL(_rtdm_event_wait);
+
+int _rtdm_select_event_wait(rtdm_select_event_t *event)
+{
+	return _rtdm_select_event_timedwait(event, 0, NULL);
+}
+
+EXPORT_SYMBOL(_rtdm_select_event_wait);
+
+int _rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
 			 rtdm_toseq_t *timeout_seq)
 {
 	xnthread_t *thread;
@@ -968,25 +1032,74 @@ unlock_out:
 	return err;
 }
 
-EXPORT_SYMBOL(rtdm_event_timedwait);
+EXPORT_SYMBOL(_rtdm_event_timedwait);
 
-/**
- * @brief Clear event state
- *
- * @param[in,out] event Event handle as returned by rtdm_event_init()
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Kernel module initialization/cleanup code
- * - Interrupt service routine
- * - Kernel-based task
- * - User-space task (RT, non-RT)
- *
- * Rescheduling: never.
- */
-void rtdm_event_clear(rtdm_event_t *event)
+int _rtdm_select_event_timedwait(rtdm_select_event_t *select_event,
+				 nanosecs_rel_t timeout,
+				 rtdm_toseq_t *timeout_seq)
+{
+	rtdm_event_t *event = &select_event->event;
+	xnthread_t *thread;
+	spl_t s;
+	int err = 0;
+
+	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
+	trace_mark(xn_rtdm_event_timedwait,
+		   "event %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
+		   event, timeout, timeout_seq, timeout_seq ? *timeout_seq : 0);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (unlikely(testbits(event->synch_base.status, RTDM_SYNCH_DELETED)))
+		err = -EIDRM;
+	else if (likely(xnsynch_test_flags(&event->synch_base,
+					   RTDM_EVENT_PENDING))) {
+		xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDING);
+		xnselect_signal(&select_event->select_block, 0);
+	} else {
+		/* non-blocking mode */
+		if (timeout < 0) {
+			err = -EWOULDBLOCK;
+			goto unlock_out;
+		}
+
+		thread = xnpod_current_thread();
+
+		if (timeout_seq && (timeout > 0)) {
+			/* timeout sequence */
+			xnsynch_sleep_on(&event->synch_base, *timeout_seq,
+					 XN_ABSOLUTE);
+		} else {
+			/* infinite or relative timeout */
+			xnsynch_sleep_on(&event->synch_base,
+					 xntbase_ns2ticks_ceil
+					 (xnthread_time_base(thread), timeout),
+					 XN_RELATIVE);
+		}
+
+		if (likely
+		    (!xnthread_test_info(thread, XNTIMEO | XNRMID | XNBREAK))) {
+			xnsynch_clear_flags(&event->synch_base,
+					    RTDM_EVENT_PENDING);
+			xnselect_signal(&select_event->select_block, 0);
+		} else if (xnthread_test_info(thread, XNTIMEO))
+			err = -ETIMEDOUT;
+		else if (xnthread_test_info(thread, XNRMID))
+			err = -EIDRM;
+		else /* XNBREAK */
+			err = -EINTR;
+	}
+
+unlock_out:
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
+EXPORT_SYMBOL(_rtdm_select_event_timedwait);
+
+void _rtdm_event_clear(rtdm_event_t *event)
 {
 	spl_t s;
 
@@ -999,7 +1112,23 @@ void rtdm_event_clear(rtdm_event_t *even
 	xnlock_put_irqrestore(&nklock, s);
 }
 
-EXPORT_SYMBOL(rtdm_event_clear);
+EXPORT_SYMBOL(_rtdm_event_clear);
+
+void _rtdm_select_event_clear(rtdm_select_event_t *event)
+{
+	spl_t s;
+
+	trace_mark(xn_rtdm_event_clear, "event %p", event);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	xnsynch_clear_flags(&event->event.synch_base, RTDM_EVENT_PENDING);
+	xnselect_signal(&event->select_block, 0);
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(_rtdm_select_event_clear);
 /** @} */
 
 /*!
@@ -1007,6 +1136,32 @@ EXPORT_SYMBOL(rtdm_event_clear);
  * @{
  */
 
+void _rtdm_sem_init(rtdm_sem_t *sem, unsigned long value)
+{
+	spl_t s;
+
+	trace_mark(xn_rtdm_sem_init, "sem %p value %lu", sem, value);
+
+	/* Make atomic for re-initialisation support */
+	xnlock_get_irqsave(&nklock, s);
+
+	sem->value = value;
+	xnsynch_init(&sem->synch_base, XNSYNCH_PRIO);
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(_rtdm_sem_init);
+
+void _rtdm_select_sem_init(rtdm_select_sem_t *sem, unsigned long value)
+{
+	_rtdm_sem_init(&sem->sem, value);
+	xnselect_init(&sem->select_block);
+}
+
+EXPORT_SYMBOL(_rtdm_select_sem_init);
+
+#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Initialise a semaphore
  *
@@ -1023,24 +1178,8 @@ EXPORT_SYMBOL(rtdm_event_clear);
  *
  * Rescheduling: never.
  */
-void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value)
-{
-	spl_t s;
+void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value);
 
-	trace_mark(xn_rtdm_sem_init, "sem %p value %lu", sem, value);
-
-	/* Make atomic for re-initialisation support */
-	xnlock_get_irqsave(&nklock, s);
-
-	sem->value = value;
-	xnsynch_init(&sem->synch_base, XNSYNCH_PRIO);
-
-	xnlock_put_irqrestore(&nklock, s);
-}
-
-EXPORT_SYMBOL(rtdm_sem_init);
-
-#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy a semaphore
  *
@@ -1057,7 +1196,6 @@ EXPORT_SYMBOL(rtdm_sem_init);
  * Rescheduling: possible.
  */
 void rtdm_sem_destroy(rtdm_sem_t *sem);
-#endif /* DOXYGEN_CPP */
 
 /**
  * @brief Decrement a semaphore
@@ -1086,12 +1224,7 @@ void rtdm_sem_destroy(rtdm_sem_t *sem);
  *
  * Rescheduling: possible.
  */
-int rtdm_sem_down(rtdm_sem_t *sem)
-{
-	return rtdm_sem_timeddown(sem, 0, NULL);
-}
-
-EXPORT_SYMBOL(rtdm_sem_down);
+int rtdm_sem_down(rtdm_sem_t *sem);
 
 /**
  * @brief Decrement a semaphore with timeout
@@ -1132,7 +1265,46 @@ EXPORT_SYMBOL(rtdm_sem_down);
  * Rescheduling: possible.
  */
 int rtdm_sem_timeddown(rtdm_sem_t *sem, nanosecs_rel_t timeout,
-		       rtdm_toseq_t *timeout_seq)
+		       rtdm_toseq_t *timeout_seq);
+
+/**
+ * @brief Increment a semaphore
+ *
+ * This function increments the given semphore's value, waking up a potential
+ * waiter which was blocked upon rtdm_sem_down().
+ *
+ * @param[in,out] sem Semaphore handle as returned by rtdm_sem_init()
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Interrupt service routine
+ * - Kernel-based task
+ * - User-space task (RT, non-RT)
+ *
+ * Rescheduling: possible.
+ */
+void rtdm_sem_up(rtdm_sem_t *sem);
+#endif /* DOXYGEN_CPP */
+
+int _rtdm_sem_down(rtdm_sem_t *sem)
+{
+	return _rtdm_sem_timeddown(sem, 0, NULL);
+}
+
+EXPORT_SYMBOL(_rtdm_sem_down);
+
+int _rtdm_select_sem_down(rtdm_select_sem_t *sem)
+{
+	return _rtdm_select_sem_timeddown(sem, 0, NULL);
+}
+
+EXPORT_SYMBOL(_rtdm_select_sem_down);
+
+int _rtdm_sem_timeddown(rtdm_sem_t *sem, nanosecs_rel_t timeout,
+			rtdm_toseq_t *timeout_seq)
 {
 	xnthread_t *thread;
 	spl_t s;
@@ -1182,28 +1354,67 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, 
 	return err;
 }
 
-EXPORT_SYMBOL(rtdm_sem_timeddown);
+EXPORT_SYMBOL(_rtdm_sem_timeddown);
 
-/**
- * @brief Increment a semaphore
- *
- * This function increments the given semphore's value, waking up a potential
- * waiter which was blocked upon rtdm_sem_down().
- *
- * @param[in,out] sem Semaphore handle as returned by rtdm_sem_init()
- *
- * Environments:
- *
- * This service can be called from:
- *
- * - Kernel module initialization/cleanup code
- * - Interrupt service routine
- * - Kernel-based task
- * - User-space task (RT, non-RT)
- *
- * Rescheduling: possible.
- */
-void rtdm_sem_up(rtdm_sem_t *sem)
+int _rtdm_select_sem_timeddown(rtdm_select_sem_t *select_sem,
+			       nanosecs_rel_t timeout,
+			       rtdm_toseq_t *timeout_seq)
+{
+	rtdm_sem_t *sem = &select_sem->sem;
+	xnthread_t *thread;
+	spl_t s;
+	int err = 0;
+
+	XENO_ASSERT(RTDM, !xnpod_unblockable_p(), return -EPERM;);
+
+	trace_mark(xn_rtdm_sem_timedwait,
+		   "sem %p timeout %Lu timeout_seq %p timeout_seq_value %Lu",
+		   sem, timeout, timeout_seq, timeout_seq ? *timeout_seq : 0);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
+		err = -EIDRM;
+	else if (sem->value > 0) {
+		sem->value--;
+		if (!sem->value)
+			xnselect_signal(&select_sem->select_block, 0);
+	} else if (timeout < 0) /* non-blocking mode */
+		err = -EWOULDBLOCK;
+	else {
+		thread = xnpod_current_thread();
+
+		if (timeout_seq && (timeout > 0)) {
+			/* timeout sequence */
+			xnsynch_sleep_on(&sem->synch_base, *timeout_seq,
+					 XN_ABSOLUTE);
+		} else {
+			/* infinite or relative timeout */
+			xnsynch_sleep_on(&sem->synch_base,
+					 xntbase_ns2ticks_ceil
+					 (xnthread_time_base(thread), timeout),
+					 XN_RELATIVE);
+		}
+
+		if (xnthread_test_info(thread, XNTIMEO | XNRMID | XNBREAK)) {
+			if (xnthread_test_info(thread, XNTIMEO))
+				err = -ETIMEDOUT;
+			else if (xnthread_test_info(thread, XNRMID))
+				err = -EIDRM;
+			else /* XNBREAK */
+				err = -EINTR;
+		} else if (!sem->value)
+			xnselect_signal(&select_sem->select_block, 0);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+
+EXPORT_SYMBOL(_rtdm_select_sem_timeddown);
+
+void _rtdm_sem_up(rtdm_sem_t *sem)
 {
 	spl_t s;
 
@@ -1219,7 +1430,28 @@ void rtdm_sem_up(rtdm_sem_t *sem)
 	xnlock_put_irqrestore(&nklock, s);
 }
 
-EXPORT_SYMBOL(rtdm_sem_up);
+EXPORT_SYMBOL(_rtdm_sem_up);
+
+void _rtdm_select_sem_up(rtdm_select_sem_t *select_sem)
+{
+	rtdm_sem_t *sem = &select_sem->sem;
+	spl_t s;
+
+	trace_mark(xn_rtdm_sem_up, "sem %p", sem);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (xnsynch_wakeup_one_sleeper(&sem->synch_base))
+		xnpod_schedule();
+	else
+		if (sem->value++ == 0
+		    && xnselect_signal(&select_sem->select_block, 1))
+			xnpod_schedule();
+
+	xnlock_put_irqrestore(&nklock, s);
+}
+
+EXPORT_SYMBOL(_rtdm_select_sem_up);
 /** @} */
 
 /*!
--- ksrc/skins/rtdm/core.c	(revision 3441)
+++ ksrc/skins/rtdm/core.c	(working copy)
@@ -294,6 +294,32 @@ err_out:
 
 EXPORT_SYMBOL(__rt_dev_socket);
 
+int __rt_dev_select_bind(int fd,
+			 struct xnselector *selector,
+			 unsigned type, unsigned index)
+{
+	struct rtdm_dev_context *context;
+	struct rtdm_operations  *ops;
+	int ret;
+
+	context = rtdm_context_get(fd);
+
+	ret = -EBADF;
+	if (unlikely(!context))
+		goto err_out;
+
+	ops = context->ops;
+
+	ret = ops->select_bind(context, selector, type, index);
+
+	XENO_ASSERT(RTDM, !rthal_local_irq_test(), rthal_local_irq_enable(););
+
+	rtdm_context_unlock(context);
+
+  err_out:
+	return ret;
+}
+
 int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
 {
 	struct rtdm_dev_context *context;

--XZdRoUSlaT
Content-Type: text/plain; charset=us-ascii
Content-Description: .signature
Content-Transfer-Encoding: 7bit


-- 


					    Gilles Chanteperdrix.
--XZdRoUSlaT--


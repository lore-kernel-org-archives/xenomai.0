MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18351.6734.895639.131993@domain.hid>
Date: Sun, 10 Feb 2008 16:37:50 +0100
In-Reply-To: <47AF057A.3070305@domain.hid>
References: <18350.7135.108901.491437@domain.hid>
	<18350.7315.555644.171720@domain.hid>
	<47AF057A.3070305@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > stats:
 > >  include/rtdm/rtdm.h        |    4 ++
 > >  include/rtdm/rtdm_driver.h |   30 +++++++++++++++-
 > >  ksrc/skins/rtdm/core.c     |   84 +++++++++++++++++++++++++++++++--------------
 > >  ksrc/skins/rtdm/device.c   |   10 +++++
 > >  ksrc/skins/rtdm/drvlib.c   |   76 ++++++++++++++++++++++++++++++++++++----
 > >  5 files changed, 170 insertions(+), 34 deletions(-)
 > > 
 > 
 > /me thinks that going for inline patches on this list is overdue...
 > 
 > > @@ -1148,8 +1208,8 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, 
 > >  
 > >  	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
 > >  		err = -EIDRM;
 > > -	else if (sem->value > 0)
 > > -		sem->value--;
 > > +	else if (sem->value > 0 && !--sem->value)
 > > +			xnselect_signal(&sem->select_block, 0);
 > >  	else if (timeout < 0) /* non-blocking mode */
 > >  		err = -EWOULDBLOCK;
 > >  	else {
 > 
 > Uuuh, this doesn't look equivalent (for --sem->value < 0).
 > 
 > Otherwise it's OK with me.

Here is a repost (inlined this time) of the select patch for rtdm, with
the discussed changes and a minor change in rtdm_sem_select_bind (since
I did not understand that sem->value could be negative).

If everybody is OK, I'll commit the whole thing.

stats:
 include/rtdm/rtdm.h        |    4 ++
 include/rtdm/rtdm_driver.h |   30 +++++++++++++++-
 ksrc/skins/rtdm/Kconfig    |    8 ++++
 ksrc/skins/rtdm/core.c     |   84 +++++++++++++++++++++++++++++++--------------
 ksrc/skins/rtdm/device.c   |   10 +++++
 ksrc/skins/rtdm/drvlib.c   |   79 ++++++++++++++++++++++++++++++++++++++----
 6 files changed, 180 insertions(+), 35 deletions(-)

-- 


					    Gilles Chanteperdrix.
--- include/rtdm/rtdm_driver.h	(revision 3460)
+++ include/rtdm/rtdm_driver.h	(working copy)
@@ -38,6 +38,7 @@
 #include <nucleus/heap.h>
 #include <nucleus/pod.h>
 #include <nucleus/synch.h>
+#include <nucleus/select.h>
 #include <rtdm/rtdm.h>
 
 /* debug support */
@@ -262,6 +263,10 @@ typedef ssize_t (*rtdm_sendmsg_handler_t
 typedef int (*rtdm_rt_handler_t)(struct rtdm_dev_context *context,
 				 rtdm_user_info_t *user_info, void *arg);
 
+typedef int (*rtdm_select_bind_handler_t)(struct rtdm_dev_context *context,
+					  struct xnselector *selector,
+					  unsigned type,
+					  unsigned index);
 /**
  * Device operations
  */
@@ -304,6 +309,8 @@ struct rtdm_operations {
 	/** Transmit message handler for non-real-time context (optional) */
 	rtdm_sendmsg_handler_t sendmsg_nrt;
 	/** @} Message-Oriented Device Operations */
+
+	rtdm_select_bind_handler_t select_bind;
 };
 
 struct rtdm_devctx_reserved {
@@ -453,7 +460,8 @@ int rtdm_dev_unregister(struct rtdm_devi
 #define rtdm_getpeername	rt_dev_getpeername
 #define rtdm_shutdown		rt_dev_shutdown
 
-struct rtdm_dev_context *rtdm_context_get(int fd);
+struct rtdm_dev_context *__rtdm_context_get(rtdm_user_info_t *user_info, int fd);
+#define rtdm_context_get(fd) __rtdm_context_get(NULL, fd)
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline void rtdm_context_lock(struct rtdm_dev_context *context)
@@ -1002,11 +1010,20 @@ void rtdm_toseq_init(rtdm_toseq_t *timeo
 
 typedef struct {
 	xnsynch_t synch_base;
+	DECLARE_XNSELECT(select_block);
 } rtdm_event_t;
 
 #define RTDM_EVENT_PENDING		XNSYNCH_SPARE1
 
 void rtdm_event_init(rtdm_event_t *event, unsigned long pending);
+#ifdef CONFIG_XENO_OPT_RTDM_SELECT
+int rtdm_event_select_bind(rtdm_event_t *event,
+			   struct xnselector *selector,
+			   unsigned type,
+			   unsigned bit_index);
+#else /* !CONFIG_XENO_OPT_RTDM_SELECT */
+#define rtdm_event_select_bind(e, s, t, b) ({ -EBADF; })
+#endif /* !CONFIG_XENO_OPT_RTDM_SELECT */
 int rtdm_event_wait(rtdm_event_t *event);
 int rtdm_event_timedwait(rtdm_event_t *event, nanosecs_rel_t timeout,
 			 rtdm_toseq_t *timeout_seq);
@@ -1027,6 +1044,7 @@ static inline void rtdm_event_destroy(rt
 {
 	trace_mark(xn_rtdm_event_destroy, "event %p", event);
 	__rtdm_synch_flush(&event->synch_base, XNRMID);
+	xnselect_destroy(&event->select_block);
 }
 #endif /* !DOXYGEN_CPP */
 
@@ -1035,9 +1053,18 @@ static inline void rtdm_event_destroy(rt
 typedef struct {
 	unsigned long value;
 	xnsynch_t synch_base;
+	DECLARE_XNSELECT(select_block);
 } rtdm_sem_t;
 
 void rtdm_sem_init(rtdm_sem_t *sem, unsigned long value);
+#ifdef CONFIG_XENO_OPT_RTDM_SELECT
+int rtdm_sem_select_bind(rtdm_sem_t *sem,
+			 struct xnselector *selector,
+			 unsigned type,
+			 unsigned bit_index);
+#else /* !CONFIG_XENO_OPT_RTDM_SELECT */
+#define rtdm_sem_select_bind(s, se, t, b) ({ -EBADF; })
+#endif /* !CONFIG_XENO_OPT_RTDM_SELECT */
 int rtdm_sem_down(rtdm_sem_t *sem);
 int rtdm_sem_timeddown(rtdm_sem_t *sem, nanosecs_rel_t timeout,
 		       rtdm_toseq_t *timeout_seq);
@@ -1048,6 +1075,7 @@ static inline void rtdm_sem_destroy(rtdm
 {
 	trace_mark(xn_rtdm_sem_destroy, "sem %p", sem);
 	__rtdm_synch_flush(&sem->synch_base, XNRMID);
+	xnselect_destroy(&sem->select_block);
 }
 #endif /* !DOXYGEN_CPP */
 
--- include/rtdm/rtdm.h	(revision 3460)
+++ include/rtdm/rtdm.h	(working copy)
@@ -247,6 +247,10 @@ ssize_t __rt_dev_recvmsg(rtdm_user_info_
 			 struct msghdr *msg, int flags);
 ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info, int fd,
 			 const struct msghdr *msg, int flags);
+struct xnselector;
+int __rt_dev_select_bind(rtdm_user_info_t *user_info, int fd,
+			 struct xnselector *selector,
+			 unsigned type, unsigned index);
 #endif /* __KERNEL__ */
 
 /* Define RTDM_NO_DEFAULT_USER_API to switch off the default rt_dev_xxx
--- ksrc/skins/rtdm/Kconfig	(revision 3460)
+++ ksrc/skins/rtdm/Kconfig	(working copy)
@@ -37,6 +37,14 @@ config XENO_OPT_RTDM_FILDES
 	a global resource all applications share, either via the RTDM skin
 	directly or via the embedded services of the POSIX skin.
 
+config XENO_OPT_RTDM_SELECT
+	bool "Select support for RTDM file descriptors"
+	select XENO_OPT_SELECT
+	help
+
+	This option allows RTDM-based file descriptors to be used with
+	select-like services.
+
 config XENO_OPT_DEBUG_RTDM
 	bool "RTDM debugging support"
 	depends on XENO_OPT_DEBUG
--- ksrc/skins/rtdm/device.c	(revision 3460)
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
--- ksrc/skins/rtdm/drvlib.c	(revision 3460)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -756,12 +756,39 @@ void rtdm_event_init(rtdm_event_t *event
 	xnsynch_init(&event->synch_base, XNSYNCH_PRIO);
 	if (pending)
 		xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
+	xnselect_init(&event->select_block);
 
 	xnlock_put_irqrestore(&nklock, s);
 }
 
 EXPORT_SYMBOL(rtdm_event_init);
 
+#ifdef CONFIG_XENO_OPT_RTDM_SELECT
+int rtdm_event_select_bind(rtdm_event_t *event,
+			   struct xnselector *selector,
+			   unsigned type,
+			   unsigned bit_index)
+{
+	struct xnselect_binding *binding;
+	int err;
+	spl_t s;
+
+	binding = xnmalloc(sizeof(*binding));
+	if (!binding)
+		return -ENOMEM;
+
+	xnlock_get_irqsave(&nklock, s);
+	err = xnselect_bind(&event->select_block,
+			    binding, selector, type,bit_index,
+			    xnsynch_test_flags(&event->synch_base,
+					       RTDM_EVENT_PENDING));
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+EXPORT_SYMBOL(rtdm_event_select_bind);
+#endif /* CONFIG_XENO_OPT_RTDM_SELECT */
+
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy an event
@@ -825,6 +852,7 @@ void rtdm_event_pulse(rtdm_event_t *even
  */
 void rtdm_event_signal(rtdm_event_t *event)
 {
+	int resched = 0;
 	spl_t s;
 
 	trace_mark(xn_rtdm_event_signal, "event %p", event);
@@ -833,6 +861,10 @@ void rtdm_event_signal(rtdm_event_t *eve
 
 	xnsynch_set_flags(&event->synch_base, RTDM_EVENT_PENDING);
 	if (xnsynch_flush(&event->synch_base, 0))
+		resched = 1;
+	if (xnselect_signal(&event->select_block, 1))
+		resched = 1;
+	if (resched)
 		xnpod_schedule();
 
 	xnlock_put_irqrestore(&nklock, s);
@@ -927,9 +959,10 @@ int rtdm_event_timedwait(rtdm_event_t *e
 	if (unlikely(testbits(event->synch_base.status, RTDM_SYNCH_DELETED)))
 		err = -EIDRM;
 	else if (likely(xnsynch_test_flags(&event->synch_base,
-					   RTDM_EVENT_PENDING)))
+					   RTDM_EVENT_PENDING))) {
 		xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDING);
-	else {
+		xnselect_signal(&event->select_block, 0);
+	} else {
 		/* non-blocking mode */
 		if (timeout < 0) {
 			err = -EWOULDBLOCK;
@@ -951,10 +984,11 @@ int rtdm_event_timedwait(rtdm_event_t *e
 		}
 
 		if (likely
-		    (!xnthread_test_info(thread, XNTIMEO | XNRMID | XNBREAK)))
+		    (!xnthread_test_info(thread, XNTIMEO | XNRMID | XNBREAK))) {
 			xnsynch_clear_flags(&event->synch_base,
 					    RTDM_EVENT_PENDING);
-		else if (xnthread_test_info(thread, XNTIMEO))
+			xnselect_signal(&event->select_block, 0);
+		} else if (xnthread_test_info(thread, XNTIMEO))
 			err = -ETIMEDOUT;
 		else if (xnthread_test_info(thread, XNRMID))
 			err = -EIDRM;
@@ -995,6 +1029,7 @@ void rtdm_event_clear(rtdm_event_t *even
 	xnlock_get_irqsave(&nklock, s);
 
 	xnsynch_clear_flags(&event->synch_base, RTDM_EVENT_PENDING);
+	xnselect_signal(&event->select_block, 0);
 
 	xnlock_put_irqrestore(&nklock, s);
 }
@@ -1034,12 +1069,37 @@ void rtdm_sem_init(rtdm_sem_t *sem, unsi
 
 	sem->value = value;
 	xnsynch_init(&sem->synch_base, XNSYNCH_PRIO);
+	xnselect_init(&sem->select_block);
 
 	xnlock_put_irqrestore(&nklock, s);
 }
 
 EXPORT_SYMBOL(rtdm_sem_init);
 
+#ifdef CONFIG_XENO_OPT_RTDM_SELECT
+int rtdm_sem_select_bind(rtdm_sem_t *sem,
+			 struct xnselector *selector,
+			 unsigned type,
+			 unsigned bit_index)
+{
+	struct xnselect_binding *binding;
+	int err;
+	spl_t s;
+
+	binding = xnmalloc(sizeof(*binding));
+	if (!binding)
+		return -ENOMEM;
+
+	xnlock_get_irqsave(&nklock, s);
+	err = xnselect_bind(&sem->select_block,
+			    binding, selector, type, bit_index, sem->value > 0);
+	xnlock_put_irqrestore(&nklock, s);
+
+	return err;
+}
+EXPORT_SYMBOL(rtdm_sem_select_bind);
+#endif /* CONFIG_XENO_OPT_RTDM_SELECT */
+
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
  * @brief Destroy a semaphore
@@ -1148,9 +1208,10 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, 
 
 	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
 		err = -EIDRM;
-	else if (sem->value > 0)
-		sem->value--;
-	else if (timeout < 0) /* non-blocking mode */
+	else if (sem->value > 0) {
+		if(!--sem->value)
+			xnselect_signal(&sem->select_block, 0);
+	} else if (timeout < 0) /* non-blocking mode */
 		err = -EWOULDBLOCK;
 	else {
 		thread = xnpod_current_thread();
@@ -1214,7 +1275,9 @@ void rtdm_sem_up(rtdm_sem_t *sem)
 	if (xnsynch_wakeup_one_sleeper(&sem->synch_base))
 		xnpod_schedule();
 	else
-		sem->value++;
+		if (sem->value++ == 0
+		    && xnselect_signal(&sem->select_block, 1))
+			xnpod_schedule();
 
 	xnlock_put_irqrestore(&nklock, s);
 }
--- ksrc/skins/rtdm/core.c	(revision 3460)
+++ ksrc/skins/rtdm/core.c	(working copy)
@@ -49,28 +49,7 @@ EXPORT_SYMBOL(rtdm_tbase);
 
 DEFINE_XNLOCK(rt_fildes_lock);
 
-/**
- * @brief Resolve file descriptor to device context
- *
- * @param[in] fd File descriptor
- *
- * @return Pointer to associated device context, or NULL on error
- *
- * @note The device context has to be unlocked using rtdm_context_unlock()
- * when it is no longer referenced.
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
-struct rtdm_dev_context *rtdm_context_get(int fd)
+struct rtdm_dev_context *__rtdm_context_get(rtdm_user_info_t *user_info, int fd)
 {
 	struct rtdm_dev_context *context;
 	spl_t s;
@@ -82,7 +61,9 @@ struct rtdm_dev_context *rtdm_context_ge
 
 	context = fildes_table[fd].context;
 	if (unlikely(!context ||
-		     test_bit(RTDM_CLOSING, &context->context_flags))) {
+		     test_bit(RTDM_CLOSING, &context->context_flags) ||
+		     context->reserved.owner != (user_info
+						 ? user_info->mm : NULL))) {
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
 		return NULL;
 	}
@@ -94,7 +75,7 @@ struct rtdm_dev_context *rtdm_context_ge
 	return context;
 }
 
-EXPORT_SYMBOL(rtdm_context_get);
+EXPORT_SYMBOL(__rtdm_context_get);
 
 static int create_instance(struct rtdm_device *device,
 			   struct rtdm_dev_context **context_ptr,
@@ -294,6 +275,34 @@ err_out:
 
 EXPORT_SYMBOL(__rt_dev_socket);
 
+int __rt_dev_select_bind(rtdm_user_info_t *info, int fd,
+			 struct xnselector *selector,
+			 unsigned type, unsigned index)
+{
+	struct rtdm_dev_context *context;
+	struct rtdm_operations  *ops;
+	int ret;
+
+	context = __rtdm_context_get(info, fd);
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
+EXPORT_SYMBOL(__rt_dev_select_bind);
+
 int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
 {
 	struct rtdm_dev_context *context;
@@ -312,7 +321,8 @@ again:
 
 	context = fildes_table[fd].context;
 
-	if (unlikely(!context)) {
+	if (unlikely(!context ||
+		     (user_info && context->reserved.owner != user_info->mm))) {
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
 		goto err_out;	/* -EBADF */
 	}
@@ -408,7 +418,7 @@ do {									\
 	struct rtdm_operations *ops;					\
 	int ret;							\
 									\
-	context = rtdm_context_get(fd);					\
+	context = __rtdm_context_get(user_info, fd);			\
 	ret = -EBADF;							\
 	if (unlikely(!context))						\
 		goto err_out;						\
@@ -517,6 +527,28 @@ ssize_t __rt_dev_sendmsg(rtdm_user_info_
 EXPORT_SYMBOL(__rt_dev_sendmsg);
 
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
+/**
+ * @brief Resolve file descriptor to device context
+ *
+ * @param[in] fd File descriptor
+ *
+ * @return Pointer to associated device context, or NULL on error
+ *
+ * @note The device context has to be unlocked using rtdm_context_unlock()
+ * when it is no longer referenced.
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
+struct rtdm_dev_context *rtdm_context_get(int fd);
 
 /**
  * @brief Increment context reference counter


From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:29:03 +0200
Message-Id: <fbbeec611f8f5ed9a8e9652894b150a02ca62c7b.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 23/25] RTDM: Early fd release with
	poll-free context reference tracking
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Two changes in one as they are tightly related: Once close is called,
remove the file descriptor from open table, allowing its reuse while
close for the previous user proceeds.

The second and major part of the patch avoids time-based polling while
waiting for context references to be dropped. This specifically helps in
scenarios where references can be held for a longer time beyond the
first close.

CC: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtdm_driver.h |   16 ++++-
 ksrc/skins/rtdm/core.c     |  168 ++++++++++++++++++++++++++++++-------------
 ksrc/skins/rtdm/device.c   |   45 ++++++++++--
 ksrc/skins/rtdm/internal.h |    8 +--
 4 files changed, 170 insertions(+), 67 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 380d752..1a4097b 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -379,6 +379,7 @@ struct rtdm_operations {
 
 struct rtdm_devctx_reserved {
 	void *owner;
+	struct list_head cleanup;
 };
 
 /**
@@ -560,19 +561,28 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay);
 struct rtdm_dev_context *rtdm_context_get(int fd);
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
+
+#define CONTEXT_IS_LOCKED(context) \
+	(atomic_read(&(context)->close_lock_count) > 1 || \
+	 (test_bit(RTDM_CLOSING, &(context)->context_flags) && \
+	  atomic_read(&(context)->close_lock_count) > 0))
+
 static inline void rtdm_context_lock(struct rtdm_dev_context *context)
 {
-	XENO_ASSERT(RTDM, atomic_read(&context->close_lock_count) > 0,
+	XENO_ASSERT(RTDM, CONTEXT_IS_LOCKED(context),
 		    /* just warn if context was a dangling pointer */);
 	atomic_inc(&context->close_lock_count);
 }
 
+extern int rtdm_apc;
+
 static inline void rtdm_context_unlock(struct rtdm_dev_context *context)
 {
-	XENO_ASSERT(RTDM, atomic_read(&context->close_lock_count) > 0,
+	XENO_ASSERT(RTDM, CONTEXT_IS_LOCKED(context),
 		    /* just warn if context was a dangling pointer */);
 	smp_mb__before_atomic_dec();
-	atomic_dec(&context->close_lock_count);
+	if (unlikely(atomic_dec_and_test(&context->close_lock_count)))
+		rthal_apc_schedule(rtdm_apc);
 }
 
 static inline void rtdm_context_put(struct rtdm_dev_context *context)
diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index e04b3f6..bf905df 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -26,7 +26,7 @@
  * @{
  */
 
-#include <linux/delay.h>
+#include <linux/workqueue.h>
 
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
@@ -35,7 +35,7 @@
 
 #include "rtdm/internal.h"
 
-#define CLOSURE_RETRY_PERIOD	100	/* ms */
+#define CLOSURE_RETRY_PERIOD_MS	100
 
 #define FD_BITMAP_SIZE  ((RTDM_FD_MAX + BITS_PER_LONG-1) / BITS_PER_LONG)
 
@@ -44,6 +44,10 @@ struct rtdm_fildes fildes_table[RTDM_FD_MAX] =
 static unsigned long used_fildes[FD_BITMAP_SIZE];
 int open_fildes;	/* number of used descriptors */
 
+static DECLARE_WORK_FUNC(close_callback);
+static DECLARE_DELAYED_WORK_NODATA(close_work, close_callback);
+static LIST_HEAD(cleanup_queue);
+
 xntbase_t *rtdm_tbase;
 EXPORT_SYMBOL(rtdm_tbase);
 
@@ -81,8 +85,7 @@ struct rtdm_dev_context *rtdm_context_get(int fd)
 	xnlock_get_irqsave(&rt_fildes_lock, s);
 
 	context = fildes_table[fd].context;
-	if (unlikely(!context ||
-		     test_bit(RTDM_CLOSING, &context->context_flags))) {
+	if (unlikely(!context)) {
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
 		return NULL;
 	}
@@ -106,8 +109,10 @@ static int create_instance(struct rtdm_device *device,
 	int fd;
 	spl_t s;
 
-	/* Reset to NULL so that we can always use cleanup_instance to revert
-	   also partially successful allocations */
+	/*
+	 * Reset to NULL so that we can always use cleanup_files/instance to
+	 * revert also partially successful allocations.
+	 */
 	*context_ptr = NULL;
 	*fildes_ptr = NULL;
 
@@ -155,7 +160,7 @@ static int create_instance(struct rtdm_device *device,
 
 	context->fd = fd;
 	context->ops = &device->ops;
-	atomic_set(&context->close_lock_count, 0);
+	atomic_set(&context->close_lock_count, 1);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	ppd = xnshadow_ppd_get(__rtdm_muxid);
@@ -163,31 +168,34 @@ static int create_instance(struct rtdm_device *device,
 
 	context->reserved.owner =
 	    ppd ? container_of(ppd, struct rtdm_process, ppd) : NULL;
+	INIT_LIST_HEAD(&context->reserved.cleanup);
 
 	return 0;
 }
 
-static int cleanup_instance(struct rtdm_device *device,
-			    struct rtdm_dev_context *context,
-			    struct rtdm_fildes *fildes, int nrt_mem)
+static void __cleanup_fildes(struct rtdm_fildes *fildes)
 {
-	spl_t s;
-
-	xnlock_get_irqsave(&rt_fildes_lock, s);
+	clear_bit((fildes - fildes_table), used_fildes);
+	fildes->context = NULL;
+	open_fildes--;
+}
 
-	if (context && unlikely(atomic_read(&context->close_lock_count) > 1)) {
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
-		return -EAGAIN;
-	}
+static void cleanup_fildes(struct rtdm_fildes *fildes)
+{
+	spl_t s;
 
-	if (fildes) {
-		clear_bit((fildes - fildes_table), used_fildes);
-		fildes->context = NULL;
-		open_fildes--;
-	}
+	if (!fildes)
+		return;
 
+	xnlock_get_irqsave(&rt_fildes_lock, s);
+	__cleanup_fildes(fildes);
 	xnlock_put_irqrestore(&rt_fildes_lock, s);
+}
 
+static void cleanup_instance(struct rtdm_device *device,
+			     struct rtdm_dev_context *context,
+			     int nrt_mem)
+{
 	if (context) {
 		if (device->reserved.exclusive_context)
 			context->device = NULL;
@@ -200,10 +208,62 @@ static int cleanup_instance(struct rtdm_device *device,
 	}
 
 	rtdm_dereference_device(device);
+}
 
-	return 0;
+static DECLARE_WORK_FUNC(close_callback)
+{
+	struct rtdm_dev_context *context;
+	LIST_HEAD(deferred_list);
+	int reschedule = 0;
+	int err;
+	spl_t s;
+
+	xnlock_get_irqsave(&rt_fildes_lock, s);
+
+	while (!list_empty(&cleanup_queue)) {
+		context = list_first_entry(&cleanup_queue,
+					   struct rtdm_dev_context,
+					   reserved.cleanup);
+		list_del(&context->reserved.cleanup);
+		atomic_inc(&context->close_lock_count);
+
+		xnlock_put_irqrestore(&rt_fildes_lock, s);
+
+		err = context->ops->close_nrt(context, NULL);
+
+		if (err == -EAGAIN ||
+		    atomic_read(&context->close_lock_count) > 1) {
+			atomic_dec(&context->close_lock_count);
+			list_add_tail(&context->reserved.cleanup,
+				      &deferred_list);
+			if (err == -EAGAIN)
+				reschedule = 1;
+		} else {
+			trace_mark(xn_rtdm, fd_closed, "fd %d", context->fd);
+
+			cleanup_instance(context->device, context,
+					 test_bit(RTDM_CREATED_IN_NRT,
+						  &context->context_flags));
+		}
+
+		xnlock_get_irqsave(&rt_fildes_lock, s);
+	}
+
+	list_splice(&deferred_list, &cleanup_queue);
+
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
+
+	if (reschedule)
+		schedule_delayed_work(&close_work,
+				      (HZ * CLOSURE_RETRY_PERIOD_MS) / 1000);
 }
 
+void rtdm_apc_handler(void *cookie)
+{
+	schedule_delayed_work(&close_work, 0);
+}
+
+
 int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 {
 	struct rtdm_device *device;
@@ -245,7 +305,8 @@ int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 	return context->fd;
 
 cleanup_out:
-	cleanup_instance(device, context, fildes, nrt_mode);
+	cleanup_fildes(fildes);
+	cleanup_instance(device, context, nrt_mode);
 
 err_out:
 	return ret;
@@ -296,7 +357,8 @@ int __rt_dev_socket(rtdm_user_info_t *user_info, int protocol_family,
 	return context->fd;
 
 cleanup_out:
-	cleanup_instance(device, context, fildes, nrt_mode);
+	cleanup_fildes(fildes);
+	cleanup_instance(device, context, nrt_mode);
 
 err_out:
 	return ret;
@@ -317,7 +379,6 @@ int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
 	if (unlikely((unsigned int)fd >= RTDM_FD_MAX))
 		goto err_out;
 
-again:
 	xnlock_get_irqsave(&rt_fildes_lock, s);
 
 	context = fildes_table[fd].context;
@@ -327,47 +388,52 @@ again:
 		goto err_out;	/* -EBADF */
 	}
 
+	/* Avoid asymmetric close context by switching to nrt. */
+	if (unlikely(test_bit(RTDM_CREATED_IN_NRT, &context->context_flags)) &&
+	    !nrt_mode) {
+		xnlock_put_irqrestore(&rt_fildes_lock, s);
+
+		ret = -ENOSYS;
+		goto err_out;
+	}
+
 	set_bit(RTDM_CLOSING, &context->context_flags);
 	atomic_inc(&context->close_lock_count);
 
+	__cleanup_fildes(&fildes_table[fd]);
+
 	xnlock_put_irqrestore(&rt_fildes_lock, s);
 
 	if (nrt_mode)
 		ret = context->ops->close_nrt(context, user_info);
-	else {
-		/* Avoid asymmetric close context by switching to nrt. */
-		if (unlikely(
-		    test_bit(RTDM_CREATED_IN_NRT, &context->context_flags))) {
-			ret = -ENOSYS;
-			goto unlock_out;
-		}
+	else
 		ret = context->ops->close_rt(context, user_info);
-	}
 
 	XENO_ASSERT(RTDM, !rthal_local_irq_disabled(),
 		    rthal_local_irq_enable(););
 
-	if (unlikely(ret == -EAGAIN) && nrt_mode) {
-		rtdm_context_unlock(context);
-		msleep(CLOSURE_RETRY_PERIOD);
-		goto again;
-	} else if (unlikely(ret < 0))
-		goto unlock_out;
+	xnlock_get_irqsave(&rt_fildes_lock, s);
 
-	ret = cleanup_instance(context->device, context, &fildes_table[fd],
-			       test_bit(RTDM_CREATED_IN_NRT,
-			       &context->context_flags));
-	if (ret < 0) {
-		rtdm_context_unlock(context);
+	if (ret == -EAGAIN || atomic_read(&context->close_lock_count) > 2) {
+		atomic_dec(&context->close_lock_count);
+		list_add(&context->reserved.cleanup, &cleanup_queue);
 
-		if (!nrt_mode)
-			goto err_out;
+		xnlock_put_irqrestore(&rt_fildes_lock, s);
 
-		msleep(CLOSURE_RETRY_PERIOD);
-		goto again;
+		if (ret == -EAGAIN) {
+			rthal_apc_schedule(rtdm_apc);
+			ret = 0;
+		}
+		goto unlock_out;
 	}
 
-	trace_mark(xn_rtdm, fd_closed, "fd %d", fd);
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
+
+	trace_mark(xn_rtdm, fd_closed, "fd %d", context->fd);
+
+	cleanup_instance(context->device, context,
+			 test_bit(RTDM_CREATED_IN_NRT,
+				  &context->context_flags));
 
 	return ret;
 
@@ -402,7 +468,7 @@ void cleanup_owned_contexts(void *owner)
 					 fd);
 
 			ret = __rt_dev_close(NULL, fd);
-			XENO_ASSERT(RTDM, ret >= 0 || ret == -EBADF,
+			XENO_ASSERT(RTDM, ret == 0 || ret == -EBADF,
 				    /* only warn here */;);
 		}
 	}
diff --git a/ksrc/skins/rtdm/device.c b/ksrc/skins/rtdm/device.c
index e229932..6eb2975 100644
--- a/ksrc/skins/rtdm/device.c
+++ b/ksrc/skins/rtdm/device.c
@@ -58,6 +58,9 @@ struct list_head *rtdm_protocol_devices;	/* hash table */
 static int name_hashkey_mask;
 static int proto_hashkey_mask;
 
+int rtdm_apc;
+EXPORT_SYMBOL(rtdm_apc);
+
 DECLARE_MUTEX(nrt_dev_lock);
 DEFINE_XNLOCK(rt_dev_lock);
 
@@ -458,19 +461,28 @@ EXPORT_SYMBOL(rtdm_dev_unregister);
 
 int __init rtdm_dev_init(void)
 {
-	int i;
+	int err, i;
+
+	rtdm_apc = rthal_apc_alloc("deferred RTDM close", rtdm_apc_handler,
+				   NULL);
+	if (rtdm_apc < 0)
+		return rtdm_apc;
 
 	name_hashkey_mask = devname_hashtab_size - 1;
 	proto_hashkey_mask = protocol_hashtab_size - 1;
 	if (((devname_hashtab_size & name_hashkey_mask) != 0) ||
-	    ((protocol_hashtab_size & proto_hashkey_mask) != 0))
-		return -EINVAL;
+	    ((protocol_hashtab_size & proto_hashkey_mask) != 0)) {
+		err = -EINVAL;
+		goto err_out1;
+	}
 
 	rtdm_named_devices = (struct list_head *)
 	    kmalloc(devname_hashtab_size * sizeof(struct list_head),
 		    GFP_KERNEL);
-	if (!rtdm_named_devices)
-		return -ENOMEM;
+	if (!rtdm_named_devices) {
+		err = -ENOMEM;
+		goto err_out1;
+	}
 
 	for (i = 0; i < devname_hashtab_size; i++)
 		INIT_LIST_HEAD(&rtdm_named_devices[i]);
@@ -479,14 +491,33 @@ int __init rtdm_dev_init(void)
 	    kmalloc(protocol_hashtab_size * sizeof(struct list_head),
 		    GFP_KERNEL);
 	if (!rtdm_protocol_devices) {
-		kfree(rtdm_named_devices);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out2;
 	}
 
 	for (i = 0; i < protocol_hashtab_size; i++)
 		INIT_LIST_HEAD(&rtdm_protocol_devices[i]);
 
 	return 0;
+
+err_out2:
+	kfree(rtdm_named_devices);
+
+err_out1:
+	rthal_apc_free(rtdm_apc);
+
+	return err;
+}
+
+void __exit rtdm_dev_cleanup(void)
+{
+	/*
+	 * Note: no need to flush the cleanup_queue as no device is allowed
+	 * to deregister as long as there are references.
+	 */
+	rthal_apc_free(rtdm_apc);
+	kfree(rtdm_named_devices);
+	kfree(rtdm_protocol_devices);
 }
 
 /*@}*/
diff --git a/ksrc/skins/rtdm/internal.h b/ksrc/skins/rtdm/internal.h
index 69299f8..3d39def 100644
--- a/ksrc/skins/rtdm/internal.h
+++ b/ksrc/skins/rtdm/internal.h
@@ -80,15 +80,11 @@ static inline void rtdm_dereference_device(struct rtdm_device *device)
 }
 
 int __init rtdm_dev_init(void);
-
-static inline void rtdm_dev_cleanup(void)
-{
-	kfree(rtdm_named_devices);
-	kfree(rtdm_protocol_devices);
-}
+void __exit rtdm_dev_cleanup(void);
 
 int rtdm_proc_register_device(struct rtdm_device *device);
 int __init rtdm_proc_init(void);
 void rtdm_proc_cleanup(void);
+void rtdm_apc_handler(void *cookie);
 
 #endif /* _RTDM_INTERNAL_H */
-- 
1.6.0.2



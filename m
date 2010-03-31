Message-ID: <4BB359FC.6040709@domain.hid>
Date: Wed, 31 Mar 2010 16:19:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BB1C51F.4010106@domain.hid> <4BB1C5B7.7040400@domain.hid>
	<4BB1D0EB.30401@domain.hid> <4BB213AD.5020606@domain.hid>
	<4BB32F45.4010603@domain.hid> <4BB355EF.7070503@domain.hid>
	<4BB35651.1020307@domain.hid> <4BB3570F.2070702@domain.hid>
	<4BB358B9.6040805@domain.hid>
In-Reply-To: <4BB358B9.6040805@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] RTDM: Fix potential NULL pointer
	dereference
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> The following changes since commit 6b3e8f2e5c69397814cb2f4029cdfbaff16e113e:
>>>>>>>>>   Gilles Chanteperdrix (1):
>>>>>>>>>         doc: regenerate
>>>>>>>>>
>>>>>>>>> are available in the git repository at:
>>>>>>>>>
>>>>>>>>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>>>>>>>>
>>>>>>>>> Unfortunately too late for 2.5.2, fortunately only relevant if something
>>>>>>>>> else went wrong in create_instance (ENOMEM or application error).
>>>>>>>>>
>>>>>>>>> Wolfgang Mauerer (1):
>>>>>>>>>       RTDM: Fix potential NULL pointer dereference
>>>>>>>>>
>>>>>>>>>  ksrc/skins/rtdm/core.c |    2 +-
>>>>>>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>>>>>
>>>>>>>> Was not there any plan to remove this code and have a more "posix
>>>>>>>> compliant" close? I thought this had been merged?
>>>>>>> Yes. But that requires more work than it would have been appropriate for
>>>>>>> 2.5.2.
>>>>>> Ok, but could we have it for 2.5.3?
>>>>>>
>>>>> Will see what I can do (no budget for this, so no promise).
>>>> The patches are floating around for some time (I was in CC of the mail
>>>> Philippe sent you about this some time ago), I guess some testing is
>>>> needed, this is why you need some time? Could we help with this testing?
>>>>
>>> Then I totally lost track of this. What series are you referring to?
>> A (private) mail entitled "Re: RTDM close() refactoring" from Philippe,
>> with in fact, a unique patch.
>>
> 
> Ah, now I found it. That discussion ended last September with a "Don't
> bother yet" by Philippe as he said you pointed out some remaining issues
> /wrt POSIX compliance. So I stopped bothering.

There was a reply "here it is", with a fixed version. Inlined here.

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index 18af70b..71abc5a 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -536,4 +536,9 @@ static inline void wrap_proc_dir_entry_owner(struct proc_dir_entry *entry)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
 #endif /* CONFIG_PROC_FS */
 
+#ifndef list_first_entry
+#define list_first_entry(ptr, type, member) \
+	list_entry((ptr)->next, type, member)
+#endif
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index ea543c1..d5f997b 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -368,6 +368,7 @@ struct rtdm_operations {
 
 struct rtdm_devctx_reserved {
 	void *owner;
+	struct list_head cleanup;
 };
 
 /**
@@ -549,9 +550,17 @@ static inline void rtdm_context_lock(struct rtdm_dev_context *context)
 	atomic_inc(&context->close_lock_count);
 }
 
+void __rtdm_context_flush(struct rtdm_dev_context *context);
+
 static inline void rtdm_context_unlock(struct rtdm_dev_context *context)
 {
-	atomic_dec(&context->close_lock_count);
+	if (atomic_dec_and_test(&context->close_lock_count))
+		__rtdm_context_flush(context);
+}
+
+static inline void rtdm_context_put(struct rtdm_dev_context *context)
+{
+	rtdm_context_unlock(context);
 }
 
 /* --- clock services --- */
diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
index 5843842..c3ff526 100644
--- a/ksrc/skins/rtdm/core.c
+++ b/ksrc/skins/rtdm/core.c
@@ -26,7 +26,7 @@
  * @{
  */
 
-#include <linux/delay.h>
+#include <linux/workqueue.h>
 
 #include <nucleus/pod.h>
 #include <nucleus/ppd.h>
@@ -44,20 +44,25 @@ struct rtdm_fildes fildes_table[RTDM_FD_MAX] =
 static unsigned long used_fildes[FD_BITMAP_SIZE];
 int open_fildes;	/* number of used descriptors */
 
+static DECLARE_WORK_FUNC(close_callback);
+static DECLARE_WORK_NODATA(close_work, close_callback);
+static LIST_HEAD(cleanup_queue);
+
 xntbase_t *rtdm_tbase;
 EXPORT_SYMBOL(rtdm_tbase);
 
 DEFINE_XNLOCK(rt_fildes_lock);
 
 /**
- * @brief Resolve file descriptor to device context
+ * @brief Retrieve and lock a device context
  *
  * @param[in] fd File descriptor
  *
  * @return Pointer to associated device context, or NULL on error
  *
- * @note The device context has to be unlocked using rtdm_context_unlock()
- * when it is no longer referenced.
+ * @note The device context has to be unlocked using
+ * rtdm_context_put() or rtdm_context_unlock() when it is no longer
+ * referenced.
  *
  * Environments:
  *
@@ -155,7 +160,7 @@ static int create_instance(struct rtdm_device *device,
 
 	context->fd = fd;
 	context->ops = &device->ops;
-	atomic_set(&context->close_lock_count, 0);
+	atomic_set(&context->close_lock_count, 1);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	ppd = xnshadow_ppd_get(__rtdm_muxid);
@@ -163,24 +168,32 @@ static int create_instance(struct rtdm_device *device,
 
 	context->reserved.owner =
 	    ppd ? container_of(ppd, struct rtdm_process, ppd) : NULL;
+	INIT_LIST_HEAD(&context->reserved.cleanup);
 
 	return 0;
 }
 
-/* call with rt_fildes_lock acquired - will release it */
-static void cleanup_instance(struct rtdm_device *device,
-			     struct rtdm_dev_context *context,
-			     struct rtdm_fildes *fildes, int nrt_mem, spl_t s)
+/* must be called with rt_fildes_lock acquired */
+static void cleanup_fildes(struct rtdm_fildes *fildes)
 {
-	if (fildes) {
-		clear_bit((fildes - fildes_table), used_fildes);
-		fildes->context = NULL;
-		open_fildes--;
-	}
+	int fd = fildes - fildes_table;
 
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
+	clear_bit(fd, used_fildes);
+	fildes->context->fd = -1;
+	fildes->context = NULL;
+	open_fildes--;
 
+	trace_mark(xn_rtdm, cleanup_fildes, "fd %d", fd);
+}
+
+/* must be called lock free */
+static void cleanup_context(struct rtdm_device *device,
+			    struct rtdm_dev_context *context,
+			    int nrt_mem)
+{
 	if (context) {
+		int fd = context->fd;
+
 		if (device->reserved.exclusive_context)
 			context->device = NULL;
 		else {
@@ -189,11 +202,26 @@ static void cleanup_instance(struct rtdm_device *device,
 			else
 				xnfree(context);
 		}
+
+		trace_mark(xn_rtdm, cleanup_context, "fd %d", fd);
 	}
 
 	rtdm_dereference_device(device);
 }
 
+/* call with rt_fildes_lock acquired - will release it */
+static void cleanup_instance(struct rtdm_device *device,
+			     struct rtdm_dev_context *context,
+			     struct rtdm_fildes *fildes, int nrt_mem, spl_t s)
+{
+	if (fildes)
+		cleanup_fildes(fildes);
+
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
+
+	cleanup_context(device, context, nrt_mem);
+}
+
 int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 {
 	struct rtdm_device *device;
@@ -298,82 +326,144 @@ err_out:
 
 EXPORT_SYMBOL(__rt_dev_socket);
 
-int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
+static DECLARE_WORK_FUNC(close_callback)
 {
 	struct rtdm_dev_context *context;
 	spl_t s;
-	int ret;
-	int nrt_mode = !rtdm_in_rt_context();
 
-	trace_mark(xn_rtdm, close, "user_info %p fd %d", user_info, fd);
-
-	ret = -EBADF;
-	if (unlikely((unsigned int)fd >= RTDM_FD_MAX))
-		goto err_out;
-
-again:
 	xnlock_get_irqsave(&rt_fildes_lock, s);
 
-	context = fildes_table[fd].context;
-
-	if (unlikely(!context)) {
+	while (!list_empty(&cleanup_queue)) {
+		context = list_first_entry(&cleanup_queue,
+					   struct rtdm_dev_context, reserved.cleanup);
+		list_del(&context->reserved.cleanup);
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
-		goto err_out;	/* -EBADF */
+		context->ops->close_nrt(context, NULL);
+		cleanup_context(context->device, context,
+				test_bit(RTDM_CREATED_IN_NRT,
+					 &context->context_flags));
+		xnlock_get_irqsave(&rt_fildes_lock, s);
 	}
 
-	set_bit(RTDM_CLOSING, &context->context_flags);
-	rtdm_context_lock(context);
-
 	xnlock_put_irqrestore(&rt_fildes_lock, s);
+}
 
-	if (nrt_mode)
-		ret = context->ops->close_nrt(context, user_info);
-	else {
-		/* Avoid asymmetric close context by switching to nrt. */
-		if (unlikely(
-		    test_bit(RTDM_CREATED_IN_NRT, &context->context_flags))) {
-			ret = -ENOSYS;
-			goto unlock_out;
+void rtdm_apc_handler(void *cookie)
+{
+	schedule_work(&close_work);
+}
+
+void __rtdm_context_flush(struct rtdm_dev_context *context)
+{
+	spl_t s;
+
+	xnlock_get_irqsave(&rt_fildes_lock, s);
+	
+	/*
+	 * The only valid context locking construct which driver may
+	 * use is:
+	 *
+	 * context = rtdm_context_get(fd)
+	 *     ...
+	 *     [ rtdm_context_lock(context);
+	 *       ... (optional nested locking)
+	 *       rtdm_context_unlock(context); ]
+	 *     ...
+	 * rtdm_context_put/unlock(context);
+	 *
+	 * Anything different, and particularly calling
+	 * rtdm_lock_context() on device contexts NOT initially
+	 * obtained from rtdm_context_get() will open a race window
+	 * which may cause access to stale memory.
+	 *
+	 * The following assertion is an attempt to detect such misuse
+	 * of the locking interface.
+	 */
+	XENO_ASSERT(RTDM,
+		    atomic_read(&context->close_lock_count),
+		    goto unlock_out);
+	/*
+	 * __rt_dev_close() already released the file descriptor. We
+	 * just need to discard the context struct.
+	 */
+	if (unlikely(rtdm_in_rt_context())) {
+		if (unlikely(context->ops->close_rt)) {
+			xnlock_put_irqrestore(&rt_fildes_lock, s);
+			context->ops->close_rt(context, NULL);
+			goto cleanup;
 		}
-		ret = context->ops->close_rt(context, user_info);
+		list_add_tail(&context->reserved.cleanup, &cleanup_queue);
+		rthal_apc_schedule(rtdm_apc);
+		goto unlock_out;
 	}
 
-	XENO_ASSERT(RTDM, !rthal_local_irq_disabled(),
-		    rthal_local_irq_enable(););
+	/*
+	 * No reference is pending, and we are running in NRT mode, we
+	 * may run the close_nrt() handler and flush the context
+	 * immediately.
+	 */
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
 
-	if (unlikely(ret == -EAGAIN) && nrt_mode) {
-		rtdm_context_unlock(context);
-		msleep(CLOSURE_RETRY_PERIOD);
-		goto again;
-	} else if (unlikely(ret < 0))
-		goto unlock_out;
+	XENO_BUGON(RTDM, in_atomic());
+
+	context->ops->close_nrt(context, NULL);
+
+cleanup:
+	cleanup_context(context->device, context,
+			test_bit(RTDM_CREATED_IN_NRT,
+				 &context->context_flags));
+	return;
+
+unlock_out:
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
+}
+
+EXPORT_SYMBOL(__rtdm_context_flush);
+
+int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
+{
+	struct rtdm_dev_context *context;
+	struct rtdm_fildes *fildes;
+	int ret;
+	spl_t s;
+
+	trace_mark(xn_rtdm, close, "user_info %p fd %d", user_info, fd);
+
+	ret = -EBADF;
+	if (unlikely((unsigned int)fd >= RTDM_FD_MAX))
+		return ret;
 
 	xnlock_get_irqsave(&rt_fildes_lock, s);
 
-	if (unlikely(atomic_read(&context->close_lock_count) > 1)) {
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
+	fildes = fildes_table + fd;
+	context = fildes->context;
+	if (unlikely(context == NULL))
+		goto unlock_out;
+
+	if (test_and_set_bit(RTDM_CLOSING, &context->context_flags))
+		goto unlock_out; /* close() in progress */
 
-		if (!nrt_mode) {
-			ret = -EAGAIN;
+	/* Avoid asymmetric close context by switching to nrt. */
+	if (unlikely(rtdm_in_rt_context() &&
+		     test_bit(RTDM_CREATED_IN_NRT, &context->context_flags))) {
+			ret = -ENOSYS;
 			goto unlock_out;
-		}
-		rtdm_context_unlock(context);
-		msleep(CLOSURE_RETRY_PERIOD);
-		goto again;
 	}
 
-	cleanup_instance(context->device, context, &fildes_table[fd],
-			 test_bit(RTDM_CREATED_IN_NRT, &context->context_flags),
-			 s);
+	cleanup_fildes(fildes);
+
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
+
+	/* Release the reference obtained in open() */
+	rtdm_context_unlock(context);
 
 	trace_mark(xn_rtdm, fd_closed, "fd %d", fd);
 
-	return ret;
+	return 0;
 
 unlock_out:
-	rtdm_context_unlock(context);
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
 
-err_out:
 	return ret;
 }
 
@@ -586,8 +676,12 @@ EXPORT_SYMBOL(rtdm_select_bind);
  *
  * @param[in] context Device context
  *
- * @note rtdm_context_get() automatically increments the lock counter. You
- * only need to call this function in special scenrios.
+ * @note rtdm_context_get() automatically increments the lock counter.
+ * WARNING: You may call rtdm_context_lock() only to hold an
+ * additional reference on a context initially locked by
+ * rtdm_context_get(). Using rtdm_context_lock() on device contexts
+ * NOT obtained this way may lead to access stale memory in some
+ * circumstances.
  *
  * Environments:
  *
@@ -607,8 +701,8 @@ void rtdm_context_lock(struct rtdm_dev_context *context);
  *
  * @param[in] context Device context
  *
- * @note Every successful call to rtdm_context_get() must be matched by a
- * rtdm_context_unlock() invocation.
+ * @note Every successful call to rtdm_context_lock() must be matched
+ * by a rtdm_context_unlock() invocation.
  *
  * Environments:
  *
@@ -624,6 +718,26 @@ void rtdm_context_lock(struct rtdm_dev_context *context);
 void rtdm_context_unlock(struct rtdm_dev_context *context);
 
 /**
+ * @brief Release a device context
+ *
+ * @param[in] context Device context
+ *
+ * @note This routine is an alias for rtdm_context_unlock().
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
+void rtdm_context_put(struct rtdm_dev_context *context);
+
+/**
  * @brief Open a device
  *
  * Refer to rt_dev_open() for parameters and return values
diff --git a/ksrc/skins/rtdm/device.c b/ksrc/skins/rtdm/device.c
index e927ce7..9838622 100644
--- a/ksrc/skins/rtdm/device.c
+++ b/ksrc/skins/rtdm/device.c
@@ -55,6 +55,7 @@ MODULE_PARM_DESC(protocol_hashtab_size,
 
 struct list_head *rtdm_named_devices;	/* hash table */
 struct list_head *rtdm_protocol_devices;	/* hash table */
+int rtdm_apc;
 static int name_hashkey_mask;
 static int proto_hashkey_mask;
 
@@ -238,12 +239,12 @@ int rtdm_dev_register(struct rtdm_device *device)
 
 	/* Sanity check: non-RT close handler?
 	 * (Always required for forced cleanup) */
-	if (!device->ops.close_nrt) {
+	if (device->ops.close_nrt == NULL) {
 		xnlogerr("RTDM: missing non-RT close handler\n");
 		return -EINVAL;
 	}
-	if (!device->ops.close_rt)
-		device->ops.close_rt = (void *)rtdm_no_support;
+	if (device->ops.close_rt)
+		xnlogerr("RTDM: RT close handler is deprecated - convert to NRT\n");
 
 	SET_DEFAULT_OP_IF_NULL(device->ops, ioctl);
 	SET_DEFAULT_OP_IF_NULL(device->ops, read);
@@ -448,6 +449,10 @@ int __init rtdm_dev_init(void)
 {
 	int i;
 
+	rtdm_apc = rthal_apc_alloc("rtdm_handler", rtdm_apc_handler, NULL);
+	if (rtdm_apc < 0)
+		return rtdm_apc;
+
 	name_hashkey_mask = devname_hashtab_size - 1;
 	proto_hashkey_mask = protocol_hashtab_size - 1;
 	if (((devname_hashtab_size & name_hashkey_mask) != 0) ||
@@ -477,4 +482,14 @@ int __init rtdm_dev_init(void)
 	return 0;
 }
 
+void __exit rtdm_dev_cleanup(void)
+{
+	rthal_apc_free(rtdm_apc);
+	rtdm_apc = -1;
+	xnarch_memory_barrier();
+	flush_scheduled_work();
+	kfree(rtdm_named_devices);
+	kfree(rtdm_protocol_devices);
+}
+
 /*@}*/
diff --git a/ksrc/skins/rtdm/internal.h b/ksrc/skins/rtdm/internal.h
index 64e5b47..c729e19 100644
--- a/ksrc/skins/rtdm/internal.h
+++ b/ksrc/skins/rtdm/internal.h
@@ -58,6 +58,7 @@ extern unsigned int protocol_hashtab_size;
 extern struct list_head *rtdm_named_devices;
 extern struct list_head *rtdm_protocol_devices;
 extern struct proc_dir_entry *rtdm_proc_root;
+extern int rtdm_apc;
 
 #ifdef MODULE
 #define rtdm_initialised 1
@@ -76,15 +77,11 @@ static inline void rtdm_dereference_device(struct rtdm_device *device)
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
					    Gilles.


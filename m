From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:32 +0100
Message-Id: <1394223638-13070-3-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 3/9] cobalt/rtdm: extract fd API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

for use by POSIX skin.
---
 include/cobalt/kernel/ppd.h         |    3 +-
 include/cobalt/kernel/rtdm/driver.h |  338 ++++----------------
 include/cobalt/kernel/rtdm/fd.h     |  186 +++++++++++
 include/cobalt/kernel/rtdm/rtdm.h   |   48 +--
 include/cobalt/uapi/rtdm/syscall.h  |   17 +-
 kernel/cobalt/Kconfig               |    8 +-
 kernel/cobalt/init.c                |    3 +
 kernel/cobalt/posix/select.c        |   47 +--
 kernel/cobalt/rtdm/Makefile         |    1 +
 kernel/cobalt/rtdm/core.c           |  578 ++++++-----------------------------
 kernel/cobalt/rtdm/device.c         |   48 +--
 kernel/cobalt/rtdm/drvlib.c         |   36 +--
 kernel/cobalt/rtdm/fd.c             |  541 ++++++++++++++++++++++++++++++++
 kernel/cobalt/rtdm/internal.h       |    6 -
 kernel/cobalt/rtdm/proc.c           |   33 +-
 kernel/cobalt/rtdm/syscall.c        |   72 ++---
 kernel/cobalt/shadow.c              |    3 +
 lib/cobalt/init.c                   |    7 +-
 lib/cobalt/rtdm.c                   |  502 ++++++++++++++----------------
 19 files changed, 1212 insertions(+), 1265 deletions(-)
 create mode 100644 include/cobalt/kernel/rtdm/fd.h
 create mode 100644 kernel/cobalt/rtdm/fd.c

diff --git a/include/cobalt/kernel/ppd.h b/include/cobalt/kernel/ppd.h
index 4ddd045..d2cfd46 100644
--- a/include/cobalt/kernel/ppd.h
+++ b/include/cobalt/kernel/ppd.h
@@ -25,10 +25,10 @@
 #include <cobalt/kernel/shadow.h>
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/heap.h>
+#include <rtdm/fd.h>
 
 #define NR_PERSONALITIES  4
 
-/* Called with nklock locked irqs off. */
 void *xnshadow_private_get(unsigned int muxid);
 
 struct xnsys_ppd {
@@ -36,6 +36,7 @@ struct xnsys_ppd {
 	unsigned long mayday_addr;
 	atomic_t refcnt;
 	char *exe_path;
+	struct rb_root fds;
 };
 
 struct xnshadow_process {
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index c76df5d..078ac1a 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -40,6 +40,7 @@
 #include <cobalt/kernel/shadow.h>
 #include <cobalt/kernel/init.h>
 #include <cobalt/kernel/tree.h>
+#include <rtdm/fd.h>
 #include <rtdm/rtdm.h>
 
 /* debug support */
@@ -78,22 +79,6 @@ enum rtdm_selecttype;
 /** @} Device Flags */
 
 /*!
- * @anchor ctx_flags @name Context Flags
- * Dynamic flags describing the state of an open RTDM device (bit numbers)
- * @{
- */
-/** Set by RTDM if the device instance was created in non-real-time
- *  context. */
-#define RTDM_CREATED_IN_NRT		0
-
-/** Set by RTDM when the device is being closed. */
-#define RTDM_CLOSING			1
-
-/** Lowest bit number the driver developer can use freely */
-#define RTDM_USER_CONTEXT_FLAG		8  /* first user-definable flag */
-/** @} Context Flags */
-
-/*!
  * @anchor drv_versioning @name Driver Versioning
  * Current revisions of RTDM structures, encoding of driver versions. See
  * @ref api_versioning "API Versioning" for the interface revision.
@@ -154,9 +139,7 @@ enum rtdm_selecttype {
 /**
  * Named device open handler
  *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
+ * @param[in] context File descriptor structure associated with opened device instance
  * @param[in] oflag Open flags as passed by the user
  *
  * @return 0 on success. On failure return either -ENOSYS, to request that
@@ -165,15 +148,12 @@ enum rtdm_selecttype {
  *
  * @see @c open() in IEEE Std 1003.1,
  * http://www.opengroup.org/onlinepubs/009695399 */
-typedef int (*rtdm_open_handler_t)(struct rtdm_dev_context *context,
-				   rtdm_user_info_t *user_info, int oflag);
+typedef int (*rtdm_open_handler_t)(struct rtdm_fd *context, int oflag);
 
 /**
  * Socket creation handler for protocol devices
  *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
+ * @param[in] context File descriptor structure associated with opened device instance
  * @param[in] protocol Protocol number as passed by the user
  *
  * @return 0 on success. On failure return either -ENOSYS, to request that
@@ -182,203 +162,15 @@ typedef int (*rtdm_open_handler_t)(struct rtdm_dev_context *context,
  *
  * @see @c socket() in IEEE Std 1003.1,
  * http://www.opengroup.org/onlinepubs/009695399 */
-typedef int (*rtdm_socket_handler_t)(struct rtdm_dev_context *context,
-				     rtdm_user_info_t *user_info, int protocol);
-
-/**
- * Close handler
- *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode or deferred user mode call
- *
- * @return 0 on success. On failure return either -ENOSYS, to request that
- * this handler be called again from the opposite realtime/non-realtime
- * context, -EAGAIN to request a recall after a grace period, or a valid
- * negative error code according to IEEE Std 1003.1.
- *
- * @note Drivers must be prepared for that case that the close handler is
- * invoked more than once per open context (even if the handler already
- * completed an earlier run successfully). The driver has to avoid releasing
- * resources twice as well as returning false errors on successive close
- * invocations.
- *
- * @see @c close() in IEEE Std 1003.1,
- * http://www.opengroup.org/onlinepubs/009695399 */
-typedef int (*rtdm_close_handler_t)(struct rtdm_dev_context *context,
-				    rtdm_user_info_t *user_info);
-
-/**
- * IOCTL handler
- *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
- * @param[in] request Request number as passed by the user
- * @param[in,out] arg Request argument as passed by the user
- *
- * @return A positive value or 0 on success. On failure return either
- * -ENOSYS, to request that the function be called again from the opposite
- * realtime/non-realtime context, or another negative error code.
- *
- * @see @c ioctl() in IEEE Std 1003.1,
- * http://www.opengroup.org/onlinepubs/009695399 */
-typedef int (*rtdm_ioctl_handler_t)(struct rtdm_dev_context *context,
-				    rtdm_user_info_t *user_info,
-				    unsigned int request, void __user *arg);
-
-/**
- * Select binding handler
- *
- * @param[in] context Context structure associated with opened device instance
- * @param[in,out] selector Object that shall be bound to the given event
- * @param[in] type Event type the selector is interested in
- * @param[in] fd_index Opaque value, to be passed to rtdm_event_select_bind or
- * rtdm_sem_select_bind unmodfied
- *
- * @return 0 on success. On failure return either -ENOSYS, to request that
- * this handler be called again from the opposite realtime/non-realtime
- * context, or another negative error code.
- */
-typedef int (*rtdm_select_bind_handler_t)(struct rtdm_dev_context *context,
-					  rtdm_selector_t *selector,
-					  enum rtdm_selecttype type,
-					  unsigned fd_index);
+typedef int (*rtdm_socket_handler_t)(struct rtdm_fd *context, int protocol);
 
-/**
- * Read handler
- *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
- * @param[out] buf Input buffer as passed by the user
- * @param[in] nbyte Number of bytes the user requests to read
- *
- * @return On success, the number of bytes read. On failure return either
- * -ENOSYS, to request that this handler be called again from the opposite
- * realtime/non-realtime context, or another negative error code.
- *
- * @see @c read() in IEEE Std 1003.1,
- * http://www.opengroup.org/onlinepubs/009695399 */
-typedef ssize_t (*rtdm_read_handler_t)(struct rtdm_dev_context *context,
-				       rtdm_user_info_t *user_info,
-				       void *buf, size_t nbyte);
-
-/**
- * Write handler
- *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
- * @param[in] buf Output buffer as passed by the user
- * @param[in] nbyte Number of bytes the user requests to write
- *
- * @return On success, the number of bytes written. On failure return
- * either -ENOSYS, to request that this handler be called again from the
- * opposite realtime/non-realtime context, or another negative error code.
- *
- * @see @c write() in IEEE Std 1003.1,
- * http://www.opengroup.org/onlinepubs/009695399 */
-typedef ssize_t (*rtdm_write_handler_t)(struct rtdm_dev_context *context,
-					rtdm_user_info_t *user_info,
-					const void *buf, size_t nbyte);
-
-/**
- * Receive message handler
- *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
- * @param[in,out] msg Message descriptor as passed by the user, automatically
- * mirrored to safe kernel memory in case of user mode call
- * @param[in] flags Message flags as passed by the user
- *
- * @return On success, the number of bytes received. On failure return
- * either -ENOSYS, to request that this handler be called again from the
- * opposite realtime/non-realtime context, or another negative error code.
- *
- * @see @c recvmsg() in IEEE Std 1003.1,
- * http://www.opengroup.org/onlinepubs/009695399 */
-typedef ssize_t (*rtdm_recvmsg_handler_t)(struct rtdm_dev_context *context,
-					  rtdm_user_info_t *user_info,
-					  struct msghdr *msg, int flags);
-
-/**
- * Transmit message handler
- *
- * @param[in] context Context structure associated with opened device instance
- * @param[in] user_info Opaque pointer to information about user mode caller,
- * NULL if kernel mode call
- * @param[in] msg Message descriptor as passed by the user, automatically
- * mirrored to safe kernel memory in case of user mode call
- * @param[in] flags Message flags as passed by the user
- *
- * @return On success, the number of bytes transmitted. On failure return
- * either -ENOSYS, to request that this handler be called again from the
- * opposite realtime/non-realtime context, or another negative error code.
- *
- * @see @c sendmsg() in IEEE Std 1003.1,
- * http://www.opengroup.org/onlinepubs/009695399 */
-typedef ssize_t (*rtdm_sendmsg_handler_t)(struct rtdm_dev_context *context,
-					  rtdm_user_info_t *user_info,
-					  const struct msghdr *msg, int flags);
 /** @} Operation Handler Prototypes */
 
-typedef int (*rtdm_rt_handler_t)(struct rtdm_dev_context *context,
-				 rtdm_user_info_t *user_info, void *arg);
-/**
- * Device operations
- */
-struct rtdm_operations {
-	/*! @name Common Operations
-	 * @{ */
-	/** Close handler for real-time contexts (optional, deprecated)
-	 *  @deprecated Only use non-real-time close handler in new drivers. */
-	rtdm_close_handler_t close_rt;
-	/** Close handler for non-real-time contexts (required) */
-	rtdm_close_handler_t close_nrt;
-
-	/** IOCTL from real-time context (optional) */
-	rtdm_ioctl_handler_t ioctl_rt;
-	/** IOCTL from non-real-time context (optional) */
-	rtdm_ioctl_handler_t ioctl_nrt;
-
-	/** Select binding handler for any context (optional) */
-	rtdm_select_bind_handler_t select_bind;
-	/** @} Common Operations */
-
-	/*! @name Stream-Oriented Device Operations
-	 * @{ */
-	/** Read handler for real-time context (optional) */
-	rtdm_read_handler_t read_rt;
-	/** Read handler for non-real-time context (optional) */
-	rtdm_read_handler_t read_nrt;
-
-	/** Write handler for real-time context (optional) */
-	rtdm_write_handler_t write_rt;
-	/** Write handler for non-real-time context (optional) */
-	rtdm_write_handler_t write_nrt;
-	/** @} Stream-Oriented Device Operations */
-
-	/*! @name Message-Oriented Device Operations
-	 * @{ */
-	/** Receive message handler for real-time context (optional) */
-	rtdm_recvmsg_handler_t recvmsg_rt;
-	/** Receive message handler for non-real-time context (optional) */
-	rtdm_recvmsg_handler_t recvmsg_nrt;
-
-	/** Transmit message handler for real-time context (optional) */
-	rtdm_sendmsg_handler_t sendmsg_rt;
-	/** Transmit message handler for non-real-time context (optional) */
-	rtdm_sendmsg_handler_t sendmsg_nrt;
-	/** @} Message-Oriented Device Operations */
-};
-
 struct rtdm_process;
 
 struct rtdm_devctx_reserved {
 	struct rtdm_process *owner;
-	struct list_head cleanup;
+	void (*close)(struct rtdm_fd *fd);
 };
 
 /**
@@ -393,19 +185,9 @@ struct rtdm_devctx_reserved {
  * device registration.
  */
 struct rtdm_dev_context {
-	/** Context flags, see @ref ctx_flags "Context Flags" for details */
-	unsigned long context_flags;
-
-	/** Associated file descriptor */
-	int fd;
-
-	/** Lock counter of context, held while structure is referenced by an
-	 *  operation handler */
-	atomic_t close_lock_count;
+	struct rtdm_fd fd;
 
 	/** Set of active device operation handlers */
-	struct rtdm_operations *ops;
-
 	/** Reference to owning device */
 	struct rtdm_device *device;
 
@@ -416,6 +198,11 @@ struct rtdm_dev_context {
 	char dev_private[0];
 };
 
+static inline struct rtdm_dev_context *rtdm_context(struct rtdm_fd *fd)
+{
+	return container_of(fd, struct rtdm_dev_context, fd);
+}
+
 /**
  * Locate the driver private area associated to a device context structure
  *
@@ -425,9 +212,9 @@ struct rtdm_dev_context {
  * context.
  */
 static inline void *
-rtdm_context_to_private(struct rtdm_dev_context *context)
+rtdm_context_to_private(struct rtdm_fd *context)
 {
-	return (void *)context->dev_private;
+	return (void *)rtdm_context(context)->dev_private;
 }
 
 /**
@@ -438,10 +225,22 @@ rtdm_context_to_private(struct rtdm_dev_context *context)
  * @return The address of the device context structure defining @a
  * dev_private.
  */
-static inline struct rtdm_dev_context *
+static inline struct rtdm_fd *
 rtdm_private_to_context(void *dev_private)
 {
-	return container_of(dev_private, struct rtdm_dev_context, dev_private);
+	struct rtdm_dev_context *ctx;
+	ctx = container_of(dev_private, struct rtdm_dev_context, dev_private);
+	return &ctx->fd;
+}
+
+static inline bool rtdm_context_user_p(struct rtdm_fd *context)
+{
+	return rtdm_fd_owner(context) != &__xnsys_global_ppd;
+}
+
+static inline struct rtdm_device *rtdm_context_device(struct rtdm_fd *context)
+{
+	return rtdm_context(context)->device;
 }
 
 struct rtdm_dev_reserved {
@@ -455,6 +254,7 @@ struct rtdm_dev_reserved {
 	};
 	atomic_t refcount;
 	struct rtdm_dev_context *exclusive_context;
+	void (*close)(struct rtdm_fd *);
 };
 
 /**
@@ -489,23 +289,17 @@ struct rtdm_device {
 	 *  optional (but deprecated) if open_nrt is non-NULL, ignored for
 	 *  protocol devices
 	 *  @deprecated Only use non-real-time open handler in new drivers. */
-	rtdm_open_handler_t open_rt;
-	/** Named device instance creation for non-real-time contexts,
-	 *  optional if open_rt is non-NULL, ignored for protocol devices */
-	rtdm_open_handler_t open_nrt;
+	rtdm_open_handler_t open;
 
 	/** Protocol socket creation for real-time contexts,
 	 *  optional (but deprecated) if socket_nrt is non-NULL, ignored for
 	 *  named devices
 	 *  @deprecated Only use non-real-time socket creation handler in new
 	 *  drivers. */
-	rtdm_socket_handler_t socket_rt;
-	/** Protocol socket creation for non-real-time contexts,
-	 *  optional if socket_rt is non-NULL, ignored for named devices */
-	rtdm_socket_handler_t socket_nrt;
+	rtdm_socket_handler_t socket;
 
 	/** Default operations on newly opened device instance */
-	struct rtdm_operations ops;
+	struct rtdm_fd_ops ops;
 
 	/** Device class ID, see @ref RTDM_CLASS_xxx */
 	int device_class;
@@ -567,36 +361,16 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay);
 #define rtdm_getpeername	rt_dev_getpeername
 #define rtdm_shutdown		rt_dev_shutdown
 
-struct rtdm_dev_context *rtdm_context_get(int fd);
-
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 
-#define CONTEXT_IS_LOCKED(context) \
-	(atomic_read(&(context)->close_lock_count) > 1 || \
-	 (test_bit(RTDM_CLOSING, &(context)->context_flags) && \
-	  atomic_read(&(context)->close_lock_count) > 0))
-
-static inline void rtdm_context_lock(struct rtdm_dev_context *context)
-{
-	/* just warn if context was a dangling pointer */
-	XENO_ASSERT(RTDM, CONTEXT_IS_LOCKED(context));
-	atomic_inc(&context->close_lock_count);
-}
-
-extern int rtdm_apc;
-
-static inline void rtdm_context_unlock(struct rtdm_dev_context *context)
+static inline int rtdm_context_lock(struct rtdm_fd *context)
 {
-	/* just warn if context was a dangling pointer */
-	XENO_ASSERT(RTDM, CONTEXT_IS_LOCKED(context));
-	smp_mb__before_atomic_dec();
-	if (unlikely(atomic_dec_and_test(&context->close_lock_count)))
-		xnapc_schedule(rtdm_apc);
+	return rtdm_fd_lock(context);
 }
 
-static inline void rtdm_context_put(struct rtdm_dev_context *context)
+static inline void rtdm_context_unlock(struct rtdm_fd *context)
 {
-	rtdm_context_unlock(context);
+	rtdm_fd_unlock(context);
 }
 
 /* --- clock services --- */
@@ -611,14 +385,6 @@ static inline nanosecs_abs_t rtdm_clock_read_monotonic(void)
 }
 #endif /* !DOXYGEN_CPP */
 
-/*!
- * @addtogroup rtdmsync
- * @{
- */
-
-int rtdm_select_bind(int fd, rtdm_selector_t *selector,
-		     enum rtdm_selecttype type, unsigned fd_index);
-
 /* --- spin lock services --- */
 /*!
  * @name Global Lock across Scheduler Invocation
@@ -1309,38 +1075,38 @@ static inline void rtdm_free(void *ptr)
 	xnfree(ptr);
 }
 
-int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
+int rtdm_mmap_to_user(struct rtdm_fd *context,
 		      void *src_addr, size_t len,
 		      int prot, void **pptr,
 		      struct vm_operations_struct *vm_ops,
 		      void *vm_private_data);
-int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
+int rtdm_iomap_to_user(struct rtdm_fd *context,
 		       phys_addr_t src_addr, size_t len,
 		       int prot, void **pptr,
 		       struct vm_operations_struct *vm_ops,
 		       void *vm_private_data);
-int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
+int rtdm_munmap(struct rtdm_fd *context, void *ptr, size_t len);
 
-static inline int rtdm_read_user_ok(rtdm_user_info_t *user_info,
+static inline int rtdm_read_user_ok(struct rtdm_fd *context,
 				    const void __user *ptr, size_t size)
 {
 	return access_rok(ptr, size);
 }
 
-static inline int rtdm_rw_user_ok(rtdm_user_info_t *user_info,
+static inline int rtdm_rw_user_ok(struct rtdm_fd *context,
 				  const void __user *ptr, size_t size)
 {
 	return access_wok(ptr, size);
 }
 
-static inline int rtdm_copy_from_user(rtdm_user_info_t *user_info,
+static inline int rtdm_copy_from_user(struct rtdm_fd *context,
 				      void *dst, const void __user *src,
 				      size_t size)
 {
 	return __xn_copy_from_user(dst, src, size) ? -EFAULT : 0;
 }
 
-static inline int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info,
+static inline int rtdm_safe_copy_from_user(struct rtdm_fd *context,
 					   void *dst, const void __user *src,
 					   size_t size)
 {
@@ -1348,14 +1114,14 @@ static inline int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info,
 		__xn_copy_from_user(dst, src, size)) ? -EFAULT : 0;
 }
 
-static inline int rtdm_copy_to_user(rtdm_user_info_t *user_info,
+static inline int rtdm_copy_to_user(struct rtdm_fd *context,
 				    void __user *dst, const void *src,
 				    size_t size)
 {
 	return __xn_copy_to_user(dst, src, size) ? -EFAULT : 0;
 }
 
-static inline int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info,
+static inline int rtdm_safe_copy_to_user(struct rtdm_fd *context,
 					 void __user *dst, const void *src,
 					 size_t size)
 {
@@ -1363,7 +1129,7 @@ static inline int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info,
 		__xn_copy_to_user(dst, src, size)) ? -EFAULT : 0;
 }
 
-static inline int rtdm_strncpy_from_user(rtdm_user_info_t *user_info,
+static inline int rtdm_strncpy_from_user(struct rtdm_fd *context,
 					 char *dst,
 					 const char __user *src, size_t count)
 {
@@ -1372,13 +1138,15 @@ static inline int rtdm_strncpy_from_user(rtdm_user_info_t *user_info,
 	return __xn_strncpy_from_user(dst, src, count);
 }
 
-static inline int rtdm_rt_capable(rtdm_user_info_t *user_info)
+static inline int rtdm_rt_capable(struct rtdm_fd *context)
 {
 	if (!XENO_ASSERT(RTDM, !xnsched_interrupt_p()))
 		return 0;
 
-	return (user_info ? xnshadow_thread(user_info) != NULL
-			  : !xnsched_root_p());
+	if (rtdm_fd_owner(context) == &__xnsys_global_ppd)
+		return !xnsched_root_p();
+
+	return xnshadow_thread(current) != NULL;
 }
 
 static inline int rtdm_in_rt_context(void)
@@ -1388,8 +1156,4 @@ static inline int rtdm_in_rt_context(void)
 
 #endif /* !DOXYGEN_CPP */
 
-int rtdm_exec_in_rt(struct rtdm_dev_context *context,
-		    rtdm_user_info_t *user_info, void *arg,
-		    rtdm_rt_handler_t handler);
-
 #endif /* _COBALT_RTDM_DRIVER_H */
diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
new file mode 100644
index 0000000..889c27a
--- /dev/null
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -0,0 +1,186 @@
+/*
+ * Copyright (C) 2005-2007 Jan Kiszka <jan.kiszka@web.de>
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@gmx.net>
+ * Copyright (C) 2008,2013,2014 Gilles Chanteperdrix <gch@xenomai.org>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef _COBALT_KERNEL_FD_H
+#define _COBALT_KERNEL_FD_H
+
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <cobalt/kernel/tree.h>
+
+struct rtdm_fd;
+struct xnselector;
+struct xnsys_ppd;
+
+/**
+ * IOCTL handler
+ *
+ * @param[in] fd File descriptor structure associated with opened device instance
+ * @param[in] request Request number as passed by the user
+ * @param[in,out] arg Request argument as passed by the user
+ *
+ * @return A positive value or 0 on success. On failure return either
+ * -ENOSYS, to request that the function be called again from the opposite
+ * realtime/non-realtime context, or another negative error code.
+ *
+ * @see @c ioctl() in IEEE Std 1003.1,
+ * http://www.opengroup.org/onlinepubs/009695399 
+ */
+typedef int rtdm_fd_ioctl_t(struct rtdm_fd *fd, unsigned int request, void __user *arg);
+
+/**
+ * Read handler
+ *
+ * @param[in] fd File descriptor structure associated with opened device instance
+ * @param[out] buf Input buffer as passed by the user
+ * @param[in] size Number of bytes the user requests to read
+ *
+ * @return On success, the number of bytes read. On failure return either
+ * -ENOSYS, to request that this handler be called again from the opposite
+ * realtime/non-realtime context, or another negative error code.
+ *
+ * @see @c read() in IEEE Std 1003.1,
+ * http://www.opengroup.org/onlinepubs/009695399 
+ */
+typedef ssize_t rtdm_fd_read_t(struct rtdm_fd *fd, void __user *buf, size_t size);
+
+/**
+ * Write handler
+ *
+ * @param[in] fd File descriptor structure associated with opened device instance
+ * @param[in] buf Output buffer as passed by the user
+ * @param[in] size Number of bytes the user requests to write
+ *
+ * @return On success, the number of bytes written. On failure return
+ * either -ENOSYS, to request that this handler be called again from the
+ * opposite realtime/non-realtime context, or another negative error code.
+ *
+ * @see @c write() in IEEE Std 1003.1,
+ * http://www.opengroup.org/onlinepubs/009695399 
+ */
+typedef ssize_t rtdm_fd_write_t(struct rtdm_fd *fd, const void __user *buf, size_t size);
+
+/**
+ * Receive message handler
+ *
+ * @param[in] fd File descriptor structure associated with opened device instance
+ * @param[in,out] msg Message descriptor as passed by the user, automatically
+ * mirrored to safe kernel memory in case of user mode call
+ * @param[in] flags Message flags as passed by the user
+ *
+ * @return On success, the number of bytes received. On failure return
+ * either -ENOSYS, to request that this handler be called again from the
+ * opposite realtime/non-realtime context, or another negative error code.
+ *
+ * @see @c recvmsg() in IEEE Std 1003.1,
+ * http://www.opengroup.org/onlinepubs/009695399 
+ */
+typedef ssize_t rtdm_fd_recvmsg_t(struct rtdm_fd *fd, struct msghdr *msg, int flags);
+
+/**
+ * Transmit message handler
+ *
+ * @param[in] fd File descriptor structure associated with opened device instance
+ * @param[in] user_info Opaque pointer to information about user mode caller,
+ * NULL if kernel mode call
+ * @param[in] msg Message descriptor as passed by the user, automatically
+ * mirrored to safe kernel memory in case of user mode call
+ * @param[in] flags Message flags as passed by the user
+ *
+ * @return On success, the number of bytes transmitted. On failure return
+ * either -ENOSYS, to request that this handler be called again from the
+ * opposite realtime/non-realtime context, or another negative error code.
+ *
+ * @see @c sendmsg() in IEEE Std 1003.1,
+ * http://www.opengroup.org/onlinepubs/009695399 
+ */
+typedef ssize_t rtdm_fd_sendmsg_t(struct rtdm_fd *fd, const struct msghdr *msg, int flags);
+
+struct rtdm_fd_ops {
+	rtdm_fd_ioctl_t *ioctl_rt;
+	rtdm_fd_ioctl_t *ioctl_nrt;
+	rtdm_fd_read_t *read_rt;
+	rtdm_fd_read_t *read_nrt;
+	rtdm_fd_write_t *write_rt;
+	rtdm_fd_write_t *write_nrt;
+	rtdm_fd_recvmsg_t *recvmsg_rt;
+	rtdm_fd_recvmsg_t *recvmsg_nrt;
+	rtdm_fd_sendmsg_t *sendmsg_rt;
+	rtdm_fd_sendmsg_t *sendmsg_nrt;
+	int (*select_bind)(struct rtdm_fd *fd, struct xnselector *selector,
+			unsigned type, unsigned index);
+	void (*close)(struct rtdm_fd *fd);
+};
+
+struct rtdm_fd {
+	unsigned magic;
+	struct rtdm_fd_ops *ops;
+	struct xnsys_ppd *cont;
+	unsigned refs;
+	struct list_head cleanup;
+};
+
+struct rtdm_fd_index {
+	struct xnid id;
+	struct rtdm_fd *fd;
+};	
+
+#define XNFD_MAGIC_ANY 0
+
+static inline struct xnsys_ppd *rtdm_fd_owner(struct rtdm_fd *fd)
+{
+	return fd->cont;
+}
+
+int rtdm_fd_enter(struct xnsys_ppd *p, struct rtdm_fd *rtdm_fd, int ufd, 
+	unsigned magic, struct rtdm_fd_ops *ops);
+
+struct rtdm_fd *rtdm_fd_get(struct xnsys_ppd *p, int ufd, unsigned magic);
+
+int rtdm_fd_lock(struct rtdm_fd *fd);
+
+void rtdm_fd_put(struct rtdm_fd *fd);
+
+void rtdm_fd_unlock(struct rtdm_fd *fd);
+
+int rtdm_fd_ioctl(struct xnsys_ppd *p, int fd, unsigned request, ...);
+
+ssize_t rtdm_fd_read(struct xnsys_ppd *p, int fd, void __user *buf, size_t size);
+
+ssize_t 
+rtdm_fd_write(struct xnsys_ppd *p, int fd, const void __user *buf, size_t size);
+
+int rtdm_fd_close(struct xnsys_ppd *p, int fd, unsigned magic);
+
+ssize_t 
+rtdm_fd_recvmsg(struct xnsys_ppd *p, int fd, struct msghdr *msg, int flags);
+
+ssize_t 
+rtdm_fd_sendmsg(struct xnsys_ppd *p, int fd, const struct msghdr *msg, int flags);
+
+int rtdm_fd_valid_p(int ufd);
+
+int rtdm_fd_select_bind(int ufd, struct xnselector *selector, unsigned type);
+
+void rtdm_fd_cleanup(struct xnsys_ppd *p);
+
+void rtdm_fd_init(void);
+
+#endif /* _COBALT_KERNEL_FD_H */
diff --git a/include/cobalt/kernel/rtdm/rtdm.h b/include/cobalt/kernel/rtdm/rtdm.h
index f90ecf0..51de97b 100644
--- a/include/cobalt/kernel/rtdm/rtdm.h
+++ b/include/cobalt/kernel/rtdm/rtdm.h
@@ -25,36 +25,20 @@
 #include <linux/ioctl.h>
 #include <linux/sched.h>
 #include <linux/socket.h>
+#include <cobalt/kernel/ppd.h>
+
+#define RTDM_FD_MAGIC 0x52544446
 
 typedef u32 socklen_t;
 typedef struct task_struct rtdm_user_info_t;
 
-int __rt_dev_open(rtdm_user_info_t *user_info,
-		  const char *path, int oflag);
-
-int __rt_dev_socket(rtdm_user_info_t *user_info,
-		    int protocol_family,
-		    int socket_type, int protocol);
-
-int __rt_dev_close(rtdm_user_info_t *user_info,
-		   int fd);
-
-int __rt_dev_ioctl(rtdm_user_info_t *user_info,
-		   int fd, int request, ...);
-
-ssize_t __rt_dev_read(rtdm_user_info_t *user_info,
-		      int fd, void *buf,
-		      size_t nbyte);
-
-ssize_t __rt_dev_write(rtdm_user_info_t *user_info,
-		       int fd, const void *buf,
-		       size_t nbyte);
+int __rt_dev_open(struct xnsys_ppd *p, int ufd, const char *path, int oflag);
 
-ssize_t __rt_dev_recvmsg(rtdm_user_info_t *user_info,
-			 int fd, struct msghdr *msg, int flags);
+int __rt_dev_socket(struct xnsys_ppd *p, int ufd, 
+		int protocol_family, int socket_type, int protocol);
 
-ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info,
-			 int fd, const struct msghdr *msg, int flags);
+int 
+__rt_dev_ioctl_fallback(struct rtdm_fd *fd, unsigned request, void __user *arg);
 
 /*
  * Define RTDM_NO_DEFAULT_USER_API to switch off the default
@@ -63,28 +47,28 @@ ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info,
 #ifndef RTDM_NO_DEFAULT_USER_API
 
 #define rt_dev_open(path, oflag, ...)				\
-	__rt_dev_open(NULL, path, oflag)
+	__rt_dev_open(&__xnsys_global_ppd, -1, path, oflag)
 
 #define rt_dev_socket(protocol_family, socket_type, protocol)	\
-	__rt_dev_socket(NULL, protocol_family, socket_type, protocol)
+	__rt_dev_socket(&__xnsys_global_ppd, -1, protocol_family, socket_type, protocol)
 
 #define rt_dev_close(fd)					\
-	__rt_dev_close(NULL, fd)
+	rtdm_fd_close(&__xnsys_global_ppd, fd, RTDM_FD_MAGIC)
 
 #define rt_dev_ioctl(fd, request, ...)				\
-	__rt_dev_ioctl(NULL, fd, request, __VA_ARGS__)
+	rtdm_fd_ioctl(&__xnsys_global_ppd, fd, request, __VA_ARGS__)
 
 #define rt_dev_read(fd, buf, nbyte)				\
-	__rt_dev_read(NULL, fd, buf, nbyte)
+	rtdm_fd_read(&__xnsys_global_ppd, fd, buf, nbyte)
 
 #define rt_dev_write(fd, buf, nbyte)				\
-	__rt_dev_write(NULL, fd, buf, nbyte)
+	rtdm_fd_write(&__xnsys_global_ppd, fd, buf, nbyte)
 
 #define rt_dev_recvmsg(fd, msg, flags)				\
-	__rt_dev_recvmsg(NULL, fd, msg, flags)
+	rtdm_fd_recvmsg(&__xnsys_global_ppd, fd, msg, flags)
 
 #define rt_dev_sendmsg(fd, msg, flags)				\
-	__rt_dev_sendmsg(NULL, fd, msg, flags)
+	rtdm_fd_sendmsg(&__xnsys_global_ppd, fd, msg, flags)
 
 static inline
 ssize_t rt_dev_recvfrom(int fd, void *buf, size_t len, int flags,
diff --git a/include/cobalt/uapi/rtdm/syscall.h b/include/cobalt/uapi/rtdm/syscall.h
index d6e161b..bfcdfb4 100644
--- a/include/cobalt/uapi/rtdm/syscall.h
+++ b/include/cobalt/uapi/rtdm/syscall.h
@@ -21,14 +21,13 @@
 
 #define RTDM_BINDING_MAGIC	0x5254444D
 
-#define sc_rtdm_fdcount		0
-#define sc_rtdm_open		1
-#define sc_rtdm_socket		2
-#define sc_rtdm_close		3
-#define sc_rtdm_ioctl		4
-#define sc_rtdm_read		5
-#define sc_rtdm_write		6
-#define sc_rtdm_recvmsg		7
-#define sc_rtdm_sendmsg		8
+#define sc_rtdm_open		0
+#define sc_rtdm_socket		1
+#define sc_rtdm_close		2
+#define sc_rtdm_ioctl		3
+#define sc_rtdm_read		4
+#define sc_rtdm_write		5
+#define sc_rtdm_recvmsg         6
+#define sc_rtdm_sendmsg         7
 
 #endif /* !_COBALT_UAPI_RTDM_SYSCALL_H */
diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 5436de6..ba4ffab 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -349,11 +349,9 @@ config XENO_OPT_RTDM_FILDES
 	default 128
 	help
 
-	This option defines the maximum number of RTDM file
-	descriptors which can be opened at the same time. RTDM file
-	descriptors are a global resource all applications share,
-	either via RTDM directly or via the embedded services of the
-	Cobalt API.
+	This option defines the maximum number of kernel-space RTDM
+	file descriptors which can be opened at the same time. RTDM
+	kernel-space file descriptors are a global resource.
 
 endmenu
 
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index 92de41d..af05ef1 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -33,6 +33,7 @@
 #include <cobalt/kernel/pipe.h>
 #include <cobalt/kernel/select.h>
 #include <cobalt/kernel/vdso.h>
+#include <rtdm/fd.h>
 #include "rtdm/internal.h"
 #include "posix/internal.h"
 #include "procfs.h"
@@ -420,6 +421,8 @@ static int __init xenomai_init(void)
 	if (ret)
 		goto cleanup_rtdm;
 
+	rtdm_fd_init();
+
 	printk(XENO_INFO "Cobalt v%s enabled%s\n",
 	       XENO_VERSION_STRING, boot_notice);
 
diff --git a/kernel/cobalt/posix/select.c b/kernel/cobalt/posix/select.c
index 6741331..e11b251 100644
--- a/kernel/cobalt/posix/select.c
+++ b/kernel/cobalt/posix/select.c
@@ -21,35 +21,14 @@
  */
 #include <linux/types.h>
 #include <linux/err.h>
+#include <cobalt/kernel/select.h>
 #include <rtdm/driver.h>
+#include <rtdm/fd.h>
 #include "internal.h"
 #include "clock.h"
 #include "mqueue.h"
 #include "select.h"
 
-#define RTDM_FD_MAX CONFIG_XENO_OPT_RTDM_FILDES
-
-static int fd_valid_p(int fd)
-{
-	const int rtdm_fd_start = __FD_SETSIZE - RTDM_FD_MAX;
-	struct rtdm_dev_context *ctx;
-	struct cobalt_process *cc;
-
-	if (fd >= rtdm_fd_start) {
-		ctx = rtdm_context_get(fd - rtdm_fd_start);
-		if (ctx == NULL)
-			return 0;
-		rtdm_context_unlock(ctx);
-		return 1;
-	}
-
-	cc = cobalt_process_context();
-	if (cc == NULL)
-		return 0;
-
-	return cobalt_assoc_lookup(&cc->uqds, fd) != NULL;
-}
-
 static int first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 {
 	int i, fd;
@@ -57,7 +36,7 @@ static int first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
 		if (fds[i]
 		    && (fd = find_first_bit(fds[i]->fds_bits, nfds)) < nfds)
-			return fd_valid_p(fd);
+			return rtdm_fd_valid_p(fd);
 
 	/* All empty is correct, used as a "sleep" mechanism by strange
 	   applications. */
@@ -66,23 +45,13 @@ static int first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 
 static int select_bind_one(struct xnselector *selector, unsigned type, int fd)
 {
-	const int rtdm_fd_start = __FD_SETSIZE - RTDM_FD_MAX;
-	struct cobalt_process *cc;
-	cobalt_assoc_t *assoc;
-
-	if (fd >= rtdm_fd_start)
-		return rtdm_select_bind(fd - rtdm_fd_start,
-					selector, type, fd);
-
-	cc = cobalt_process_context();
-	if (cc == NULL)
-		return -EPERM;
+	int rc;
 
-	assoc = cobalt_assoc_lookup(&cc->uqds, fd);
-	if (assoc == NULL)
-		return -EBADF;
+	rc = rtdm_fd_select_bind(fd, selector, type);
+	if (rc != -ENOENT)
+		return rc;
 
-	return cobalt_mq_select_bind(assoc2ufd(assoc)->kfd, selector, type, fd);
+	return -EBADF;
 }
 
 static int select_bind_all(struct xnselector *selector,
diff --git a/kernel/cobalt/rtdm/Makefile b/kernel/cobalt/rtdm/Makefile
index 0339ef1..51e7011 100644
--- a/kernel/cobalt/rtdm/Makefile
+++ b/kernel/cobalt/rtdm/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_XENOMAI) += rtdm.o
 rtdm-y :=	core.o		\
 		device.o	\
 		drvlib.o	\
+		fd.o		\
 		init.o		\
 		syscall.o
 
diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index b4f2a81..a673fca 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -37,96 +37,73 @@
 #define CLOSURE_RETRY_PERIOD_MS	100
 
 #define FD_BITMAP_SIZE  ((RTDM_FD_MAX + BITS_PER_LONG-1) / BITS_PER_LONG)
-
-struct rtdm_fildes fildes_table[RTDM_FD_MAX] =
-	{ [0 ... RTDM_FD_MAX-1] = { NULL } };
 static unsigned long used_fildes[FD_BITMAP_SIZE];
-int open_fildes;	/* number of used descriptors */
-
-static void close_callback(struct work_struct *work);
-static DECLARE_DELAYED_WORK(close_work, close_callback);
-static LIST_HEAD(cleanup_queue);
+int open_fildes;       /* number of used descriptors */
 
 DEFINE_XNLOCK(rt_fildes_lock);
 
-/**
- * @brief Retrieve and lock a device context
- *
- * @param[in] fd File descriptor
- *
- * @return Pointer to associated device context, or NULL on error
- *
- * @note The device context has to be unlocked using rtdm_context_put() when
- * it is no longer referenced.
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
+static void cleanup_instance(struct rtdm_device *device,
+			     struct rtdm_dev_context *context)
 {
-	struct rtdm_dev_context *context;
-	spl_t s;
-
-	if ((unsigned int)fd >= RTDM_FD_MAX)
-		return NULL;
-
-	xnlock_get_irqsave(&rt_fildes_lock, s);
-
-	context = fildes_table[fd].context;
-	if (unlikely(!context)) {
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
-		return NULL;
+	if (context) {
+		if (device->reserved.exclusive_context)
+			context->device = NULL;
+		else
+			kfree(context);
 	}
 
-	atomic_inc(&context->close_lock_count);
-
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
+	rtdm_dereference_device(device);
+}
 
-	return context;
+void __rt_dev_close(struct rtdm_fd *fd)
+{
+	struct rtdm_dev_context *context = rtdm_context(fd);
+	context->reserved.close(fd);
+	cleanup_instance(context->device, context);
 }
 
-EXPORT_SYMBOL_GPL(rtdm_context_get);
+void __rt_dev_unref(struct rtdm_fd *fd, unsigned idx)
+{
+	if (fd->magic != RTDM_FD_MAGIC)
+		return;
+
+	xnlock_get(&rt_fildes_lock);
+	if (rtdm_fd_owner(fd) == &__xnsys_global_ppd) {
+		clear_bit(idx, used_fildes);
+		--open_fildes;
+	}
+	xnlock_put(&rt_fildes_lock);
+}
 
-static int create_instance(struct rtdm_device *device,
-			   struct rtdm_dev_context **context_ptr,
-			   struct rtdm_fildes **fildes_ptr,
-			   rtdm_user_info_t *user_info, int nrt_mem)
+static int create_instance(struct xnsys_ppd *p, int fd, 
+			struct rtdm_device *device,
+			struct rtdm_dev_context **context_ptr)
 {
 	struct rtdm_dev_context *context;
 	spl_t s;
-	int fd;
+	int err;
 
 	/*
 	 * Reset to NULL so that we can always use cleanup_files/instance to
 	 * revert also partially successful allocations.
 	 */
 	*context_ptr = NULL;
-	*fildes_ptr = NULL;
 
-	/* Reserve a file descriptor */
-	xnlock_get_irqsave(&rt_fildes_lock, s);
+	if (p == &__xnsys_global_ppd) {
+		xnlock_get_irqsave(&rt_fildes_lock, s);
+
+		if (unlikely(open_fildes >= RTDM_FD_MAX)) {
+			xnlock_put_irqrestore(&rt_fildes_lock, s);
+			return -ENFILE;
+		}
 
-	if (unlikely(open_fildes >= RTDM_FD_MAX)) {
+		fd = find_first_zero_bit(used_fildes, RTDM_FD_MAX);
+		__set_bit(fd, used_fildes);
+		open_fildes++;
+		
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
-		return -ENFILE;
 	}
 
-	fd = find_first_zero_bit(used_fildes, RTDM_FD_MAX);
-	__set_bit(fd, used_fildes);
-	open_fildes++;
-
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-	*fildes_ptr = &fildes_table[fd];
-
 	context = device->reserved.exclusive_context;
 	if (context) {
 		xnlock_get_irqsave(&rt_dev_lock, s);
@@ -135,151 +112,53 @@ static int create_instance(struct rtdm_device *device,
 			xnlock_put_irqrestore(&rt_dev_lock, s);
 			return -EBUSY;
 		}
+
 		context->device = device;
 
 		xnlock_put_irqrestore(&rt_dev_lock, s);
 	} else {
-		if (nrt_mem)
-			context = kmalloc(sizeof(struct rtdm_dev_context) +
-					  device->context_size, GFP_KERNEL);
-		else
-			context = xnmalloc(sizeof(struct rtdm_dev_context) +
-					   device->context_size);
-		if (unlikely(!context))
+		context = kmalloc(sizeof(struct rtdm_dev_context) + 
+				device->context_size, GFP_KERNEL);
+		if (unlikely(context == NULL))
 			return -ENOMEM;
 
 		context->device = device;
 	}
 
-	*context_ptr = context;
-
-	context->fd = fd;
-	context->ops = &device->ops;
-	atomic_set(&context->close_lock_count, 1);
-
-	context->reserved.owner = xnshadow_private_get(__rtdm_muxid);
-	INIT_LIST_HEAD(&context->reserved.cleanup);
-
-	return 0;
-}
-
-static void __cleanup_fildes(struct rtdm_fildes *fildes)
-{
-	__clear_bit((fildes - fildes_table), used_fildes);
-	fildes->context = NULL;
-	open_fildes--;
-}
-
-static void cleanup_fildes(struct rtdm_fildes *fildes)
-{
-	spl_t s;
-
-	if (!fildes)
-		return;
-
-	xnlock_get_irqsave(&rt_fildes_lock, s);
-	__cleanup_fildes(fildes);
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
-}
-
-static void cleanup_instance(struct rtdm_device *device,
-			     struct rtdm_dev_context *context,
-			     int nrt_mem)
-{
-	if (context) {
-		if (device->reserved.exclusive_context)
-			context->device = NULL;
-		else {
-			if (nrt_mem)
-				kfree(context);
-			else
-				xnfree(context);
-		}
-	}
-
-	rtdm_dereference_device(device);
-}
-
-static void close_callback(struct work_struct *work)
-{
-	struct rtdm_dev_context *context;
-	LIST_HEAD(deferred_list);
-	int reschedule = 0;
-	int err;
-	spl_t s;
-
-	xnlock_get_irqsave(&rt_fildes_lock, s);
-
-	while (!list_empty(&cleanup_queue)) {
-		context = list_first_entry(&cleanup_queue,
-					   struct rtdm_dev_context,
-					   reserved.cleanup);
-		list_del(&context->reserved.cleanup);
-		atomic_inc(&context->close_lock_count);
-
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-		err = context->ops->close_nrt(context, NULL);
-
-		if (err == -EAGAIN ||
-		    atomic_read(&context->close_lock_count) > 1) {
-			atomic_dec(&context->close_lock_count);
-			list_add_tail(&context->reserved.cleanup,
-				      &deferred_list);
-			if (err == -EAGAIN)
-				reschedule = 1;
-		} else {
-			trace_mark(xn_rtdm, fd_closed, "fd %d", context->fd);
-
-			cleanup_instance(context->device, context,
-					 test_bit(RTDM_CREATED_IN_NRT,
-						  &context->context_flags));
-		}
-
-		xnlock_get_irqsave(&rt_fildes_lock, s);
-	}
-
-	list_splice(&deferred_list, &cleanup_queue);
+	context->reserved.close = device->reserved.close;
+	if (p == &__xnsys_global_ppd)
+		context->reserved.owner = NULL;
+	else
+		context->reserved.owner = xnshadow_private_get(__rtdm_muxid);
 
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
+	err = rtdm_fd_enter(p, &context->fd, fd, RTDM_FD_MAGIC, &device->ops);
+	if (err < 0)
+		return err;
 
-	if (reschedule)
-		schedule_delayed_work(&close_work,
-				      (HZ * CLOSURE_RETRY_PERIOD_MS) / 1000);
-}
+	*context_ptr = context;
 
-void rtdm_apc_handler(void *cookie)
-{
-	schedule_delayed_work(&close_work, 0);
+	return fd;
 }
 
-
-int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
+int __rt_dev_open(struct xnsys_ppd *p, int ufd, const char *path, int oflag)
 {
 	struct rtdm_device *device;
-	struct rtdm_fildes *fildes;
 	struct rtdm_dev_context *context;
 	int ret;
-	int nrt_mode = !rtdm_in_rt_context();
 
 	device = get_named_device(path);
-	trace_mark(xn_rtdm, open, "user_info %p path %s oflag %d device %p",
-		   user_info, path, oflag, device);
+	trace_mark(xn_rtdm, open, "sys_ppd %p path %s oflag %d device %p",
+		   p, path, oflag, device);
 	ret = -ENODEV;
 	if (!device)
 		goto err_out;
 
-	ret = create_instance(device, &context, &fildes, user_info, nrt_mode);
-	if (ret != 0)
+	ret = create_instance(p, ufd, device, &context);
+	if (ret < 0)
 		goto cleanup_out;
+	ufd = ret;
 
-	if (nrt_mode) {
-		context->context_flags = (1 << RTDM_CREATED_IN_NRT);
-		ret = device->open_nrt(context, user_info, oflag);
-	} else {
-		context->context_flags = 0;
-		ret = device->open_rt(context, user_info, oflag);
-	}
+	ret = device->open(&context->fd, oflag);
 
 	if (!XENO_ASSERT(RTDM, !spltest()))
 		splnone();
@@ -287,51 +166,40 @@ int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 	if (unlikely(ret < 0))
 		goto cleanup_out;
 
-	fildes->context = context;
-
 	trace_mark(xn_rtdm, fd_created,
-		   "device %p fd %d", device, context->fd);
+		"device %p fd %d", device, rtdm_fd_index(&context->fd));
 
-	return context->fd;
+	return ufd;
 
 cleanup_out:
-	cleanup_fildes(fildes);
-	cleanup_instance(device, context, nrt_mode);
+	cleanup_instance(device, context);
 
 err_out:
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(__rt_dev_open);
 
-int __rt_dev_socket(rtdm_user_info_t *user_info, int protocol_family,
+int __rt_dev_socket(struct xnsys_ppd *p, int ufd, int protocol_family,
 		    int socket_type, int protocol)
 {
 	struct rtdm_device *device;
-	struct rtdm_fildes *fildes;
 	struct rtdm_dev_context *context;
 	int ret;
-	int nrt_mode = !rtdm_in_rt_context();
 
 	device = get_protocol_device(protocol_family, socket_type);
-	trace_mark(xn_rtdm, socket, "user_info %p protocol_family %d "
+	trace_mark(xn_rtdm, socket, "sys_ppd %p protocol_family %d "
 		   "socket_type %d protocol %d device %p",
-		   user_info, protocol_family, socket_type, protocol, device);
+		   p, protocol_family, socket_type, protocol, device);
 	ret = -EAFNOSUPPORT;
 	if (!device)
 		goto err_out;
 
-	ret = create_instance(device, &context, &fildes, user_info, nrt_mode);
-	if (ret != 0)
+	ret = create_instance(p, ufd, device, &context);
+	if (ret < 0)
 		goto cleanup_out;
+	ufd = ret;
 
-	if (nrt_mode) {
-		context->context_flags = (1 << RTDM_CREATED_IN_NRT);
-		ret = device->socket_nrt(context, user_info, protocol);
-	} else {
-		context->context_flags = 0;
-		ret = device->socket_rt(context, user_info, protocol);
-	}
+	ret = device->socket(&context->fd, protocol);
 
 	if (!XENO_ASSERT(RTDM, !spltest()))
 		splnone();
@@ -339,302 +207,36 @@ int __rt_dev_socket(rtdm_user_info_t *user_info, int protocol_family,
 	if (unlikely(ret < 0))
 		goto cleanup_out;
 
-	fildes->context = context;
-
 	trace_mark(xn_rtdm, fd_created,
-		   "device %p fd %d", device, context->fd);
+		"device %p fd %d", device, rtdm_fd_index(&context->fd));
 
-	return context->fd;
+	return ufd;
 
 cleanup_out:
-	cleanup_fildes(fildes);
-	cleanup_instance(device, context, nrt_mode);
+	cleanup_instance(device, context);
 
 err_out:
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(__rt_dev_socket);
 
-int __rt_dev_close(rtdm_user_info_t *user_info, int fd)
-{
-	struct rtdm_dev_context *context;
-	spl_t s;
-	int ret;
-	int nrt_mode = !rtdm_in_rt_context();
-
-	trace_mark(xn_rtdm, close, "user_info %p fd %d", user_info, fd);
-
-	ret = -EBADF;
-	if (unlikely((unsigned int)fd >= RTDM_FD_MAX))
-		goto err_out;
-
-	xnlock_get_irqsave(&rt_fildes_lock, s);
-
-	context = fildes_table[fd].context;
-
-	if (unlikely(!context)) {
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
-		goto err_out;	/* -EBADF */
-	}
-
-	/* Avoid asymmetric close context by switching to nrt. */
-	if (unlikely(test_bit(RTDM_CREATED_IN_NRT, &context->context_flags)) &&
-	    !nrt_mode) {
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-		ret = -ENOSYS;
-		goto err_out;
-	}
-
-	set_bit(RTDM_CLOSING, &context->context_flags);
-	atomic_inc(&context->close_lock_count);
-
-	__cleanup_fildes(&fildes_table[fd]);
-
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-	if (nrt_mode)
-		ret = context->ops->close_nrt(context, user_info);
-	else
-		ret = context->ops->close_rt(context, user_info);
-
-	if (!XENO_ASSERT(RTDM, !spltest()))
-		splnone();
-
-	xnlock_get_irqsave(&rt_fildes_lock, s);
-
-	if (ret == -EAGAIN || atomic_read(&context->close_lock_count) > 2) {
-		atomic_dec(&context->close_lock_count);
-		list_add(&context->reserved.cleanup, &cleanup_queue);
-
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-		if (ret == -EAGAIN) {
-			xnapc_schedule(rtdm_apc);
-			ret = 0;
-		}
-		goto unlock_out;
-	}
-
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-	trace_mark(xn_rtdm, fd_closed, "fd %d", context->fd);
-
-	cleanup_instance(context->device, context,
-			 test_bit(RTDM_CREATED_IN_NRT,
-				  &context->context_flags));
-
-	return ret;
-
-unlock_out:
-	rtdm_context_unlock(context);
-
-err_out:
-	return ret;
-}
-
-EXPORT_SYMBOL_GPL(__rt_dev_close);
-
-void cleanup_process_files(struct rtdm_process *owner)
+int 
+__rt_dev_ioctl_fallback(struct rtdm_fd *fd, unsigned request, void __user *arg)
 {
-	struct rtdm_dev_context *context;
-	unsigned int fd;
-	int ret;
-	spl_t s;
-
-	for (fd = 0; fd < RTDM_FD_MAX; fd++) {
-		xnlock_get_irqsave(&rt_fildes_lock, s);
-
-		context = fildes_table[fd].context;
-		if (context && context->reserved.owner != owner)
-			context = NULL;
-
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
-
-		if (context) {
-			if (XENO_DEBUG(RTDM_APPL))
-				printk(XENO_INFO "closing RTDM file descriptor %d\n",
-				       fd);
-
-			ret = __rt_dev_close(NULL, fd);
-			XENO_ASSERT(RTDM, ret == 0 || ret == -EBADF);
-		}
-	}
+	struct rtdm_device *dev = rtdm_context(fd)->device;
+	struct rtdm_device_info dev_info;
+
+	if (fd->magic != RTDM_FD_MAGIC || request != RTIOC_DEVICE_INFO)
+		return -ENOSYS;
+	
+	dev_info.device_flags = dev->device_flags;
+	dev_info.device_class = dev->device_class;
+	dev_info.device_sub_class = dev->device_sub_class;
+	dev_info.profile_version = dev->profile_version;
+	
+	return rtdm_safe_copy_to_user(fd, arg, &dev_info,  sizeof(dev_info));
 }
 
-#define MAJOR_FUNCTION_WRAPPER_TH(operation, args...)			\
-do {									\
-	struct rtdm_dev_context *context;				\
-	struct rtdm_operations *ops;					\
-	int ret;							\
-									\
-	context = rtdm_context_get(fd);					\
-	ret = -EBADF;							\
-	if (unlikely(!context))						\
-		goto err_out;						\
-									\
-	ops = context->ops;						\
-									\
-	if (rtdm_in_rt_context())					\
-		ret = ops->operation##_rt(context, user_info, args);	\
-	else								\
-		ret = ops->operation##_nrt(context, user_info, args);	\
-									\
-	if (!XENO_ASSERT(RTDM, !spltest()))				\
-		    splnone();
-
-#define MAJOR_FUNCTION_WRAPPER_BH()					\
-	rtdm_context_unlock(context);					\
-									\
-err_out:								\
-	trace_mark(xn_rtdm, operation##_done, "result %d", ret);	\
-	return ret;							\
-} while (0)
-
-#define MAJOR_FUNCTION_WRAPPER(operation, args...)			\
-do {									\
-	MAJOR_FUNCTION_WRAPPER_TH(operation, args);			\
-	MAJOR_FUNCTION_WRAPPER_BH();					\
-} while (0)
-
-int __rt_dev_ioctl(rtdm_user_info_t *user_info, int fd, int request, ...)
-{
-	va_list args;
-	void __user *arg;
-
-	va_start(args, request);
-	arg = va_arg(args, void __user *);
-	va_end(args);
-
-	trace_mark(xn_rtdm, ioctl, "user_info %p fd %d request %d arg %p",
-		   user_info, fd, request, arg);
-
-	MAJOR_FUNCTION_WRAPPER_TH(ioctl, (unsigned int)request, arg);
-
-	if (unlikely(ret < 0) && (unsigned int)request == RTIOC_DEVICE_INFO) {
-		struct rtdm_device *dev = context->device;
-		struct rtdm_device_info dev_info;
-
-		dev_info.device_flags = dev->device_flags;
-		dev_info.device_class = dev->device_class;
-		dev_info.device_sub_class = dev->device_sub_class;
-		dev_info.profile_version = dev->profile_version;
-
-		ret = rtdm_safe_copy_to_user(user_info, arg, &dev_info,
-					     sizeof(dev_info));
-	}
-
-	MAJOR_FUNCTION_WRAPPER_BH();
-}
-
-EXPORT_SYMBOL_GPL(__rt_dev_ioctl);
-
-ssize_t __rt_dev_read(rtdm_user_info_t *user_info, int fd, void *buf,
-		      size_t nbyte)
-{
-	trace_mark(xn_rtdm, read, "user_info %p fd %d buf %p nbyte %zu",
-		   user_info, fd, buf, nbyte);
-	MAJOR_FUNCTION_WRAPPER(read, buf, nbyte);
-}
-
-EXPORT_SYMBOL_GPL(__rt_dev_read);
-
-ssize_t __rt_dev_write(rtdm_user_info_t *user_info, int fd, const void *buf,
-		       size_t nbyte)
-{
-	trace_mark(xn_rtdm, write, "user_info %p fd %d buf %p nbyte %zu",
-		   user_info, fd, buf, nbyte);
-	MAJOR_FUNCTION_WRAPPER(write, buf, nbyte);
-}
-
-EXPORT_SYMBOL_GPL(__rt_dev_write);
-
-ssize_t __rt_dev_recvmsg(rtdm_user_info_t *user_info, int fd,
-			 struct msghdr *msg, int flags)
-{
-	trace_mark(xn_rtdm, recvmsg, "user_info %p fd %d msg_name %p "
-		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
-		   "msg_control %p msg_controllen %zu msg_flags %d",
-		   user_info, fd, msg->msg_name, msg->msg_namelen,
-		   msg->msg_iov, msg->msg_iovlen, msg->msg_control,
-		   msg->msg_controllen, msg->msg_flags);
-	MAJOR_FUNCTION_WRAPPER(recvmsg, msg, flags);
-}
-
-EXPORT_SYMBOL_GPL(__rt_dev_recvmsg);
-
-ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info, int fd,
-			 const struct msghdr *msg, int flags)
-{
-	trace_mark(xn_rtdm, sendmsg, "user_info %p fd %d msg_name %p "
-		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
-		   "msg_control %p msg_controllen %zu msg_flags %d",
-		   user_info, fd, msg->msg_name, msg->msg_namelen,
-		   msg->msg_iov, msg->msg_iovlen, msg->msg_control,
-		   msg->msg_controllen, msg->msg_flags);
-	MAJOR_FUNCTION_WRAPPER(sendmsg, msg, flags);
-}
-
-EXPORT_SYMBOL_GPL(__rt_dev_sendmsg);
-
-/**
- * @brief Bind a selector to specified event types of a given file descriptor
- * @internal
- *
- * This function is invoked by higher RTOS layers implementing select-like
- * services. It shall not be called directly by RTDM drivers.
- *
- * @param[in] fd File descriptor to bind to
- * @param[in,out] selector Selector object that shall be bound to the given
- * event
- * @param[in] type Event type the caller is interested in
- * @param[in] fd_index Index in the file descriptor set of the caller
- *
- * @return 0 on success, otherwise:
- *
- * - -EBADF is returned if the file descriptor @a fd cannot be resolved.
- *
- * - -EINVAL is returned if @a type or @a fd_index are invalid.
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
-int rtdm_select_bind(int fd, rtdm_selector_t *selector,
-		     enum rtdm_selecttype type, unsigned fd_index)
-{
-	struct rtdm_dev_context *context;
-	struct rtdm_operations  *ops;
-	int ret;
-
-	context = rtdm_context_get(fd);
-
-	ret = -EBADF;
-	if (unlikely(!context))
-		goto err_out;
-
-	ops = context->ops;
-
-	ret = ops->select_bind(context, selector, type, fd_index);
-
-	if (!XENO_ASSERT(RTDM, !spltest()))
-		    splnone();
-
-	rtdm_context_unlock(context);
-
-  err_out:
-	return ret;
-}
-
-EXPORT_SYMBOL_GPL(rtdm_select_bind);
-
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 
 /**
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 299c788..25d5120 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -49,23 +49,21 @@
 struct list_head rtdm_named_devices;	/* hash table */
 struct rb_root rtdm_protocol_devices;
 
-int rtdm_apc;
-EXPORT_SYMBOL_GPL(rtdm_apc);
-
 struct semaphore nrt_dev_lock;
 DEFINE_XNLOCK(rt_dev_lock);
 
 int rtdm_initialised = 0;
 
+extern void __rt_dev_close(struct rtdm_fd *fd);
+
 int rtdm_no_support(void)
 {
 	return -ENOSYS;
 }
 
-int rtdm_select_bind_no_support(struct rtdm_dev_context *context,
+int rtdm_select_bind_no_support(struct rtdm_fd *fd,
 				struct xnselector *selector,
-				unsigned type,
-				unsigned index)
+				unsigned type, unsigned index)
 {
 	return -EBADF;
 }
@@ -190,30 +188,20 @@ int rtdm_dev_register(struct rtdm_device *device)
 	switch (device->device_flags & RTDM_DEVICE_TYPE_MASK) {
 	case RTDM_NAMED_DEVICE:
 		/* Sanity check: any open handler? */
-		if (!XENO_ASSERT(RTDM, ANY_HANDLER(*device, open))) {
+		if (device->open == NULL) {
 			printk(XENO_ERR "missing open handler for RTDM device\n");
 			return -EINVAL;
 		}
-		if (device->open_rt &&
-		    device->socket_rt != (void *)rtdm_no_support)
-			printk(XENO_ERR "RT open handler is deprecated, "
-			       "RTDM driver requires update\n");
-		SET_DEFAULT_OP_IF_NULL(*device, open);
-		SET_DEFAULT_OP(*device, socket);
+		device->socket = (typeof(device->socket))rtdm_no_support;
 		break;
 
 	case RTDM_PROTOCOL_DEVICE:
 		/* Sanity check: any socket handler? */
-		if (!XENO_ASSERT(RTDM, ANY_HANDLER(*device, socket))) {
+		if (device->socket == NULL) {
 			printk(XENO_ERR "missing socket handler for RTDM device\n");
 			return -EINVAL;
 		}
-		if (device->socket_rt &&
-		    device->socket_rt != (void *)rtdm_no_support)
-			printk(XENO_ERR "RT socket creation handler is "
-			       "deprecated, RTDM driver requires update\n");
-		SET_DEFAULT_OP_IF_NULL(*device, socket);
-		SET_DEFAULT_OP(*device, open);
+		device->open = (typeof(device->open))rtdm_no_support;
 		break;
 
 	default:
@@ -222,16 +210,12 @@ int rtdm_dev_register(struct rtdm_device *device)
 
 	/* Sanity check: non-RT close handler?
 	 * (Always required for forced cleanup) */
-	if (!device->ops.close_nrt) {
-		printk(XENO_ERR "missing non-RT close handler for RTDM device\n");
+	if (!device->ops.close) {
+		printk(XENO_ERR "missing close handler for RTDM device\n");
 		return -EINVAL;
 	}
-	if (device->ops.close_rt &&
-	    device->ops.close_rt != (void *)rtdm_no_support)
-		printk(XENO_ERR "RT close handler is deprecated, RTDM driver "
-		       "requires update\n");
-	else
-		device->ops.close_rt = (void *)rtdm_no_support;
+	device->reserved.close = device->ops.close;
+	device->ops.close = __rt_dev_close;
 
 	SET_DEFAULT_OP_IF_NULL(device->ops, ioctl);
 	SET_DEFAULT_OP_IF_NULL(device->ops, read);
@@ -386,7 +370,7 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
 
 		if (!__test_and_set_bit(0, &warned))
 			printk(XENO_WARN "RTDM device %s still in use - waiting for"
-			       "release...\n", reg_dev->device_name);
+			       " release...\n", reg_dev->device_name);
 		msleep(poll_delay);
 		trace_mark(xn_rtdm, dev_poll, "device %p", device);
 
@@ -423,11 +407,6 @@ int __init rtdm_dev_init(void)
 {
 	sema_init(&nrt_dev_lock, 1);
 
-	rtdm_apc = xnapc_alloc("deferred RTDM close", rtdm_apc_handler,
-				   NULL);
-	if (rtdm_apc < 0)
-		return rtdm_apc;
-
 	INIT_LIST_HEAD(&rtdm_named_devices);
 	xntree_init(&rtdm_protocol_devices);
 
@@ -440,7 +419,6 @@ void rtdm_dev_cleanup(void)
 	 * Note: no need to flush the cleanup_queue as no device is allowed
 	 * to deregister as long as there are references.
 	 */
-	xnapc_free(rtdm_apc);
 }
 
 /*@}*/
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 17178ee..3c1d5d5 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1884,7 +1884,7 @@ static struct file_operations rtdm_mmap_fops = {
 	.get_unmapped_area = rtdm_unmapped_area
 };
 
-static int rtdm_do_mmap(rtdm_user_info_t *user_info,
+static int rtdm_do_mmap(struct rtdm_fd *fd,
 			struct rtdm_mmap_data *mmap_data,
 			size_t len, int prot, void **pptr)
 {
@@ -1912,7 +1912,7 @@ static int rtdm_do_mmap(rtdm_user_info_t *user_info,
 	filp->f_op = (typeof(filp->f_op))old_fops;
 	filp->private_data = old_priv_data;
 
-	filp_close(filp, user_info->files);
+	filp_close(filp, current->files);
 
 	if (IS_ERR_VALUE(u_addr))
 		return (int)u_addr;
@@ -1976,7 +1976,7 @@ static int rtdm_do_mmap(rtdm_user_info_t *user_info,
  *
  * Rescheduling: possible.
  */
-int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
+int rtdm_mmap_to_user(struct rtdm_fd *fd,
 		      void *src_addr, size_t len,
 		      int prot, void **pptr,
 		      struct vm_operations_struct *vm_ops,
@@ -1989,7 +1989,7 @@ int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
 		.vm_private_data = vm_private_data
 	};
 
-	return rtdm_do_mmap(user_info, &mmap_data, len, prot, pptr);
+	return rtdm_do_mmap(fd, &mmap_data, len, prot, pptr);
 }
 
 EXPORT_SYMBOL_GPL(rtdm_mmap_to_user);
@@ -2044,7 +2044,7 @@ EXPORT_SYMBOL_GPL(rtdm_mmap_to_user);
  *
  * Rescheduling: possible.
  */
-int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
+int rtdm_iomap_to_user(struct rtdm_fd *fd,
 		       phys_addr_t src_addr, size_t len,
 		       int prot, void **pptr,
 		       struct vm_operations_struct *vm_ops,
@@ -2057,7 +2057,7 @@ int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
 		.vm_private_data = vm_private_data
 	};
 
-	return rtdm_do_mmap(user_info, &mmap_data, len, prot, pptr);
+	return rtdm_do_mmap(fd, &mmap_data, len, prot, pptr);
 }
 
 EXPORT_SYMBOL_GPL(rtdm_iomap_to_user);
@@ -2086,16 +2086,16 @@ EXPORT_SYMBOL_GPL(rtdm_iomap_to_user);
  *
  * Rescheduling: possible.
  */
-int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len)
+int rtdm_munmap(struct rtdm_fd *fd, void *ptr, size_t len)
 {
 	int err;
 
 	if (!XENO_ASSERT(RTDM, xnsched_root_p()))
 		return -EPERM;
 
-	down_write(&user_info->mm->mmap_sem);
-	err = do_munmap(user_info->mm, (unsigned long)ptr, len);
-	up_write(&user_info->mm->mmap_sem);
+	down_write(&current->mm->mmap_sem);
+	err = do_munmap(current->mm, (unsigned long)ptr, len);
+	up_write(&current->mm->mmap_sem);
 
 	return err;
 }
@@ -2263,7 +2263,7 @@ void rtdm_free(void *ptr);
  *
  * Rescheduling: never.
  */
-int rtdm_read_user_ok(rtdm_user_info_t *user_info, const void __user *ptr,
+int rtdm_read_user_ok(struct rtdm_fd *fd, const void __user *ptr,
 		      size_t size);
 
 /**
@@ -2287,7 +2287,7 @@ int rtdm_read_user_ok(rtdm_user_info_t *user_info, const void __user *ptr,
  *
  * Rescheduling: never.
  */
-int rtdm_rw_user_ok(rtdm_user_info_t *user_info, const void __user *ptr,
+int rtdm_rw_user_ok(struct rtdm_fd *fd, const void __user *ptr,
 		    size_t size);
 
 /**
@@ -2316,7 +2316,7 @@ int rtdm_rw_user_ok(rtdm_user_info_t *user_info, const void __user *ptr,
  *
  * Rescheduling: never.
  */
-int rtdm_copy_from_user(rtdm_user_info_t *user_info, void *dst,
+int rtdm_copy_from_user(struct rtdm_fd *fd, void *dst,
 			const void __user *src, size_t size);
 
 /**
@@ -2346,7 +2346,7 @@ int rtdm_copy_from_user(rtdm_user_info_t *user_info, void *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info, void *dst,
+int rtdm_safe_copy_from_user(struct rtdm_fd *fd, void *dst,
 			     const void __user *src, size_t size);
 
 /**
@@ -2375,7 +2375,7 @@ int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info, void *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
+int rtdm_copy_to_user(struct rtdm_fd *fd, void __user *dst,
 		      const void *src, size_t size);
 
 /**
@@ -2405,7 +2405,7 @@ int rtdm_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
+int rtdm_safe_copy_to_user(struct rtdm_fd *fd, void __user *dst,
 			   const void *src, size_t size);
 
 /**
@@ -2436,7 +2436,7 @@ int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_strncpy_from_user(rtdm_user_info_t *user_info, char *dst,
+int rtdm_strncpy_from_user(struct rtdm_fd *fd, char *dst,
 			   const char __user *src, size_t count);
 
 /**
@@ -2482,7 +2482,7 @@ int rtdm_in_rt_context(void);
  *
  * Rescheduling: never.
  */
-int rtdm_rt_capable(rtdm_user_info_t *user_info);
+int rtdm_rt_capable(struct rtdm_fd *fd);
 
 #endif /* DOXYGEN_CPP */
 
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
new file mode 100644
index 0000000..1125842
--- /dev/null
+++ b/kernel/cobalt/rtdm/fd.c
@@ -0,0 +1,541 @@
+/*
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka@web.de>
+ * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@gmx.net>
+ * Copyright (C) 2013,2014 Gilles Chanteperdrix <gch@xenomai.org>.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/kthread.h>
+#include <cobalt/kernel/registry.h>
+#include <cobalt/kernel/lock.h>
+#include <cobalt/kernel/ppd.h>
+#include <rtdm/fd.h>
+
+#ifdef CONFIG_SMP
+static DEFINE_XNLOCK(__rtdm_fd_lock);
+#endif
+static LIST_HEAD(rtdm_fd_cleanup_queue);
+static struct semaphore rtdm_fd_cleanup_sem;
+
+extern int 
+__rt_dev_ioctl_fallback(struct rtdm_fd *fd, unsigned request, void __user *arg);
+extern void __rt_dev_unref(struct rtdm_fd *fd, unsigned idx);
+
+static int enosys(void)
+{
+	return -ENOSYS;
+}
+
+static int ebadf(void)
+{
+	return -EBADF;
+}
+
+static void nop_close(struct rtdm_fd *fd)
+{
+}
+
+static inline struct rtdm_fd_index *
+rtdm_fd_index_fetch(struct xnsys_ppd *p, int ufd)
+{
+	struct xnid *id = xnid_fetch(&p->fds, ufd);
+	if (id == NULL)
+		return NULL;
+
+	return container_of(id, struct rtdm_fd_index, id);
+}
+
+static struct rtdm_fd *rtdm_fd_fetch(struct xnsys_ppd *p, int ufd)
+{
+	struct rtdm_fd_index *idx = rtdm_fd_index_fetch(p, ufd);
+	if (idx == NULL)
+		return NULL;
+
+	return idx->fd;
+}
+
+int rtdm_fd_enter(struct xnsys_ppd *p, struct rtdm_fd *fd, int ufd, 
+	unsigned magic, struct rtdm_fd_ops *ops)
+{
+	struct rtdm_fd_index *idx;
+	spl_t s;
+	int err;
+
+	secondary_mode_only();
+
+	if (magic == XNFD_MAGIC_ANY) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	idx = kmalloc(sizeof(*idx), GFP_KERNEL);
+	if (idx == NULL) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	if (ops->ioctl_rt == NULL && ops->ioctl_nrt == NULL)
+		ops->ioctl_rt = ops->ioctl_nrt = (rtdm_fd_ioctl_t *)ebadf;
+	else {
+		if (ops->ioctl_rt == NULL)
+			ops->ioctl_rt = (rtdm_fd_ioctl_t *)enosys;
+		if (ops->ioctl_nrt == NULL)
+			ops->ioctl_nrt = (rtdm_fd_ioctl_t *)enosys;
+	}
+
+	if (ops->read_rt == NULL && ops->read_nrt == NULL)
+		ops->read_rt = ops->read_nrt = (rtdm_fd_read_t *)ebadf;
+	else {
+		if (ops->read_rt == NULL)
+			ops->read_rt = (rtdm_fd_read_t *)enosys;
+		if (ops->read_nrt == NULL)
+			ops->read_nrt = (rtdm_fd_read_t *)enosys;
+	}
+
+	if (ops->write_rt == NULL && ops->write_nrt == NULL)
+		ops->write_rt = ops->write_nrt = (rtdm_fd_write_t *)ebadf;
+	else {
+		if (ops->write_rt == NULL)
+			ops->write_rt = (rtdm_fd_write_t *)enosys;
+		if (ops->write_nrt == NULL)
+			ops->write_nrt = (rtdm_fd_write_t *)enosys;
+	}
+
+	if (ops->recvmsg_rt == NULL && ops->recvmsg_nrt == NULL)
+		ops->recvmsg_rt = ops->recvmsg_nrt = (rtdm_fd_recvmsg_t *)ebadf;
+	else {
+		if (ops->recvmsg_rt == NULL)
+			ops->recvmsg_rt = (rtdm_fd_recvmsg_t *)enosys;
+		if (ops->recvmsg_nrt == NULL)
+			ops->recvmsg_nrt = (rtdm_fd_recvmsg_t *)enosys;
+	}
+
+	if (ops->sendmsg_rt == NULL && ops->sendmsg_nrt == NULL)
+		ops->sendmsg_rt = ops->sendmsg_nrt = (rtdm_fd_sendmsg_t *)ebadf;
+	else {
+		if (ops->sendmsg_rt == NULL)
+			ops->sendmsg_rt = (rtdm_fd_sendmsg_t *)enosys;
+		if (ops->sendmsg_nrt == NULL)
+			ops->sendmsg_nrt = (rtdm_fd_sendmsg_t *)enosys;
+	}
+
+	if (ops->select_bind == NULL)
+		ops->select_bind = (typeof(ops->select_bind))ebadf;
+
+	if (ops->close == NULL)
+		ops->close = nop_close;
+
+	fd->magic = magic;
+	fd->ops = ops;
+	fd->cont = p;
+	fd->refs = 1;
+
+	idx->fd = fd;
+
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+	err = xnid_enter(&p->fds, &idx->id, ufd);
+	if (err < 0) {
+		xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+		err = -EBUSY;
+		goto err_free_index;
+	}
+	xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+	
+	return 0;
+
+  err_free_index:
+	kfree(idx);
+  err:
+	if (ops->close)
+		ops->close(fd);
+	return err;
+}
+
+struct rtdm_fd *rtdm_fd_get(struct xnsys_ppd *p, int ufd, unsigned magic)
+{
+	struct rtdm_fd *res;
+	spl_t s;
+	
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+	res = rtdm_fd_fetch(p, ufd);
+	if (res == NULL || (magic != XNFD_MAGIC_ANY && res->magic != magic)) {
+		res = ERR_PTR(-EBADF);
+		goto err_unlock;
+	}
+	
+	++res->refs;
+  err_unlock:
+	xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+	
+	return res;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_get);
+
+struct lostage_trigger_close {
+	struct ipipe_work_header work; /* Must be first */
+};
+
+static void rtdm_fd_do_close(struct rtdm_fd *fd)
+{
+	secondary_mode_only();
+
+	fd->ops->close(fd);
+
+	if (!XENO_ASSERT(NUCLEUS, !spltest()))
+		splnone();
+}
+
+static int rtdm_fd_cleanup_thread(void *data)
+{
+	struct rtdm_fd *fd;
+	int err;
+	spl_t s;
+	
+	for (;;) {
+		set_cpus_allowed_ptr(current, cpu_online_mask);
+
+		do {
+			err = down_killable(&rtdm_fd_cleanup_sem);
+		} while (err && !kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		xnlock_get_irqsave(&__rtdm_fd_lock, s);
+		fd = list_first_entry(&rtdm_fd_cleanup_queue, 
+				struct rtdm_fd, cleanup);
+		list_del(&fd->cleanup);
+		xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+
+		rtdm_fd_do_close(fd);
+	}
+
+	return 0;
+}
+
+static void lostage_trigger_close(struct ipipe_work_header *work)
+{
+	up(&rtdm_fd_cleanup_sem);
+}
+
+static void rtdm_fd_put_inner(struct rtdm_fd *fd, spl_t s)
+{
+	int destroy;
+
+	destroy = --fd->refs == 0;
+	xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+	
+	if (!destroy)
+		return;
+	
+	if (ipipe_root_p)
+		rtdm_fd_do_close(fd);
+	else {
+		struct lostage_trigger_close closework = {
+			.work = {
+				.size = sizeof(closework),
+				.handler = lostage_trigger_close,
+			},
+		};
+		
+		xnlock_get_irqsave(&__rtdm_fd_lock, s);
+		list_add_tail(&fd->cleanup, &rtdm_fd_cleanup_queue);
+		xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+
+		ipipe_post_work_root(&closework, work);
+	}
+}
+
+void rtdm_fd_put(struct rtdm_fd *fd)
+{
+	spl_t s;
+	
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+	rtdm_fd_put_inner(fd, s);
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_put);
+
+int rtdm_fd_lock(struct rtdm_fd *fd)
+{
+	spl_t s;
+
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+	if (fd->refs == 0) {
+		xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+		return -EIDRM;
+	}
+	++fd->refs;
+	xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_lock);
+
+void rtdm_fd_unlock(struct rtdm_fd *fd)
+{
+	spl_t s;
+
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+/* just warn if context was a dangling pointer */
+	XENO_ASSERT(NUCLEUS, fd->refs > 0);
+	rtdm_fd_put_inner(fd, s);
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_unlock);
+
+int rtdm_fd_ioctl(struct xnsys_ppd *p, int ufd, unsigned request, ...)
+{
+	void __user *arg;
+	struct rtdm_fd *fd;
+	va_list args;
+	int err;
+
+	va_start(args, request);
+	arg = va_arg(args, void __user *);
+	va_end(args);
+
+	trace_mark(xn_rtdm, ioctl, "sys_ppd %p fd %d request %d arg %p",
+		   p, ufd, request, arg);
+	
+	fd = rtdm_fd_get(p, ufd, XNFD_MAGIC_ANY);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
+	
+	if (ipipe_root_p)
+		err = fd->ops->ioctl_nrt(fd, request, arg);
+	else
+		err = fd->ops->ioctl_rt(fd, request, arg);
+	
+	if (!XENO_ASSERT(NUCLEUS, !spltest()))
+		    splnone();
+
+	if (err < 0) {
+		int ret = __rt_dev_ioctl_fallback(fd, request, arg);
+		if (ret != -ENOSYS)
+			err = ret;
+	}
+
+	rtdm_fd_put(fd);
+	
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_ioctl);
+
+ssize_t 
+rtdm_fd_read(struct xnsys_ppd *p, int ufd, void __user *buf, size_t size)
+{
+	struct rtdm_fd *fd;
+	ssize_t err;
+	
+	trace_mark(xn_rtdm, read, "sys_ppd %p fd %d buf %p nbyte %zu",
+		   p, ufd, buf, size);
+
+	fd = rtdm_fd_get(p, ufd, XNFD_MAGIC_ANY);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
+	
+	if (ipipe_root_p)
+		err = fd->ops->read_nrt(fd, buf, size);
+	else
+		err = fd->ops->read_rt(fd, buf, size);
+	
+	if (!XENO_ASSERT(NUCLEUS, !spltest()))
+		    splnone();
+
+	rtdm_fd_put(fd);
+	
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_read);
+
+ssize_t rtdm_fd_write(struct xnsys_ppd *p, int ufd,
+		const void __user *buf, size_t size)
+{
+	struct rtdm_fd *fd;
+	ssize_t err;
+	
+	trace_mark(xn_rtdm, write, "sys_ppd %p fd %d buf %p nbyte %zu",
+		   p, ufd, buf, size);
+
+	fd = rtdm_fd_get(p, ufd, XNFD_MAGIC_ANY);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
+	
+	if (ipipe_root_p)
+		err = fd->ops->write_nrt(fd, buf, size);
+	else
+		err = fd->ops->write_rt(fd, buf, size);
+	
+	if (!XENO_ASSERT(NUCLEUS, !spltest()))
+		    splnone();
+
+	rtdm_fd_put(fd);
+	
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_write);
+
+ssize_t 
+rtdm_fd_recvmsg(struct xnsys_ppd *p, int ufd, struct msghdr *msg, int flags)
+{
+	struct rtdm_fd *fd;
+	ssize_t err;
+	
+	trace_mark(xn_rtdm, recvmsg, "sys_ppd %p fd %d msg_name %p "
+		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
+		   "msg_control %p msg_controllen %zu msg_flags %d",
+		   p, ufd, msg->msg_name, msg->msg_namelen,
+		   msg->msg_iov, msg->msg_iovlen, msg->msg_control,
+		   msg->msg_controllen, msg->msg_flags);
+
+	fd = rtdm_fd_get(p, ufd, XNFD_MAGIC_ANY);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
+	
+	if (ipipe_root_p)
+		err = fd->ops->recvmsg_nrt(fd, msg, flags);
+	else
+		err = fd->ops->recvmsg_rt(fd, msg, flags);
+	
+	if (!XENO_ASSERT(NUCLEUS, !spltest()))
+		    splnone();
+
+	rtdm_fd_put(fd);
+	
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_recvmsg);
+
+ssize_t 
+rtdm_fd_sendmsg(struct xnsys_ppd *p, int ufd, const struct msghdr *msg, int flags)
+{
+	struct rtdm_fd *fd;
+	ssize_t err;
+	
+	trace_mark(xn_rtdm, sendmsg, "sys_ppd %p fd %d msg_name %p "
+		   "msg_namelen %u msg_iov %p msg_iovlen %zu "
+		   "msg_control %p msg_controllen %zu msg_flags %d",
+		   p, ufd, msg->msg_name, msg->msg_namelen,
+		   msg->msg_iov, msg->msg_iovlen, msg->msg_control,
+		   msg->msg_controllen, msg->msg_flags);
+
+	fd = rtdm_fd_get(p, ufd, XNFD_MAGIC_ANY);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
+	
+	if (ipipe_root_p)
+		err = fd->ops->sendmsg_nrt(fd, msg, flags);
+	else
+		err = fd->ops->sendmsg_rt(fd, msg, flags);
+	
+	if (!XENO_ASSERT(NUCLEUS, !spltest()))
+		    splnone();
+
+	rtdm_fd_put(fd);
+	
+	return err;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_sendmsg);
+
+static void 
+rtdm_fd_close_inner(struct xnsys_ppd *p, struct rtdm_fd_index *idx, spl_t s)
+{
+	xnid_remove(&p->fds, &idx->id);
+	rtdm_fd_put_inner(idx->fd, s);
+
+	kfree(idx);
+}
+
+int rtdm_fd_close(struct xnsys_ppd *p, int ufd, unsigned magic)
+{
+	struct rtdm_fd_index *idx;
+	struct rtdm_fd *fd;
+	spl_t s;
+
+	trace_mark(xn_rtdm, close, "sys_ppd %p fd %d", p, ufd);
+
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+	idx = rtdm_fd_index_fetch(p, ufd);
+	if (idx == NULL)
+		goto ebadf;
+
+	fd = idx->fd;
+	if (magic != XNFD_MAGIC_ANY && fd->magic != magic) {
+	  ebadf:
+		xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+		return -EBADF;
+	}
+	__rt_dev_unref(fd, xnid_id(&idx->id));
+	rtdm_fd_close_inner(p, idx, s);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_close);
+
+int rtdm_fd_valid_p(int ufd)
+{
+	struct rtdm_fd *fd;
+	spl_t s;
+
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+	fd = rtdm_fd_fetch(xnsys_ppd_get(0), ufd);
+	xnlock_put_irqrestore(&__rtdm_fd_lock, s);
+	
+	return fd != NULL;
+}
+
+int rtdm_fd_select_bind(int ufd, struct xnselector *selector, unsigned type)
+{
+	struct xnsys_ppd *p;
+	struct rtdm_fd *fd;
+	int rc;
+	
+	p = xnsys_ppd_get(0);
+	fd = rtdm_fd_get(p, ufd, XNFD_MAGIC_ANY);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
+	
+	rc = fd->ops->select_bind(fd, selector, type, ufd);
+
+	rtdm_fd_put(fd);
+	
+	return rc;
+}
+
+static void rtdm_fd_destroy(void *cookie, struct xnid *id)
+{
+	struct xnsys_ppd *p = cookie;
+	struct rtdm_fd_index *idx;
+	spl_t s;
+
+	idx = container_of(id, struct rtdm_fd_index, id);
+	xnlock_get_irqsave(&__rtdm_fd_lock, s);
+	rtdm_fd_close_inner(p, idx, XNFD_MAGIC_ANY);
+}
+
+void rtdm_fd_cleanup(struct xnsys_ppd *p)
+{
+	xntree_cleanup(&p->fds, p, rtdm_fd_destroy);
+}
+
+void rtdm_fd_init(void)
+{
+	sema_init(&rtdm_fd_cleanup_sem, 0);
+	kthread_run(rtdm_fd_cleanup_thread, NULL, "rtdm_fd");
+}
diff --git a/kernel/cobalt/rtdm/internal.h b/kernel/cobalt/rtdm/internal.h
index 3288068..6db80a6 100644
--- a/kernel/cobalt/rtdm/internal.h
+++ b/kernel/cobalt/rtdm/internal.h
@@ -31,10 +31,6 @@
 #define DEF_DEVNAME_HASHTAB_SIZE	256	/* entries in name hash table */
 #define DEF_PROTO_HASHTAB_SIZE		256	/* entries in protocol hash table */
 
-struct rtdm_fildes {
-	struct rtdm_dev_context *context;
-};
-
 struct rtdm_process {
 #ifdef CONFIG_XENO_OPT_VFILE
 	char name[32];
@@ -46,10 +42,8 @@ DECLARE_EXTERN_XNLOCK(rt_fildes_lock);
 DECLARE_EXTERN_XNLOCK(rt_dev_lock);
 
 extern int __rtdm_muxid;
-extern struct rtdm_fildes fildes_table[];
 extern int open_fildes;
 extern struct semaphore nrt_dev_lock;
-extern unsigned int devname_hashtab_size;
 extern struct list_head rtdm_named_devices;
 extern struct rb_root rtdm_protocol_devices;
 extern struct xnpersonality rtdm_personality;
diff --git a/kernel/cobalt/rtdm/proc.c b/kernel/cobalt/rtdm/proc.c
index 28ec6ab..f45bae7 100644
--- a/kernel/cobalt/rtdm/proc.c
+++ b/kernel/cobalt/rtdm/proc.c
@@ -184,40 +184,35 @@ static int openfd_show(struct xnvfile_regular_iterator *it, void *data)
 	struct rtdm_dev_context *context;
 	struct rtdm_device *device;
 	struct rtdm_process owner;
-	int close_lock_count, fd;
-	spl_t s;
+	int close_lock_count, i;
+	struct rtdm_fd *fd;
 
 	if (data == NULL) {
 		xnvfile_puts(it, "Index\tLocked\tDevice\t\t\t\tOwner [PID]\n");
 		return 0;
 	}
 
-	fd = (int)it->pos - 1;
+	i = (int)it->pos - 1;
 
-	xnlock_get_irqsave(&rt_fildes_lock, s);
-
-	context = fildes_table[fd].context;
-	if (context == NULL) {
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
+	fd = rtdm_fd_get(&__xnsys_global_ppd, i, RTDM_FD_MAGIC);
+	if (fd == NULL)
 		return VFILE_SEQ_SKIP;
-	}
 
-	close_lock_count = atomic_read(&context->close_lock_count);
+	context = rtdm_context(fd);
+	close_lock_count = fd->refs;
 	device = context->device;
-	if (context->reserved.owner)
-		memcpy(&owner, context->reserved.owner, sizeof(owner));
-	else {
-		strcpy(owner.name, "<kernel>");
-		owner.pid = -1;
-	}
 
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
+	strcpy(owner.name, "<kernel>");
+	owner.pid = -1;
 
-	xnvfile_printf(it, "%d\t%d\t%-31s %s [%d]\n", fd,
+	xnvfile_printf(it, "%d\t%d\t%-31s %s [%d]\n", i,
 		       close_lock_count,
 		       (device->device_flags & RTDM_NAMED_DEVICE) ?
 		       device->device_name : device->proc_name,
 		       owner.name, owner.pid);
+
+	rtdm_fd_put(fd);
+
 	return 0;
 }
 
@@ -230,7 +225,7 @@ static ssize_t openfd_store(struct xnvfile_input *input)
 	if (ret < 0)
 		return ret;
 
-	cret = __rt_dev_close(current, (int)val);
+	cret = rtdm_fd_close(&__xnsys_global_ppd, (int)val, RTDM_FD_MAGIC);
 	if (cret < 0)
 		return cret;
 
diff --git a/kernel/cobalt/rtdm/syscall.c b/kernel/cobalt/rtdm/syscall.c
index 24edd3a..d7bc2bb 100644
--- a/kernel/cobalt/rtdm/syscall.c
+++ b/kernel/cobalt/rtdm/syscall.c
@@ -24,83 +24,71 @@
 
 int __rtdm_muxid;
 
-static int sys_rtdm_fdcount(void)
-{
-	return RTDM_FD_MAX;
-}
-
-static int sys_rtdm_open(const char __user *u_path, int oflag)
+static int sys_rtdm_open(int fd, const char __user *u_path, int oflag)
 {
 	char krnl_path[RTDM_MAX_DEVNAME_LEN + 1];
-	struct task_struct *p = current;
 
 	if (unlikely(__xn_safe_strncpy_from_user(krnl_path, u_path,
 						 sizeof(krnl_path) - 1) < 0))
 		return -EFAULT;
 	krnl_path[sizeof(krnl_path) - 1] = '\0';
 
-	return __rt_dev_open(p, krnl_path, oflag);
-}
-
-static int sys_rtdm_socket(int protocol_family, int socket_type, int protocol)
-{
-	return __rt_dev_socket(current,
-			       protocol_family, socket_type, protocol);
+	return __rt_dev_open(xnsys_ppd_get(0), fd, krnl_path, oflag);
 }
 
-static int sys_rtdm_close(int fd)
+static int 
+sys_rtdm_socket(int fd, int protocol_family, int socket_type, int protocol)
 {
-	return __rt_dev_close(current, fd);
+	return __rt_dev_socket(xnsys_ppd_get(0), fd, 
+			protocol_family, socket_type, protocol);
 }
 
-static int sys_rtdm_ioctl(int fd, int request, void *arglist)
+int sys_rtdm_ioctl(int fd, unsigned int request, void __user *arg)
 {
-	return __rt_dev_ioctl(current, fd, request, arglist);
+	return rtdm_fd_ioctl(xnsys_ppd_get(0), fd, request, arg);
 }
 
-static int sys_rtdm_read(int fd, void __user *u_buf, size_t nbytes)
+ssize_t sys_rtdm_read(int fd, void __user *buf, size_t size)
 {
-	return __rt_dev_read(current, fd, u_buf, nbytes);
+	return rtdm_fd_read(xnsys_ppd_get(0), fd, buf, size);
 }
 
-static int sys_rtdm_write(int fd, const void __user *u_buf, size_t nbytes)
+ssize_t sys_rtdm_write(int fd, const void __user *buf, size_t size)
 {
-	return __rt_dev_write(current, fd, u_buf, nbytes);
+	return rtdm_fd_write(xnsys_ppd_get(0), fd, buf, size);
 }
 
-static int sys_rtdm_recvmsg(int fd, struct msghdr __user *u_msg, int flags)
+ssize_t sys_rtdm_recvmsg(int fd, struct msghdr __user *umsg, int flags)
 {
-	struct task_struct *p = current;
-	struct msghdr krnl_msg;
+	struct msghdr m;
 	int ret;
 
-	if (unlikely(!access_wok(u_msg, sizeof(krnl_msg)) ||
-		     __xn_copy_from_user(&krnl_msg, u_msg,
-					 sizeof(krnl_msg))))
+	if (__xn_copy_from_user(&m, umsg, sizeof(m)))
 		return -EFAULT;
 
-	ret = __rt_dev_recvmsg(p, fd, &krnl_msg, flags);
-	if (unlikely(ret < 0))
+	ret = rtdm_fd_recvmsg(xnsys_ppd_get(0), fd, &m, flags);
+	if (ret < 0)
 		return ret;
-
-	if (unlikely(__xn_copy_to_user(u_msg, &krnl_msg, sizeof(krnl_msg))))
+	
+	if (__xn_copy_to_user(umsg, &m, sizeof(*umsg)))
 		return -EFAULT;
-
+	
 	return ret;
 }
 
-static int sys_rtdm_sendmsg(int fd, const struct msghdr __user *u_msg,
-			    int flags)
+ssize_t sys_rtdm_sendmsg(int fd, struct msghdr __user *umsg, int flags)
 {
-	struct task_struct *p = current;
-	struct msghdr krnl_msg;
+	struct msghdr m;
 
-	if (unlikely(!access_rok(u_msg, sizeof(krnl_msg)) ||
-		     __xn_copy_from_user(&krnl_msg, u_msg,
-					 sizeof(krnl_msg))))
+	if (__xn_copy_from_user(&m, umsg, sizeof(m)))
 		return -EFAULT;
 
-	return __rt_dev_sendmsg(p, fd, &krnl_msg, flags);
+	return rtdm_fd_sendmsg(xnsys_ppd_get(0), fd, &m, flags);
+}
+
+int sys_rtdm_close(int fd)
+{
+	return rtdm_fd_close(xnsys_ppd_get(0), fd, XNFD_MAGIC_ANY);
 }
 
 static void *rtdm_process_attach(void)
@@ -123,12 +111,10 @@ static void rtdm_process_detach(void *arg)
 {
 	struct rtdm_process *process = arg;
 
-	cleanup_process_files(process);
 	kfree(process);
 }
 
 static struct xnsyscall rtdm_syscalls[] = {
-	SKINCALL_DEF(sc_rtdm_fdcount, sys_rtdm_fdcount, any),
 	SKINCALL_DEF(sc_rtdm_open, sys_rtdm_open, probing),
 	SKINCALL_DEF(sc_rtdm_socket, sys_rtdm_socket, probing),
 	SKINCALL_DEF(sc_rtdm_close, sys_rtdm_close, probing),
diff --git a/kernel/cobalt/shadow.c b/kernel/cobalt/shadow.c
index 0d045dc..3ed6e0f 100644
--- a/kernel/cobalt/shadow.c
+++ b/kernel/cobalt/shadow.c
@@ -58,6 +58,7 @@
 #include <cobalt/kernel/ppd.h>
 #include <cobalt/kernel/vdso.h>
 #include <cobalt/kernel/thread.h>
+#include <rtdm/fd.h>
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm-generic/xenomai/mayday.h>
@@ -1601,6 +1602,7 @@ static void user_process_detach(void *arg)
 
 	if (p->exe_path)
 		kfree(p->exe_path);
+	rtdm_fd_cleanup(p);
 	process_hash_remove(process);
 	xnheap_destroy_mapped(&p->sem_heap, post_ppd_release, NULL);
 	atomic_dec(&personalities[user_muxid]->refcnt);
@@ -1648,6 +1650,7 @@ static void *user_process_attach(void)
 		exe_path = NULL; /* Not lethal, but weird. */
 	}
 	p->exe_path = exe_path;
+	xntree_init(&p->fds);
 	atomic_set(&p->refcnt, 1);
 	atomic_inc(&personalities[user_muxid]->refcnt);
 
diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index e68094b..f774f2d 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -49,8 +49,6 @@ pthread_t __cobalt_main_tid;
 
 int __rtdm_muxid = -1;
 
-int __rtdm_fd_start = INT_MAX;
-
 static void sigill_handler(int sig)
 {
 	const char m[] = "no Xenomai support in kernel?\n";
@@ -151,11 +149,8 @@ void __libcobalt_init(void)
 	breq.feat_req = XENOMAI_FEAT_DEP;
 	breq.abi_rev = XENOMAI_ABI_REV;
 	muxid = XENOMAI_SYSBIND(RTDM_BINDING_MAGIC, &breq);
-	if (muxid > 0) {
+	if (muxid > 0)
 		__rtdm_muxid = __xn_mux_shifted_id(muxid);
-		__rtdm_fd_start = FD_SETSIZE - XENOMAI_SKINCALL0(__rtdm_muxid,
-								 sc_rtdm_fdcount);
-	}
 
 	/*
 	 * Upon fork, in case the parent required init deferral, this
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index e789d76..cb27697 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -26,10 +26,11 @@
 #include <sys/socket.h>
 #include <rtdm/rtdm.h>
 #include <cobalt/uapi/rtdm/syscall.h>
+#include <cobalt/uapi/syscall.h>
 #include <asm/xenomai/syscall.h>
 
 extern int __rtdm_muxid;
-extern int __rtdm_fd_start;
+extern int __cobalt_muxid;
 
 static inline int set_errno(int ret)
 {
@@ -42,8 +43,13 @@ static inline int set_errno(int ret)
 
 COBALT_IMPL(int, open, (const char *path, int oflag, ...))
 {
-	int ret, oldtype;
+	int ret, fd, oldtype;
 	const char *rtdm_path = path;
+	va_list ap;
+
+	fd = __STD(open("/dev/null", O_RDONLY));
+	if (fd < 0)
+		return fd;
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
@@ -51,78 +57,78 @@ COBALT_IMPL(int, open, (const char *path, int oflag, ...))
 	if (strncmp(path, "/dev/", 5) == 0)
 		rtdm_path += 5;
 
-	ret = XENOMAI_SKINCALL2(__rtdm_muxid, sc_rtdm_open, rtdm_path, oflag);
+	ret = XENOMAI_SKINCALL3(__rtdm_muxid, 
+				sc_rtdm_open, 
+				fd, rtdm_path, oflag);
 
 	pthread_setcanceltype(oldtype, NULL);
 
-	if (ret >= 0)
-		ret += __rtdm_fd_start;
-	else if (ret == -ENODEV || ret == -ENOSYS) {
-		va_list ap;
-
-		va_start(ap, oflag);
-
-		ret = __STD(open(path, oflag, va_arg(ap, mode_t)));
+	if (ret == fd)
+		return fd;
+	__STD(close(fd));
 
-		va_end(ap);
+	if (ret != -ENODEV && ret != -ENOSYS)
+		return set_errno(ret);
 
-		if (ret >= __rtdm_fd_start) {
-			__STD(close(ret));
-			errno = EMFILE;
-			ret = -1;
-		}
-	} else {
-		errno = -ret;
-		ret = -1;
-	}
+	va_start(ap, oflag);
+	ret = __STD(open(path, oflag, va_arg(ap, mode_t)));
+	va_end(ap);
 
 	return ret;
 }
 
 COBALT_IMPL(int, socket, (int protocol_family, int socket_type, int protocol))
 {
-	int ret;
+	int ret, fd;
 
-	ret = XENOMAI_SKINCALL3(__rtdm_muxid,
+	fd = __STD(open("/dev/null", O_RDONLY));
+	if (fd < 0)
+		return fd;
+
+	ret = XENOMAI_SKINCALL4(__rtdm_muxid,
 				sc_rtdm_socket,
-				protocol_family, socket_type, protocol);
-	if (ret >= 0)
-		ret += __rtdm_fd_start;
-	else if (ret == -EAFNOSUPPORT || ret == -EPROTONOSUPPORT || 
-		 ret == -ENOSYS) {
-		ret = __STD(socket(protocol_family, socket_type, protocol));
-
-		if (ret >= __rtdm_fd_start) {
-			__STD(close(ret));
-			errno = -EMFILE;
-			ret = -1;
-		}
-	} else {
-		errno = -ret;
-		ret = -1;
-	}
+				fd, protocol_family, socket_type, protocol);
+	if (ret == fd)
+		return fd;
+	__STD(close(fd));
 
-	return ret;
+	if (ret != -EAFNOSUPPORT && ret != -EPROTONOSUPPORT && ret != -ENOSYS)
+		return set_errno(ret);
+	
+	return __STD(socket(protocol_family, socket_type, protocol));
 }
 
 COBALT_IMPL(int, close, (int fd))
 {
+	int oldtype;
 	int ret;
+	
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	ret = XENOMAI_SKINCALL1(__rtdm_muxid, sc_rtdm_close, fd);
 
-	if (fd >= __rtdm_fd_start) {
-		int oldtype;
+	pthread_setcanceltype(oldtype, NULL);
 
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	if (ret != -EBADF && ret != -ENOSYS) {
+		if (ret == 0)
+			__STD(close(fd));
+		return set_errno(ret);
+	}
 
-		ret = set_errno(XENOMAI_SKINCALL1(__rtdm_muxid,
-						  sc_rtdm_close,
-						  fd - __rtdm_fd_start));
+	return __STD(close(fd));
+}
 
-		pthread_setcanceltype(oldtype, NULL);
+static int __xn_ioctl(int fd, unsigned long request, void *arg)
+{
+	int ret, oldtype;
 
-		return ret;
-	} else
-		return __STD(close(fd));
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	ret = XENOMAI_SKINCALL3(__rtdm_muxid,
+				sc_rtdm_ioctl, 
+				fd, request, arg);
+
+	pthread_setcanceltype(oldtype, NULL);
 
 	return ret;
 }
@@ -131,327 +137,269 @@ COBALT_IMPL(int, ioctl, (int fd, unsigned long int request, ...))
 {
 	va_list ap;
 	void *arg;
+	int ret;
 
 	va_start(ap, request);
 	arg = va_arg(ap, void *);
 	va_end(ap);
 
-	if (fd >= __rtdm_fd_start)
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   request, arg));
-	else
-		return __STD(ioctl(fd, request, arg));
+	ret = __xn_ioctl(fd, request, arg);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(ioctl(fd, request, arg));
 }
 
 COBALT_IMPL(ssize_t, read, (int fd, void *buf, size_t nbyte))
 {
-	if (fd >= __rtdm_fd_start) {
-		int ret, oldtype;
-
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	int ret, oldtype;
+	
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_read,
-						  fd - __rtdm_fd_start,
-						  buf, nbyte));
+	ret = XENOMAI_SKINCALL3(__rtdm_muxid, 
+				sc_rtdm_read, 
+				fd, buf, nbyte);
 
-		pthread_setcanceltype(oldtype, NULL);
+	pthread_setcanceltype(oldtype, NULL);
 
-		return ret;
-	} else
-		return __STD(read(fd, buf, nbyte));
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+		
+	return __STD(read(fd, buf, nbyte));
 }
 
 COBALT_IMPL(ssize_t, write, (int fd, const void *buf, size_t nbyte))
 {
-	if (fd >= __rtdm_fd_start) {
-		int ret, oldtype;
+	int ret, oldtype;
 
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_write,
-						  fd - __rtdm_fd_start,
-						  buf, nbyte));
+	ret = XENOMAI_SKINCALL3(__rtdm_muxid, 
+				sc_rtdm_write,
+				fd, buf, nbyte);
 
-		pthread_setcanceltype(oldtype, NULL);
+	pthread_setcanceltype(oldtype, NULL);
 
-		return ret;
-	} else
-		return __STD(write(fd, buf, nbyte));
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(write(fd, buf, nbyte));
 }
 
-COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr * msg, int flags))
+static ssize_t __xn_recvmsg(int fd, struct msghdr *msg, int flags)
 {
-	if (fd >= __rtdm_fd_start) {
-		int ret, oldtype;
+	int ret, oldtype;
 
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_recvmsg,
-						  fd - __rtdm_fd_start,
-						  msg, flags));
+	ret = XENOMAI_SKINCALL3(__rtdm_muxid, 
+				sc_rtdm_recvmsg, 
+				fd, msg, flags);
 
-		pthread_setcanceltype(oldtype, NULL);
+	pthread_setcanceltype(oldtype, NULL);
 
-		return ret;
-	} else
-		return __STD(recvmsg(fd, msg, flags));
+	return ret;
 }
 
-COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr * msg, int flags))
+COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
 {
-	if (fd >= __rtdm_fd_start) {
-		int ret, oldtype;
-
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_sendmsg,
-						  fd - __rtdm_fd_start,
-						  msg, flags));
+	int ret;
 
-		pthread_setcanceltype(oldtype, NULL);
+	ret = __xn_recvmsg(fd, msg, flags);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 
-		return ret;
-	} else
-		return __STD(sendmsg(fd, msg, flags));
+	return __STD(recvmsg(fd, msg, flags));
 }
 
-COBALT_IMPL(ssize_t, recvfrom, (int fd, void *buf, size_t len, int flags,
-				struct sockaddr * from, socklen_t * fromlen))
+static ssize_t __xn_sendmsg(int fd, const struct msghdr *msg, int flags)
 {
-	if (fd >= __rtdm_fd_start) {
-		struct iovec iov = { buf, len };
-		struct msghdr msg =
-		    { from, (from != NULL) ? *fromlen : 0, &iov, 1, NULL, 0 };
-		int ret, oldtype;
+	int ret, oldtype;
 
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		ret = XENOMAI_SKINCALL3(__rtdm_muxid,
-					sc_rtdm_recvmsg,
-					fd - __rtdm_fd_start, &msg, flags);
+	ret = XENOMAI_SKINCALL3(__rtdm_muxid, 
+				sc_rtdm_sendmsg,
+				fd, msg, flags);
 
-		pthread_setcanceltype(oldtype, NULL);
+	pthread_setcanceltype(oldtype, NULL);
 
-		if (ret < 0) {
-			errno = -ret;
-			ret = -1;
-		} else if (from != NULL)
-			*fromlen = msg.msg_namelen;
-		return ret;
-	} else
-		return __STD(recvfrom(fd, buf, len, flags, from, fromlen));
+	return ret;
 }
 
-COBALT_IMPL(ssize_t, sendto, (int fd, const void *buf, size_t len, int flags,
-			      const struct sockaddr * to, socklen_t tolen))
+COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct iovec iov = { (void *)buf, len };
-		struct msghdr msg =
-		    { (struct sockaddr *)to, tolen, &iov, 1, NULL, 0 };
-		int ret, oldtype;
+	int ret;
+	
+	ret = __xn_sendmsg(fd, msg, flags);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	return __STD(sendmsg(fd, msg, flags));
+}
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_sendmsg,
-						  fd - __rtdm_fd_start,
-						  &msg, flags));
+COBALT_IMPL(ssize_t, recvfrom, (int fd, void *buf, size_t len, int flags,
+				struct sockaddr *from, socklen_t *fromlen))
+{
+	struct iovec iov = { buf, len };
+	struct msghdr msg =
+		{ from, (from != NULL) ? *fromlen : 0, &iov, 1, NULL, 0 };
+	int ret;
 
-		pthread_setcanceltype(oldtype, NULL);
+	ret = __xn_recvmsg(fd, &msg, flags);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 
-		return ret;
-	} else
-		return __STD(sendto(fd, buf, len, flags, to, tolen));
+	return __STD(recvfrom(fd, buf, len, flags, from, fromlen));
 }
 
-COBALT_IMPL(ssize_t, recv, (int fd, void *buf, size_t len, int flags))
+COBALT_IMPL(ssize_t, sendto, (int fd, const void *buf, size_t len, int flags,
+			      const struct sockaddr *to, socklen_t tolen))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct iovec iov = { buf, len };
-		struct msghdr msg = { NULL, 0, &iov, 1, NULL, 0 };
-		int ret, oldtype;
-
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+	struct iovec iov = { (void *)buf, len };
+	struct msghdr msg =
+		{ (struct sockaddr *)to, tolen, &iov, 1, NULL, 0 };
+	int ret;
+	
+	ret = __xn_sendmsg(fd, &msg, flags);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_recvmsg,
-						  fd - __rtdm_fd_start,
-						  &msg, flags));
+	return __STD(sendto(fd, buf, len, flags, to, tolen));
+}
 
-		pthread_setcanceltype(oldtype, NULL);
+COBALT_IMPL(ssize_t, recv, (int fd, void *buf, size_t len, int flags))
+{
+	struct iovec iov = { buf, len };
+	struct msghdr msg = { NULL, 0, &iov, 1, NULL, 0 };
+	int ret;
+	
+	ret = __xn_recvmsg(fd, &msg, flags);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);	
 
-		return ret;
-	} else
-		return __STD(recv(fd, buf, len, flags));
+	return __STD(recv(fd, buf, len, flags));
 }
 
 COBALT_IMPL(ssize_t, send, (int fd, const void *buf, size_t len, int flags))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct iovec iov = { (void *)buf, len };
-		struct msghdr msg = { NULL, 0, &iov, 1, NULL, 0 };
-		int ret, oldtype;
-
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_sendmsg,
-						  fd - __rtdm_fd_start,
-						  &msg, flags));
+	struct iovec iov = { (void *)buf, len };
+	struct msghdr msg = { NULL, 0, &iov, 1, NULL, 0 };
+	int ret;
 
-		pthread_setcanceltype(oldtype, NULL);
+	ret = __xn_sendmsg(fd, &msg, flags);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);	
 
-		return ret;
-	} else
-		return __STD(send(fd, buf, len, flags));
+	return __STD(send(fd, buf, len, flags));
 }
 
 COBALT_IMPL(int, getsockopt, (int fd, int level, int optname, void *optval,
-			      socklen_t * optlen))
+			      socklen_t *optlen))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct _rtdm_getsockopt_args args =
-		    { level, optname, optval, optlen };
-
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   _RTIOC_GETSOCKOPT, &args));
-	} else
-		return __STD(getsockopt(fd, level, optname, optval, optlen));
+	struct _rtdm_getsockopt_args args = { level, optname, optval, optlen };
+	int ret;
+	
+	ret = __xn_ioctl(fd, _RTIOC_GETSOCKOPT, &args);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(getsockopt(fd, level, optname, optval, optlen));
 }
 
 COBALT_IMPL(int, setsockopt, (int fd, int level, int optname, const void *optval,
 			      socklen_t optlen))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct _rtdm_setsockopt_args args =
-		    { level, optname, (void *)optval, optlen };
-
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   _RTIOC_SETSOCKOPT, &args));
-	} else
-		return __STD(setsockopt(fd, level, optname, optval, optlen));
+	struct _rtdm_setsockopt_args args = { 
+		level, optname, (void *)optval, optlen 
+	};
+	int ret;
+	
+	ret = __xn_ioctl(fd, _RTIOC_SETSOCKOPT, &args);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(setsockopt(fd, level, optname, optval, optlen));
 }
 
 COBALT_IMPL(int, bind, (int fd, const struct sockaddr *my_addr, socklen_t addrlen))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct _rtdm_setsockaddr_args args = { my_addr, addrlen };
-
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   _RTIOC_BIND, &args));
-	} else
-		return __STD(bind(fd, my_addr, addrlen));
+	struct _rtdm_setsockaddr_args args = { my_addr, addrlen };
+	int ret;
+	
+	ret = __xn_ioctl(fd, _RTIOC_BIND, &args);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(bind(fd, my_addr, addrlen));
 }
 
 COBALT_IMPL(int, connect, (int fd, const struct sockaddr *serv_addr, socklen_t addrlen))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct _rtdm_setsockaddr_args args = { serv_addr, addrlen };
-		int ret, oldtype;
-
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_ioctl,
-						  fd - __rtdm_fd_start,
-						  _RTIOC_CONNECT, &args));
-
-		pthread_setcanceltype(oldtype, NULL);
+	struct _rtdm_setsockaddr_args args = { serv_addr, addrlen };
+	int ret;
+	
+	ret = __xn_ioctl(fd, _RTIOC_CONNECT, &args);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 
-		return ret;
-	} else
-		return __STD(connect(fd, serv_addr, addrlen));
+	return __STD(connect(fd, serv_addr, addrlen));
 }
 
 COBALT_IMPL(int, listen, (int fd, int backlog))
 {
-	if (fd >= __rtdm_fd_start) {
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   _RTIOC_LISTEN, backlog));
-	} else
-		return __STD(listen(fd, backlog));
-}
-
-COBALT_IMPL(int, accept, (int fd, struct sockaddr *addr, socklen_t * addrlen))
-{
-	if (fd >= __rtdm_fd_start) {
-		struct _rtdm_getsockaddr_args args = { addr, addrlen };
-		int oldtype;
-
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-		fd = XENOMAI_SKINCALL3(__rtdm_muxid,
-				       sc_rtdm_ioctl,
-				       fd - __rtdm_fd_start,
-				       _RTIOC_ACCEPT, &args);
-
-		pthread_setcanceltype(oldtype, NULL);
+	int ret;
 
-		if (fd < 0)
-			return set_errno(fd);
+	ret = __xn_ioctl(fd, _RTIOC_LISTEN, (void *)(long)backlog);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 
-		return fd + __rtdm_fd_start;
-	} else {
-		fd = __STD(accept(fd, addr, addrlen));
+	return __STD(listen(fd, backlog));
+}
 
-		if (fd >= __rtdm_fd_start) {
-			__STD(close(fd));
-			errno = EMFILE;
-			fd = -1;
-		}
+COBALT_IMPL(int, accept, (int fd, struct sockaddr *addr, socklen_t *addrlen))
+{
+	struct _rtdm_getsockaddr_args args = { addr, addrlen };
+	int ret;
+	
+	ret = __xn_ioctl(fd, _RTIOC_ACCEPT, &args);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 
-		return fd;
-	}
+	return __STD(accept(fd, addr, addrlen));
 }
 
 COBALT_IMPL(int, getsockname, (int fd, struct sockaddr *name, socklen_t *namelen))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct _rtdm_getsockaddr_args args = { name, namelen };
-
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   _RTIOC_GETSOCKNAME, &args));
-	} else
-		return __STD(getsockname(fd, name, namelen));
+	struct _rtdm_getsockaddr_args args = { name, namelen };
+	int ret;
+	
+	ret = __xn_ioctl(fd, _RTIOC_GETSOCKNAME, &args);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(getsockname(fd, name, namelen));
 }
 
 COBALT_IMPL(int, getpeername, (int fd, struct sockaddr *name, socklen_t *namelen))
 {
-	if (fd >= __rtdm_fd_start) {
-		struct _rtdm_getsockaddr_args args = { name, namelen };
-
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   _RTIOC_GETPEERNAME, &args));
-	} else
-		return __STD(getpeername(fd, name, namelen));
+	struct _rtdm_getsockaddr_args args = { name, namelen };
+	int ret;
+	
+	ret = __xn_ioctl(fd, _RTIOC_GETPEERNAME, &args);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(getpeername(fd, name, namelen));
 }
 
 COBALT_IMPL(int, shutdown, (int fd, int how))
 {
-	if (fd >= __rtdm_fd_start) {
-		return set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						   sc_rtdm_ioctl,
-						   fd - __rtdm_fd_start,
-						   _RTIOC_SHUTDOWN, how));
-	} else
-		return __STD(shutdown(fd, how));
+	int ret;
+
+	ret = __xn_ioctl(fd, _RTIOC_SHUTDOWN, (void *)(long)how);
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
+	return __STD(shutdown(fd, how));
 }
-- 
1.7.10.4



From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat,  1 Feb 2014 19:27:28 +0100
Message-Id: <1391279248-5565-3-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1391279248-5565-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <52ED3BA0.4040105@xenomai.org>
 <1391279248-5565-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 3/3] cobalt/rtdm: base on common fd implementation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 include/cobalt/kernel/rtdm/driver.h |  328 +++-----------------
 include/cobalt/kernel/rtdm/rtdm.h   |   48 +--
 kernel/cobalt/posix/select.c        |   30 +-
 kernel/cobalt/rtdm/core.c           |  564 +++++------------------------------
 kernel/cobalt/rtdm/device.c         |   46 +--
 kernel/cobalt/rtdm/drvlib.c         |   36 +--
 kernel/cobalt/rtdm/internal.h       |    6 -
 kernel/cobalt/rtdm/proc.c           |   33 +-
 kernel/cobalt/rtdm/syscall.c        |   80 +----
 lib/cobalt/rtdm.c                   |  501 +++++++++++++------------------
 10 files changed, 394 insertions(+), 1278 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 1fe74e6..e2b01e5 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -39,6 +39,7 @@
 #include <cobalt/kernel/apc.h>
 #include <cobalt/kernel/shadow.h>
 #include <cobalt/kernel/tree.h>
+#include <cobalt/kernel/fd.h>
 #include <rtdm/rtdm.h>
 
 /* debug support */
@@ -77,22 +78,6 @@ enum rtdm_selecttype;
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
@@ -153,9 +138,7 @@ enum rtdm_selecttype {
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
@@ -164,15 +147,12 @@ enum rtdm_selecttype {
  *
  * @see @c open() in IEEE Std 1003.1,
  * http://www.opengroup.org/onlinepubs/009695399 */
-typedef int (*rtdm_open_handler_t)(struct rtdm_dev_context *context,
-				   rtdm_user_info_t *user_info, int oflag);
+typedef int (*rtdm_open_handler_t)(struct xnfd *context, int oflag);
 
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
@@ -181,203 +161,15 @@ typedef int (*rtdm_open_handler_t)(struct rtdm_dev_context *context,
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
+typedef int (*rtdm_socket_handler_t)(struct xnfd *context, int protocol);
 
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
-
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
+	void (*close)(struct xnfd *fd);
 };
 
 /**
@@ -392,19 +184,9 @@ struct rtdm_devctx_reserved {
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
+	struct xnfd fd;
 
 	/** Set of active device operation handlers */
-	struct rtdm_operations *ops;
-
 	/** Reference to owning device */
 	struct rtdm_device *device;
 
@@ -415,6 +197,11 @@ struct rtdm_dev_context {
 	char dev_private[0];
 };
 
+static inline struct rtdm_dev_context *rtdm_context(struct xnfd *fd)
+{
+	return container_of(fd, struct rtdm_dev_context, fd);
+}
+
 /**
  * Locate the driver private area associated to a device context structure
  *
@@ -424,9 +211,9 @@ struct rtdm_dev_context {
  * context.
  */
 static inline void *
-rtdm_context_to_private(struct rtdm_dev_context *context)
+rtdm_context_to_private(struct xnfd *context)
 {
-	return (void *)context->dev_private;
+	return (void *)rtdm_context(context)->dev_private;
 }
 
 /**
@@ -437,10 +224,12 @@ rtdm_context_to_private(struct rtdm_dev_context *context)
  * @return The address of the device context structure defining @a
  * dev_private.
  */
-static inline struct rtdm_dev_context *
+static inline struct xnfd *
 rtdm_private_to_context(void *dev_private)
 {
-	return container_of(dev_private, struct rtdm_dev_context, dev_private);
+	struct rtdm_dev_context *ctx;
+	ctx = container_of(dev_private, struct rtdm_dev_context, dev_private);
+	return &ctx->fd;
 }
 
 struct rtdm_dev_reserved {
@@ -453,6 +242,7 @@ struct rtdm_dev_reserved {
 	};
 	atomic_t refcount;
 	struct rtdm_dev_context *exclusive_context;
+	void (*close)(struct xnfd *);
 };
 
 /**
@@ -485,23 +275,17 @@ struct rtdm_device {
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
+	struct xnfd_ops ops;
 
 	/** Device class ID, see @ref RTDM_CLASS_xxx */
 	int device_class;
@@ -566,36 +350,16 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay);
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
+static inline void rtdm_context_lock(struct xnfd *context)
 {
-	/* just warn if context was a dangling pointer */
-	XENO_ASSERT(RTDM, CONTEXT_IS_LOCKED(context));
-	atomic_inc(&context->close_lock_count);
+	xnfd_lock(context);
 }
 
-extern int rtdm_apc;
-
-static inline void rtdm_context_unlock(struct rtdm_dev_context *context)
+static inline void rtdm_context_unlock(struct xnfd *context)
 {
-	/* just warn if context was a dangling pointer */
-	XENO_ASSERT(RTDM, CONTEXT_IS_LOCKED(context));
-	smp_mb__before_atomic_dec();
-	if (unlikely(atomic_dec_and_test(&context->close_lock_count)))
-		xnapc_schedule(rtdm_apc);
-}
-
-static inline void rtdm_context_put(struct rtdm_dev_context *context)
-{
-	rtdm_context_unlock(context);
+	xnfd_unlock(context);
 }
 
 /* --- clock services --- */
@@ -610,14 +374,6 @@ static inline nanosecs_abs_t rtdm_clock_read_monotonic(void)
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
@@ -1308,38 +1064,38 @@ static inline void rtdm_free(void *ptr)
 	xnfree(ptr);
 }
 
-int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
+int rtdm_mmap_to_user(struct xnfd *context,
 		      void *src_addr, size_t len,
 		      int prot, void **pptr,
 		      struct vm_operations_struct *vm_ops,
 		      void *vm_private_data);
-int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
+int rtdm_iomap_to_user(struct xnfd *context,
 		       phys_addr_t src_addr, size_t len,
 		       int prot, void **pptr,
 		       struct vm_operations_struct *vm_ops,
 		       void *vm_private_data);
-int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
+int rtdm_munmap(struct xnfd *context, void *ptr, size_t len);
 
-static inline int rtdm_read_user_ok(rtdm_user_info_t *user_info,
+static inline int rtdm_read_user_ok(struct xnfd *context,
 				    const void __user *ptr, size_t size)
 {
 	return access_rok(ptr, size);
 }
 
-static inline int rtdm_rw_user_ok(rtdm_user_info_t *user_info,
+static inline int rtdm_rw_user_ok(struct xnfd *context,
 				  const void __user *ptr, size_t size)
 {
 	return access_wok(ptr, size);
 }
 
-static inline int rtdm_copy_from_user(rtdm_user_info_t *user_info,
+static inline int rtdm_copy_from_user(struct xnfd *context,
 				      void *dst, const void __user *src,
 				      size_t size)
 {
 	return __xn_copy_from_user(dst, src, size) ? -EFAULT : 0;
 }
 
-static inline int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info,
+static inline int rtdm_safe_copy_from_user(struct xnfd *context,
 					   void *dst, const void __user *src,
 					   size_t size)
 {
@@ -1347,14 +1103,14 @@ static inline int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info,
 		__xn_copy_from_user(dst, src, size)) ? -EFAULT : 0;
 }
 
-static inline int rtdm_copy_to_user(rtdm_user_info_t *user_info,
+static inline int rtdm_copy_to_user(struct xnfd *context,
 				    void __user *dst, const void *src,
 				    size_t size)
 {
 	return __xn_copy_to_user(dst, src, size) ? -EFAULT : 0;
 }
 
-static inline int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info,
+static inline int rtdm_safe_copy_to_user(struct xnfd *context,
 					 void __user *dst, const void *src,
 					 size_t size)
 {
@@ -1362,7 +1118,7 @@ static inline int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info,
 		__xn_copy_to_user(dst, src, size)) ? -EFAULT : 0;
 }
 
-static inline int rtdm_strncpy_from_user(rtdm_user_info_t *user_info,
+static inline int rtdm_strncpy_from_user(struct xnfd *context,
 					 char *dst,
 					 const char __user *src, size_t count)
 {
@@ -1371,13 +1127,15 @@ static inline int rtdm_strncpy_from_user(rtdm_user_info_t *user_info,
 	return __xn_strncpy_from_user(dst, src, count);
 }
 
-static inline int rtdm_rt_capable(rtdm_user_info_t *user_info)
+static inline int rtdm_rt_capable(struct xnfd *context)
 {
 	if (!XENO_ASSERT(RTDM, !xnsched_interrupt_p()))
 		return 0;
 
-	return (user_info ? xnshadow_thread(user_info) != NULL
-			  : !xnsched_root_p());
+	if (xnfd_owner(context) == &__xnsys_global_ppd)
+		return !xnsched_root_p();
+
+	return xnshadow_thread(current) != NULL;
 }
 
 static inline int rtdm_in_rt_context(void)
@@ -1387,8 +1145,4 @@ static inline int rtdm_in_rt_context(void)
 
 #endif /* !DOXYGEN_CPP */
 
-int rtdm_exec_in_rt(struct rtdm_dev_context *context,
-		    rtdm_user_info_t *user_info, void *arg,
-		    rtdm_rt_handler_t handler);
-
 #endif /* _COBALT_RTDM_DRIVER_H */
diff --git a/include/cobalt/kernel/rtdm/rtdm.h b/include/cobalt/kernel/rtdm/rtdm.h
index f90ecf0..cbf324c 100644
--- a/include/cobalt/kernel/rtdm/rtdm.h
+++ b/include/cobalt/kernel/rtdm/rtdm.h
@@ -25,36 +25,20 @@
 #include <linux/ioctl.h>
 #include <linux/sched.h>
 #include <linux/socket.h>
+#include <cobalt/kernel/ppd.h>
+
+#define RTDM_MAGIC 0x5254444d
 
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
+__rt_dev_ioctl_fallback(struct xnfd *fd, unsigned request, void __user *arg);
 
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
+	xnfd_close(&__xnsys_global_ppd, fd, RTDM_MAGIC)
 
 #define rt_dev_ioctl(fd, request, ...)				\
-	__rt_dev_ioctl(NULL, fd, request, __VA_ARGS__)
+	xnfd_ioctl(&__xnsys_global_ppd, fd, request, __VA_ARGS__)
 
 #define rt_dev_read(fd, buf, nbyte)				\
-	__rt_dev_read(NULL, fd, buf, nbyte)
+	xnfd_read(&__xnsys_global_ppd, fd, buf, nbyte)
 
 #define rt_dev_write(fd, buf, nbyte)				\
-	__rt_dev_write(NULL, fd, buf, nbyte)
+	xnfd_write(&__xnsys_global_ppd, fd, buf, nbyte)
 
 #define rt_dev_recvmsg(fd, msg, flags)				\
-	__rt_dev_recvmsg(NULL, fd, msg, flags)
+	xnfd_recvmsg(&__xnsys_global_ppd, fd, msg, flags)
 
 #define rt_dev_sendmsg(fd, msg, flags)				\
-	__rt_dev_sendmsg(NULL, fd, msg, flags)
+	xnfd_sendmsg(&__xnsys_global_ppd, fd, msg, flags)
 
 static inline
 ssize_t rt_dev_recvfrom(int fd, void *buf, size_t len, int flags,
diff --git a/kernel/cobalt/posix/select.c b/kernel/cobalt/posix/select.c
index 1c56abd..2e3d77a 100644
--- a/kernel/cobalt/posix/select.c
+++ b/kernel/cobalt/posix/select.c
@@ -21,34 +21,13 @@
  */
 #include <linux/types.h>
 #include <linux/err.h>
-#include <rtdm/driver.h>
 #include <cobalt/kernel/fd.h>
+#include <cobalt/kernel/select.h>
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
-
-	if (xnfd_valid_p(fd))
-		return 1;
-
-	if (fd >= rtdm_fd_start) {
-		ctx = rtdm_context_get(fd - rtdm_fd_start);
-		if (ctx == NULL)
-			return 0;
-		rtdm_context_unlock(ctx);
-		return 1;
-	}
-
-	return 0;
-}
-
 static int first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 {
 	int i, fd;
@@ -56,7 +35,7 @@ static int first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 	for (i = 0; i < XNSELECT_MAX_TYPES; i++)
 		if (fds[i]
 		    && (fd = find_first_bit(fds[i]->fds_bits, nfds)) < nfds)
-			return fd_valid_p(fd);
+			return xnfd_valid_p(fd);
 
 	/* All empty is correct, used as a "sleep" mechanism by strange
 	   applications. */
@@ -65,17 +44,12 @@ static int first_fd_valid_p(fd_set *fds[XNSELECT_MAX_TYPES], int nfds)
 
 static int select_bind_one(struct xnselector *selector, unsigned type, int fd)
 {
-	const int rtdm_fd_start = __FD_SETSIZE - RTDM_FD_MAX;
 	int rc;
 
 	rc = xnfd_select_bind(fd, selector, type);
 	if (rc != -ENOENT)
 		return rc;
 
-	if (fd >= rtdm_fd_start)
-		return rtdm_select_bind(fd - rtdm_fd_start,
-					selector, type, fd);
-
 	return -EBADF;
 }
 
diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index b4f2a81..95cba0d 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -37,96 +37,61 @@
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
-
-	return context;
+	rtdm_dereference_device(device);
 }
 
-EXPORT_SYMBOL_GPL(rtdm_context_get);
+void __rt_dev_close(struct xnfd *fd)
+{
+	struct rtdm_dev_context *context = rtdm_context(fd);
+	
+	context->reserved.close(fd);
+	cleanup_instance(context->device, context);
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
@@ -139,147 +104,54 @@ static int create_instance(struct rtdm_device *device,
 
 		xnlock_put_irqrestore(&rt_dev_lock, s);
 	} else {
-		if (nrt_mem)
-			context = kmalloc(sizeof(struct rtdm_dev_context) +
-					  device->context_size, GFP_KERNEL);
-		else
-			context = xnmalloc(sizeof(struct rtdm_dev_context) +
-					   device->context_size);
+		context = kmalloc(sizeof(struct rtdm_dev_context) +
+				device->context_size, GFP_KERNEL);
 		if (unlikely(!context))
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
+	err = xnfd_enter(p, &context->fd, fd, RTDM_MAGIC, &device->ops);
+	if (err < 0) {
+		if (device->reserved.exclusive_context) {
+			xnlock_get_irqsave(&rt_dev_lock, s);
 			context->device = NULL;
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
+			xnlock_put_irqrestore(&rt_dev_lock, s);
+		} else
+			kfree(context);
+		
+		return err;
 	}
 
-	list_splice(&deferred_list, &cleanup_queue);
-
-	xnlock_put_irqrestore(&rt_fildes_lock, s);
+	if (p == &__xnsys_global_ppd)
+		context->reserved.owner = NULL;
+	else
+		context->reserved.owner = xnshadow_private_get(__rtdm_muxid);
+	context->reserved.close = device->reserved.close;
+	*context_ptr = context;
 
-	if (reschedule)
-		schedule_delayed_work(&close_work,
-				      (HZ * CLOSURE_RETRY_PERIOD_MS) / 1000);
+	return 0;
 }
 
-void rtdm_apc_handler(void *cookie)
-{
-	schedule_delayed_work(&close_work, 0);
-}
-
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
+	ret = create_instance(p, ufd, device, &context);
 	if (ret != 0)
 		goto cleanup_out;
 
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
@@ -287,51 +159,39 @@ int __rt_dev_open(rtdm_user_info_t *user_info, const char *path, int oflag)
 	if (unlikely(ret < 0))
 		goto cleanup_out;
 
-	fildes->context = context;
-
 	trace_mark(xn_rtdm, fd_created,
-		   "device %p fd %d", device, context->fd);
+		"device %p fd %d", device, xnfd_index(&context->fd));
 
-	return context->fd;
+	return xnfd_index(&context->fd);
 
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
+	ret = create_instance(p, ufd, device, &context);
 	if (ret != 0)
 		goto cleanup_out;
 
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
@@ -339,302 +199,36 @@ int __rt_dev_socket(rtdm_user_info_t *user_info, int protocol_family,
 	if (unlikely(ret < 0))
 		goto cleanup_out;
 
-	fildes->context = context;
-
 	trace_mark(xn_rtdm, fd_created,
-		   "device %p fd %d", device, context->fd);
+		"device %p fd %d", device, xnfd_index(&context->fd));
 
-	return context->fd;
+	return xnfd_index(&context->fd);
 
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
+__rt_dev_ioctl_fallback(struct xnfd *fd, unsigned request, void __user *arg)
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
+	if (request != RTIOC_DEVICE_INFO)
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
index aca34f7..d04f427 100644
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
 
+extern void __rt_dev_close(struct xnfd *fd);
+
 int rtdm_no_support(void)
 {
 	return -ENOSYS;
 }
 
-int rtdm_select_bind_no_support(struct rtdm_dev_context *context,
+int rtdm_select_bind_no_support(struct xnfd *fd,
 				struct xnselector *selector,
-				unsigned type,
-				unsigned index)
+				unsigned type)
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
index 17178ee..3f16507 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1884,7 +1884,7 @@ static struct file_operations rtdm_mmap_fops = {
 	.get_unmapped_area = rtdm_unmapped_area
 };
 
-static int rtdm_do_mmap(rtdm_user_info_t *user_info,
+static int rtdm_do_mmap(struct xnfd *fd,
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
+int rtdm_mmap_to_user(struct xnfd *fd,
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
+int rtdm_iomap_to_user(struct xnfd *fd,
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
+int rtdm_munmap(struct xnfd *fd, void *ptr, size_t len)
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
+int rtdm_read_user_ok(struct xnfd *fd, const void __user *ptr,
 		      size_t size);
 
 /**
@@ -2287,7 +2287,7 @@ int rtdm_read_user_ok(rtdm_user_info_t *user_info, const void __user *ptr,
  *
  * Rescheduling: never.
  */
-int rtdm_rw_user_ok(rtdm_user_info_t *user_info, const void __user *ptr,
+int rtdm_rw_user_ok(struct xnfd *fd, const void __user *ptr,
 		    size_t size);
 
 /**
@@ -2316,7 +2316,7 @@ int rtdm_rw_user_ok(rtdm_user_info_t *user_info, const void __user *ptr,
  *
  * Rescheduling: never.
  */
-int rtdm_copy_from_user(rtdm_user_info_t *user_info, void *dst,
+int rtdm_copy_from_user(struct xnfd *fd, void *dst,
 			const void __user *src, size_t size);
 
 /**
@@ -2346,7 +2346,7 @@ int rtdm_copy_from_user(rtdm_user_info_t *user_info, void *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info, void *dst,
+int rtdm_safe_copy_from_user(struct xnfd *fd, void *dst,
 			     const void __user *src, size_t size);
 
 /**
@@ -2375,7 +2375,7 @@ int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info, void *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
+int rtdm_copy_to_user(struct xnfd *fd, void __user *dst,
 		      const void *src, size_t size);
 
 /**
@@ -2405,7 +2405,7 @@ int rtdm_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
+int rtdm_safe_copy_to_user(struct xnfd *fd, void __user *dst,
 			   const void *src, size_t size);
 
 /**
@@ -2436,7 +2436,7 @@ int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info, void __user *dst,
  *
  * Rescheduling: never.
  */
-int rtdm_strncpy_from_user(rtdm_user_info_t *user_info, char *dst,
+int rtdm_strncpy_from_user(struct xnfd *fd, char *dst,
 			   const char __user *src, size_t count);
 
 /**
@@ -2482,7 +2482,7 @@ int rtdm_in_rt_context(void);
  *
  * Rescheduling: never.
  */
-int rtdm_rt_capable(rtdm_user_info_t *user_info);
+int rtdm_rt_capable(struct xnfd *fd);
 
 #endif /* DOXYGEN_CPP */
 
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
index 28ec6ab..0b8cafa 100644
--- a/kernel/cobalt/rtdm/proc.c
+++ b/kernel/cobalt/rtdm/proc.c
@@ -184,40 +184,35 @@ static int openfd_show(struct xnvfile_regular_iterator *it, void *data)
 	struct rtdm_dev_context *context;
 	struct rtdm_device *device;
 	struct rtdm_process owner;
-	int close_lock_count, fd;
-	spl_t s;
+	int close_lock_count, i;
+	struct xnfd *fd;
 
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
+	fd = xnfd_get(&__xnsys_global_ppd, i, RTDM_MAGIC);
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
+	xnfd_put(fd);
+
 	return 0;
 }
 
@@ -230,7 +225,7 @@ static ssize_t openfd_store(struct xnvfile_input *input)
 	if (ret < 0)
 		return ret;
 
-	cret = __rt_dev_close(current, (int)val);
+	cret = xnfd_close(&__xnsys_global_ppd, (int)val, RTDM_MAGIC);
 	if (cret < 0)
 		return cret;
 
diff --git a/kernel/cobalt/rtdm/syscall.c b/kernel/cobalt/rtdm/syscall.c
index 24edd3a..42f8c06 100644
--- a/kernel/cobalt/rtdm/syscall.c
+++ b/kernel/cobalt/rtdm/syscall.c
@@ -24,83 +24,23 @@
 
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
-}
-
-static int sys_rtdm_close(int fd)
-{
-	return __rt_dev_close(current, fd);
-}
-
-static int sys_rtdm_ioctl(int fd, int request, void *arglist)
-{
-	return __rt_dev_ioctl(current, fd, request, arglist);
-}
-
-static int sys_rtdm_read(int fd, void __user *u_buf, size_t nbytes)
-{
-	return __rt_dev_read(current, fd, u_buf, nbytes);
-}
-
-static int sys_rtdm_write(int fd, const void __user *u_buf, size_t nbytes)
-{
-	return __rt_dev_write(current, fd, u_buf, nbytes);
+	return __rt_dev_open(xnsys_ppd_get(0), fd, krnl_path, oflag);
 }
 
-static int sys_rtdm_recvmsg(int fd, struct msghdr __user *u_msg, int flags)
+static int 
+sys_rtdm_socket(int fd, int protocol_family, int socket_type, int protocol)
 {
-	struct task_struct *p = current;
-	struct msghdr krnl_msg;
-	int ret;
-
-	if (unlikely(!access_wok(u_msg, sizeof(krnl_msg)) ||
-		     __xn_copy_from_user(&krnl_msg, u_msg,
-					 sizeof(krnl_msg))))
-		return -EFAULT;
-
-	ret = __rt_dev_recvmsg(p, fd, &krnl_msg, flags);
-	if (unlikely(ret < 0))
-		return ret;
-
-	if (unlikely(__xn_copy_to_user(u_msg, &krnl_msg, sizeof(krnl_msg))))
-		return -EFAULT;
-
-	return ret;
-}
-
-static int sys_rtdm_sendmsg(int fd, const struct msghdr __user *u_msg,
-			    int flags)
-{
-	struct task_struct *p = current;
-	struct msghdr krnl_msg;
-
-	if (unlikely(!access_rok(u_msg, sizeof(krnl_msg)) ||
-		     __xn_copy_from_user(&krnl_msg, u_msg,
-					 sizeof(krnl_msg))))
-		return -EFAULT;
-
-	return __rt_dev_sendmsg(p, fd, &krnl_msg, flags);
+	return __rt_dev_socket(xnsys_ppd_get(0), fd, 
+			protocol_family, socket_type, protocol);
 }
 
 static void *rtdm_process_attach(void)
@@ -123,20 +63,12 @@ static void rtdm_process_detach(void *arg)
 {
 	struct rtdm_process *process = arg;
 
-	cleanup_process_files(process);
 	kfree(process);
 }
 
 static struct xnsyscall rtdm_syscalls[] = {
-	SKINCALL_DEF(sc_rtdm_fdcount, sys_rtdm_fdcount, any),
 	SKINCALL_DEF(sc_rtdm_open, sys_rtdm_open, probing),
 	SKINCALL_DEF(sc_rtdm_socket, sys_rtdm_socket, probing),
-	SKINCALL_DEF(sc_rtdm_close, sys_rtdm_close, probing),
-	SKINCALL_DEF(sc_rtdm_ioctl, sys_rtdm_ioctl, probing),
-	SKINCALL_DEF(sc_rtdm_read, sys_rtdm_read, probing),
-	SKINCALL_DEF(sc_rtdm_write, sys_rtdm_write, probing),
-	SKINCALL_DEF(sc_rtdm_recvmsg, sys_rtdm_recvmsg, probing),
-	SKINCALL_DEF(sc_rtdm_sendmsg, sys_rtdm_sendmsg, probing),
 };
 
 struct xnpersonality rtdm_personality = {
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index d253bb1..21d5411 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -31,7 +31,6 @@
 
 extern int __rtdm_muxid;
 extern int __cobalt_muxid;
-extern int __rtdm_fd_start;
 
 static inline int set_errno(int ret)
 {
@@ -44,8 +43,13 @@ static inline int set_errno(int ret)
 
 COBALT_IMPL(int, open, (const char *path, int oflag, ...))
 {
-	int ret, oldtype;
+	int ret, fd, oldtype;
 	const char *rtdm_path = path;
+	va_list ap;
+
+	fd = open("/dev/null", O_RDONLY);
+	if (fd < 0)
+		return fd;
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
@@ -53,85 +57,78 @@ COBALT_IMPL(int, open, (const char *path, int oflag, ...))
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
+	close(fd);
 
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
+
+	fd = open("/dev/null", O_RDONLY);
+	if (fd < 0)
+		return fd;
 
-	ret = XENOMAI_SKINCALL3(__rtdm_muxid,
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
+	close(fd);
 
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
 
 	ret = XENOMAI_SKINCALL1(__cobalt_muxid, sc_cobalt_close, fd);
-	if (ret != -EBADF) {
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (ret != -EBADF && ret != -ENOSYS) {
 		if (ret == 0)
 			__STD(close(fd));
 		return set_errno(ret);
 	}
 
-	if (fd >= __rtdm_fd_start) {
-		int oldtype;
+	return __STD(close(fd));
+}
 
-		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+static int __xn_ioctl(int fd, unsigned long request, void *arg)
+{
+	int ret, oldtype;
 
-		ret = set_errno(XENOMAI_SKINCALL1(__rtdm_muxid,
-						  sc_rtdm_close,
-						  fd - __rtdm_fd_start));
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-		pthread_setcanceltype(oldtype, NULL);
+	ret = XENOMAI_SKINCALL3(__cobalt_muxid,
+				sc_cobalt_ioctl, 
+				fd, request, arg);
 
-		return ret;
-	} else
-		return __STD(close(fd));
+	pthread_setcanceltype(oldtype, NULL);
 
 	return ret;
 }
@@ -140,24 +137,17 @@ COBALT_IMPL(int, ioctl, (int fd, unsigned long int request, ...))
 {
 	va_list ap;
 	void *arg;
-	int err;
+	int ret;
 
 	va_start(ap, request);
 	arg = va_arg(ap, void *);
 	va_end(ap);
 
-	err = XENOMAI_SKINCALL3(__cobalt_muxid,
-				sc_cobalt_ioctl, fd, request, arg);
-	if (err != -EBADF)
-		return set_errno(err);
-
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
@@ -166,26 +156,14 @@ COBALT_IMPL(ssize_t, read, (int fd, void *buf, size_t nbyte))
 	
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	ret = XENOMAI_SKINCALL3(__cobalt_muxid, sc_cobalt_read, 
+	ret = XENOMAI_SKINCALL3(__cobalt_muxid, 
+				sc_cobalt_read, 
 				fd, buf, nbyte);
 
-	if (ret != -EBADF) {
-		pthread_setcanceltype(oldtype, NULL);
-		return set_errno(ret);
-	}
-
-	if (fd >= __rtdm_fd_start) {
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_read,
-						  fd - __rtdm_fd_start,
-						  buf, nbyte));
-
-		pthread_setcanceltype(oldtype, NULL);
-
-		return ret;
-	}
-
 	pthread_setcanceltype(oldtype, NULL);
+
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
 		
 	return __STD(read(fd, buf, nbyte));
 }
@@ -196,299 +174,232 @@ COBALT_IMPL(ssize_t, write, (int fd, const void *buf, size_t nbyte))
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	ret = XENOMAI_SKINCALL3(__cobalt_muxid, sc_cobalt_write,
+	ret = XENOMAI_SKINCALL3(__cobalt_muxid, 
+				sc_cobalt_write,
 				fd, buf, nbyte);
 
-	if (ret != -EBADF) {
-		pthread_setcanceltype(oldtype, NULL);
-		return set_errno(ret);
-	}
-	
-	if (fd >= __rtdm_fd_start) {
-		ret = set_errno(XENOMAI_SKINCALL3(__rtdm_muxid,
-						  sc_rtdm_write,
-						  fd - __rtdm_fd_start,
-						  buf, nbyte));
-
-		pthread_setcanceltype(oldtype, NULL);
-
-		return ret;
-	}
-
 	pthread_setcanceltype(oldtype, NULL);
 
+	if (ret != -EBADF && ret != -ENOSYS)
+		return set_errno(ret);
+
 	return __STD(write(fd, buf, nbyte));
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
+	ret = XENOMAI_SKINCALL3(__cobalt_muxid, 
+				sc_cobalt_recvmsg, 
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
+	ret = XENOMAI_SKINCALL3(__cobalt_muxid, 
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



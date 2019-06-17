From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] cobalt/rtdm: allow for device teardown
Date: Mon, 17 Jun 2019 17:53:23 +0200
Message-Id: <20190617155323.21337-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

rtdm_dev_unregister() will hang soft until all references on the
dismantled device have been dropped, which in turn cannot happen until
all rtdm_fds on the device have been closed, which cannot happen until
all references on those fds have been dropped eventually. We need a
way to force a teardown on devices, so that rtdm_dev_unregister() will
not hang.

We have three issues to address for this:

- we have no mean of unblocking threads put to sleep by a device
  handler waiting for some event to happen (.read*, .ioctl* etc),
  which prevents the reference on the fd taken on entry to the I/O
  call from being dropped.

- we have to drop the initial reference set when the fd is created.

- the fix must be backward compatible with existing drivers with no
change, even if that means that these drivers cannot benefit from such
fix, but the situation should not be worse than it is today for them
(i.e. rtdm_dev_unregister() would block if fds are still active on the
device).

The solution is to tear down all fds still attached to the device by
calling a new optional fd_ops .teardown() handler which may be
specified by the driver. This handler should unblock any thread
sleeping on the rtdm_fd, typically by flushing the underlying
synchronization object.

New drivers and in-tree ones should implement the teardown handler if
they put threads to sleep in any of their I/O handlers, which most of
them do. The teardown routine should call rtdm_fd_teardown() before
returning for completing the release process.

Drivers which don't block threads should set this handler to
rtdm_fd_teardown() directly.

NOTE: operations on a file descriptor connected to a device which is
being torn down now leads to the ESHUTDOWN error.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/rtdm/driver.h |  5 +++--
 include/cobalt/kernel/rtdm/fd.h     | 10 +++++++++
 kernel/cobalt/rtdm/core.c           | 25 ++++++++++++++++-----
 kernel/cobalt/rtdm/device.c         | 22 ++++++++++++++++--
 kernel/cobalt/rtdm/fd.c             | 35 ++++++++++++++++++++++++++++-
 kernel/cobalt/rtdm/internal.h       |  6 +++++
 6 files changed, 93 insertions(+), 10 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 72f75388d..59461686d 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -234,9 +234,9 @@ struct rtdm_driver;
  * @brief RTDM state management handlers
  */
 struct rtdm_sm_ops {
-	/** Handler called upon transition to COBALT_STATE_WARMUP */ 
+	/** Handler called upon transition to COBALT_STATE_WARMUP */
 	int (*start)(struct rtdm_driver *drv);
-	/** Handler called upon transition to COBALT_STATE_TEARDOWN */ 
+	/** Handler called upon transition to COBALT_STATE_TEARDOWN */
 	int (*stop)(struct rtdm_driver *drv);
 };
 
@@ -385,6 +385,7 @@ struct rtdm_device {
 		atomic_t refcount;
 		struct rtdm_fd_ops ops;
 		wait_queue_head_t putwq;
+		struct list_head openfd_list;
 	};
 };
 
diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 572b17e29..1f801322d 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -289,6 +289,12 @@ struct rtdm_fd_ops {
 					   unsigned long len,
 					   unsigned long pgoff,
 					   unsigned long flags);
+	/**
+	 * Handler called upon device tear down. This routine should
+	 * unblock any waiter sleeping on this channel, then call
+	 * rtdm_fd_teardown() to complete eventually.
+	 */
+	void (*teardown)(struct rtdm_fd *fd);
 };
 
 /** @} File operation handlers */
@@ -304,7 +310,9 @@ struct rtdm_fd {
 #ifdef CONFIG_XENO_ARCH_SYS3264
 	int compat;
 #endif
+	bool stale;
 	struct list_head cleanup;
+	struct list_head next;	/* in dev->openfd_list */
 };
 
 #define RTDM_FD_MAGIC 0x52544446
@@ -353,6 +361,8 @@ int rtdm_fd_enter(struct rtdm_fd *rtdm_fd, int ufd,
 
 int rtdm_fd_register(struct rtdm_fd *fd, int ufd);
 
+void rtdm_fd_teardown(struct rtdm_fd *fd);
+
 struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic);
 
 int rtdm_fd_lock(struct rtdm_fd *fd);
diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index c1aedb3d0..ae7e31e71 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -131,6 +131,23 @@ open_devnode(struct rtdm_device *dev, const char *path, int oflag)
 
 #endif /* !CONFIG_XENO_OPT_RTDM_COMPAT_DEVNODE */
 
+static int register_new_fd(struct rtdm_dev_context *context, int ufd)
+{
+	int ret;
+	spl_t s;
+
+	trace_cobalt_fd_created(&context->fd, ufd);
+	ret = rtdm_fd_register(&context->fd, ufd);
+	if (ret < 0)
+		return ret;
+
+	xnlock_get_irqsave(&nklock, s);
+	list_add(&context->fd.next, &context->device->openfd_list);
+	xnlock_put_irqrestore(&nklock, s);
+
+	return ret;
+}
+
 int __rtdm_dev_open(const char *path, int oflag)
 {
 	struct rtdm_dev_context *context;
@@ -174,7 +191,7 @@ int __rtdm_dev_open(const char *path, int oflag)
 
 	context->fd.minor = dev->minor;
 	context->fd.oflags = oflag;
-	
+
 	trace_cobalt_fd_open(current, &context->fd, ufd, oflag);
 
 	if (dev->ops.open) {
@@ -185,8 +202,7 @@ int __rtdm_dev_open(const char *path, int oflag)
 			goto fail_open;
 	}
 
-	trace_cobalt_fd_created(&context->fd, ufd);
-	ret = rtdm_fd_register(&context->fd, ufd);
+	ret = register_new_fd(context, ufd);
 	if (ret < 0)
 		goto fail_open;
 
@@ -240,8 +256,7 @@ int __rtdm_dev_socket(int protocol_family, int socket_type,
 			goto fail_socket;
 	}
 
-	trace_cobalt_fd_created(&context->fd, ufd);
-	ret = rtdm_fd_register(&context->fd, ufd);
+	ret = register_new_fd(context, ufd);
 	if (ret < 0)
 		goto fail_socket;
 
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 4cfdb1c5b..86191e414 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -417,6 +417,7 @@ int rtdm_dev_register(struct rtdm_device *dev)
 	else
 		dev->ops.open = (typeof(dev->ops.open))enosys;
 
+	INIT_LIST_HEAD(&dev->openfd_list);
 	init_waitqueue_head(&dev->putwq);
 	dev->ops.close = __rtdm_dev_close; /* Interpose on driver's handler. */
 	atomic_set(&dev->refcount, 0);
@@ -524,8 +525,10 @@ EXPORT_SYMBOL_GPL(rtdm_dev_register);
 /**
  * @brief Unregister a RTDM device
  *
- * Removes the device from the RTDM namespace. This routine waits until
- * all connections to @a device have been closed prior to unregistering.
+ * Removes the device from the RTDM namespace. This routine first
+ * attempts to teardown all active connections to the @a device prior
+ * to unregistering. The teardown handler should unblock any thread
+ * sleeping on a resource managed for the connection.
  *
  * @param[in] dev Device descriptor.
  *
@@ -534,6 +537,8 @@ EXPORT_SYMBOL_GPL(rtdm_dev_register);
 void rtdm_dev_unregister(struct rtdm_device *dev)
 {
 	struct rtdm_driver *drv = dev->driver;
+	struct rtdm_fd *fd, *n;
+	spl_t s;
 
 	secondary_mode_only();
 
@@ -542,6 +547,19 @@ void rtdm_dev_unregister(struct rtdm_device *dev)
 	/* Lock out any further connection. */
 	dev->magic = ~RTDM_DEVICE_MAGIC;
 
+	xnlock_get_irqsave(&nklock, s);
+	list_for_each_entry_safe(fd, n, &dev->openfd_list, next) {
+		if (drv->ops.teardown) {
+			rtdm_fd_get_light(fd);
+			fd->stale = true;
+			xnlock_put_irqrestore(&nklock, s);
+			drv->ops.teardown(fd);
+			rtdm_fd_put(fd);
+			xnlock_get_irqsave(&nklock, s);
+		}
+	}
+	xnlock_put_irqrestore(&nklock, s);
+
 	/* Then wait for the ongoing connections to finish. */
 	wait_event(dev->putwq,
 		   atomic_read(&dev->refcount) == 0);
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index f3b6444c3..4b6c5ecf7 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -168,7 +168,9 @@ int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
 	fd->owner = ppd;
 	fd->ufd = ufd;
 	fd->refs = 1;
+	fd->stale = false;
 	set_compat_bit(fd);
+	INIT_LIST_HEAD(&fd->next);
 
 	return 0;
 }
@@ -205,7 +207,9 @@ int rtdm_fd_register(struct rtdm_fd *fd, int ufd)
  * @param[in] magic Magic word for lookup validation
  *
  * @return Pointer to the RTDM file descriptor matching @a ufd, or
- * ERR_PTR(-EBADF).
+ * ERR_PTR(-EBADF) if the use-space handle is
+ * invalid. ERR_PTR(-ESHUTDOWN) is returned if the underlying device
+ * is being torned down at the time of the call.
  *
  * @note The file descriptor returned must be later released by a call
  * to rtdm_fd_put().
@@ -224,6 +228,10 @@ struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic)
 		fd = ERR_PTR(-EBADF);
 		goto out;
 	}
+	if (fd->stale) {
+		fd = ERR_PTR(-ESHUTDOWN);
+		goto out;
+	}
 
 	++fd->refs;
 out:
@@ -274,6 +282,9 @@ static void __put_fd(struct rtdm_fd *fd, spl_t s)
 	int destroy;
 
 	destroy = --fd->refs == 0;
+	if (destroy && !list_empty(&fd->next))
+		list_del(&fd->next);
+
 	xnlock_put_irqrestore(&fdtree_lock, s);
 
 	if (!destroy)
@@ -316,6 +327,28 @@ void rtdm_fd_put(struct rtdm_fd *fd)
 }
 EXPORT_SYMBOL_GPL(rtdm_fd_put);
 
+/**
+ * @brief Force a teardown on a RTDM file descriptor
+ *
+ * @param[in] fd RTDM file descriptor to tear down
+ *
+ * This call drops the initial reference on @fd. The device managing
+ * the connection represented by @fd is prevented from unloading until
+ * all references are dropped.
+ *
+ * @note This service must be called at device teardown, typically
+ * from a driver's fd_ops->teardown() handler.
+ *
+ * @coretags{secondary-only}
+ */
+void rtdm_fd_teardown(struct rtdm_fd *fd)
+{
+	secondary_mode_only();
+
+	rtdm_fd_put(fd);
+}
+EXPORT_SYMBOL_GPL(rtdm_fd_teardown);
+
 /**
  * @brief Hold a reference on a RTDM file descriptor
  *
diff --git a/kernel/cobalt/rtdm/internal.h b/kernel/cobalt/rtdm/internal.h
index b634bd997..99488e058 100644
--- a/kernel/cobalt/rtdm/internal.h
+++ b/kernel/cobalt/rtdm/internal.h
@@ -49,6 +49,12 @@ int __rtdm_dev_ioctl_core(struct rtdm_fd *fd,
 int __rtdm_mmap_from_fdop(struct rtdm_fd *fd, size_t len, off_t offset,
 			  int prot, int flags, void **pptr);
 
+/* nklock held, irqs off. */
+static inline void rtdm_fd_get_light(struct rtdm_fd *fd)
+{
+	++fd->refs;
+}
+
 int rtdm_init(void);
 
 void rtdm_cleanup(void);
-- 
2.21.0



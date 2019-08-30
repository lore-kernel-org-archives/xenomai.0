From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v4 2/2] cobalt/rtdm: allow for device teardown
Date: Fri, 30 Aug 2019 18:03:14 +0200
Message-Id: <20190830160314.29441-2-rpm@xenomai.org>
In-Reply-To: <20190830160314.29441-1-rpm@xenomai.org>
References: <20190830160314.29441-1-rpm@xenomai.org>
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

Currently, rtdm_dev_unregister() will hang soft until all references
on the dismantled device have been dropped, which in turn cannot
happen until all rtdm_fds on the device have been closed, which cannot
happen until all references on those fds have been dropped eventually.
Unfortunately, applications have no indication that such teardown has
been requested, and keep sleeping on I/O channels managed by the
dismantled device, which prevents rtdm_dev_unregister() from
completing.

Allow for orderly device teardown by tracking all file descriptors
representing connections active on a device, forcing each of them down
by calling the driver's close() handler from rtdm_dev_unregister().
Since a close() handler should abort any ongoing I/O operation on the
channel being dismantled, any blocking I/O call on such channel should
return on error with no additional change to the existing drivers. The
common error code indicating an aborted I/O operation in this case is
EBADF.

Upon receiving the error, the application is expected to close the
stale file descriptor and/or exit, which would drop the corresponding
file reference.

Stale file descriptors lingering in applications will still prevent
driver modules serving them from unloading until they are eventually
closed. Subsequent operations on a file descriptor connected to a
device which is being torn now down lead to the EBADF error.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/list.h        |  2 +-
 include/cobalt/kernel/rtdm/driver.h |  1 +
 include/cobalt/kernel/rtdm/fd.h     |  2 ++
 kernel/cobalt/rtdm/core.c           | 25 ++++++++++++++++++++-----
 kernel/cobalt/rtdm/device.c         | 24 ++++++++++++++++++++++--
 kernel/cobalt/rtdm/fd.c             | 13 +++++++++++--
 kernel/cobalt/rtdm/internal.h       |  6 ++++++
 7 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/include/cobalt/kernel/list.h b/include/cobalt/kernel/list.h
index 989d934b8..37b91b0d5 100644
--- a/include/cobalt/kernel/list.h
+++ b/include/cobalt/kernel/list.h
@@ -45,7 +45,7 @@ do {										\
   ({								\
 	  __type *__item;					\
 	  __item = list_first_entry(__head, __type, __member);	\
-	  list_del(&__item->__member);				\
+	  list_del(&(__item)->__member);			\
 	  __item;						\
   })
 
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 72f75388d..3559a6f99 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -385,6 +385,7 @@ struct rtdm_device {
 		atomic_t refcount;
 		struct rtdm_fd_ops ops;
 		wait_queue_head_t putwq;
+		struct list_head openfd_list;
 	};
 };
 
diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 572b17e29..30849fc79 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -304,7 +304,9 @@ struct rtdm_fd {
 #ifdef CONFIG_XENO_ARCH_SYS3264
 	int compat;
 #endif
+	bool stale;
 	struct list_head cleanup;
+	struct list_head next;	/* in dev->openfd_list */
 };
 
 #define RTDM_FD_MAGIC 0x52544446
diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index 28db7adb7..b9b7319fe 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -54,7 +54,7 @@ void __rtdm_dev_close(struct rtdm_fd *fd)
 	struct rtdm_device *dev = context->device;
 	struct rtdm_driver *drv = dev->driver;
 
-	if (drv->ops.close)
+	if (!fd->stale && drv->ops.close)
 		drv->ops.close(fd);
 
 	cleanup_instance(dev, context);
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
index 4cfdb1c5b..ea72be15c 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -417,6 +417,7 @@ int rtdm_dev_register(struct rtdm_device *dev)
 	else
 		dev->ops.open = (typeof(dev->ops.open))enosys;
 
+	INIT_LIST_HEAD(&dev->openfd_list);
 	init_waitqueue_head(&dev->putwq);
 	dev->ops.close = __rtdm_dev_close; /* Interpose on driver's handler. */
 	atomic_set(&dev->refcount, 0);
@@ -524,8 +525,9 @@ EXPORT_SYMBOL_GPL(rtdm_dev_register);
 /**
  * @brief Unregister a RTDM device
  *
- * Removes the device from the RTDM namespace. This routine waits until
- * all connections to @a device have been closed prior to unregistering.
+ * Removes the device from the RTDM namespace. This routine first
+ * attempts to teardown all active connections to the @a device prior
+ * to unregistering.
  *
  * @param[in] dev Device descriptor.
  *
@@ -534,6 +536,8 @@ EXPORT_SYMBOL_GPL(rtdm_dev_register);
 void rtdm_dev_unregister(struct rtdm_device *dev)
 {
 	struct rtdm_driver *drv = dev->driver;
+	struct rtdm_fd *fd;
+	spl_t s;
 
 	secondary_mode_only();
 
@@ -542,6 +546,22 @@ void rtdm_dev_unregister(struct rtdm_device *dev)
 	/* Lock out any further connection. */
 	dev->magic = ~RTDM_DEVICE_MAGIC;
 
+	xnlock_get_irqsave(&nklock, s);
+	for (;;) {
+		fd = list_get_entry(&dev->openfd_list, struct rtdm_fd, next);
+		if (fd == NULL)
+			break;
+		fd->stale = true;
+		if (drv->ops.close) {
+			rtdm_fd_get_light(fd);
+			xnlock_put_irqrestore(&nklock, s);
+			drv->ops.close(fd);
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
index d965aafef..dce1f05a1 100644
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
@@ -231,6 +233,11 @@ struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic)
 		goto out;
 	}
 
+	if (fd->stale) {
+		fd = ERR_PTR(-EBADF);
+		goto out;
+	}
+
 	++fd->refs;
 out:
 	xnlock_put_irqrestore(&fdtree_lock, s);
@@ -279,7 +286,11 @@ static void __put_fd(struct rtdm_fd *fd, spl_t s)
 {
 	int destroy;
 
+	XENO_WARN_ON(COBALT, fd->refs <= 0);
 	destroy = --fd->refs == 0;
+	if (destroy && !list_empty(&fd->next))
+		list_del(&fd->next);
+
 	xnlock_put_irqrestore(&fdtree_lock, s);
 
 	if (!destroy)
@@ -367,8 +378,6 @@ void rtdm_fd_unlock(struct rtdm_fd *fd)
 	spl_t s;
 
 	xnlock_get_irqsave(&fdtree_lock, s);
-	/* Warn if fd was unreferenced. */
-	XENO_WARN_ON(COBALT, fd->refs <= 0);
 	__put_fd(fd, s);
 }
 EXPORT_SYMBOL_GPL(rtdm_fd_unlock);
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



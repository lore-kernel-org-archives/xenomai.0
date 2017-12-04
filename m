From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sun,  3 Dec 2017 22:22:24 -0500
Message-Id: <1512357744-120225-1-git-send-email-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH] Split rtdm_fd_enter up,
	move the functionality where we store the fd until after the open()
	call succeeds. Calls where open() fail a fd is left in the
	tree even after the cleanup code is executed. If this fd
	number is used again we will fail the call to open until a
	different fd is used. This patch addresses this situation by
	not adding the fd into the tree until open has succeeded and
	the fd is valid.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 include/cobalt/kernel/rtdm/fd.h |  2 ++
 kernel/cobalt/posix/mqueue.c    |  7 ++++++-
 kernel/cobalt/posix/timerfd.c   |  4 ++++
 kernel/cobalt/rtdm/core.c       | 12 +++++++++---
 kernel/cobalt/rtdm/fd.c         | 24 ++++++++++++++++--------
 5 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 086b04b..e504c0c 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -345,6 +345,8 @@ static inline int rtdm_fd_is_compat(const struct rtdm_fd *fd)
 int rtdm_fd_enter(struct rtdm_fd *rtdm_fd, int ufd,
 		  unsigned int magic, struct rtdm_fd_ops *ops);
 
+int rtdm_fd_register(struct rtdm_fd *fd, int ufd);
+
 struct rtdm_fd *rtdm_fd_get(int ufd, unsigned int magic);
 
 int rtdm_fd_lock(struct rtdm_fd *fd);
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 6357d22..859e12e 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -267,6 +267,7 @@ static struct rtdm_fd_ops mqd_ops = {
 static inline int mqd_create(struct cobalt_mq *mq, unsigned long flags, int ufd)
 {
 	struct cobalt_mqd *mqd;
+	int ret;
 
 	if (cobalt_ppd_get(0) == &cobalt_kernel_ppd)
 		return -EPERM;
@@ -278,7 +279,11 @@ static inline int mqd_create(struct cobalt_mq *mq, unsigned long flags, int ufd)
 	mqd->fd.oflags = flags;
 	mqd->mq = mq;
 
-	return rtdm_fd_enter(&mqd->fd, ufd, COBALT_MQD_MAGIC, &mqd_ops);
+	ret = rtdm_fd_enter(&mqd->fd, ufd, COBALT_MQD_MAGIC, &mqd_ops);
+	if (ret < 0)
+		return ret;
+
+	return rtdm_fd_register(&mqd->fd, ufd);
 }
 
 static int mq_open(int uqd, const char *name, int oflags,
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 51e7605..217e68a 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -202,6 +202,10 @@ COBALT_SYSCALL(timerfd_create, lostage, (int clockid, int flags))
 	if (ret < 0)
 		goto fail;
 
+	ret = rtdm_fd_register(&tfd->fd, ufd);
+	if (ret < 0)
+		goto fail;
+
 	return ufd;
 fail:
 	xnselect_destroy(&tfd->read_select);
diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index 05f273f..01d9caf 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -174,7 +174,7 @@ int __rtdm_dev_open(const char *path, int oflag)
 
 	context->fd.minor = dev->minor;
 	context->fd.oflags = oflag;
-
+	
 	trace_cobalt_fd_open(current, &context->fd, ufd, oflag);
 
 	if (dev->ops.open) {
@@ -185,9 +185,12 @@ int __rtdm_dev_open(const char *path, int oflag)
 			goto fail_open;
 	}
 
-	fd_install(ufd, filp);
-
 	trace_cobalt_fd_created(&context->fd, ufd);
+	ret = rtdm_fd_register(&context->fd, ufd);
+	if (ret < 0)
+		goto fail_open;
+
+	fd_install(ufd, filp);
 
 	return ufd;
 
@@ -238,6 +241,9 @@ int __rtdm_dev_socket(int protocol_family, int socket_type,
 	}
 
 	trace_cobalt_fd_created(&context->fd, ufd);
+	ret = rtdm_fd_register(&context->fd, ufd);
+	if (ret < 0)
+		goto fail_socket;
 
 	return ufd;
 
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index ffcd3aa..e355526 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -145,20 +145,13 @@ static inline void set_compat_bit(struct rtdm_fd *fd)
 int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
 		  struct rtdm_fd_ops *ops)
 {
-	struct rtdm_fd_index *idx;
 	struct cobalt_ppd *ppd;
-	spl_t s;
-	int ret;
-
+	
 	secondary_mode_only();
 
 	if (magic == 0)
 		return -EINVAL;
 
-	idx = kmalloc(sizeof(*idx), GFP_KERNEL);
-	if (idx == NULL)
-		return -ENOMEM;
-
 	assign_default_dual_handlers(ops->ioctl);
 	assign_default_dual_handlers(ops->read);
 	assign_default_dual_handlers(ops->write);
@@ -175,6 +168,21 @@ int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
 	fd->refs = 1;
 	set_compat_bit(fd);
 
+	return 0;
+}
+
+int rtdm_fd_register(struct rtdm_fd *fd, int ufd)
+{
+	struct rtdm_fd_index *idx;
+	struct cobalt_ppd *ppd;
+	spl_t s;
+	int ret = 0;
+
+	ppd = cobalt_ppd_get(0);
+	idx = kmalloc(sizeof(*idx), GFP_KERNEL);
+	if (idx == NULL)
+		return -ENOMEM;
+
 	idx->fd = fd;
 
 	xnlock_get_irqsave(&fdtree_lock, s);
-- 
2.7.4



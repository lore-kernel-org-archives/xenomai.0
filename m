From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date: Tue, 16 Oct 2018 09:56:10 +0200
Message-Id: <1539676570-4773-1-git-send-email-sebastian.smolorz@gmx.de>
Subject: [Xenomai] [PATCH] rtdm: add integer file descriptor to struct
 rtdm_fd
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

RTDM drivers refer to open files or sockets by using struct rtdm_fd.
Normally, the integer file descriptor returned by socket() or open() calls
is not necessary for driver operations. However, in some special cases
this value has to be determined. To ease the retrieval of this value for
those drivers it is added directly to struct rtdm_fd. Otherwise it would
be necessary to iterate over the fd's rb_tree.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 include/cobalt/kernel/rtdm/fd.h | 6 ++++++
 kernel/cobalt/rtdm/fd.c         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 58d3c4a..572b17e 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -298,6 +298,7 @@ struct rtdm_fd {
 	struct rtdm_fd_ops *ops;
 	struct cobalt_ppd *owner;
 	unsigned int refs;
+	int ufd;
 	int minor;
 	int oflags;
 #ifdef CONFIG_XENO_ARCH_SYS3264
@@ -320,6 +321,11 @@ static inline struct cobalt_ppd *rtdm_fd_owner(const struct rtdm_fd *fd)
 	return fd->owner;
 }
 
+static inline int rtdm_fd_ufd(const struct rtdm_fd *fd)
+{
+	return fd->ufd;
+}
+
 static inline int rtdm_fd_minor(const struct rtdm_fd *fd)
 {
 	return fd->minor;
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 8d577b2..807a11e 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -166,6 +166,7 @@ int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
 	fd->magic = magic;
 	fd->ops = ops;
 	fd->owner = ppd;
+	fd->ufd = ufd;
 	fd->refs = 1;
 	set_compat_bit(fd);
 
-- 
2.7.4



From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/9] cobalt/rtdm/fd: Fix default handler setups
Date: Mon,  5 Jul 2021 09:36:37 +0200
Message-Id: <3b7f4bc45d90dadad263ec036381e9a652b0a714.1625470600.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625470600.git.jan.kiszka@siemens.com>
References: <cover.1625470600.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

2db562ad62ec had a point in avoiding EBADF for file descriptors that are
not under RTDM management. But it unfortunately got a lot of other cases
wrong along this.

This one is about returning the right error code if an RTDM driver does
not implement a particular handler. That must never be EADV because that
error would signal "not an RTDM fd, retry with Linux" which is obviously
wrong. Even worse, mmap clearly defines the right error to return in
case it is not implemented, and that is ENODEV as was returned before.

So this restores ENODEV as invalid default for mmap, uses ENOTTY for
unimplemented IOCTL and switches all others to EBADF which is a match
for select and a reasonable choice for read/write/recvmsg/sendmsg.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 61 ++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index e5e0c02376..8e4e15e794 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -52,9 +52,19 @@ static int enosys(void)
 	return -ENOSYS;
 }
 
-static int eadv(void)
+static int enotty(void)
 {
-	return -EADV;
+	return -ENOTTY;
+}
+
+static int ebadf(void)
+{
+	return -EBADF;
+}
+
+static int enodev(void)
+{
+	return -ENODEV;
 }
 
 static inline struct rtdm_fd_index *
@@ -76,24 +86,23 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
 	return idx->fd;
 }
 
-#define assign_invalid_handler(__handler)				\
+#define assign_invalid_handler(__handler, __invalid)			\
 	do								\
-		(__handler) = (typeof(__handler))eadv;			\
+		(__handler) = (typeof(__handler))__invalid;		\
 	while (0)
 
-#define __assign_default_handler(__handler, __placeholder)		\
+/* Calling this handler should beget ENOSYS if not implemented. */
+#define assign_switch_handler(__handler)				\
 	do								\
 		if ((__handler) == NULL)				\
-			(__handler) = (typeof(__handler))__placeholder;	\
+			assign_invalid_handler(__handler, enosys);	\
 	while (0)
 
-/* Calling this handler should beget EADV if not implemented. */
-#define assign_invalid_default_handler(__handler)			\
-	__assign_default_handler(__handler, eadv)
-
-/* Calling this handler should beget ENOSYS if not implemented. */
-#define assign_default_handler(__handler)				\
-	__assign_default_handler(__handler, enosys)
+#define assign_default_handler(__handler, __invalid)			\
+	do								\
+		if ((__handler) == NULL)				\
+			assign_invalid_handler(__handler, __invalid);	\
+	while (0)
 
 #define __rt(__handler)		__handler ## _rt
 #define __nrt(__handler)	__handler ## _nrt
@@ -103,14 +112,16 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
  * are implemented, ENOSYS otherwise for NULL handlers to trigger the
  * adaptive switch.
  */
-#define assign_default_dual_handlers(__handler)				\
+#define assign_default_dual_handlers(__handler, __invalid_handler)	\
 	do								\
 		if (__rt(__handler) || __nrt(__handler)) {		\
-			assign_default_handler(__rt(__handler));	\
-			assign_default_handler(__nrt(__handler));	\
+			assign_switch_handler(__rt(__handler));		\
+			assign_switch_handler(__nrt(__handler));	\
 		} else {						\
-			assign_invalid_handler(__rt(__handler));	\
-			assign_invalid_handler(__nrt(__handler));	\
+			assign_invalid_handler(__rt(__handler),		\
+					       __invalid_handler);	\
+			assign_invalid_handler(__nrt(__handler),	\
+					       __invalid_handler);	\
 		}							\
 	while (0)
 
@@ -147,13 +158,13 @@ int rtdm_fd_enter(struct rtdm_fd *fd, int ufd, unsigned int magic,
 	if (magic == 0)
 		return -EINVAL;
 
-	assign_default_dual_handlers(ops->ioctl);
-	assign_default_dual_handlers(ops->read);
-	assign_default_dual_handlers(ops->write);
-	assign_default_dual_handlers(ops->recvmsg);
-	assign_default_dual_handlers(ops->sendmsg);
-	assign_invalid_default_handler(ops->select);
-	assign_invalid_default_handler(ops->mmap);
+	assign_default_dual_handlers(ops->ioctl, enotty);
+	assign_default_dual_handlers(ops->read, ebadf);
+	assign_default_dual_handlers(ops->write, ebadf);
+	assign_default_dual_handlers(ops->recvmsg, ebadf);
+	assign_default_dual_handlers(ops->sendmsg, ebadf);
+	assign_default_handler(ops->select, ebadf);
+	assign_default_handler(ops->mmap, enodev);
 
 	ppd = cobalt_ppd_get(0);
 	fd->magic = magic;
-- 
2.26.2



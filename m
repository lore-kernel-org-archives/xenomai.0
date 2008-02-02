From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AwQ+ef14yH"
Content-Transfer-Encoding: 7bit
Message-ID: <18340.31655.777349.789045@domain.hid>
Date: Sat, 2 Feb 2008 15:18:15 +0100
In-Reply-To: <18340.31323.677695.655702@domain.hid>
References: <18340.31233.591834.293535@domain.hid>
	<18340.31323.677695.655702@domain.hid>
Subject: [Xenomai-core] [PATCH 5/5] RTDM: check file descriptor owner.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--AwQ+ef14yH
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


This patch makes RTDM service rtdm_context_get check the owner of a file
descriptor. This will prevent a process to close an RTDM file descriptor
belonging to another process.

Stats:
 include/rtdm/rtdm.h        |    2 +-
 include/rtdm/rtdm_driver.h |    2 +-
 ksrc/skins/posix/syscall.c |    5 +++--
 ksrc/skins/rtdm/core.c     |   15 +++++++++------
 4 files changed, 14 insertions(+), 10 deletions(-)

-- 


					    Gilles Chanteperdrix.

--AwQ+ef14yH
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-rtdm-check-owner.diff"
Content-Transfer-Encoding: 7bit

diff -Naurdp -x '*~' trunk/include/rtdm/rtdm.h rtdm_check_context/include/rtdm/rtdm.h
--- trunk/include/rtdm/rtdm.h	2008-01-25 21:20:40.000000000 +0100
+++ rtdm_check_context/include/rtdm/rtdm.h	2008-02-02 14:22:36.000000000 +0100
@@ -248,7 +248,7 @@ ssize_t __rt_dev_recvmsg(rtdm_user_info_
 ssize_t __rt_dev_sendmsg(rtdm_user_info_t *user_info, int fd,
 			 const struct msghdr *msg, int flags);
 struct xnselector;
-int __rt_dev_select_bind(int fd,
+int __rt_dev_select_bind(rtdm_user_info_t *user_info, int fd,
 			 struct xnselector *selector,
 			 unsigned type, unsigned index);
 #endif /* __KERNEL__ */
diff -Naurdp -x '*~' trunk/include/rtdm/rtdm_driver.h rtdm_check_context/include/rtdm/rtdm_driver.h
--- trunk/include/rtdm/rtdm_driver.h	2008-01-25 21:33:13.000000000 +0100
+++ rtdm_check_context/include/rtdm/rtdm_driver.h	2008-02-02 14:16:18.000000000 +0100
@@ -461,7 +461,7 @@ int rtdm_dev_unregister(struct rtdm_devi
 #define rtdm_getpeername	rt_dev_getpeername
 #define rtdm_shutdown		rt_dev_shutdown
 
-struct rtdm_dev_context *rtdm_context_get(int fd);
+struct rtdm_dev_context *rtdm_context_get(rtdm_user_info_t *user_info, int fd);
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline void rtdm_context_lock(struct rtdm_dev_context *context)
diff -Naurdp -x '*~' trunk/ksrc/skins/posix/syscall.c rtdm_check_context/ksrc/skins/posix/syscall.c
--- trunk/ksrc/skins/posix/syscall.c	2008-02-02 14:30:56.000000000 +0100
+++ rtdm_check_context/ksrc/skins/posix/syscall.c	2008-02-02 14:33:30.000000000 +0100
@@ -1898,7 +1898,7 @@ static int fd_valid_p(int fd)
 	
 	if (fd >= rtdm_fd_start) {
 		struct rtdm_dev_context *ctx;
-		ctx = rtdm_context_get(fd - rtdm_fd_start);
+		ctx = rtdm_context_get(current, fd - rtdm_fd_start);
 		if (ctx) {
 			rtdm_context_unlock(ctx);
 			return 1;
@@ -1930,7 +1930,8 @@ static int select_bind_one(struct xnsele
 	const int rtdm_fd_start = FD_SETSIZE - RTDM_FD_MAX;
 	
 	if (fd >= rtdm_fd_start)
-		return __rt_dev_select_bind(fd - rtdm_fd_start,
+		return __rt_dev_select_bind(current,
+					    fd - rtdm_fd_start,
 					    selector, type, fd);
 #endif /* CONFIG_XENO_SKIN_RTDM */
 
diff -Naurdp -x '*~' trunk/ksrc/skins/rtdm/core.c rtdm_check_context/ksrc/skins/rtdm/core.c
--- trunk/ksrc/skins/rtdm/core.c	2008-01-25 21:20:40.000000000 +0100
+++ rtdm_check_context/ksrc/skins/rtdm/core.c	2008-02-02 14:20:06.000000000 +0100
@@ -70,7 +70,7 @@ DEFINE_XNLOCK(rt_fildes_lock);
  *
  * Rescheduling: never.
  */
-struct rtdm_dev_context *rtdm_context_get(int fd)
+struct rtdm_dev_context *rtdm_context_get(rtdm_user_info_t *user_info, int fd)
 {
 	struct rtdm_dev_context *context;
 	spl_t s;
@@ -82,7 +82,9 @@ struct rtdm_dev_context *rtdm_context_ge
 
 	context = fildes_table[fd].context;
 	if (unlikely(!context ||
-		     test_bit(RTDM_CLOSING, &context->context_flags))) {
+		     test_bit(RTDM_CLOSING, &context->context_flags) ||
+		     context->reserved.owner != (user_info
+						 ? user_info->mm : NULL))) {
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
 		return NULL;
 	}
@@ -294,7 +296,7 @@ err_out:
 
 EXPORT_SYMBOL(__rt_dev_socket);
 
-int __rt_dev_select_bind(int fd,
+int __rt_dev_select_bind(rtdm_user_info_t *user_info, int fd,
 			 struct xnselector *selector,
 			 unsigned type, unsigned index)
 {
@@ -302,7 +304,7 @@ int __rt_dev_select_bind(int fd,
 	struct rtdm_operations  *ops;
 	int ret;
 
-	context = rtdm_context_get(fd);
+	context = rtdm_context_get(user_info, fd);
 
 	ret = -EBADF;
 	if (unlikely(!context))
@@ -338,7 +340,8 @@ again:
 
 	context = fildes_table[fd].context;
 
-	if (unlikely(!context)) {
+	if (unlikely(!context ||
+		     (user_info && context->reserved.owner != user_info->mm))) {
 		xnlock_put_irqrestore(&rt_fildes_lock, s);
 		goto err_out;	/* -EBADF */
 	}
@@ -434,7 +437,7 @@ do {									\
 	struct rtdm_operations *ops;					\
 	int ret;							\
 									\
-	context = rtdm_context_get(fd);					\
+	context = rtdm_context_get(user_info, fd);			\
 	ret = -EBADF;							\
 	if (unlikely(!context))						\
 		goto err_out;						\

--AwQ+ef14yH--


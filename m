Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 3/5] y2038: cobalt/posix/muqueue: Adding mq_timedreceive64
Date: Tue,  8 Jun 2021 10:12:13 +0800
Message-Id: <1623118333-7429-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

Add a syscall specific for mq_timedreceive with 64bit
time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/mqueue.c    | 28 ++++++++++++++++++++++++++++
 kernel/cobalt/posix/mqueue.h    | 11 +++++++++++
 kernel/cobalt/posix/syscall32.c | 10 ++++++++++
 kernel/cobalt/posix/syscall32.h |  6 ++++++
 5 files changed, 56 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 464e170..c27d6d0 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -130,6 +130,7 @@
 #define sc_cobalt_clock_adjtime64		107
 #define sc_cobalt_mutex_timedlock64		108
 #define sc_cobalt_mq_timedsend64		109
+#define sc_cobalt_mq_timedreceive64		110
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 9179427..2bb2fb7 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -1031,3 +1031,31 @@ COBALT_SYSCALL(mq_timedreceive, primary,
 
 	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
 }
+
+int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
+				 ssize_t __user *u_len,
+			     unsigned int __user *u_prio,
+			     const void __user *u_ts)
+{
+	ssize_t len;
+	int ret;
+
+	ret = cobalt_copy_from_user(&len, u_len, sizeof(len));
+	if (ret)
+		return ret;
+
+	ret = __cobalt_mq_timedreceive(uqd, u_buf, &len, u_prio,
+				       u_ts, u_ts ? mq_fetch_timeout64 : NULL);
+
+	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
+}
+
+COBALT_SYSCALL(mq_timedreceive64, primary,
+	       (mqd_t uqd, void __user *u_buf,
+		ssize_t __user *u_len,
+		unsigned int __user *u_prio,
+		const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio,
+				       u_ts);
+}
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index f8414f4..6ef986b 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -50,6 +50,11 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 			     int (*fetch_timeout)(struct timespec64 *ts,
 						  const void __user *u_ts));
 
+int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
+				 ssize_t __user *u_len,
+			     unsigned int __user *u_prio,
+			     const void __user *u_ts);
+
 int __cobalt_mq_notify(mqd_t fd, const struct sigevent *evp);
 
 COBALT_SYSCALL_DECL(mq_open,
@@ -76,6 +81,12 @@ COBALT_SYSCALL_DECL(mq_timedreceive,
 		     unsigned int __user *u_prio,
 		     const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL(mq_timedreceive64, primary,
+	       (mqd_t uqd, void __user *u_buf,
+		ssize_t __user *u_len,
+		unsigned int __user *u_prio,
+		const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(mq_notify,
 		    (mqd_t fd, const struct sigevent *__user evp));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 716fc16..e24c96a 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -354,6 +354,16 @@ COBALT_SYSCALL32emu(mq_timedreceive, primary,
 	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
 }
 
+COBALT_SYSCALL32emu(mq_timedreceive64, primary,
+		    (mqd_t uqd, void __user *u_buf,
+		     ssize_t __user *u_len,
+		     unsigned int __user *u_prio,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio,
+				       u_ts);
+}
+
 static inline int mq_fetch_timeout(struct timespec64 *ts,
 				   const void __user *u_ts)
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index dd0e43d..3a551b9 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -132,6 +132,12 @@ COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			  unsigned int __user *u_prio,
 			  const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu(mq_timedreceive64, primary,
+		    (mqd_t uqd, void __user *u_buf,
+		     ssize_t __user *u_len,
+		     unsigned int __user *u_prio,
+		     const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(mq_notify,
 			 (mqd_t fd, const struct compat_sigevent *__user u_cev));
 
-- 
2.7.4



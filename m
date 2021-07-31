From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 3/5] y2038: cobalt/posix/muqueue: Adding mq_timedreceive64
Date: Sat, 31 Jul 2021 09:19:40 +0200
Message-Id: <20210731071942.69806-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210731071942.69806-1-florian.bezdeka@siemens.com>
References: <20210731071942.69806-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Song Chen <chensong_2000@189.cn>

Add a syscall specific for mq_timedreceive64 with 64bit time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
[Florian: Reformat commit msg, relocate code, tracing, fix compat decl]
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h      |  1 +
 kernel/cobalt/posix/mqueue.c       | 26 ++++++++++++++++++++++++++
 kernel/cobalt/posix/mqueue.h       | 10 ++++++++++
 kernel/cobalt/posix/syscall32.c    |  8 ++++++++
 kernel/cobalt/posix/syscall32.h    |  5 +++++
 kernel/cobalt/trace/cobalt-posix.h |  3 ++-
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 464e170cc..c27d6d044 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -130,6 +130,7 @@
 #define sc_cobalt_clock_adjtime64		107
 #define sc_cobalt_mutex_timedlock64		108
 #define sc_cobalt_mq_timedsend64		109
+#define sc_cobalt_mq_timedreceive64		110
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index db8fb4f09..06258ac7d 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -1013,6 +1013,24 @@ fail:
 	return ret;
 }
 
+int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
+			       ssize_t __user *u_len,
+			       unsigned int __user *u_prio,
+			       const void __user *u_ts)
+{
+	ssize_t len;
+	int ret;
+
+	ret = cobalt_copy_from_user(&len, u_len, sizeof(len));
+	if (ret)
+		return ret;
+
+	ret = __cobalt_mq_timedreceive(uqd, u_buf, &len, u_prio, u_ts,
+				       u_ts ? mq_fetch_timeout64 : NULL);
+
+	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
+}
+
 COBALT_SYSCALL(mq_timedreceive, primary,
 	       (mqd_t uqd, void __user *u_buf,
 		ssize_t __user *u_len,
@@ -1031,3 +1049,11 @@ COBALT_SYSCALL(mq_timedreceive, primary,
 
 	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
 }
+
+COBALT_SYSCALL(mq_timedreceive64, primary,
+	       (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+		unsigned int __user *u_prio,
+		const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio, u_ts);
+}
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index f16774a3b..35d81378b 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -50,6 +50,11 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 			     int (*fetch_timeout)(struct timespec64 *ts,
 						  const void __user *u_ts));
 
+int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
+			       ssize_t __user *u_len,
+			       unsigned int __user *u_prio,
+			       const void __user *u_ts);
+
 int __cobalt_mq_notify(mqd_t fd, const struct sigevent *evp);
 
 COBALT_SYSCALL_DECL(mq_open,
@@ -76,6 +81,11 @@ COBALT_SYSCALL_DECL(mq_timedreceive,
 		     unsigned int __user *u_prio,
 		     const struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL(mq_timedreceive64, primary,
+	       (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+		unsigned int __user *u_prio,
+		const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(mq_notify,
 		    (mqd_t fd, const struct sigevent *__user evp));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index d3f87c246..d52be0207 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -354,6 +354,14 @@ COBALT_SYSCALL32emu(mq_timedreceive, primary,
 	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
 }
 
+COBALT_SYSCALL32emu(mq_timedreceive64, primary,
+		    (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+		     unsigned int __user *u_prio,
+		     const struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio, u_ts);
+}
+
 static inline int mq_fetch_timeout(struct timespec64 *ts,
 				   const void __user *u_ts)
 {
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 0e552202e..006054e85 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -132,6 +132,11 @@ COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			  unsigned int __user *u_prio,
 			  const struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(mq_timedreceive64,
+			 (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+			  unsigned int __user *u_prio,
+			  const struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(mq_notify,
 			 (mqd_t fd, const struct compat_sigevent *__user u_cev));
 
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 476a54f97..a88579bdf 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -162,7 +162,8 @@
 		__cobalt_symbolic_syscall(clock_getres64),		\
 		__cobalt_symbolic_syscall(clock_adjtime64),		\
 		__cobalt_symbolic_syscall(mutex_timedlock64),		\
-		__cobalt_symbolic_syscall(mq_timedsend64))
+		__cobalt_symbolic_syscall(mq_timedsend64),  		\
+		__cobalt_symbolic_syscall(mq_timedreceive64))
 
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
-- 
2.30.2



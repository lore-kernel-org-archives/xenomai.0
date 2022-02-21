From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/3] y2038: posix/mqueue: Fix compat case for mq_timedreceive64
Date: Mon, 21 Feb 2022 14:25:02 +0100
Message-Id: <20220221132504.55876-2-florian.bezdeka@siemens.com>
In-Reply-To: <20220221132504.55876-1-florian.bezdeka@siemens.com>
References: <20220221132504.55876-1-florian.bezdeka@siemens.com>
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
Cc: jan.kiszka@siemens.com, johannes.lauenstein@siemens.com, Florian Bezdeka <florian.bezdeka@siemens.com>

There is a pointer to ssize_t part of the ABI. The pointer itself is
autocorrected by the syscall enter machinery, but when reading/writing
we have to care about different sizes between compat and native case.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../x86/include/asm/xenomai/syscall32-table.h |  1 +
 kernel/cobalt/posix/mqueue.c                  | 26 +++++++++----------
 kernel/cobalt/posix/mqueue.h                  |  2 +-
 kernel/cobalt/posix/syscall32.c               | 17 ++++++++++--
 kernel/cobalt/posix/syscall32.h               |  3 ++-
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
index fb55d8863..3c9c287e1 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
@@ -63,5 +63,6 @@ __COBALT_CALL32emu_THUNK(recvmsg)
 __COBALT_CALL32emu_THUNK(sendmsg)
 __COBALT_CALL32emu_THUNK(mmap)
 __COBALT_CALL32emu_THUNK(backtrace)
+__COBALT_CALL32emu_THUNK(mq_timedreceive64)
 
 #endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index d0a6d4e31..3514ba1b0 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -1048,21 +1048,12 @@ fail:
 }
 
 int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
-			       ssize_t __user *u_len,
+			       ssize_t *len,
 			       unsigned int __user *u_prio,
 			       const void __user *u_ts)
 {
-	ssize_t len;
-	int ret;
-
-	ret = cobalt_copy_from_user(&len, u_len, sizeof(len));
-	if (ret)
-		return ret;
-
-	ret = __cobalt_mq_timedreceive(uqd, u_buf, &len, u_prio, u_ts,
-				       u_ts ? mq_fetch_timeout64 : NULL);
-
-	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
+	return __cobalt_mq_timedreceive(uqd, u_buf, len, u_prio, u_ts,
+					u_ts ? mq_fetch_timeout64 : NULL);
 }
 
 COBALT_SYSCALL(mq_timedreceive, primary,
@@ -1089,5 +1080,14 @@ COBALT_SYSCALL(mq_timedreceive64, primary,
 		unsigned int __user *u_prio,
 		const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio, u_ts);
+	ssize_t len;
+	int ret;
+
+	ret = cobalt_copy_from_user(&len, u_len, sizeof(len));
+	if (ret)
+		return ret;
+
+	ret = __cobalt_mq_timedreceive64(uqd, u_buf, &len, u_prio, u_ts);
+
+	return ret ?: cobalt_copy_to_user(u_len, &len, sizeof(*u_len));
 }
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index b4b263158..d9223866a 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -51,7 +51,7 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 						  const void __user *u_ts));
 
 int __cobalt_mq_timedreceive64(mqd_t uqd, void __user *u_buf,
-			       ssize_t __user *u_len,
+			       ssize_t *len,
 			       unsigned int __user *u_prio,
 			       const void __user *u_ts);
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 0c3f50a81..b65a0a760 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -367,11 +367,24 @@ COBALT_SYSCALL32emu(mq_timedreceive, primary,
 }
 
 COBALT_SYSCALL32emu(mq_timedreceive64, primary,
-		    (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+		    (mqd_t uqd, void __user *u_buf,
+		     compat_ssize_t __user *u_len,
 		     unsigned int __user *u_prio,
 		     const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mq_timedreceive64(uqd, u_buf, u_len, u_prio, u_ts);
+	compat_ssize_t clen;
+	ssize_t len;
+	int ret;
+
+	ret = cobalt_copy_from_user(&clen, u_len, sizeof(*u_len));
+	if (ret)
+		return ret;
+
+	len = clen;
+	ret = __cobalt_mq_timedreceive64(uqd, u_buf, &len, u_prio, u_ts);
+	clen = len;
+
+	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
 }
 
 static inline int mq_fetch_timeout(struct timespec64 *ts,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index a64d100e7..55f08121c 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -140,7 +140,8 @@ COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			  const struct old_timespec32 __user *u_ts));
 
 COBALT_SYSCALL32emu_DECL(mq_timedreceive64,
-			 (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
+			 (mqd_t uqd, void __user *u_buf,
+			  compat_ssize_t __user *u_len,
 			  unsigned int __user *u_prio,
 			  const struct __kernel_timespec __user *u_ts));
 
-- 
2.35.1



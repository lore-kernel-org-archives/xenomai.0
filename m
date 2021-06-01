From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 4/6] y2038: cobalt/posix/clock: Adding clock_adjtime64
Date: Tue,  1 Jun 2021 15:31:22 +0200
Message-Id: <20210601133124.1466307-5-florian.bezdeka@siemens.com>
In-Reply-To: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
References: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
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

Add a syscall specific for clock_adjtime with 64bit
time_t.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 22 ++++++++++++++++++++++
 kernel/cobalt/posix/clock.h     |  6 ++++++
 kernel/cobalt/posix/syscall32.c |  7 +++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 5 files changed, 40 insertions(+)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 0e178cdf0..a2795a364 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -127,6 +127,7 @@
 #define sc_cobalt_clock_settime64		104
 #define sc_cobalt_clock_nanosleep64		105
 #define sc_cobalt_clock_getres64		106
+#define sc_cobalt_clock_adjtime64		107
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index d61e2b724..95af54845 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -276,6 +276,28 @@ COBALT_SYSCALL(clock_adjtime, current,
 	return cobalt_copy_to_user(u_tx, &tx, sizeof(tx));
 }
 
+int __cobalt_clock_adjtime64(clockid_t clock_id,
+			struct __kernel_timex __user *u_tx)
+{
+	struct __kernel_timex tx;
+	int ret;
+
+	if (cobalt_copy_from_user(&tx, u_tx, sizeof(tx)))
+		return -EFAULT;
+
+	ret = __cobalt_clock_adjtime(clock_id, &tx);
+	if (ret)
+		return ret;
+
+	return cobalt_copy_to_user(u_tx, &tx, sizeof(tx));
+}
+
+COBALT_SYSCALL(clock_adjtime64, current,
+	       (clockid_t clock_id, struct __kernel_timex __user *u_tx))
+{
+	return __cobalt_clock_adjtime64(clock_id, u_tx);
+}
+
 int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt)
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 473c6aa0c..e18373979 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -115,6 +115,9 @@ int __cobalt_clock_settime64(clockid_t clock_id,
 int __cobalt_clock_adjtime(clockid_t clock_id,
 			   struct __kernel_timex *tx);
 
+int __cobalt_clock_adjtime64(clockid_t clock_id,
+			struct __kernel_timex __user *u_tx);
+
 int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
 			     struct timespec64 *rmt);
@@ -145,6 +148,9 @@ COBALT_SYSCALL_DECL(clock_settime64,
 COBALT_SYSCALL_DECL(clock_adjtime,
 		    (clockid_t clock_id, struct __user_old_timex __user *u_tx));
 
+COBALT_SYSCALL_DECL(clock_adjtime64,
+		    (clockid_t clock_id, struct __kernel_timex __user *u_tx));
+
 COBALT_SYSCALL_DECL(clock_nanosleep,
 		    (clockid_t clock_id, int flags,
 		     const struct __user_old_timespec __user *u_rqt,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index bba4bebbd..29c99bd05 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -222,6 +222,13 @@ COBALT_SYSCALL32emu(clock_adjtime, current,
 	return sys32_put_timex(u_tx, &tx);
 }
 
+COBALT_SYSCALL32emu(clock_adjtime64, current,
+		    (clockid_t clock_id, struct __kernel_timex __user *u_tx))
+{
+	return __cobalt_clock_adjtime64(clock_id, u_tx);
+}
+
+
 COBALT_SYSCALL32emu(clock_nanosleep, nonrestartable,
 		    (clockid_t clock_id, int flags,
 		     const struct old_timespec32 __user *u_rqt,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 4897f676c..64f6e4931 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -79,6 +79,10 @@ COBALT_SYSCALL32emu_DECL(clock_adjtime,
 			 (clockid_t clock_id,
 			  struct old_timex32 __user *u_tx));
 
+COBALT_SYSCALL32emu_DECL(clock_adjtime64,
+			 (clockid_t clock_id,
+			  struct __kernel_timex __user *u_tx));
+
 COBALT_SYSCALL32emu_DECL(clock_nanosleep,
 			 (clockid_t clock_id, int flags,
 			  const struct old_timespec32 __user *u_rqt,
-- 
2.31.1



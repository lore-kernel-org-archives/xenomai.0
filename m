From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/6] y2038: cobalt/posix/clock: Adding clock_getres64
Date: Tue,  1 Jun 2021 15:31:19 +0200
Message-Id: <20210601133124.1466307-2-florian.bezdeka@siemens.com>
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
Cc: jan.kiszka@siemens.com, chensong <chensong@tj.kylinos.cn>, Florian Bezdeka <florian.bezdeka@siemens.com>

From: chensong <chensong@tj.kylinos.cn>

Add a syscall specific for clock_getres with 64bit
time_t.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/clock.c     | 26 +++++++++++++++++++++++++-
 kernel/cobalt/posix/clock.h     |  6 ++++++
 kernel/cobalt/posix/syscall32.c |  7 +++++++
 kernel/cobalt/posix/syscall32.h |  4 ++++
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index acb8260d0..0e178cdf0 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -126,6 +126,7 @@
 #define sc_cobalt_clock_gettime64		103
 #define sc_cobalt_clock_settime64		104
 #define sc_cobalt_clock_nanosleep64		105
+#define sc_cobalt_clock_getres64		106
 
 #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
 
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index eafd580bd..d61e2b724 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -93,6 +93,30 @@ COBALT_SYSCALL(clock_getres, current,
 	return 0;
 }
 
+int __cobalt_clock_getres64(clockid_t clock_id,
+			struct __kernel_timespec __user *u_ts)
+{
+	struct timespec64 ts;
+	int ret;
+
+	ret = __cobalt_clock_getres(clock_id, &ts);
+	if (ret)
+		return ret;
+
+	if (cobalt_put_timespec64(&ts, u_ts))
+		return -EFAULT;
+
+	trace_cobalt_clock_getres(clock_id, &ts);
+
+	return 0;
+}
+
+COBALT_SYSCALL(clock_getres64, current,
+	       (clockid_t clock_id, struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_clock_getres64(clock_id, u_ts);
+}
+
 int __cobalt_clock_gettime(clockid_t clock_id, struct timespec64 *ts)
 {
 	xnticks_t ns;
@@ -442,7 +466,7 @@ struct xnclock *cobalt_clock_find(clockid_t clock_id)
 	    clock_id == CLOCK_MONOTONIC_RAW ||
 	    clock_id == CLOCK_REALTIME)
 		return &nkclock;
-	
+
 	if (__COBALT_CLOCK_EXT_P(clock_id)) {
 		nr = __COBALT_CLOCK_EXT_INDEX(clock_id);
 		xnlock_get_irqsave(&nklock, s);
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index ff8653b39..473c6aa0c 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -97,6 +97,9 @@ static inline int clock_flag(int flag, clockid_t clock_id)
 int __cobalt_clock_getres(clockid_t clock_id,
 			  struct timespec64 *ts);
 
+int __cobalt_clock_getres64(clockid_t clock_id,
+			struct __kernel_timespec __user *u_ts);
+
 int __cobalt_clock_gettime(clockid_t clock_id,
 			   struct timespec64 *ts);
 
@@ -123,6 +126,9 @@ int __cobalt_clock_nanosleep64(clockid_t clock_id, int flags,
 COBALT_SYSCALL_DECL(clock_getres,
 		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
+COBALT_SYSCALL_DECL(clock_getres64,
+		    (clockid_t clock_id, struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL_DECL(clock_gettime,
 		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
 
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index d7fc2cd71..bba4bebbd 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -156,6 +156,13 @@ COBALT_SYSCALL32emu(clock_getres, current,
 	return u_ts ? sys32_put_timespec(u_ts, &ts) : 0;
 }
 
+COBALT_SYSCALL32emu(clock_getres64, current,
+		    (clockid_t clock_id,
+		     struct __kernel_timespec __user *u_ts))
+{
+	return __cobalt_clock_getres64(clock_id, u_ts);
+}
+
 COBALT_SYSCALL32emu(clock_gettime, current,
 		    (clockid_t clock_id,
 		     struct old_timespec32 __user *u_ts))
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 7bcde4254..4897f676c 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -55,6 +55,10 @@ COBALT_SYSCALL32emu_DECL(clock_getres,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
 
+COBALT_SYSCALL32emu_DECL(clock_getres64,
+			 (clockid_t clock_id,
+			  struct __kernel_timespec __user *u_ts));
+
 COBALT_SYSCALL32emu_DECL(clock_gettime,
 			 (clockid_t clock_id,
 			  struct old_timespec32 __user *u_ts));
-- 
2.31.1



From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 4/9] cobalt/kernel: y2038: convert struct timex to
 __kernel_timex
Date: Wed,  5 May 2021 18:53:03 +0200
Message-Id: <84c45651e7f34d9d9d87f7b85ceed63048d16927.1620233588.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620233588.git.jan.kiszka@siemens.com>
References: <cover.1620233588.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

As internal interfaces are gradually being made y2038-safe, the
__kernel_timex type should be used internally by the kernel to
represent time adjustment parameters. Apply the same reasoning to
Cobalt.

We still use a legacy y2038-unsafe timex type at the kernel<->user
interface boundary (struct __user_old_timex) until libcobalt is
y2038-safe.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/clock.h                 |  7 +--
 include/cobalt/kernel/compat.h                |  4 +-
 include/cobalt/uapi/kernel/types.h            | 44 +++++++++++++++++--
 .../include/asm-generic/xenomai/wrappers.h    |  4 ++
 kernel/cobalt/posix/clock.c                   |  6 +--
 kernel/cobalt/posix/clock.h                   |  4 +-
 kernel/cobalt/posix/compat.c                  | 28 +++++++++---
 kernel/cobalt/posix/syscall32.c               |  2 +-
 kernel/cobalt/trace/cobalt-posix.h            |  4 +-
 9 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index 1c99173ff8..0e4f1e1cbe 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -24,6 +24,7 @@
 #include <cobalt/kernel/list.h>
 #include <cobalt/kernel/vfile.h>
 #include <cobalt/uapi/kernel/types.h>
+#include <asm/xenomai/wrappers.h>
 
 /**
  * @addtogroup cobalt_core_clock
@@ -32,7 +33,7 @@
 
 struct xnsched;
 struct xntimerdata;
-struct timex;
+struct __kernel_timex;
 
 struct xnclock_gravity {
 	unsigned long irq;
@@ -67,7 +68,7 @@ struct xnclock {
 					    struct xnsched *sched);
 #endif
 		int (*adjust_time)(struct xnclock *clock,
-				   struct timex *tx);
+				   struct __kernel_timex *tx);
 		int (*set_gravity)(struct xnclock *clock,
 				   const struct xnclock_gravity *p);
 		void (*reset_gravity)(struct xnclock *clock);
@@ -275,7 +276,7 @@ static inline int xnclock_set_time(struct xnclock *clock,
 #endif /* !CONFIG_XENO_OPT_EXTCLOCK */
 
 static inline int xnclock_adjust_time(struct xnclock *clock,
-				      struct timex *tx)
+				      struct __kernel_timex *tx)
 {
 	if (clock->ops.adjust_time == NULL)
 		return -EOPNOTSUPP;
diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
index 7bec8c3be5..d7f0008d9f 100644
--- a/include/cobalt/kernel/compat.h
+++ b/include/cobalt/kernel/compat.h
@@ -104,11 +104,11 @@ int sys32_get_timeval(struct __kernel_old_timeval *tv,
 int sys32_put_timeval(struct compat_timeval __user *ctv,
 		      const struct __kernel_old_timeval *tv);
 
-int sys32_get_timex(struct timex *tx,
+int sys32_get_timex(struct __kernel_timex *tx,
 		    const struct old_timex32 __user *ctx);
 
 int sys32_put_timex(struct old_timex32 __user *ctx,
-		    const struct timex *tx);
+		    const struct __kernel_timex *tx);
 
 ssize_t sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
 			size_t cfdsize);
diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
index 10abbb55a5..2c931c29c3 100644
--- a/include/cobalt/uapi/kernel/types.h
+++ b/include/cobalt/uapi/kernel/types.h
@@ -58,9 +58,10 @@ static inline xnhandle_t xnhandle_get_id(xnhandle_t handle)
 }
 
 /*
- * Our representation of time at the kernel<->user interface boundary
- * at the moment, until we have fully transitioned to a y2038-safe
- * implementation in libcobalt.
+ * Our representation of time specs at the kernel<->user interface
+ * boundary at the moment, until we have fully transitioned to a
+ * y2038-safe implementation in libcobalt. Once done, those legacy
+ * types will be removed.
  */
 struct __user_old_timespec {
 	long  tv_sec;
@@ -72,4 +73,41 @@ struct __user_old_itimerspec {
 	struct __user_old_timespec it_value;
 };
 
+struct __user_old_timeval {
+	long  tv_sec;
+	long  tv_usec;
+};
+
+/* Lifted from include/uapi/linux/timex.h. */
+struct __user_old_timex {
+	unsigned int modes;	/* mode selector */
+	__kernel_long_t offset;	/* time offset (usec) */
+	__kernel_long_t freq;	/* frequency offset (scaled ppm) */
+	__kernel_long_t maxerror;/* maximum error (usec) */
+	__kernel_long_t esterror;/* estimated error (usec) */
+	int status;		/* clock command/status */
+	__kernel_long_t constant;/* pll time constant */
+	__kernel_long_t precision;/* clock precision (usec) (read only) */
+	__kernel_long_t tolerance;/* clock frequency tolerance (ppm)
+				   * (read only)
+				   */
+	struct __user_old_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
+	__kernel_long_t tick;	/* (modified) usecs between clock ticks */
+
+	__kernel_long_t ppsfreq;/* pps frequency (scaled ppm) (ro) */
+	__kernel_long_t jitter; /* pps jitter (us) (ro) */
+	int shift;              /* interval duration (s) (shift) (ro) */
+	__kernel_long_t stabil;            /* pps stability (scaled ppm) (ro) */
+	__kernel_long_t jitcnt; /* jitter limit exceeded (ro) */
+	__kernel_long_t calcnt; /* calibration intervals (ro) */
+	__kernel_long_t errcnt; /* calibration errors (ro) */
+	__kernel_long_t stbcnt; /* stability limit exceeded (ro) */
+
+	int tai;		/* TAI offset (ro) */
+
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32;
+};
+
 #endif /* !_COBALT_UAPI_KERNEL_TYPES_H */
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index be62ab744b..42cd1955ac 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -152,6 +152,10 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
 #endif /* < 3.10 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,0,0)
+#define __kernel_timex		timex
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,1,0)
 #define old_timex32		compat_timex
 #define SO_RCVTIMEO_OLD		SO_RCVTIMEO
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 4a3365d2a9..23a45bba9b 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -166,7 +166,7 @@ int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
 	return 0;
 }
 
-int __cobalt_clock_adjtime(clockid_t clock_id, struct timex *tx)
+int __cobalt_clock_adjtime(clockid_t clock_id, struct __kernel_timex *tx)
 {
 	int _ret, ret = 0;
 
@@ -199,9 +199,9 @@ COBALT_SYSCALL(clock_settime, current,
 }
 
 COBALT_SYSCALL(clock_adjtime, current,
-	       (clockid_t clock_id, struct timex __user *u_tx))
+	       (clockid_t clock_id, struct __user_old_timex __user *u_tx))
 {
-	struct timex tx;
+	struct __kernel_timex tx;
 	int ret;
 
 	if (cobalt_copy_from_user(&tx, u_tx, sizeof(tx)))
diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
index 7e45fdcc6b..e69e76e1be 100644
--- a/kernel/cobalt/posix/clock.h
+++ b/kernel/cobalt/posix/clock.h
@@ -104,7 +104,7 @@ int __cobalt_clock_settime(clockid_t clock_id,
 			   const struct timespec64 *ts);
 
 int __cobalt_clock_adjtime(clockid_t clock_id,
-			   struct timex *tx);
+			   struct __kernel_timex *tx);
 
 int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     const struct timespec64 *rqt,
@@ -120,7 +120,7 @@ COBALT_SYSCALL_DECL(clock_settime,
 		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(clock_adjtime,
-		    (clockid_t clock_id, struct timex __user *u_tx));
+		    (clockid_t clock_id, struct __user_old_timex __user *u_tx));
 
 COBALT_SYSCALL_DECL(clock_nanosleep,
 		    (clockid_t clock_id, int flags,
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index 767a8033a6..6002d74802 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -98,11 +98,21 @@ int sys32_put_timeval(struct compat_timeval __user *ctv,
 }
 EXPORT_SYMBOL_GPL(sys32_put_timeval);
 
-int sys32_get_timex(struct timex *tx,
+int sys32_get_timex(struct __kernel_timex *tx,
 		    const struct old_timex32 __user *ctx)
 {
+	struct __kernel_old_timeval time;
+	int ret;
+
 	memset(tx, 0, sizeof(*tx));
 
+	ret = sys32_get_timeval(&time, &ctx->time);
+	if (ret)
+		return ret;
+
+	tx->time.tv_sec = time.tv_sec;
+	tx->time.tv_usec = time.tv_usec;
+
 	if (!access_rok(ctx, sizeof(*ctx)) ||
 	    __xn_get_user(tx->modes, &ctx->modes) ||
 	    __xn_get_user(tx->offset, &ctx->offset) ||
@@ -113,8 +123,6 @@ int sys32_get_timex(struct timex *tx,
 	    __xn_get_user(tx->constant, &ctx->constant) ||
 	    __xn_get_user(tx->precision, &ctx->precision) ||
 	    __xn_get_user(tx->tolerance, &ctx->tolerance) ||
-	    __xn_get_user(tx->time.tv_sec, &ctx->time.tv_sec) ||
-	    __xn_get_user(tx->time.tv_usec, &ctx->time.tv_usec) ||
 	    __xn_get_user(tx->tick, &ctx->tick) ||
 	    __xn_get_user(tx->ppsfreq, &ctx->ppsfreq) ||
 	    __xn_get_user(tx->jitter, &ctx->jitter) ||
@@ -131,8 +139,18 @@ int sys32_get_timex(struct timex *tx,
 EXPORT_SYMBOL_GPL(sys32_get_timex);
 
 int sys32_put_timex(struct old_timex32 __user *ctx,
-		    const struct timex *tx)
+		    const struct __kernel_timex *tx)
 {
+	struct __kernel_old_timeval time;
+	int ret;
+
+	time.tv_sec = tx->time.tv_sec;
+	time.tv_usec = tx->time.tv_usec;
+
+	ret = sys32_put_timeval(&ctx->time, &time);
+	if (ret)
+		return ret;
+
 	if (!access_wok(ctx, sizeof(*ctx)) ||
 	    __xn_put_user(tx->modes, &ctx->modes) ||
 	    __xn_put_user(tx->offset, &ctx->offset) ||
@@ -143,8 +161,6 @@ int sys32_put_timex(struct old_timex32 __user *ctx,
 	    __xn_put_user(tx->constant, &ctx->constant) ||
 	    __xn_put_user(tx->precision, &ctx->precision) ||
 	    __xn_put_user(tx->tolerance, &ctx->tolerance) ||
-	    __xn_put_user(tx->time.tv_sec, &ctx->time.tv_sec) ||
-	    __xn_put_user(tx->time.tv_usec, &ctx->time.tv_usec) ||
 	    __xn_put_user(tx->tick, &ctx->tick) ||
 	    __xn_put_user(tx->ppsfreq, &ctx->ppsfreq) ||
 	    __xn_put_user(tx->jitter, &ctx->jitter) ||
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 5c858806b6..4f819e0e5a 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -174,7 +174,7 @@ COBALT_SYSCALL32emu(clock_settime, current,
 COBALT_SYSCALL32emu(clock_adjtime, current,
 		    (clockid_t clock_id, struct old_timex32 __user *u_tx))
 {
-	struct timex tx;
+	struct __kernel_timex tx;
 	int ret;
 
 	ret = sys32_get_timex(&tx, u_tx);
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 3a649a6712..cff1bd9b71 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -764,12 +764,12 @@ DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_settime,
 );
 
 TRACE_EVENT(cobalt_clock_adjtime,
-	TP_PROTO(clockid_t clk_id, struct timex *tx),
+	TP_PROTO(clockid_t clk_id, struct __kernel_timex *tx),
 	TP_ARGS(clk_id, tx),
 
 	TP_STRUCT__entry(
 		__field(clockid_t, clk_id)
-		__field(struct timex *, tx)
+		__field(struct __kernel_timex *, tx)
 	),
 
 	TP_fast_assign(
-- 
2.26.2



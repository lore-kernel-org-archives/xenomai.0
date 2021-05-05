From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 6/9] cobalt/sem: y2038: Fixing the sem_timedwait syscall
 for 32 bit systems
Date: Wed,  5 May 2021 18:53:05 +0200
Message-Id: <e5f51970866448edb8bfbcf5e11dfe67c48ae5ba.1620233588.git.jan.kiszka@siemens.com>
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

From: Florian Bezdeka <florian.bezdeka@siemens.com>

On systems using 32 bit for time_t the sem_timedwait syscall was broken
because the function used for copying the timeout value from userspace
to kernel (=sem_fetch_timeout()) was always copying
sizeof(struct timespec64).

A 32 bit application (or more specific an application with 4 byte
time_t) would only provide sizeof(struct old_timespec32).

Notable changes:
  - The copy operation from userspace to kernel is now already done in
    the syscall handler. So it is always done and might fail. Reporting
    a failure is delayed until the timeout is being validated.

  - Validation: Switched to timespec64_valid() instead of our own
    check.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/sem.c       | 40 +++++++++++++++------------------
 kernel/cobalt/posix/sem.h       |  6 ++---
 kernel/cobalt/posix/syscall32.c | 10 +++++++--
 kernel/cobalt/posix/syscall32.h |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 467a9b7dd6..827a4751a0 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -267,20 +267,11 @@ out:
 	return ret;
 }
 
-static inline int sem_fetch_timeout(struct timespec64 *ts,
-				    const void __user *u_ts)
-{
-	return u_ts == NULL ? -EFAULT :
-		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
-}
-
 int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
-			   const void __user *u_ts,
-			   int (*fetch_timeout)(struct timespec64 *ts,
-						const void __user *u_ts))
+			   const struct timespec64 *ts)
 {
-	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
-	int pull_ts = 1, ret, info;
+	int ret, info;
+	bool validate_ts = true;
 	struct cobalt_sem *sem;
 	xnhandle_t handle;
 	xntmode_t tmode;
@@ -304,24 +295,23 @@ int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
 		 * it's actually more complex, to keep some
 		 * applications ported to Linux happy.
 		 */
-		if (pull_ts) {
+		if (validate_ts) {
 			atomic_inc(&sem->state->value);
-			xnlock_put_irqrestore(&nklock, s);
-			ret = fetch_timeout(&ts, u_ts);
-			xnlock_get_irqsave(&nklock, s);
-			if (ret)
+			if (!ts) {
+				ret = -EFAULT;
 				break;
-			if (ts.tv_nsec >= ONE_BILLION) {
+			}
+			if (!timespec64_valid(ts)) {
 				ret = -EINVAL;
 				break;
 			}
-			pull_ts = 0;
+			validate_ts = false;
 			continue;
 		}
 
 		ret = 0;
 		tmode = sem->flags & SEM_RAWCLOCK ? XN_ABSOLUTE : XN_REALTIME;
-		info = xnsynch_sleep_on(&sem->synchbase, ts2ns(&ts) + 1, tmode);
+		info = xnsynch_sleep_on(&sem->synchbase, ts2ns(ts) + 1, tmode);
 		if (info & XNRMID)
 			ret = -EINVAL;
 		else if (info & (XNBREAK|XNTIMEO)) {
@@ -434,9 +424,15 @@ COBALT_SYSCALL(sem_wait, primary,
 
 COBALT_SYSCALL(sem_timedwait, primary,
 	       (struct cobalt_sem_shadow __user *u_sem,
-		struct __user_old_timespec __user *u_ts))
+		const struct __user_old_timespec __user *u_ts))
 {
-	return __cobalt_sem_timedwait(u_sem, u_ts, sem_fetch_timeout);
+	int ret = 1;
+	struct timespec64 ts64;
+
+	if (u_ts)
+		ret = cobalt_get_u_timespec(&ts64, u_ts);
+
+	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
 COBALT_SYSCALL(sem_trywait, primary,
diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
index d172994950..658e11f7a6 100644
--- a/kernel/cobalt/posix/sem.h
+++ b/kernel/cobalt/posix/sem.h
@@ -64,9 +64,7 @@ __cobalt_sem_open(struct cobalt_sem_shadow __user *usm,
 		  int oflags, mode_t mode, unsigned int value);
 
 int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
-			   const void __user *u_ts,
-			   int (*fetch_timeout)(struct timespec64 *ts,
-						const void __user *u_ts));
+			   const struct timespec64 *ts);
 
 int __cobalt_sem_destroy(xnhandle_t handle);
 
@@ -91,7 +89,7 @@ COBALT_SYSCALL_DECL(sem_wait,
 
 COBALT_SYSCALL_DECL(sem_timedwait,
 		    (struct cobalt_sem_shadow __user *u_sem,
-		     struct __user_old_timespec __user *u_ts));
+		     const struct __user_old_timespec __user *u_ts));
 
 COBALT_SYSCALL_DECL(sem_trywait,
 		    (struct cobalt_sem_shadow __user *u_sem));
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 57aa7251a4..edac7ea4ae 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -124,9 +124,15 @@ COBALT_SYSCALL32emu(sem_open, lostage,
 
 COBALT_SYSCALL32emu(sem_timedwait, primary,
 		    (struct cobalt_sem_shadow __user *u_sem,
-		     struct old_timespec32 __user *u_ts))
+		     const struct old_timespec32 __user *u_ts))
 {
-	return __cobalt_sem_timedwait(u_sem, u_ts, sys32_fetch_timeout);
+	int ret = 1;
+	struct timespec64 ts64;
+
+	if (u_ts)
+		ret = sys32_fetch_timeout(&ts64, u_ts);
+
+	return __cobalt_sem_timedwait(u_sem, ret ? NULL : &ts64);
 }
 
 COBALT_SYSCALL32emu(clock_getres, current,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 66cd2a5d24..d72fd20229 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -229,6 +229,6 @@ COBALT_SYSCALL32emu_DECL(sem_open,
 
 COBALT_SYSCALL32emu_DECL(sem_timedwait,
 			 (struct cobalt_sem_shadow __user *u_sem,
-			  struct old_timespec32 __user *u_ts));
+			  const struct old_timespec32 __user *u_ts));
 
 #endif /* !_COBALT_POSIX_SYSCALL32_H */
-- 
2.26.2



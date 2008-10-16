Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F764A5.5030205@domain.hid>
Message-Id: <20081016154622.117667989@domain.hid>
Date: Thu, 16 Oct 2008 17:46:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081016154620.320953568@domain.hid>
Content-Disposition: inline;
	filename=ensure-mode-switch-in-mutex-fast-paths.patch
Subject: [Xenomai-core] [PATCH 11/12] Ensure mode switch in mutex fast paths
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

With the help of xeno_get_current_mode(), this patch ensures that shadow
threads in secondary mode will be switched to primary again in case they
acquire an uncontended native or POSIX mutex, thus would otherwise only
pick the user space fast path. This prevents potential priority
inversions that the fast mutex optimizations introduced.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/skins/native/mutex.c |   31 ++++++++-------
 src/skins/posix/mutex.c  |   94 +++++++++++++++++++++++++++--------------------
 2 files changed, 71 insertions(+), 54 deletions(-)

Index: b/src/skins/native/mutex.c
===================================================================
--- a/src/skins/native/mutex.c
+++ b/src/skins/native/mutex.c
@@ -18,6 +18,7 @@
 
 #include <limits.h>
 #include <nucleus/synch.h>
+#include <nucleus/thread.h>
 #include <native/syscall.h>
 #include <native/mutex.h>
 #include <asm-generic/bits/current.h>
@@ -78,22 +79,24 @@ static int rt_mutex_acquire_inner(RT_MUT
 	if (!cur)
 		return -EPERM;
 
-	err = xnsynch_fast_acquire(mutex->fastlock, cur);
-	if (likely(!err)) {
-		mutex->lockcnt = 1;
-		return 0;
-	}
-
-	if (err == -EBUSY) {
-		if (mutex->lockcnt == UINT_MAX)
-			return -EAGAIN;
+	if (likely(!(xeno_get_current_mode() & XNRELAX))) {
+		err = xnsynch_fast_acquire(mutex->fastlock, cur);
+		if (likely(!err)) {
+			mutex->lockcnt = 1;
+			return 0;
+		}
+
+		if (err == -EBUSY) {
+			if (mutex->lockcnt == UINT_MAX)
+				return -EAGAIN;
+
+			mutex->lockcnt++;
+			return 0;
+		}
 
-		mutex->lockcnt++;
-		return 0;
+		if (timeout == TM_NONBLOCK && mode == XN_RELATIVE)
+			return -EWOULDBLOCK;
 	}
-
-	if (timeout == TM_NONBLOCK && mode == XN_RELATIVE)
-		return -EWOULDBLOCK;
 #endif /* CONFIG_XENO_FASTSYNCH */
 
 	err = XENOMAI_SKINCALL3(__native_muxid,
Index: b/src/skins/posix/mutex.c
===================================================================
--- a/src/skins/posix/mutex.c
+++ b/src/skins/posix/mutex.c
@@ -164,31 +164,33 @@ int __wrap_pthread_mutex_lock(pthread_mu
 		goto out;
 	}
 
-	err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
+	if (likely(!(xeno_get_current_mode() & XNRELAX))) {
+		err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
 
-	if (likely(!err)) {
-		shadow->lockcnt = 1;
-		cb_read_unlock(&shadow->lock, s);
-		return 0;
-	}
+		if (likely(!err)) {
+			shadow->lockcnt = 1;
+			cb_read_unlock(&shadow->lock, s);
+			return 0;
+		}
 
-	if (err == -EBUSY)
-		switch(shadow->attr.type) {
-		case PTHREAD_MUTEX_NORMAL:
-			break;
+		if (err == -EBUSY)
+			switch(shadow->attr.type) {
+			case PTHREAD_MUTEX_NORMAL:
+				break;
 
-		case PTHREAD_MUTEX_ERRORCHECK:
-			err = -EDEADLK;
-			goto out;
+			case PTHREAD_MUTEX_ERRORCHECK:
+				err = -EDEADLK;
+				goto out;
 
-		case PTHREAD_MUTEX_RECURSIVE:
-			if (shadow->lockcnt == UINT_MAX) {
-				err = -EAGAIN;
+			case PTHREAD_MUTEX_RECURSIVE:
+				if (shadow->lockcnt == UINT_MAX) {
+					err = -EAGAIN;
+					goto out;
+				}
+				++shadow->lockcnt;
+				err = 0;
 				goto out;
 			}
-			++shadow->lockcnt;
-			err = 0;
-			goto out;
 		}
 #endif /* CONFIG_XENO_FASTSYNCH */
 
@@ -226,32 +228,34 @@ int __wrap_pthread_mutex_timedlock(pthre
 		goto out;
 	}	
 
-	err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
+	if (likely(!(xeno_get_current_mode() & XNRELAX))) {
+		err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
 
-	if (likely(!err)) {
-		shadow->lockcnt = 1;
-		cb_read_unlock(&shadow->lock, s);
-		return 0;
-	}
+		if (likely(!err)) {
+			shadow->lockcnt = 1;
+			cb_read_unlock(&shadow->lock, s);
+			return 0;
+		}
 
-	if (err == -EBUSY)
-		switch(shadow->attr.type) {
-		case PTHREAD_MUTEX_NORMAL:
-			break;
+		if (err == -EBUSY)
+			switch(shadow->attr.type) {
+			case PTHREAD_MUTEX_NORMAL:
+				break;
 
-		case PTHREAD_MUTEX_ERRORCHECK:
-			err = -EDEADLK;
-			goto out;
+			case PTHREAD_MUTEX_ERRORCHECK:
+				err = -EDEADLK;
+				goto out;
 
-		case PTHREAD_MUTEX_RECURSIVE:
-			if (shadow->lockcnt == UINT_MAX) {
-				err = -EAGAIN;
+			case PTHREAD_MUTEX_RECURSIVE:
+				if (shadow->lockcnt == UINT_MAX) {
+					err = -EAGAIN;
+					goto out;
+				}
+
+				++shadow->lockcnt;
 				goto out;
 			}
-
-			++shadow->lockcnt;
-			goto out;
-		}
+	}
 #endif /* CONFIG_XENO_FASTSYNCH */
 
 	do {
@@ -286,7 +290,17 @@ int __wrap_pthread_mutex_trylock(pthread
 	if (unlikely(shadow->magic != PSE51_MUTEX_MAGIC)) {
 		err = -EINVAL;
 		goto out;
-	}	
+	}
+
+	if (unlikely(xeno_get_current_mode() & XNRELAX)) {
+		do {
+			err = -XENOMAI_SYSCALL1(__xn_sys_migrate,
+						XENOMAI_XENO_DOMAIN);
+		} while (err == EINTR);
+
+		if (err)
+			goto out;
+	}
 
 	err = xnsynch_fast_acquire(get_ownerp(shadow), cur);
 



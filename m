Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22C.5080907@domain.hid>
Message-ID: <48BBB085.7040407@domain.hid>
Date: Mon, 01 Sep 2008 11:06:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid>
In-Reply-To: <48BBA9E6.5070400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH 9/9] Optimize xnsynch_sleep_on for
	XN_NONBLOCK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This patch improves the performance of xnsynch_sleep_on when it is
called with (XN_RELATIVE, XN_NONBLOCK) timeout parameters. For this
purpose, it introduces a new thread info XNNONBLCK that is set in case
xnsynch_sleep_on fails while in XN_NONBLOCK mode. Maybe this should be
solved via a dedicated trylock (but that would duplicate quite some
code), hopefully we can avoid it completely by doing lock stealing on
trylock via (generic) fast locks, even in user space.

---
 include/nucleus/thread.h  |    1 +
 ksrc/nucleus/pod.c        |    8 +++++---
 ksrc/nucleus/synch.c      |   20 +++++++++++++++++---
 ksrc/skins/native/mutex.c |   13 +++++++------
 ksrc/skins/posix/mutex.c  |    5 +----
 ksrc/skins/posix/mutex.h  |    8 +++++++-
 6 files changed, 38 insertions(+), 17 deletions(-)

Index: b/include/nucleus/thread.h
===================================================================
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -116,6 +116,7 @@
 #define XNROBBED  0x00000020 /**< Robbed from resource ownership */
 #define XNATOMIC  0x00000040 /**< In atomic switch from secondary to primary mode */
 #define XNAFFSET  0x00000080 /**< CPU affinity changed from primary mode */
+#define XNNONBLCK 0x00000100 /**< Non-blocking mode prevented suspension */
 
 /* These information flags are available to the real-time interfaces */
 #define XNTHREAD_INFO_SPARE0  0x10000000
Index: b/ksrc/nucleus/pod.c
===================================================================
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1401,14 +1401,16 @@ void xnpod_suspend_thread(xnthread_t *th
 						thread->name, mask);
 				);
 			xnthread_clear_info(thread,
-					    XNRMID | XNTIMEO | XNROBBED);
+					    XNRMID | XNTIMEO | XNROBBED |
+					    XNNONBLCK);
 			xnthread_set_info(thread, XNBREAK);
 			goto unlock_and_exit;
 		}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK |
-					    XNWAKEN | XNROBBED);
+		xnthread_clear_info(thread,
+				    XNRMID | XNTIMEO | XNBREAK | XNWAKEN |
+				    XNROBBED | XNNONBLCK);
 	}
 
 	/* Don't start the timer for a thread indefinitely delayed by
Index: b/ksrc/nucleus/synch.c
===================================================================
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -194,7 +194,8 @@ redo:
 
 	if (!owner) {
 		synch->owner = thread;
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
+		xnthread_clear_info(thread,
+				    XNRMID | XNTIMEO | XNBREAK | XNNONBLCK);
 		goto unlock_and_exit;
 	}
 
@@ -202,11 +203,18 @@ redo:
 		if (xnthread_test_info(owner, XNWAKEN) && owner->wwake == synch) {
 			/* Ownership is still pending, steal the resource. */
 			synch->owner = thread;
-			xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK);
+			xnthread_clear_info(thread,
+					    XNRMID | XNTIMEO | XNBREAK |
+					    XNNONBLCK);
 			xnthread_set_info(owner, XNROBBED);
 			goto unlock_and_exit;
 		}
 
+		if (timeout == XN_NONBLOCK && timeout_mode == XN_RELATIVE) {
+			xnthread_set_info(thread, XNNONBLCK);
+			goto unlock_and_exit;
+		}
+
 		if (!xnthread_test_state(owner, XNBOOST)) {
 			owner->bprio = owner->cprio;
 			xnthread_set_state(owner, XNBOOST);
@@ -220,8 +228,14 @@ redo:
 		insertpqf(&owner->claimq, &synch->link, thread->cprio);
 		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
 		xnsynch_renice_thread(owner, thread->cprio);
-	} else
+	} else {
+		if (timeout == XN_NONBLOCK && timeout_mode == XN_RELATIVE) {
+			xnthread_set_info(thread, XNNONBLCK);
+			goto unlock_and_exit;
+		}
+
 		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
+	}
 
 	xnpod_suspend_thread(thread, XNPEND, timeout, timeout_mode, synch);
 
Index: b/ksrc/skins/native/mutex.c
===================================================================
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -388,17 +388,18 @@ int rt_mutex_acquire_inner(RT_MUTEX *mut
 
 	if (unlikely
 	    (xnthread_test_info(thread,
-				XNBREAK | XNRMID | XNROBBED | XNTIMEO))) {
+				XNBREAK | XNNONBLCK | XNRMID | XNROBBED |
+				XNTIMEO))) {
+		if (xnthread_test_info(thread, XNNONBLCK)) {
+			err = -EWOULDBLOCK;	/* Try-to-lock failed. */
+			goto cleanup_and_exit;
+		}
 		if (xnthread_test_info(thread, XNROBBED)) {
 			xnlock_put_irqrestore(&nklock, s);
 			goto retry;
 		}
 		if (xnthread_test_info(thread, XNTIMEO)) {
-			if (timeout_mode == XN_RELATIVE &&
-			    timeout == XN_NONBLOCK)
-				err = -EWOULDBLOCK;
-			else
-				err = -ETIMEDOUT;
+			err = -ETIMEDOUT;
 			goto cleanup_and_exit;
 		}
 		if (xnthread_test_info(thread, XNBREAK)) {
Index: b/ksrc/skins/posix/mutex.c
===================================================================
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -406,13 +406,10 @@ int pthread_mutex_trylock(pthread_mutex_
 				err = 0;
 			}
 		}
-	} else {
+	} else
 		err =
 		    -pse51_mutex_timedlock_internal(cur, shadow, 1,
 						    XN_RELATIVE, XN_NONBLOCK);
-		if (err == ETIMEDOUT)
-			err = EBUSY;
-	}
 
 	cb_read_unlock(&shadow->lock, s);
 
Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -174,7 +174,13 @@ static inline int pse51_mutex_timedlock_
 	xnsynch_sleep_on(&mutex->synchbase, timeout, timeout_mode);
 
 	if (unlikely
-	    (xnthread_test_info(cur, XNBREAK | XNRMID | XNROBBED | XNTIMEO))) {
+	    (xnthread_test_info(cur,
+				XNBREAK | XNNONBLCK | XNRMID | XNROBBED |
+				XNTIMEO))) {
+		if (xnthread_test_info(cur, XNNONBLCK)) {
+			err = -EBUSY;
+			goto error;
+		}
 		if (xnthread_test_info(cur, XNROBBED)) {
 			xnlock_put_irqrestore(&nklock, s);
 			goto retry_lock;



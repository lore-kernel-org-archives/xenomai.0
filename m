Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22B.3050205@domain.hid>
Message-ID: <48BBB213.1090502@domain.hid>
Date: Mon, 01 Sep 2008 11:12:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid>
In-Reply-To: <48BBA9E6.5070400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH 7/9] Switch POSIX mutexes to
	XNSYNCH_FWDROB
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

Switch POSIX over to XNSYNCH_FWDROB, demonstrating the use of this flag
(and aligning the implementation for following native version). This can
save the syscall so far required on releasing a stolen mutex.

---
 ksrc/skins/posix/mutex.c |   10 ++++++----
 ksrc/skins/posix/mutex.h |   42 +++++++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 21 deletions(-)

Index: b/ksrc/skins/posix/mutex.c
===================================================================
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -85,7 +85,7 @@ int pse51_mutex_init_internal(struct __s
 			      xnarch_atomic_t *ownerp,
 			      const pthread_mutexattr_t *attr)
 {
-	xnflags_t synch_flags = XNSYNCH_PRIO | XNSYNCH_NOPIP;
+	xnflags_t synch_flags = XNSYNCH_PRIO | XNSYNCH_NOPIP | XNSYNCH_FWDROB;
 	struct xnsys_ppd *sys_ppd;
 	pse51_kqueues_t *kq;
 	spl_t s;
@@ -117,7 +117,6 @@ int pse51_mutex_init_internal(struct __s
 	mutex->attr = *attr;
 	mutex->owner = ownerp;
 	mutex->owningq = kq;
-	mutex->sleepers = 0;
 	xnarch_atomic_set(ownerp, XN_NO_HANDLE);
 
 	xnlock_get_irqsave(&nklock, s);
@@ -306,10 +305,8 @@ int pse51_mutex_timedlock_break(struct _
 		/* Attempting to relock a normal mutex, deadlock. */
 		xnlock_get_irqsave(&nklock, s);
 		for (;;) {
-			++mutex->sleepers;
 			xnsynch_sleep_on(&mutex->synchbase, timeout,
 					 timeout_mode);
-			--mutex->sleepers;
 
 			if (xnthread_test_info(cur, XNBREAK)) {
 				err = -EINTR;
@@ -326,6 +323,11 @@ int pse51_mutex_timedlock_break(struct _
 				break;
 			}
 		}
+		if (!xnsynch_nsleepers(&mutex->synchbase))
+			xnarch_atomic_set
+				(mutex->owner,
+				 clear_claimed
+					(xnarch_atomic_get(mutex->owner)));
 		xnlock_put_irqrestore(&nklock, s);
 
 		break;
Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -57,7 +57,6 @@ typedef struct pse51_mutex {
 
 	xnarch_atomic_t *owner;
 	pthread_mutexattr_t attr;
-	unsigned sleepers;
 	pse51_kqueues_t *owningq;
 } pse51_mutex_t;
 
@@ -172,24 +171,30 @@ static inline int pse51_mutex_timedlock_
 	}
 
 	xnsynch_set_owner(&mutex->synchbase, owner);
-	++mutex->sleepers;
 	xnsynch_sleep_on(&mutex->synchbase, timeout, timeout_mode);
-	--mutex->sleepers;
 
-	if (xnthread_test_info(cur, XNBREAK)) {
-		err = -EINTR;
-		goto error;
-	}
-	if (xnthread_test_info(cur, XNRMID)) {
+	if (unlikely
+	    (xnthread_test_info(cur, XNBREAK | XNRMID | XNROBBED | XNTIMEO))) {
+		if (xnthread_test_info(cur, XNROBBED)) {
+			xnlock_put_irqrestore(&nklock, s);
+			goto retry_lock;
+		}
+		if (xnthread_test_info(cur, XNTIMEO)) {
+			err = -ETIMEDOUT;
+			goto error;
+		}
+		if (xnthread_test_info(cur, XNBREAK)) {
+			err = -EINTR;
+			goto error;
+		}
+		/* XNRMID */
 		err = -EINVAL;
 		goto error;
 	}
-	if (xnthread_test_info(cur, XNTIMEO)) {
-		err = -ETIMEDOUT;
-		goto error;
-	}
 
-	ownerh = set_claimed(xnthread_handle(cur), mutex->sleepers);
+	ownerh = xnthread_handle(cur);
+	if (xnsynch_nsleepers(&mutex->synchbase))
+		ownerh = set_claimed(ownerh, 1);
 	xnarch_atomic_set(mutex->owner, ownerh);
 	shadow->lockcnt = count;
 	xnlock_put_irqrestore(&nklock, s);
@@ -197,7 +202,7 @@ static inline int pse51_mutex_timedlock_
 	return 0;
 
   error:
-	if (!mutex->sleepers)
+	if (!xnsynch_nsleepers(&mutex->synchbase))
 		xnarch_atomic_set
 			(mutex->owner,
 			 clear_claimed(xnarch_atomic_get(mutex->owner)));
@@ -218,10 +223,13 @@ static inline void pse51_mutex_unlock_in
 
 	xnlock_get_irqsave(&nklock, s);
 	owner = xnsynch_wakeup_one_sleeper(&mutex->synchbase);
-	ownerh = set_claimed(xnthread_handle(owner), mutex->sleepers);
-	xnarch_atomic_set(mutex->owner, ownerh);
-	if (owner)
+	if (owner) {
+		ownerh = set_claimed(xnthread_handle(owner),
+				     xnsynch_nsleepers(&mutex->synchbase));
+		xnarch_atomic_set(mutex->owner, ownerh);
 		xnpod_schedule();
+	} else
+		xnarch_atomic_set(mutex->owner, XN_NO_HANDLE);
 	xnlock_put_irqrestore(&nklock, s);
 }
 



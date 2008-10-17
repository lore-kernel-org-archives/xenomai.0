Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F8B484.7010102@domain.hid>
Message-Id: <20081017154600.433015624@domain.hid>
Date: Fri, 17 Oct 2008 17:46:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
References: <20081017154559.420723261@domain.hid>
Subject: [Xenomai-core] [PATCH 06/13] Refactor mutex lockcnt tracking
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


This patch establishes the policy that only the current owner of a mutex
shall modify its lockcnt value (the POSIX skin works like that, too).

So far, needless updates took place when the previous owner just woke up
the new one. Moreover, the only spot that assumed lockcnt > 0 <=> mutex
assigned is changed to use xnsynch_owner instead.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/native/cond.c  |    6 ++----
 ksrc/skins/native/mutex.c |    8 ++------
 2 files changed, 4 insertions(+), 10 deletions(-)

Index: b/ksrc/skins/native/cond.c
===================================================================
--- a/ksrc/skins/native/cond.c
+++ b/ksrc/skins/native/cond.c
@@ -421,10 +421,8 @@ int rt_cond_wait_inner(RT_COND *cond, RT
 
 	mutex->lockcnt = 0;
 
-	if (xnsynch_release(&mutex->synch_base)) {
-		mutex->lockcnt = 1;
-		/* Scheduling deferred */
-	}
+	xnsynch_release(&mutex->synch_base);
+	/* Scheduling deferred */
 
 	xnsynch_sleep_on(&cond->synch_base, timeout, timeout_mode);
 
Index: b/ksrc/skins/native/mutex.c
===================================================================
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -320,8 +320,6 @@ int rt_mutex_acquire_inner(RT_MUTEX *mut
 		err = -EINTR;	/* Unblocked. */
 	else {
 	      grab_mutex:
-		/* xnsynch_sleep_on() might have stolen the resource,
-		   so we need to put our internal data in sync. */
 		mutex->lockcnt = 1;
 	}
 
@@ -524,10 +522,8 @@ int rt_mutex_release(RT_MUTEX *mutex)
 	if (--mutex->lockcnt > 0)
 		goto unlock_and_exit;
 
-	if (xnsynch_release(&mutex->synch_base)) {
-		mutex->lockcnt = 1;
+	if (xnsynch_release(&mutex->synch_base))
 		xnpod_schedule();
-	}
 
       unlock_and_exit:
 
@@ -584,7 +580,7 @@ int rt_mutex_inquire(RT_MUTEX *mutex, RT
 	strcpy(info->name, mutex->name);
 	info->lockcnt = mutex->lockcnt;
 	info->nwaiters = xnsynch_nsleepers(&mutex->synch_base);
-	if (mutex->lockcnt)
+	if (xnsynch_owner(&mutex->synch_base))
 		strcpy(info->owner,
 		       xnthread_name(xnsynch_owner(&mutex->synch_base)));
 	else



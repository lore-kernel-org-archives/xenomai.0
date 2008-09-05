Message-ID: <48C0EE6F.3090001@domain.hid>
Date: Fri, 05 Sep 2008 10:31:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BD409B.8000309@domain.hid>
In-Reply-To: <48BD409B.8000309@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] POSIX: Fix race when setting claimed bit - v2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

[ The refactored version according to our discussion. ]

This patch fixes the race when the claimed bit changes between the lock
less check an the entry of the nklock-protected section.

---
 ksrc/skins/posix/mutex.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -134,11 +134,16 @@ static inline int pse51_mutex_timedlock_
 	/* Set bit 0, so that mutex_unlock will know that the mutex is claimed.
 	   Hold the nklock, for mutual exclusion with slow mutex_unlock. */
 	xnlock_get_irqsave(&nklock, s);
-	while(!test_claimed(owner)) {
+	if (test_claimed(owner)) {
+		old = xnarch_atomic_intptr_get(mutex->owner);
+		goto test_no_owner;
+	}
+	do {
 		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
 						   owner, set_claimed(owner, 1));
 		if (likely(old == owner))
 			break;
+	  test_no_owner:
 		if (old == NULL) {
 			/* Owner called fast mutex_unlock
 			   (on another cpu) */
@@ -146,7 +151,7 @@ static inline int pse51_mutex_timedlock_
 			goto retry_lock;
 		}
 		owner = old;
-	}
+	} while (!test_claimed(owner));
 
 	xnsynch_set_owner(&mutex->synchbase, clear_claimed(owner));
 	++mutex->sleepers;


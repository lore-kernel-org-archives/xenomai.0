Message-ID: <48BD409B.8000309@domain.hid>
Date: Tue, 02 Sep 2008 15:33:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] POSIX: Fix race when setting claimed bit
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

Patch 2 of my fast lock series actually also contained an attempt to fix
a race I spotted in the code that atomically sets the claimed bit. I
forgot about this fact and even, worse, I only replace the original race
with another one.

So here comes a new attempt to fix the issue that the lock owner and/or
the claimed bit can change between trylock and the cmpxchg under nklock.
Please have a look and cross-check the logic.

The patch applies on top of vanilla SVN, so my series has to be rebased
and the fix has to be ported to native as well - where we just found it
in the field.

Jan

---
 ksrc/skins/posix/mutex.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -134,17 +134,18 @@ static inline int pse51_mutex_timedlock_
 	/* Set bit 0, so that mutex_unlock will know that the mutex is claimed.
 	   Hold the nklock, for mutual exclusion with slow mutex_unlock. */
 	xnlock_get_irqsave(&nklock, s);
+	owner = xnarch_atomic_intptr_get(mutex->owner);
 	while(!test_claimed(owner)) {
-		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
-						   owner, set_claimed(owner, 1));
-		if (likely(old == owner))
-			break;
-		if (old == NULL) {
+		if (owner == NULL) {
 			/* Owner called fast mutex_unlock
 			   (on another cpu) */
 			xnlock_put_irqrestore(&nklock, s);
 			goto retry_lock;
 		}
+		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
+						   owner, set_claimed(owner, 1));
+		if (likely(old == owner))
+			break;
 		owner = old;
 	}
 


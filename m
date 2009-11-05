Message-ID: <4AF30B2A.3050205@domain.hid>
Date: Thu, 05 Nov 2009 18:28:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] native: Properly update lockcnt on recursive
 call from secondary mode
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

We cannot assume that only non-recursive rt_mutex_acquire calls will
happen; the application may be buggy and come from secondary mode. Make
sure to update the user space recursion counter correctly in any case so
that at least the mutex is kept in a valid state.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Can be pulled from 'for-upstream' as well.

 src/skins/native/mutex.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/skins/native/mutex.c b/src/skins/native/mutex.c
index 29843c7..98844ef 100644
--- a/src/skins/native/mutex.c
+++ b/src/skins/native/mutex.c
@@ -96,6 +96,20 @@ static int rt_mutex_acquire_inner(RT_MUTEX *mutex, RTIME timeout, xntmode_t mode
 
 		if (timeout == TM_NONBLOCK && mode == XN_RELATIVE)
 			return -EWOULDBLOCK;
+	} else if (xnsynch_fast_owner_check(mutex->fastlock, cur) == 0) {
+		/*
+		 * The application is buggy as it jumped to secondary mode
+		 * while holding the mutex. Nevertheless, we have to keep the
+		 * mutex state consistent.
+		 *
+		 * We make no efforts to migrate or warn here. There is
+		 * CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX to catch such bugs.
+		 */
+		if (mutex->lockcnt == UINT_MAX)
+			return -EAGAIN;
+
+		mutex->lockcnt++;
+		return 0;
 	}
 #endif /* CONFIG_XENO_FASTSYNCH */
 
-- 
1.6.0.2


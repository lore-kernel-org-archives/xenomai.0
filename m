Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22C.2010602@domain.hid>
Message-ID: <48BBAE63.8010008@domain.hid>
Date: Mon, 01 Sep 2008 10:57:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid>
In-Reply-To: <48BBA9E6.5070400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH 6/9] Add XNSYNCH_FWDROB
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

Intermediate helper as long as skins implement fast locking and related
owner tracking on their own: Add 'forward XN_ROBBED state' to the caller
of xnsynch_sleep_on so that the correct owner can be looked up there.

---
 include/nucleus/synch.h |    3 ++-
 ksrc/nucleus/pod.c      |    6 ++++--
 ksrc/nucleus/synch.c    |   18 +++++++++++++-----
 3 files changed, 19 insertions(+), 8 deletions(-)

Index: b/include/nucleus/synch.h
===================================================================
--- a/include/nucleus/synch.h
+++ b/include/nucleus/synch.h
@@ -30,10 +30,11 @@
 #define XNSYNCH_NOPIP   0x0
 #define XNSYNCH_PIP     0x2
 #define XNSYNCH_DREORD  0x4
+#define XNSYNCH_FWDROB  0x8
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
-#define XNSYNCH_CLAIMED 0x8	/* Claimed by other thread(s) w/ PIP */
+#define XNSYNCH_CLAIMED 0x10	/* Claimed by other thread(s) w/ PIP */
 
 /* Spare flags usable by upper interfaces */
 #define XNSYNCH_SPARE0  0x01000000
Index: b/ksrc/nucleus/synch.c
===================================================================
--- a/ksrc/nucleus/synch.c
+++ b/ksrc/nucleus/synch.c
@@ -231,12 +231,20 @@ redo:
 	if (xnthread_test_info(thread, XNROBBED)) {
 		/* Somebody stole us the ownership while we were ready
 		   to run, waiting for the CPU: we need to wait again
-		   for the resource. */
-		if (timeout_mode != XN_RELATIVE || timeout == XN_INFINITE)
-			goto redo;
+		   for the resource, here or at caller site. */
+		if (timeout_mode != XN_RELATIVE || timeout == XN_INFINITE) {
+			if (testbits(synch->status, XNSYNCH_FWDROB))
+				goto unlock_and_exit;
+			else
+				goto redo;
+		}
 		timeout = xntimer_get_timeout_stopped(&thread->rtimer);
-		if (timeout > 1) /* Otherwise, it's too late. */
-			goto redo;
+		if (timeout > 1) { /* Otherwise, it's too late. */
+			if (testbits(synch->status, XNSYNCH_FWDROB))
+				goto unlock_and_exit;
+			else
+				goto redo;
+		}
 		xnthread_set_info(thread, XNTIMEO);
 	}
 
Index: b/ksrc/nucleus/pod.c
===================================================================
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1400,13 +1400,15 @@ void xnpod_suspend_thread(xnthread_t *th
 						"(thread=%s, mask=%lx)?!",
 						thread->name, mask);
 				);
-			xnthread_clear_info(thread, XNRMID | XNTIMEO);
+			xnthread_clear_info(thread,
+					    XNRMID | XNTIMEO | XNROBBED);
 			xnthread_set_info(thread, XNBREAK);
 			goto unlock_and_exit;
 		}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
-		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNROBBED);
+		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK |
+					    XNWAKEN | XNROBBED);
 	}
 
 	/* Don't start the timer for a thread indefinitely delayed by



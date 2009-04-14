Message-ID: <49E4967C.6010909@domain.hid>
Date: Tue, 14 Apr 2009 15:58:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] posix: Fix HAVE_MQUEUE_H check
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Please pull from git://git.xenomai.org/xenomai-jki.git for-upstream

------>

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/posix/mqueue.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/posix/mqueue.h b/include/posix/mqueue.h
index b5870f9..f4f40c8 100644
--- a/include/posix/mqueue.h
+++ b/include/posix/mqueue.h
@@ -40,7 +40,7 @@
 
 #endif /* !(__KERNEL__ || __XENO_SIM__) */
 
-#if defined(__KERNEL__) || defined(__XENO_SIM__) || !HAVE_MQUEUE
+#if defined(__KERNEL__) || defined(__XENO_SIM__) || !defined(HAVE_MQUEUE_H)
 
 #ifndef MQ_PRIO_MAX
 #define MQ_PRIO_MAX 32768
@@ -104,7 +104,7 @@ int mq_unlink(const char *name);
 }
 #endif
 
-#else /* !(__KERNEL__ || __XENO_SIM__ || !HAVE_MQUEUE) */
+#else /* !(__KERNEL__ || __XENO_SIM__ || !HAVE_MQUEUE_H) */
 
 #include_next <mqueue.h>
 
@@ -155,6 +155,6 @@ int __real_mq_notify(mqd_t mqdes, const struct sigevent *notification);
 }
 #endif
 
-#endif /* !(__KERNEL__ || __XENO_SIM__ || !HAVE_MQUEUE) */
+#endif /* !(__KERNEL__ || __XENO_SIM__ || !HAVE_MQUEUE_H) */
 
 #endif /* _XENO_POSIX_MQUEUE_H */


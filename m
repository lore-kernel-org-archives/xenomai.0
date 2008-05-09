Message-ID: <48241735.1050400@domain.hid>
Date: Fri, 09 May 2008 11:19:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] avoid deadlock-prone sighand_lock in
	do_schedule_event
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This has been posted earlier already: Fix deadlocks when debugging
Xenomai applications via gdb by removing any attempt to acquire
sighand_lock (while holding rq_lock). This patch also cleans up the now
unused lock wrapper.

Unless someone complains, I'm going to merge this later today into trunk
and 2.4.x.

Jan

---
 include/asm-generic/wrappers.h |    1 -
 ksrc/nucleus/shadow.c          |    2 --
 2 files changed, 3 deletions(-)

Index: b/include/asm-generic/wrappers.h
===================================================================
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -95,7 +95,6 @@ unsigned long __va_to_kva(unsigned long 
 #define PF_NOFREEZE 0
 
 /* Signals */
-#define wrap_sighand_lock(p)     ((p)->sigmask_lock)
 #define wrap_get_sigpending(m,p) sigandsets(m, \
 					    &(p)->pending.signal, \
 					    &(p)->pending.signal)
Index: b/ksrc/nucleus/shadow.c
===================================================================
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2194,9 +2194,7 @@ static inline void do_schedule_event(str
 			if (signal_pending(next)) {
 				sigset_t pending;
 
-				spin_lock(&wrap_sighand_lock(next));	/* Already interrupt-safe. */
 				wrap_get_sigpending(&pending, next);
-				spin_unlock(&wrap_sighand_lock(next));
 
 				if (sigismember(&pending, SIGSTOP) ||
 				    sigismember(&pending, SIGINT))

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


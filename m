Message-ID: <49B3AA0E.5020805@domain.hid>
Date: Sun, 08 Mar 2009 12:20:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] nucleus: Remove xnshadow_relax from taskexit
	hook
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

This is no longer needed as do_exit, the caller of this hook, always
runs in secondary mode. Enforce this assumptions by leaving a XENO_BUGON
behind.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/shadow.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index e2f2968..66943ba 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2179,12 +2179,11 @@ static inline void do_taskexit_event(struct task_struct *p)
 	if (!thread)
 		return;
 
+	XENO_BUGON(NUCLEUS, xnpod_shadow_p());
+
 	if (xnthread_test_state(thread, XNDEBUG))
 		unlock_timers();
 
-	if (xnpod_shadow_p())
-		xnshadow_relax(0);
-
 	magic = xnthread_get_magic(thread);
 
 	xnlock_get_irqsave(&nklock, s);


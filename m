Message-ID: <49C0BE3A.40705@domain.hid>
Date: Wed, 18 Mar 2009 10:26:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Add module param to configure watchdog
	timeout
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

This allows to play with larger watchdog timeouts without requiring the
user to recompile the kernel to find out if an overload situation is
permanent or transient.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/sched.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index e740d26..77f5a4b 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -49,6 +49,10 @@ int xnsched_register_class(struct xnsched_class *sched_class)
 
 #ifdef CONFIG_XENO_OPT_WATCHDOG
 
+static u_long wd_timeout_arg = CONFIG_XENO_OPT_WATCHDOG_TIMEOUT;
+module_param_named(watchdog_timeout, wd_timeout_arg, ulong, 0444);
+MODULE_PARM_DESC(watchdog_timeout, "Watchdog timeout (s)");
+
 /*! 
  * @internal
  * \fn void xnsched_watchdog_handler(struct xntimer *timer)
@@ -69,8 +73,8 @@ static void xnsched_watchdog_handler(struct xntimer *timer)
 		xnsched_reset_watchdog(sched);
 		return;
 	}
-		
-	if (unlikely(++sched->wdcount >= CONFIG_XENO_OPT_WATCHDOG_TIMEOUT)) {
+
+	if (unlikely(++sched->wdcount >= wd_timeout_arg)) {
 		trace_mark(xn_nucleus, watchdog, "thread %p thread_name %s",
 			   thread, xnthread_name(thread));
 		xnprintf("watchdog triggered -- killing runaway thread '%s'\n",


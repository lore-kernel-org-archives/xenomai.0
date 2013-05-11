From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat, 11 May 2013 19:51:32 +0200
Message-Id: <1368294693-4769-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <518E84CD.7010506@xenomai.org>
References: <518E84CD.7010506@xenomai.org>
Subject: [Xenomai] [PATCH 1/2] nucleus/shadow: generalize
	xnshadow_call_mayday
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Allow skins to use it to send other signals than SIGDEBUG
---
 include/nucleus/shadow.h |    5 ++---
 ksrc/nucleus/sched.c     |    3 ++-
 ksrc/nucleus/shadow.c    |    3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/nucleus/shadow.h b/include/nucleus/shadow.h
index 9c8784c..bca3c48 100644
--- a/include/nucleus/shadow.h
+++ b/include/nucleus/shadow.h
@@ -99,10 +99,9 @@ void xnshadow_rpi_check(void);
 
 #ifdef RTHAL_HAVE_RETURN_EVENT
 #define XNARCH_HAVE_MAYDAY  1
-void xnshadow_call_mayday(struct xnthread *thread, int sigtype);
+void xnshadow_call_mayday(struct xnthread *thread);
 #else
-static inline void xnshadow_call_mayday(struct xnthread *thread,
-					int sigtype)
+static inline void xnshadow_call_mayday(struct xnthread *thread)
 {
 	/* no luck, I-pipe too old. Nobody hears you screaming... */
 }
diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 5d2f074..3391f4a 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -99,7 +99,8 @@ static void xnsched_watchdog_handler(struct xntimer *timer)
 		xnprintf("watchdog triggered -- signaling runaway thread "
 			 "'%s'\n", xnthread_name(thread));
 		xnthread_set_info(thread, XNAMOK);
-		xnshadow_call_mayday(thread, SIGDEBUG_WATCHDOG);
+		xnshadow_send_sig(thread, SIGDEBUG, SIGDEBUG_WATCHDOG, 1);
+		xnshadow_call_mayday(thread);
 	} else
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 	{
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 7c4e032..50ee035 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1643,11 +1643,10 @@ static unsigned long map_mayday_page(struct task_struct *p)
 	return IS_ERR_VALUE(u_addr) ? 0UL : u_addr;
 }
 
-void xnshadow_call_mayday(struct xnthread *thread, int sigtype)
+void xnshadow_call_mayday(struct xnthread *thread)
 {
 	struct task_struct *p = xnthread_archtcb(thread)->user_task;
 	xnthread_set_info(thread, XNKICKED);
-	xnshadow_send_sig(thread, SIGDEBUG, sigtype, 1);
 	xnarch_call_mayday(p);
 }
 EXPORT_SYMBOL_GPL(xnshadow_call_mayday);
-- 
1.7.2.5



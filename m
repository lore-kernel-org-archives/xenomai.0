From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 22 Jun 2018 17:42:33 +0200
Message-Id: <3dd233eb073399888f984dcad834e96264b5c77f.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 1/4] cobalt/posix: Move signal_put_siginfo
	unmodified
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We will need it inside signal_wait. No functional changes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/signal.c | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 2081af4e04..a71bb1085b 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -201,6 +201,37 @@ void cobalt_signal_flush(struct cobalt_thread *thread)
 	sigemptyset(&thread->sigpending);
 }
 
+static int signal_put_siginfo(void __user *u_si, const struct siginfo *si,
+			      int overrun)
+{
+	struct siginfo __user *u_p = u_si;
+	int ret;
+
+	ret = __xn_put_user(si->si_signo, &u_p->si_signo);
+	ret |= __xn_put_user(si->si_errno, &u_p->si_errno);
+	ret |= __xn_put_user(si->si_code, &u_p->si_code);
+
+	/*
+	 * Copy the generic/standard siginfo bits to userland.
+	 */
+	switch (si->si_code) {
+	case SI_TIMER:
+		ret |= __xn_put_user(si->si_tid, &u_p->si_tid);
+		ret |= __xn_put_user(si->si_ptr, &u_p->si_ptr);
+		ret |= __xn_put_user(overrun, &u_p->si_overrun);
+		break;
+	case SI_QUEUE:
+	case SI_MESGQ:
+		ret |= __xn_put_user(si->si_ptr, &u_p->si_ptr);
+		/* falldown wanted. */
+	case SI_USER:
+		ret |= __xn_put_user(si->si_pid, &u_p->si_pid);
+		ret |= __xn_put_user(si->si_uid, &u_p->si_uid);
+	}
+
+	return ret;
+}
+
 static int signal_wait(sigset_t *set, xnticks_t timeout,
 		       void __user *u_si,
 		       int (*put_siginfo)(void __user *u_si,
@@ -335,37 +366,6 @@ fail:
 	return ret;
 }
 
-static int signal_put_siginfo(void __user *u_si, const struct siginfo *si,
-			      int overrun)
-{
-	struct siginfo __user *u_p = u_si;
-	int ret;
-
-	ret = __xn_put_user(si->si_signo, &u_p->si_signo);
-	ret |= __xn_put_user(si->si_errno, &u_p->si_errno);
-	ret |= __xn_put_user(si->si_code, &u_p->si_code);
-
-	/*
-	 * Copy the generic/standard siginfo bits to userland.
-	 */
-	switch (si->si_code) {
-	case SI_TIMER:
-		ret |= __xn_put_user(si->si_tid, &u_p->si_tid);
-		ret |= __xn_put_user(si->si_ptr, &u_p->si_ptr);
-		ret |= __xn_put_user(overrun, &u_p->si_overrun);
-		break;
-	case SI_QUEUE:
-	case SI_MESGQ:
-		ret |= __xn_put_user(si->si_ptr, &u_p->si_ptr);
-		/* falldown wanted. */
-	case SI_USER:
-		ret |= __xn_put_user(si->si_pid, &u_p->si_pid);
-		ret |= __xn_put_user(si->si_uid, &u_p->si_uid);
-	}
-
-	return ret;
-}
-
 int __cobalt_sigwait(sigset_t *set)
 {
 	return signal_wait(set, XN_INFINITE, NULL, NULL);
-- 
2.13.7



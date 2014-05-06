Message-ID: <5368DC2C.5000505@xenomai.org>
Date: Tue, 06 May 2014 14:57:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20140502141307.B6A14EC0@centrum.cz>,
 <53639AC8.1000507@xenomai.org>,
 <20140506101735.3A0BEBEB@centrum.cz> <5368A3A2.1010302@xenomai.org>
 <20140506112918.F5E14FAA@centrum.cz>
In-Reply-To: <20140506112918.F5E14FAA@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] non-blocking rt_task_suspend(NULL)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 05/06/2014 11:29 AM, Petr Cervenka wrote:

> 
> Here it is. It's full of modules and other perhaps not so real-time 
> settings, because it was derived from Kubuntu kernel config file.
> 

Thanks. The issue seems to happen as a result of a relax -> harden transition racing with a signal receipt. In order to help me ruling out some assumptions, could you please apply the patch below, and confirm that no job control is involved (SIGCONT/SIGSTOP) in your application?

Knowing whether any of the two warnings added by this patch is issued when the bug happens would also help solving the issue, TIA.

diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 0a2ee19..9fb797f 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1379,15 +1379,17 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
 		 * context, to collect and act upon the pending Linux
 		 * signal.
 		 */
-		if ((mask & XNRELAX) == 0 &&
-		    xnthread_test_info(thread, XNKICKED)) {
-			if (wchan) {
-				thread->wchan = wchan;
-				xnsynch_forget_sleeper(thread);
+		if (xnthread_test_info(thread, XNKICKED)) {
+			if ((mask & XNRELAX) == 0) {
+				if (wchan) {
+					thread->wchan = wchan;
+					xnsynch_forget_sleeper(thread);
+				}
+				xnthread_clear_info(thread, XNRMID | XNTIMEO);
+				xnthread_set_info(thread, XNBREAK);
+				goto unlock_and_exit;
 			}
-			xnthread_clear_info(thread, XNRMID | XNTIMEO);
-			xnthread_set_info(thread, XNBREAK);
-			goto unlock_and_exit;
+			WARN_ON(1);
 		}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 38c1423..fc592a2 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2696,6 +2696,8 @@ static inline void do_sigwake_event(struct task_struct *p)
 		}
 	}
 
+	WARN_ON(!signal_pending(p));
+
 	/*
 	 * If a relaxed thread is getting a signal while running, we
 	 * force it out of RPI, so that it won't keep a boosted
-- 
Philippe.


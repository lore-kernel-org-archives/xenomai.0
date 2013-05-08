Message-ID: <518A77F8.3070404@xenomai.org>
Date: Wed, 08 May 2013 18:06:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>
	<51830D98.7090309@xenomai.org>	<5183CDD6.80400@mitrol.it>
	<518A06C9.50204@mitrol.it> <518A4C09.8030906@xenomai.org>
	<518A505C.2090207@mitrol.it> <518A52A7.5000801@xenomai.org>
	<518A5600.20508@mitrol.it> <518A6195.7030206@mitrol.it>
In-Reply-To: <518A6195.7030206@mitrol.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Re : Sporadic problem : rt_task_sleep locked after
 debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 05/08/2013 04:30 PM, Paolo Minazzi wrote:
> I think to be very near to the solution of this problem.
> Thanks to Gilles for his patience.
> 
> Now I will retry to make a summary of the problem.
>

<snip>

> The thread 1 finds thread 70 in debug mode !
> 

Which is expected. thread 70 has to be scheduled in with no pending ptrace signals for leaving this mode, and this may happen long after the truckload of other threads releases the CPU.

> My patch adjust this problem.
> 
> I realize that it is a very special case, but it is my case.
> 
> I'd like to know if the patch is valid or can be written in a different 
> way.
> For example, I could insert my patch directly in xnpod_delete_thread().
> 
> The function unlock_timers() cannot be called from 
> xenomai-2.5.6/ksrc/skins/native/task.c
> because it is defined static. This is a detail. There are simple ways to 
> solve this.
> 

No, really the patch is wrong, but what you expose does reveal a bug in the Xenomai core for sure. As Gilles told you, you would be only papering over that real bug, which would likely show up in a different situation.

First we need to check for a lock imbalance, I don't think that code is particularly safe.
Please apply the patch below, hoping that it won't affect the timings too much.
A lock imbalance should trigger a BUG assertion, we will try finding out any weirdness
in the locking sequence based on the kernel log output this patch also produces.
Please apply this patch on the stock Xenomai code, then send us back any valuable
kernel output. TIA,

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index c91a6f3..edbbbfd 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -725,18 +725,30 @@ static inline void set_linux_task_priority(struct task_struct *p, int prio)
 		       prio, p->comm);
 }
 
-static inline void lock_timers(void)
+static inline void __lock_timers(struct xnthread *thread, const char *fn)
 {
 	xnarch_atomic_inc(&nkpod->timerlck);
 	setbits(nktbase.status, XNTBLCK);
+	XENO_BUGON(NUCLEUS, xnarch_atomic_get(&nkpod->timerlck) == 0);
+	printk(KERN_WARNING "%s LOCK, thread=%s[%d], count=%d\n",
+	       fn, thread->name, xnthread_user_pid(thread),
+	       xnarch_atomic_get(&nkpod->timerlck));
 }
 
-static inline void unlock_timers(void)
+static inline void __unlock_timers(struct xnthread *thread, const char *fn)
 {
-	if (xnarch_atomic_dec_and_test(&nkpod->timerlck))
+	if (xnarch_atomic_dec_and_test(&nkpod->timerlck)) {
 		clrbits(nktbase.status, XNTBLCK);
+		XENO_BUGON(NUCLEUS, xnarch_atomic_get(&nkpod->timerlck) != 0);
+	}
+	printk(KERN_WARNING "%s UNLOCK, thread=%s[%d], count=%d\n",
+	       fn, thread->name, xnthread_user_pid(thread),
+	       xnarch_atomic_get(&nkpod->timerlck));
 }
 
+#define lock_timers(t)		__lock_timers((t), __func__)
+#define unlock_timers(t)	__unlock_timers((t), __func__)
+
 static void xnshadow_dereference_skin(unsigned magic)
 {
 	unsigned muxid;
@@ -2572,7 +2584,7 @@ static inline void do_taskexit_event(struct task_struct *p)
 	XENO_BUGON(NUCLEUS, !xnpod_root_p());
 
 	if (xnthread_test_state(thread, XNDEBUG))
-		unlock_timers();
+		unlock_timers(thread);
 
 	magic = xnthread_get_magic(thread);
 
@@ -2636,7 +2648,7 @@ static inline void do_schedule_event(struct task_struct *next_task)
 					goto no_ptrace;
 			}
 			xnthread_clear_state(next, XNDEBUG);
-			unlock_timers();
+			unlock_timers(next);
 		}
 
 	      no_ptrace:
@@ -2691,7 +2703,7 @@ static inline void do_sigwake_event(struct task_struct *p)
 		    sigismember(&pending, SIGSTOP)
 		    || sigismember(&pending, SIGINT)) {
 			xnthread_set_state(thread, XNDEBUG);
-			lock_timers();
+			lock_timers(thread);
 		}
 	}

-- 
Philippe.


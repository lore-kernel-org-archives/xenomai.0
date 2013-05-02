Message-ID: <51826EEA.1090202@mitrol.it>
Date: Thu, 02 May 2013 15:49:30 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Re : Sporadic problem : rt_task_sleep locked after
	debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm Paolo Minazzi and some time ago I write you for a problem
related to xenomai and gdb.
After a long time I think to be near to a solution.
I'd like your help and opinions because maybe also other people
have the same problem.

In short, if I debug a xenomai user-space application,
sometimes after a rt_task_sleep the application seems locked.
After this condition, I have to restart my arm processor
because xenomai seems locked. Normal linux application instead
continue to work correctly.

A solution that works for me is to comment some lines in
xenomai-2.5.6/ksrc/nucleus/shadow.c:2620
Please see my comments that begin with "// COMMENT"

==================================================================================
if (xnthread_test_state(next, XNDEBUG)) {
         if (signal_pending(next_task)) {
                 sigset_t pending;
                 /*
                  * Do not grab the sighand lock here:
                  * it's useless, and we already own
                  * the runqueue lock, so this would
                  * expose us to deadlock situations on
                  * SMP.
                  */
                 wrap_get_sigpending(&pending, next_task);

                 // COMMENT if (sigismember(&pending, SIGSTOP) ||
                 // COMMENT     sigismember(&pending, SIGINT))
                 // COMMENT         goto no_ptrace;
         }
         xnthread_clear_state(next, XNDEBUG);
         unlock_timers();
}
no_ptrace:
==================================================================================

The source of my problem seems to be the locked timers.
If I unlock the timers (manually using a dirty hack) when I'm in the bug 
condition
I can repeair the problem and continue to use xenomai without any problems.

In xenomai-2.5.6/ksrc/nucleus/shadow.c:2615

                 /*
                  * Check whether we need to unlock the timers, each
                  * time a Linux task resumes from a stopped state,
                  * excluding tasks resuming shortly for entering a
                  * stopped state asap due to ptracing. To identify the
                  * latter, we need to check for SIGSTOP and SIGINT in
                  * order to encompass both the NPTL and LinuxThreads
                  * behaviours.
                  */

that explains why SIGINT and SIGSTOP are checked. I do not understand well
all this but it seems related to signal used by gdb.
Have you got an idea to solve in the right way the problem ?

Thanks for your time

Paolo Minazzi



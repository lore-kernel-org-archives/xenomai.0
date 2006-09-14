Subject: Re: [Xenomai-help] problem with rt_task_send() timeout and timer
	overruns
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1158242302.5040.121.camel@domain.hid>
References: <45087D79.50506@domain.hid> <1158242302.5040.121.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 16:57:28 +0200
Message-Id: <1158245848.5040.138.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <vleves@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-09-14 at 15:58 +0200, Philippe Gerum wrote:
> On Wed, 2006-09-13 at 17:51 -0400, Vincent Levesque wrote:
> > Hello all,
> > 
> > I ran into some problems after moving working code to a slower machine 
> > and traced the problem down to the example attached at the bottom of 
> > this email. I've been using rt_task_send() to implement the equivalent 
> > of a function call, with an error code returned in the reply MCB's 
> > opcode field. In the example below, I send a message and expect a "666" 
> > opcode to be returned but I receive garbage at least on a few calls. The 
> > problem seems to occur when 1) the update rate in the sender is too high 
> > and 2) rt_task_send() has a timeout value (1 sec in the example.)  If I 
> > increase MAIN_RATE_NS or set the TIMEOUT to TM_INFINITE everything seems 
> > to be ok. I've been able to reproduce this problem with xenomai 2.2.2 
> > (two PCs) and 2.1.3. In more complex versions of this code the reply 
> > data buffers also seemed to be invalid or corrupted.
> > 
> 
> Confirmed and reproduced, including over the simulator. The reason for
> the invalid opcode is that rt_task_reply() signals an EXIO error, so the
> return value is not filled in. The question is: why do we get this
> error. More later.

This behaviour was due to the conflict between undergoing a periodic
timeline through rt_task_make_periodic(), while blocking on
rt_task_send() for a reply, at the same time. Since the main rate is 5
ms, and the peer rate is 100 us, waiting for 50 periods of the latter
would delay the peer task long enough for the main period to trigger and
spuriously unblock rt_task_send(), before any reply was sent.

This use case is a bit tortuous, and actually not recommended, since
running a timeline means that you should either wait for the next
period, or process your work cycle without entering incompatible delays.
But it has revealed a real problem, since blocking on e.g. a semaphore,
instead of a reply, for a bounded time, would have raised the same
issue. Thanks for reporting.

This patch against v2.2.2 should fix the issue.

--- ksrc/nucleus/thread.c	(revision 1606)
+++ ksrc/nucleus/thread.c	(working copy)
@@ -35,7 +35,9 @@
 {
 	xnthread_t *thread = container_of(timer, xnthread_t, ptimer);
 
-	if (xnthread_test_flags(thread, XNDELAY))	/* Prevent unwanted round-robin. */
+	/* Prevent unwanted round-robin, and do not wake up threads
+	   blocked on a resource. */
+	if (xnthread_test_flags(thread, XNDELAY|XNPEND) == XNDELAY)
 		xnpod_resume_thread(thread, XNDELAY);
 }
 
-- 
Philippe.




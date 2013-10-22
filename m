From: "Daniel Merrill" <daniel.merrill@psware.com>
References: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<52558563.2010408@xenomai.org>	<8fed609f.0000172c.00000017@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<525587A2.5000507@xenomai.org>
 <73cb019f.0000172c.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <8a1928a6.00000970.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <1aa47ae4.00001700.00000005@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <526681B9.1010302@xenomai.org>
In-Reply-To: <526681B9.1010302@xenomai.org>
Date: Tue, 22 Oct 2013 09:50:30 -0700 (MST)
Message-ID: <257ab41a.00001700.00000010@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Xenomai] t_suspend and XNBREAK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Philippe Gerum' <rpm@xenomai.org>, xenomai@xenomai.org



> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Tuesday, October 22, 2013 6:47 AM
> To: Daniel Merrill; xenomai@xenomai.org
> Subject: Re: [Xenomai] t_suspend and XNBREAK
> 
> On 10/21/2013 08:21 PM, Daniel Merrill wrote:
> 
> > More follow up on this, we went ahead and put some logging in shadow.c
> > which from what we could find is where the signal is "kicking" the
thread.
> >>From the logging it looks like the only signals we get (while attached
> >>to
> > GDB) are SIGSTOP, SIGTRAP, SIGRT32 and SIGKILL(upon exiting the
debugger).
> > I'm assuming the SIGSTOP, SIGTRAP and SIGKILL are normal from the
> > debugger. It looks like shadow.c looks for SIGTRAP and SIGSTOP and
> > sets an XNDEBUG state on the thread which I assume allows it to
> > restart the suspend?
> 
> XNDEBUG marks a thread which is ptraced, this has implications when
managing
> the system timer while the app is single-stepped/stopped by a debugger.
> 
>   SIGRT32 I believe comes from our calls to t_delete. I'm guessing
> > this is what's causing the suspends to fail? Anyway, I appreciate any
> > additional insight anyone can offer. Thanks again for all the help.
> >
> 
> t_delete() will cause t_suspend() to unblock if sent to the suspended
task, due to
> receiving SIGRT32/SIGCANCEL from the linux side, which is how the NPTL
deals
> with async cancellation internally (t_delete() ->
> pthread_cancel() -> t(g)kill(SIGCANCEL)).
> 
> Internally, XNBREAK will be raised for that task, causing -EINTR to be
> propagated back. However, since there is SIGCANCEL pending for the task,
the
> NPTL handler should run on the way back to the call site in t_suspend(),
and the
> task should never return from this handler.
> 
> In short, receiving EINTR from t_suspend() is unexpected, particularly
when
> unblocked by SIGCANCEL. I could not reproduce this issue based on the
simple
> test, running over GDB (7.5.1).
> 
> A few questions more:
> 
> - regardless of t_delete(), is the problem about one or multiple threads
> unblocking unexpectedly from t_suspend(0), when single-stepping a
distinct
> thread over GDB?
> 

There are about 5 threads that this occurs on, all are deleted by an
outside "controlling" thread. Essentially what happens is occasionally
some of the threads will fail to suspend because of the EINTR issue. What
is supposed to happen is that the thread is supposed to suspend itself and
then wait in that state until it is removed by the t_delete.  Most of the
time it works even when debugger is attached, however taking some code
paths seems to put it into a state where some or all of the threads that
receive the t_delete begin to fail their t_suspend(0) calls.

> - I'm testing with Xenomai 2.6.3. Which version have you been using, on
which
> cpu/platform, using which I-pipe release in the kernel (check
> /proc/xenomai/{version, hal}?

We're using Xenomai 2.6.2.1, i-pipe-core-3.5.7-x86-3
> 
> - Also could you write a simple test code illustrating the issue so that
I could try
> reproducing it? Typically, would this be reproducible on your setup with
a single
> task running t_suspend(0), while ptracing the main routine in parallel?
> 
I've been wanting to give this a try and will attempt now that I think I
have an understanding of what is causing the issue. Up to this point I've
been at a loss for what even to try. I will give it my best shot and see
if I can get this to happen in a much simpler context.

> TIA,
> 
> --
> Philippe.


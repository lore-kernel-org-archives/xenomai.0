Message-ID: <526681B9.1010302@xenomai.org>
Date: Tue, 22 Oct 2013 15:46:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <efafe9af.0000172c.00000011@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<52558563.2010408@xenomai.org>	<8fed609f.0000172c.00000017@dmerrill_win764.PERF.PERFORMANCESOFTWARE>	<525587A2.5000507@xenomai.org>
 <73cb019f.0000172c.0000001c@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <8a1928a6.00000970.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
 <1aa47ae4.00001700.00000005@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
In-Reply-To: <1aa47ae4.00001700.00000005@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] t_suspend and XNBREAK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Daniel Merrill <daniel.merrill@psware.com>, xenomai@xenomai.org

On 10/21/2013 08:21 PM, Daniel Merrill wrote:

> More follow up on this, we went ahead and put some logging in shadow.c
> which from what we could find is where the signal is "kicking" the thread.
>>From the logging it looks like the only signals we get (while attached to
> GDB) are SIGSTOP, SIGTRAP, SIGRT32 and SIGKILL(upon exiting the debugger).
> I'm assuming the SIGSTOP, SIGTRAP and SIGKILL are normal from the
> debugger. It looks like shadow.c looks for SIGTRAP and SIGSTOP and sets an
> XNDEBUG state on the thread which I assume allows it to restart the
> suspend?

XNDEBUG marks a thread which is ptraced, this has implications when 
managing the system timer while the app is single-stepped/stopped by a 
debugger.

  SIGRT32 I believe comes from our calls to t_delete. I'm guessing
> this is what's causing the suspends to fail? Anyway, I appreciate any
> additional insight anyone can offer. Thanks again for all the help.
>

t_delete() will cause t_suspend() to unblock if sent to the suspended 
task, due to receiving SIGRT32/SIGCANCEL from the linux side, which is 
how the NPTL deals with async cancellation internally (t_delete() -> 
pthread_cancel() -> t(g)kill(SIGCANCEL)).

Internally, XNBREAK will be raised for that task, causing -EINTR to be 
propagated back. However, since there is SIGCANCEL pending for the task, 
the NPTL handler should run on the way back to the call site in 
t_suspend(), and the task should never return from this handler.

In short, receiving EINTR from t_suspend() is unexpected, particularly 
when unblocked by SIGCANCEL. I could not reproduce this issue based on 
the simple test, running over GDB (7.5.1).

A few questions more:

- regardless of t_delete(), is the problem about one or multiple threads 
unblocking unexpectedly from t_suspend(0), when single-stepping a 
distinct thread over GDB?

- I'm testing with Xenomai 2.6.3. Which version have you been using, on 
which cpu/platform, using which I-pipe release in the kernel (check 
/proc/xenomai/{version, hal}?

- Also could you write a simple test code illustrating the issue so that 
I could try reproducing it? Typically, would this be reproducible on 
your setup with a single task running t_suspend(0), while ptracing the 
main routine in parallel?

TIA,

-- 
Philippe.


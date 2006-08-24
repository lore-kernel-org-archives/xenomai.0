Subject: Re: [Xenomai-help] scheduling of low priority primary mode Xenomai
	threads versus high priority secondary mode Xenomai threads
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <75975c320608231401k79b60e4o7a53bc75b2149287@domain.hid>
References: <75975c320608231401k79b60e4o7a53bc75b2149287@domain.hid>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 11:51:44 +0200
Message-Id: <1156413105.4832.89.camel@domain.hid>
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
To: Paul Ianna <paulianna2002@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-08-23 at 17:01 -0400, Paul Ianna wrote:
> Greetings (again),
> 
> If a running primary mode high priority Xenomai thread drops to
> secondary mode and ends up in a function that takes a "long" time,
> what happens to primary mode low priority Xenomai threads that are (or
> become) ready to run?
> 

If by "long time" you mean actual computing time without any blocked
state, then the low priority thread will wait until the high priority
one either suspends Linux-wise, or moves back to primary and suspends
Xenomai-wise (e.g. by issuing a blocking Xenomai syscall). IOW, Linux
and Xenomai schedulers are coupled and have compatible priority scales,
so that the real-time priority scheme always looks consistent even
across domain migrations.

You should think of this feature as a way to have the Linux kernel as a
whole inherit the Xenomai priority of the secondary mode thread which
runs.

This coupling can be disabled by switching on
CONFIG_XENO_OPT_RPIDISABLE, in which case, moving to secondary mode
means downgrading the thread priority to the one assigned to the regular
Linux kernel in the Xenomai scheduler when both schedulers are not
coupled, i.e. the lowest one.

> On the flip side, what happens if a high priority secondary mode
> Xenomai thread is blocked and becomes ready to run while a low
> priority primary mode Xenomai thread is executing?
> 

That's a tricky part: since a primary mode thread is running, interrupts
- that could unblock the secondary mode thread - do _not_ flow down to
Linux, until no more primary mode thread runs on the current CPU. This
is implied by the position of the Xenomai domain in the Adeos pipeline,
which precedes Linux there.

Adeos ensures that all domains process the incoming interrupts in turn,
according to their priority in the pipeline, and to do so, it guarantees
that a domain will resume execution only after all higher priority
domains are done with their current duties. As a consequence of which,
primary mode threads in the Xenomai domain always have overall
precedence over blocked secondary mode threads from the Linux domain,
since the wake up interrupt will be propagated to Linux only after the
Xenomai domain has suspended execution.

If the secondary mode thread is awaken by some internal event (e.g.
Linux semaphore or wait queue signaled), then the preempted activity
must belong to the secondary mode anyway, since Linux synchronizations
must be used (in this case, "posted" or "signaled") when the Linux
scheduler is in control.

> I guess, asked another way, do Xenomai primary mode threads always
> preempt/run with precedence over Xenomai secondary mode threads, even
> though a secondary mode thread may have higher Xenomai priority?
> 

Not when CONFIG_XENO_OPT_RPIDISABLE is off, except if the secondary mode
thread is blocked by the Linux scheduler. That's precisely the point of
scheduler coupling.

PS: by secondary mode threads, we really mean Xenomai-enabled user-space
threads, aka "shadows". Plain regular Linux threads unknown from the
Xenomai scheduler are always preempted by primary mode threads, but they
_do_ compete for the CPU with secondary mode threads according to their
priority and scheduling class (e.g. a regular Linux thread belonging to
the SCHED_FIFO class with static priority 50, would preempt a secondary
mode Xenomai thread with priority 49).

> Thanks in advance,
> Paul
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.




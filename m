Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44AD3048.5050602@domain.hid>
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>
	<44AD27AF.8050804@domain.hid> <1152200271.4978.85.camel@domain.hid>
	<44AD3048.5050602@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 18:37:51 +0200
Message-Id: <1152203872.4978.124.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-07-06 at 17:46 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-07-06 at 17:09 +0200, Jan Kiszka wrote:
> >>> We could do that from the current loop below, given that the
> >>> accumulation routine is changed to use thread->sched implicitely.
> >> The idea is avoid adding even further load to the nklock-protected loop.
> >> And we only update the current thread, not each and every.
> >>
> > 
> > Yes, but why? I mean, accumulated time so far remains significant even
> > for non-running threads.
> 
> Update must only happen for the currently running thread on each cpu,
> otherwise you skew the stats up.
> 

The point is that you don't want to update there, just peek at the
current value for all threads, and indeed update for the current one
before that. So we should keep the initial loop, but only read the
accumulator in the second one.

> 
> But looking at the whole code in stat_seq_open() again, I now wonder if
> that whole routine isn't
> 
> a) fragile on task removal and
> b) still poorly scaling.
> 
> The thread name is only copied by reference, a disappearing instance my
> cause troubles on printing it.

Yes, this will admittedly print garbage if the day really goes rainy
(the kernel memory we point at would still be mapped, but occupied by
other data). The other option would be to copy the name, but that's
unacceptable latency-wise, since we would need to do that under nklock
protection.

>  And, instead of holding the lock all the
> time, shouldn't we better
> 
> 1. pick some element from the queue and mark it somehow
>    in-use under lock
> 2. print or copy the entry
> 3. reacquire the lock to proceed to the next one - after checking if
>    that element happened to be removed from the queue meanwhile

Unfortunately, you can't since the associated memory might be utterly
trashed.

>  (in that
>    case we could abort the output or try to resync)
> 

It's the "try to resync" that bothers me. We currently have no sane way
to give any guarantee about the consistency of the output sequence here,
unless maybe using an array representation for indexing the threads. But
I suspect ore issues ahead.

> I'm worrying about a potential nice xeno-top tool polling the stats at
> high frequency and causing unexpected jitters if there are a significant
> number tasks registered (think of passive shadows we may create
> automatically in the future!).
> 

I agree, that's a potential issue. But we should also find an approach
that does not cause half-baked or mis-resynced data to be emitted, and
the current seqfile interface is not providing an easy way to do this.

> Jan
> 
-- 
Philippe.




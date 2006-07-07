Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44AE16B3.80901@domain.hid>
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>
	<44AD27AF.8050804@domain.hid> <1152200271.4978.85.camel@domain.hid>
	<44AD3048.5050602@domain.hid>  <44AD3C00.9050909@domain.hid>
	<1152259455.5017.14.camel@domain.hid>  <44AE16B3.80901@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 10:49:18 +0200
Message-Id: <1152262158.5017.22.camel@domain.hid>
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

On Fri, 2006-07-07 at 10:09 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-07-06 at 18:36 +0200, Jan Kiszka wrote:
> >> Jan Kiszka wrote:
> >>> Philippe Gerum wrote:
> >>>> On Thu, 2006-07-06 at 17:09 +0200, Jan Kiszka wrote:
> >>>>>> We could do that from the current loop below, given that the
> >>>>>> accumulation routine is changed to use thread->sched implicitely.
> >>>>> The idea is avoid adding even further load to the nklock-protected loop.
> >>>>> And we only update the current thread, not each and every.
> >>>>>
> >>>> Yes, but why? I mean, accumulated time so far remains significant even
> >>>> for non-running threads.
> >>> Update must only happen for the currently running thread on each cpu,
> >>> otherwise you skew the stats up.
> >>>
> >>>
> >>> But looking at the whole code in stat_seq_open() again, I now wonder if
> >>> that whole routine isn't
> >>>
> >>> a) fragile on task removal and
> >>> b) still poorly scaling.
> >>>
> >>> The thread name is only copied by reference, a disappearing instance my
> >>> cause troubles on printing it. And, instead of holding the lock all the
> >>> time, shouldn't we better
> >>>
> >>> 1. pick some element from the queue and mark it somehow
> >>>    in-use under lock
> >>> 2. print or copy the entry
> >>> 3. reacquire the lock to proceed to the next one - after checking if
> >>>    that element happened to be removed from the queue meanwhile (in that
> >>>    case we could abort the output or try to resync)
> >> Not feasible (threads may not always be prevented from being deleted),
> >> but what about this:
> >>
> >> - maintain a modification counter for nkpod->threadq
> >> - in our /proc-loops (sched and latency e.g.):
> >>   1. take nklock
> >>   2. get current counter
> >>   3. compare with previous, restart whole loop if not matching
> >>   4. copy current element (including the name...)
> >>   5. forward element pointer
> >>   6. release nklock
> >>   7. goto 1 if not end-of-list
> >>
> >> As modifications on threadq should be fairly rare, I don't see a risk of
> >> looping endlessly here.
> >>
> > 
> > The more I think of it, the more I'm convinced that we are trying to
> > tweak /proc/xenomai/stats for the wrong purpose. Actually, some xeno_top
> > tool would rather need the equivalent of individual /proc/<pid> files,
> > thus reducing the contention on access, and the need for weird grepping
> > on the output. e.g. /proc/xenomai/threads/<pid> could emit per-thread
> > data in some easily greppable form by a user-space tool.
> 
> Far too complex in my eyes for this simple purpose (what's the pid of
> kernel-only threads?) -

It's symbolic name. It's not a matter of simplicity, your patch for that
purpose is rather complex already.

>  and we need to solve the latency problem of
> /sched and /stat anyway.

That's separate issues. Solving the scalability issue
of /proc/xenomai/stats and friends does not improve their usability in
the context of user-space tools monitoring thread activity. E.g. how are
we going to extend the reporting about such activity if need be, adding
yet another column to /stats and /sched?

> 
> Jan
-- 
Philippe.




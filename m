From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4651DBC7.1000305@domain.hid>
References: <465099CE.2010004@domain.hid>  <4651AFF9.5030402@domain.hid>
	<1179763621.473.145.camel@domain.hid>  <4651C70E.8080908@domain.hid>
	<1179766310.473.168.camel@domain.hid>  <4651DBC7.1000305@domain.hid>
Content-Type: text/plain
Date: Thu, 24 May 2007 11:20:19 +0200
Message-Id: <1179998419.23117.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] module_put called over non-root domain
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

On Mon, 2007-05-21 at 19:49 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> >>
> > 
> > In the light of what I have just written, you would only cause useless
> > wakeups doing so.
> 
> My question was if the test for "useless" was really race-safe on SMP.
> Then we could introduce it again in the APC handler. Otherwise, it might
> be safer to live with some degree of uselessness.
> 

This test is only a hint; the real problem if any would happen in the
wakeup routine. As a matter of fact, moving the wakeup call to the APC
would open a SMP issue, since we would have no guarantee that the target
task did not exit in the meantime on another CPU. The current
implementation prevents this by grabbing the nklock in the taskexit
hook, which means that once somebody is running the Xenomai deletion
hook on any CPU, no shadow task can exit on another one, so this has the
same effect as holding a task reference lock Linux-wise (albeit a bit
massive). We need to work a bit more on this issue.

> > 
> >>>> Well, this thing seems to work,
> >>> It does, actually.
> >>>
> >>>>  but it doesn't leave me with a good
> >>>> feeling. IMHO, there are far too many cleanup cases with all the
> >>>> combinations of non-shadow termination, shadow self-termination,
> >>>> termination on task exit, various SMP scenarios, etc.
> >>>>  Moreover, quite a
> >>>> lot of stuff is executed in atomic scheduling hooks (namely on cleanup).
> >>>> At least for shadow threads, I don't think all of this is necessary.
> >>>> Actually, deferring most of the uncritical cleanup work into Linux
> >>>> context would make things more regular, easier to review, and likely
> >>>> less disturbing for overall system latencies. I know that atomic
> >>>> scheduling hooks are required to implement certain skins, but I don't
> >>>> see why janitor work should be done there as well. And we also still
> >>>> have that tiny uncleanness on shadow threads termination around TCB
> >>>> release vs. hook execution.
> >>> Talking about xnshadow_unmap, and as your patch illustrates, what you
> >>> could postpone is basically the first part of the routine, which updates
> >>> the reference counts. The rest _must_ run over the deletion hook in
> >>> atomic context (already runs fine all Linux debug switches on). The
> >> rpi_pop()? No chance to call it before entering the scheduler and then
> >> the hooks?
> > 
> > What do you have in mind precisely?
> 
> Preemptibility whenever having all things in a single atomic region
> doesn't buy us much. Even if rpi_pop per se might not be heavy, adding
> it to an already complex path doesn't improve things.
> 
> So my spontaneous idea was, as you said the rest _must_ be atomic, if
> that piece couldn't be actually moved into the task deletion service and
> the task_exit Linux hook, ie. before taking the nklock again and do the
> final reschedule. Just an example for what might be improvable - once we
> dig here again.
> 

You don't want to run rpi_pop() after the bulk of xnpod_delete_thread()
has run for the same thread, and you don't want a preemption to occur
anytime between the thread deletion and the update of the RPI state that
still refers to it. You might try moving the call to rpi_pop() to the
prologue of both routines instead of waiting for the deletion hook to do
it, but this would introduce a priority issue in the do_taskexit_event
callout, since we might have lowered the root priority in rpi_pop() and
be switched out in the middle of the deletion process. Unless we hold
the nklock all time long, that is. Back to square #1, I'm afraid.

> > 
> >>> latency hit is certainly not seen there; the real issues are left in the
> >>> native and POSIX skin thread deletion routines (heap management and
> >>> other housekeeping calls under nklock and so on).
> >> That's surely true. Besides RPI manipulation, there is really no
> >> problematic code left here latency-wise. Other hooks are trickier. But
> >> my point is that we first need some infrastructure to provide an
> >> alternative cleanup context before we can start moving things. My patch
> >> today is a hack...err...workaround from this perspective.
> >>
> > 
> > I don't see it this way. This code is very specific, in the sense it
> > lays on the inter-domain boundary between Linux and Xenomai's primary
> > mode for a critical operation like thread deletion, this is what make
> > things a bit confusing. What's below and above this layer has to be as
> > seamless as possible, this code in particular can't.
> 
> Well, we could move the memory release of the shadow thread in Linux
> context e.g. (release on idle, a bit like RCU - uuuh).

This is basically what Gilles did in a recent patch to fix some treading
on freed memory, by releasing the shadow TCB through
xnheap_schedule_free(). I think we should have a look at the removal
from registry operations now.

>  Then the
> reference counter can find a new home as well. Maybe some more things,
> dunno yet.

The ref. count management has to move to Linux context anyway.

> 
> > 
> >>>> As we are already at it: LO_MAX_REQUESTS is a hidden limitation that
> >>>> may (theoretically) bite large setups when e.g. too many threads gets
> >>>> killed from the "wrong" context. At least some overflow detection is
> >>>> required here to warn the unfortunate user that he reached hard-coded
> >>>> scalability limits.
> >>> Yes.
> >> CONFIG_XENO_OPT_DEBUG[_NUCLEUS] or unconditionally (error return code)?
> >>
> > 
> > Making it depend on the debug switch looks good. People who are serious
> > about making production software do want to activate this switch once in
> > a while while developing it, really.
> > 
> 
> --- xenomai.orig/ksrc/nucleus/shadow.c
> +++ xenomai/ksrc/nucleus/shadow.c
> @@ -890,11 +890,19 @@ static void schedule_linux_call(int type
>  		);
> 
>  	splhigh(s);
> +
>  	reqnum = rq->in;
> +
> +	if (XENO_DEBUG(NUCLEUS) &&
> +	    ((reqnum + 1) & (LO_MAX_REQUESTS - 1)) == rq->out)
> +		xnpod_fatal("lostage queue overflow on CPU %d! "
> +			    "Increase LO_MAX_REQUESTS", cpuid);
> +
>  	rq->req[reqnum].type = type;
>  	rq->req[reqnum].task = p;
>  	rq->req[reqnum].arg = arg;
>  	rq->in = (reqnum + 1) & (LO_MAX_REQUESTS - 1);
> +
>  	splexit(s);
> 
>  	rthal_apc_schedule(lostage_apc);
> 
> 

Looks good. Will merge, thanks.

-- 
Philippe.




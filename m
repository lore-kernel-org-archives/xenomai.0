From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46555E5F.9020709@domain.hid>
References: <465099CE.2010004@domain.hid>  <4651AFF9.5030402@domain.hid>
	<1179763621.473.145.camel@domain.hid>  <4651C70E.8080908@domain.hid>
	<1179766310.473.168.camel@domain.hid>  <4651DBC7.1000305@domain.hid>
	<1179998419.23117.42.camel@domain.hid>  <46555E5F.9020709@domain.hid>
Content-Type: text/plain
Date: Fri, 25 May 2007 02:37:10 +0200
Message-Id: <1180053430.16478.41.camel@domain.hid>
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

On Thu, 2007-05-24 at 11:43 +0200, Jan Kiszka wrote:
> > You don't want to run rpi_pop() after the bulk of xnpod_delete_thread()
> 
> Not after, I meant before. But then...
> 
> > has run for the same thread, and you don't want a preemption to occur
> > anytime between the thread deletion and the update of the RPI state that
> > still refers to it. You might try moving the call to rpi_pop() to the
> > prologue of both routines instead of waiting for the deletion hook to do
> > it, but this would introduce a priority issue in the do_taskexit_event
> > callout, since we might have lowered the root priority in rpi_pop() and
> > be switched out in the middle of the deletion process. Unless we hold
> > the nklock all time long, that is. Back to square #1, I'm afraid.
> 
> ...there might be other issues, OK.
> 
> So we might need some reference counter for the xnthread object so that
> the last user actually frees it and some flags to check what jobs remain
> to be done for cleanup.
> 
> >>>>> latency hit is certainly not seen there; the real issues are left in the
> >>>>> native and POSIX skin thread deletion routines (heap management and
> >>>>> other housekeeping calls under nklock and so on).
> >>>> That's surely true. Besides RPI manipulation, there is really no
> >>>> problematic code left here latency-wise. Other hooks are trickier. But
> >>>> my point is that we first need some infrastructure to provide an
> >>>> alternative cleanup context before we can start moving things. My patch
> >>>> today is a hack...err...workaround from this perspective.
> >>>>
> >>> I don't see it this way. This code is very specific, in the sense it
> >>> lays on the inter-domain boundary between Linux and Xenomai's primary
> >>> mode for a critical operation like thread deletion, this is what make
> >>> things a bit confusing. What's below and above this layer has to be as
> >>> seamless as possible, this code in particular can't.
> >> Well, we could move the memory release of the shadow thread in Linux
> >> context e.g. (release on idle, a bit like RCU - uuuh).
> > 
> > This is basically what Gilles did in a recent patch to fix some treading
> > on freed memory, by releasing the shadow TCB through
> > xnheap_schedule_free(). I think we should have a look at the removal
> > from registry operations now.
> 
> Look, we now have xnheap_schedule_free,

Actually, we had this for the last two years now, it just happened to be
underused.

>  next we a need kind of
> xnregistery_schedule_free
>  - that's my point, provide a generic platform
> for all these things. More may follow (for new kind of skins eg.).
> 

Yes, what we need is a common policy for object creation and deletion,
that properly uses the APC mechanism. The logic behind this being that
any object creation which involves secondary domain work to set them up
- such as threads, heaps, queues, pipes - will invariably require the
deletion process to follow the converse path, i.e. rely on Linux kernel
services.

So far, this has been achieved by setting the lostage bit in the syscall
exec mode, but this has two drawbacks: 1) kernel-based threads take no
advantage of this since they don't go through the syscall mechanism, 2)
when such routine wants to switch to primary mode in order to finish the
housekeeping work, it has to perform this transition "manually", by a
call to the hardening service, which is opening Pandora's box if badly
used. From the interface design POV, I'd really prefer that
xnshadow_relax/harden remain internal calls only used by the nucleus. I
guess we both agree on that. But, to sum up, let's drop the
micro-optimization approach to solve this issue, this just would not
scale.

PS: The registry is special, it has to defer some work to Linux by
design, so basically all registrable objects are concerned here.

> Jan
> 
-- 
Philippe.




Subject: Re: [Xenomai-core] Timer optimisations, continued
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C6626A.6000304@domain.hid>
References: <448E98A3.6080707@domain.hid>	<448E9E8B.70809@domain.hid>
	<448EA7F7.5000802@domain.hid>	<448EB038.8070802@domain.hid>
	<448EE593.7010809@domain.hid>	<448EF022.1040901@domain.hid>
	<17550.61982.685449.470866@domain.hid>
	<44C6626A.6000304@domain.hid>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 10:53:48 +0200
Message-Id: <1153990428.5251.46.camel@domain.hid>
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

On Tue, 2006-07-25 at 20:26 +0200, Jan Kiszka wrote:

<massive snippage>

> 
> To summarise these lengthy results:
> 
>  o ns-based xntimers are nice on first sight, but not on second. Most
>    use-cases (except 5) require less conversions when we keep the
>    abstraction as it is.
> 

The current approach was a deliberate choice to favour accuracy of
timers, at the - reasonably small - expense of not optimizing the
"timeout" use case. The net result is that the core timing code is
TSC-based, so that no time unit conversion occurs after a timer has been
started, except in the case where the hw timer has a different time unit
than the TSC used (this said, this last conversion before programmin
gthe hw timer would be needed regardless of the time unit maintained by
the timing core).

>  o Performance should be improvable by combining fast_tsc_to_ns for full
>    64-bit conversions with nodiv_imuldiv for short relative ns-to-tsc.
>    It should be ok to loose some accuracy wrt to long periods given that
>    TSC are AFAIK not very accurate themselves. Nevertheless, to keep
>    precision on 64-bit ns-to-tsc reverse conversions, those should
>    remain implemented as they are:
>    "if (ns <= ULONG_MAX) nodiv_imuldiv else xnarch_ns_to_tsc"
> 

I basically agree with that, including the 64/32 optimization on delay
ranges. IOW, we could optimize time conversions in the timing core
_locally_ (i.e. nucleus/timer.c exclusively) even at the expense of a
small loss of accuracy in the dedicated converters. In any case, we are
implicitely talking of the oneshot mode here, and as such, it would be
acceptable to trigger an early shot once in a while - i.e. due to the
loss of accuracy - that would cause the existing code to restart the
timer until it eventually elapses past the expected time, given that
this would only occur with large delays. But: we must leave the existing
converters as they are in the xnarch layer, keeping the most accurate
operations provided there, since a lot of code depends on their
accuracy.

>  o A further improvement should be achievable for scenarios 4 and 5 by
>    introducing absolute xntimers (more precisely: a flag to
>    differentiate between the mode on xntimer_start). I have an outdated
>    patch for this in my repos, needs re-basing.
> 

Grmblm... Well, I would have preferred that we don't add that kind of
complexity to the nucleus interface, but I must admit that some
important use cases are definitely better served by absolute timespecs,
so I would surrender to this requirement, provided the implementation is
confined to xnpod_suspend_thread() + xntimer_start().

> To verify that we actually improve something with each of the changes
> above, some kind of fine-grained test suite will be required. The
> timerbench could be extended to support all 5 scenarios. But does
> someone have any quick idea how to evaluate the overall performances
> best? The new per-task statistics code is not accurate enough as it
> accounts IRQs mostly to the preempted task, not the preempting one. Mm,
> execution time of some long-running number-crunching Linux task in the
> background?

Better use a kernel-based low priority RT task running in the
background, limiting the sampling period to a duration that Linux could
bear with (maybe running multiple subsequent periods with warmup phases,
just to let the penguin breath). The effect of TLB misses would be much
lower, and no need to block the Linux IRQs using Xenomai's I-shield.

> Looking forward to feedback!
> 
> Jan
> 
> 
> PS: Finally, after stabilising the xntimers again, we will see a nice
> rtdm_timer API as well. But those patches need even more re-basing then...
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.




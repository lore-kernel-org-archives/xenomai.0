From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467E2E9C.90905@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
	<467E2E9C.90905@domain.hid>
Content-Type: text/plain
Date: Sun, 24 Jun 2007 20:15:19 +0200
Message-Id: <1182708919.7044.201.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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

On Sun, 2007-06-24 at 10:43 +0200, Jan Kiszka wrote: 
> Philippe Gerum wrote:
> > On Sat, 2007-06-23 at 13:39 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Sat, 2007-06-23 at 10:08 +0200, Jan Kiszka wrote:
> >>>> Hi,
> >>>>
> >>>> [just to save this early-Saturday-morning insight]
> >>>>
> >>>> I think the xntimer interface is not yet ready to represent all required
> >>>> scenarios. What kind of timers are there? Let's start with POSIX:
> >>>>
> >>>> 1. Realtime timers	- use realtime clock as base, re-tune
> >>>> 			  absolute(!) expiry dates if the realtime clock
> >>>> 			  changes
> >>>> 2. Monotonic timers	- use monotonic clock as base, don't re-adjust
> >>>> 			  during runtime
> >>>>
> >>>> Now what we have in current trunk:
> >>>>
> >>>> 3a. Realtime xntimers	- use wallclock_offset to calculate absolute
> >>>> 			  expiry dates, don't re-adjust during runtime
> >>>> 4a. Monotonic xntimers	- use raw jiffies/TSC as base, don't re-adjust
> >>>> 			  during runtime
> >>>>
> >>>> And this is what we planed to introduce soon:
> >>>>
> >>>> 3b. Realtime xntimers	- use wallclock offset to calculate absolute
> >>>> 			  expiry dates, re-adjust if the offset changes
> >>>> 			  during runtime
> >>> I merged this patch already, so this issue becomes top-ranked on the fix
> >>> list.
> >> Nope, you didn't. We only discussed 3b on Thursday, we still have 3a in
> >> place (i.e. no running timer is re-adjusted on xntbase_adjust_time). But
> >> we will need this for POSIX compliance.
> >>
> > 
> > Sorry, my mistake. I was thinking about "timebase readjustment", which
> > patch I did merge, while you were talking about "timer readjustement",
> > which code is not there yet anyway.
> > 
> >>>> 4b. Monotonic xntimers	- same as 4a
> >>>>
> >>>> 3b and 4b almost perfectly match POSIX, one only has to pass relative
> >>>> realtime timers as monotonic ones (Linux does so too). But there are a
> >>>> lot of skins that potentially rely on 3a!
> >>> They do, but not only on the timer issue, but this also has an impact on
> >>> the time unit used to return the current time. I must admit that this is
> >>> becoming a mess.
> >> Leaving Native apart for a while (though this doesn't mean we should
> >> break its API):
> > 
> > No doubt about this. But the native skin is particular in the sense that
> > it does not provide any service to change its own epoch, so one may
> > assume that it directly depends on the global epoch defined by the
> > nucleus, and as such, may be subject to immediate timer expiry in case
> > the wallclock offset is globally updated. AFAICS, "only"
> > rt_task_sleep_until() and rt_task_set_periodic() would be impacted.
> 
> Yes, looks like. So you think we could migrate Native over the POSIX
> scheme just by clarifying the docs? Hmm, could work.

I would not hesitate a second to change this API if it ought to work
differently, but fact is that POSIX behaviour in case the epoch changes
is logically speaking the only one that fits. If we only have to make
the doc explicit about that, fine, but that's not the main issue.

> 
> > 
> >>  Are there also legacy RTOS skins around that rely on a
> >> timer property "set timeout according to current wallclock, but don't
> >> touch it anymore once it was started"?
> >>
> > 
> > There are legacy RTOS which have both the notions of absolute timeouts
> > and also define a mechanism to setup their own epoch: those would be
> > impacted by the pending changes on the nucleus timer management. In that
> > case, the virtual RTOS machine should be isolated from propagation of
> > wallclock offset changes from other parts of the Xenomai system.
> > 
> > E.g. VRTX's sc_adelay service which is currently emulated using a
> > relative delay, but should in fact be using an absolute timeout since
> > there is a service to change the epoch in this interface (sc_sclock).
> > Actually, it looks like each and every skin should be inspected for
> > conformance again wrt time management once the dust has settled on the
> > timebase and timer related changes (pSOS would be next).
> > 
> >> Actually, this wouldn't be a mess then, it would just derive from
> >> Xenomai aiming at emulating all the available timer variants on the
> >> market. And this may come at the price of slightly increase complexity
> >> (but not necessarily worse than the current code, ie. acceptable IMO).
> >>
> > 
> > As illustrated by the VRTX code, what makes the situation messy in my
> > eyes is that some skins used to work around the nucleus limitations in
> > terms of time management (lack of built-in absolute timing support, no
> > timebases, no strictly monotonic absolute timing), but those hacks tend
> > to bite us now that we do have / are in the process of having proper
> > support at nucleus level.
> > 
> > The other issue regarding legacy RTOS emulation, is that they should not
> > be impacted by the wallclock offset at all, when they deal with jiffies.
> > E.g. in the VRTX case, we should always have something behaving like
> > this:
> > 
> > sc_stime(8129)
> > ...
> > ...(work for 11 VRTX ticks)
> > ...
> > ticks = sc_gtime(); /* ticks == 8140 */
> > 
> > If sc_stime() is not called to set the epoch for the VRTX timebase, then
> > 0 would be assumed for the epoch, and 11 returned by the sc_gtime()
> > call.
> > In any case, starting the timebase, or having another skin propagate a
> > wallclock offset change in parallel should never impact the VRTX machine
> > time. The reason is that some application code might do some weird
> > arithmetics on tick deltas, but also on the raw VRTX clock value for
> > internal purpose, and touching the epoch under its feet would break such
> > code.
> 
> This is a question how you define the other real-time applications. You
> consider them unrelated and ideally isolated just because they use a
> different skin. I wouldn't do so.
> 
> For me, it is rather the question what would be the expected behaviour
> if those other applications were written for VRTX as well here? What is
> the expect impact in some VRTX application if a second one changes the
> epoch? _That_ is the effect that matters IMO.
> 

That's _not_ the typical use case. The reality is stubborn: in the
legacy RTOS world, you have a single application (in the logical sense)
controlling the entire target, not many unrelated programs. This is not
the UNIX world, where a slew of unrelated program are sharing the O/S
services, in the legacy embedded world,  programs - when there are many
(which is seldom) - will all serve different aspects of a single
purpose. You can bet that all these different pieces are written in a
way that they do not interfere but rather cooperate. E.g. in the VRTX
case, you would not have each and every program calling sc_stime() or
sc_sclock() randomly.

> OK, there might be vary rare scenarios where you put applications of
> different skins together on the same box, but don't want them
> cooperate
> in any way. In that case, and only then, it would be a valid
> requirement
> to isolate the time bases.
> 
Ok, so let's illustrate your point here: you would consider that some
built-in support should be provided by Xenomai, in order to run formerly
distributed applications, that used to run over multiple boards
controlled by different RTOSes, or a single embedded RTOS running
several unrelated programs that may fiddle with the epoch. E.g. one
VRTX-based, another pSOS-based and finally a ChorusMC-based board would
have run a complex distributed application exchanging timestamps for
say, data fusion, and we would like to port it to Linux over a single or
multiple Xenomai boxes. 

Actually, your reasoning is biased by the way you would like RTDM to be
usable in a transverse manner, as a gateway infrastructure between
different skins sharing a common I/O space. Fair enough, but that
remains very marginal wrt how people would use legacy RTOS skins, albeit
it makes a lot of sense when writing new POSIX/native-based applications
over Xenomai. 

> > 
> >>>>  At least the whole native
> >>>> skin, I would say. So we may actually need two knobs when starting an
> >>>> xntimer:
> >>>>
> >>>>  A) Take wallclock offset into account when calculating internal expiry
> >>>>     date?
> >>>>  B) Re-tune the expiry date during runtime if the offset changes?
> >>>>
> >>>> Reasonable combinations are none of both ("POSIX monotonic"), A
> >>>> ("Xenomai realtime"), and A+B ("POSIX realtime"). Am I right? Please
> >>>> comment.
> >>> Sorry, -ENOPARSE. Which is the alternative here?
> >> Forgetting about variant "A only", ie. potentially breaking existing
> >> stuff for the sake of POSIX and only POSIX. But I don't think this is
> >> acceptable, we need xntimer to support all three as soon as some skin
> >> cries for variant "A only".
> > 
> > Ok, let me rephrase the options, so that I'm sure we are talking about
> > the same issues. We obviously need:
> > 
> > * real-time: absolute trigger dates based on a variable epoch depending
> > on the global timeline (the Linux one actually), check for elapsed
> > timers upon epoch changes, no resync of still outstanding ones. IOW, A
> > +B, aka POSIX real-time.
> 
> (In fact, technically, Xenomai will have to resync because all timers
> are internally based on the monotonic, non-adjustable TSC clock.)
> 
> > * monotonic, absolute trigger dates based on a fixed epoch depending on
> > a strictly monotonic timeline, neither immediate expiry check nor resync
> > needed since the epoch cannot be changed (we are using some read-only
> > free running CPU counter to get timestamps here). IOW, neither A nor B,
> > aka POSIX monotonic.
> > * relative, which is a simple variant of monotonic, in the sense that
> > trigger dates are expressed as delays instead of absolute dates on the
> > monotonic timeline.
> > 
> > The A-only option would accept absolute timeouts based on the timebase's
> > epoch, but would not do anything upon epoch change? This is where I fail
> > to find any useful application for this option: since this is an
> > absolute timeout, we may not resync the expiry value anyway  - not
> > because POSIX does it this way, but first and foremost because it's just
> > logically correct -, but for the same reason, we ought to fire all
> > timers of this kind which would have "suddently" elapsed due to the
> > epoch change.
> 
> Again my questions: Are there RTOS APIs defining that some of their own
> absolute timers/timeouts will _not_ be impacted by a change of their
> _own_ epoch? Or do all RTOSes we want to emulate behave like POSIX here?
> 

All RTOS emulations that exhibit absolute timers would have to behave
like POSIX does. This is something you can sanely enforce even if the
original RTOS implementation does not, because any other behaviour would
be plain wrong application-wise.

The fact that some RTOS would not care about outstanding absolute timers
when changing the epoch, would not be a feature per se, but an accepted
_limitation_ of the real-time executive for the sake of simplifying
their implementation. Those RTOS assume that common practice involves
setting the epoch only once at startup, so there should be no need for
expiry check. If the application wants to change the epoch, then it is
bluntly assumed that it would have to take care of any potential
side-effects by its own means, period.

Here is another illustration of such logic which applies to pSOS, this
is an excerpt from the "pSOSSystem system concept" guide: "No elapsed
tick counter is included, because this can be easily maintained by your
own code". Here they assume that an application developer always control
the timer ISR, which is true on legacy embedded systems, but not anymore
with Xenomai. So the point here is that we are not going to emulate
limitations of the original RTOS unless one could actually have built
valid code over them. In the case we are talking about, you just cannot
make any code running reliably from not checking for absolute timer
expiries when changing the epoch, so we are not going to emulate this
limitation.

For the record, the same pSOS documentation states that "absolute timing
is affected by any tm_set calls that change the calendar date and time,
whereas relative timings are not affected.", and impacted syscalls are
documented in a way that confirms the POSIX behaviour. OTOH, the VRTXsa
documentation says nil about that issue, but its support for absolute
timing is very limited (it was a late VRTXsa addon IIRC). But, to
connect to the other issue, VRTX clearly states that the tick counter is
reset to zero before the RTOS starts, so the global wallclock offset
would kill us here.

> > 
> > Now, instead of the A-only option, I would rather seek a way to isolate
> > a given timebase from the propagation of wallclock offset changes, so
> > that its epoch remains stable from its POV. We could then have legacy
> > RTOS start absolute timers within their own "time space", while being
> > able to apply the rules about absolute timing management common sense
> > dictates.
> 
> Isolation is a valid feature, but it is the last resort for me, because
> it really means isolation, ie. no more convenient interaction with other
> skins.
> 

Here is a simple illustration of how your patch currently bites legacy
apps until we allow to decouple timebases when needed: apps running over
legacy RTOSes which do neither define timeout sequences a la RTDM nor
absolute timeouts in general, would have a serious problem with
propagation of wallclock offset changes (due to the action of other
skins) to their timebase. I.e. would they want to emulate timeout
sequences by reading their tick-based clock when the timed call returns,
and they would end up miscomputing the remaining timeout value.

> > 
> > But then, the initial issue arises again: in which specific cases, do we
> > need to keep the timebase tied by a common epoch through the wallclock
> > offset, so that we could keep this option open for those skins, if need
> > be, too?
> 
> Two applications or an application and a driver exchange data that is
> tagged with time stamps, e.g. in order to synchronise their operations
> on common trigger dates or to perform data fusion. If their time bases
> are decoupled like before my patch, they would have to implement their
> own clock offset estimation mechanism with all the potential errors
> (because user code is interruptible e.g.).
> 

Ok, let's take the example of two legacy RTOS applications fusioning data they
timestamped on their respective side using their own time retrieval service,
one using VRTX and the other one VxWorks. For the timestamping to be interpretable,
you would need to know the tick granularity on each side, and apply a conversion
to timestamps, in order to compare them appropriately. Additionally, the
accuracy of timestamping would be limited to the said granularity (1ms, 10ms?).
Maybe, if you limit the case to a common tick frequency on both sides, fast enough to get
reasonably accurate timestamps, this would work, but still, you would prefer
having both RTOS keep their 0-based epoch untouched, so that timestamps have a comparable
origin.
What is the advantage of this approach, compared to using a specialized service, for
such a specialized use, which would be based on the master timebase, since what
you deeply want is a common timeline to timestamp the data your applications exchange?
I must surely be utterly blind, but I see no point in making the situation harder, just
for the sake of forcing the legacy RTOS interface to fit new usages.

Let me state my thoughts clearly again: I'm convinced that your point is definitely valid
for any new application one would build using the POSIX/native+RTDM combo. But, use cases
involved in porting apps over legacy RTOS emulators are not comparable. Therefore, if we
can find a simple way to make both requirements co-exist (consistent timestamping _and_
sandboxing), I'm all for it and I would merge it (almost) blindly. But if we can't, proper
sandboxing has priority over anything else because it's the way it's going to be used most
often.

> 
> 
> I'm convinced that if you stick multiple apps of different skins
> together on the same silicon, you are rather seeking for cooperation
> than isolation.

Not in the "skin as a virtual machine" case, which is typically the POV somebody
porting an application from a legacy RTOS to Linux using Xenomai would have.

> 
>  And in this case, having a common time base would simply
> move the routine job of time synchronisation from the application into
> the core -- where is belongs.

Nobody disputes this point, but rather the fact that having a common epoch might
be a desirable feature when you just want to sandbox a standalone RTOS+application
combo within a Xenomai system. That is not desirable at all in such a case.

> 
> 
> > 
> >>>> Moreover, it looks to me like the monotonic API I introduced is not very
> >>>> handy (fortunately, there is no in-tree user yet). It has a sticky
> >>>> property, i.e. you set a persistent flag in the xntimer object if it
> >>>> ought to be monotonic. As xntimer structures are typically also
> >>>> persistent, you easily end up saving the current mode, setting your own,
> >>>> and restoring the old one once the timer fired -- to keep other users of
> >>>> the timer happy. E.g., think of RTDM doing some monotonic timing with a
> >>>> task while the owning skin may prefer realtime mode. I'm almost
> >>>> convinced now that passing a non-sticky mode on each xntimer_start
> >>>> (along with XN_ABSOLUTE/RELATIVE in the same parameter) will be more useful.
> >>>>
> >>> This issue seems orthogonal to the more fundamental one: in which case
> >>> does RTDM need to recycle and _change_ the behaviour of timers owned by
> >>> other layers? A simple (code) illustration would help understanding the
> >>> issue, which is likely RTDM-specific, due to the transverse aspect of
> >>> this interface.
> >> I can't tell for sure yet if there are _real_ scenarios where RTDM may
> >> want to switch the xnthread rtimer to monotonic while it is in some
> >> realtime mode, I still need to meditate on this. It's just the strong
> >> _feeling_ that it is cleaner to define the behaviour on start and not on
> >> timer init or via a sticky flag.
> >>
> > 
> > Actually, my own strong feeling would say that fiddling with other
> > layers timers would be definitely wrong. The point looks pretty simple
> > here: whether you defined the xntimer object and you may do whatever
> > change you want on it, or you did not, and only the API exported by the
> > owning layer should give you this opportunity, albeit indirectly.
> > 
> > So this confirms your point that, would such change be needed, we would
> > need to make the monotonic flag a dynamic property of the start call. 
> > 
> >> Same goes for POSIX I think. You may call clock_nanosleep e.g. with
> >> different clock IDs for the same thread. Currently, all timeouts are
> >> converted before the timer is started. But if we put reasonable logic
> >> into the generic code, those special treatment may be obsolete. Maybe
> >> Gilles has some ideas on how the timer interface (which influences also
> >> xnpod_suspend_thread etc.) might optimally look like for this.
> >>
> > 
> > An orthogonal option would be to make the timer object to be used a
> > parameter of the few timed nucleus calls.
> 
> That would open the option to move the thread's rtimer on the stack of
> the waiter (like the kernel does). Someone (some skin) who wants to
> suspend the current thread would create an xntimer of the desired
> properties and pass it down to xnpod_suspend_thread (or callers of the
> latter).
> 
> Practically, that would mean turning a single functions call as there is
> now into two of them.

You tend to generalize the use of stack-based timers, which I don't. We could
still keep the resource and periodic timer objects available from the base TCB,
and move additional timers to the skin-defined TCBs if need be, which would not
impede us from using stack-based timers in some cases. The path length to suspension
would be strictly equivalent, by making the absolute/relative flag a static property of
timers. From a strictly logical POV, a timer should be by essence either absolute
or relative, and not mutable on such a fundamental property (e.g. just try reading a
code which happily changes the behaviour of a given timer between absolute and
relative management mode dynamically, depending on contextual information: this is
just asking for troubles).

> One may need to code a simple prototype, but my
> feeling is that this extends the code path length before suspension. The
> question would be what we gain with this pattern. I think it really
> takes some prototypes...
> 
> Jan
> 
-- 
Philippe.




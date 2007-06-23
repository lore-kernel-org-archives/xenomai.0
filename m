From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467D0684.7030604@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid>
Content-Type: text/plain
Date: Sat, 23 Jun 2007 20:37:38 +0200
Message-Id: <1182623858.6000.139.camel@domain.hid>
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

On Sat, 2007-06-23 at 13:39 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Sat, 2007-06-23 at 10:08 +0200, Jan Kiszka wrote:
> >> Hi,
> >>
> >> [just to save this early-Saturday-morning insight]
> >>
> >> I think the xntimer interface is not yet ready to represent all required
> >> scenarios. What kind of timers are there? Let's start with POSIX:
> >>
> >> 1. Realtime timers	- use realtime clock as base, re-tune
> >> 			  absolute(!) expiry dates if the realtime clock
> >> 			  changes
> >> 2. Monotonic timers	- use monotonic clock as base, don't re-adjust
> >> 			  during runtime
> >>
> >> Now what we have in current trunk:
> >>
> >> 3a. Realtime xntimers	- use wallclock_offset to calculate absolute
> >> 			  expiry dates, don't re-adjust during runtime
> >> 4a. Monotonic xntimers	- use raw jiffies/TSC as base, don't re-adjust
> >> 			  during runtime
> >>
> >> And this is what we planed to introduce soon:
> >>
> >> 3b. Realtime xntimers	- use wallclock offset to calculate absolute
> >> 			  expiry dates, re-adjust if the offset changes
> >> 			  during runtime
> > 
> > I merged this patch already, so this issue becomes top-ranked on the fix
> > list.
> 
> Nope, you didn't. We only discussed 3b on Thursday, we still have 3a in
> place (i.e. no running timer is re-adjusted on xntbase_adjust_time). But
> we will need this for POSIX compliance.
> 

Sorry, my mistake. I was thinking about "timebase readjustment", which
patch I did merge, while you were talking about "timer readjustement",
which code is not there yet anyway.

> > 
> >> 4b. Monotonic xntimers	- same as 4a
> >>
> >> 3b and 4b almost perfectly match POSIX, one only has to pass relative
> >> realtime timers as monotonic ones (Linux does so too). But there are a
> >> lot of skins that potentially rely on 3a!
> > 
> > They do, but not only on the timer issue, but this also has an impact on
> > the time unit used to return the current time. I must admit that this is
> > becoming a mess.
> 
> Leaving Native apart for a while (though this doesn't mean we should
> break its API):

No doubt about this. But the native skin is particular in the sense that
it does not provide any service to change its own epoch, so one may
assume that it directly depends on the global epoch defined by the
nucleus, and as such, may be subject to immediate timer expiry in case
the wallclock offset is globally updated. AFAICS, "only"
rt_task_sleep_until() and rt_task_set_periodic() would be impacted.

>  Are there also legacy RTOS skins around that rely on a
> timer property "set timeout according to current wallclock, but don't
> touch it anymore once it was started"?
> 

There are legacy RTOS which have both the notions of absolute timeouts
and also define a mechanism to setup their own epoch: those would be
impacted by the pending changes on the nucleus timer management. In that
case, the virtual RTOS machine should be isolated from propagation of
wallclock offset changes from other parts of the Xenomai system.

E.g. VRTX's sc_adelay service which is currently emulated using a
relative delay, but should in fact be using an absolute timeout since
there is a service to change the epoch in this interface (sc_sclock).
Actually, it looks like each and every skin should be inspected for
conformance again wrt time management once the dust has settled on the
timebase and timer related changes (pSOS would be next).

> Actually, this wouldn't be a mess then, it would just derive from
> Xenomai aiming at emulating all the available timer variants on the
> market. And this may come at the price of slightly increase complexity
> (but not necessarily worse than the current code, ie. acceptable IMO).
> 

As illustrated by the VRTX code, what makes the situation messy in my
eyes is that some skins used to work around the nucleus limitations in
terms of time management (lack of built-in absolute timing support, no
timebases, no strictly monotonic absolute timing), but those hacks tend
to bite us now that we do have / are in the process of having proper
support at nucleus level.

The other issue regarding legacy RTOS emulation, is that they should not
be impacted by the wallclock offset at all, when they deal with jiffies.
E.g. in the VRTX case, we should always have something behaving like
this:

sc_stime(8129)
...
...(work for 11 VRTX ticks)
...
ticks = sc_gtime(); /* ticks == 8140 */

If sc_stime() is not called to set the epoch for the VRTX timebase, then
0 would be assumed for the epoch, and 11 returned by the sc_gtime()
call.
In any case, starting the timebase, or having another skin propagate a
wallclock offset change in parallel should never impact the VRTX machine
time. The reason is that some application code might do some weird
arithmetics on tick deltas, but also on the raw VRTX clock value for
internal purpose, and touching the epoch under its feet would break such
code.

> > 
> >>  At least the whole native
> >> skin, I would say. So we may actually need two knobs when starting an
> >> xntimer:
> >>
> >>  A) Take wallclock offset into account when calculating internal expiry
> >>     date?
> >>  B) Re-tune the expiry date during runtime if the offset changes?
> >>
> >> Reasonable combinations are none of both ("POSIX monotonic"), A
> >> ("Xenomai realtime"), and A+B ("POSIX realtime"). Am I right? Please
> >> comment.
> > 
> > Sorry, -ENOPARSE. Which is the alternative here?
> 
> Forgetting about variant "A only", ie. potentially breaking existing
> stuff for the sake of POSIX and only POSIX. But I don't think this is
> acceptable, we need xntimer to support all three as soon as some skin
> cries for variant "A only".

Ok, let me rephrase the options, so that I'm sure we are talking about
the same issues. We obviously need:

* real-time: absolute trigger dates based on a variable epoch depending
on the global timeline (the Linux one actually), check for elapsed
timers upon epoch changes, no resync of still outstanding ones. IOW, A
+B, aka POSIX real-time.
* monotonic, absolute trigger dates based on a fixed epoch depending on
a strictly monotonic timeline, neither immediate expiry check nor resync
needed since the epoch cannot be changed (we are using some read-only
free running CPU counter to get timestamps here). IOW, neither A nor B,
aka POSIX monotonic.
* relative, which is a simple variant of monotonic, in the sense that
trigger dates are expressed as delays instead of absolute dates on the
monotonic timeline.

The A-only option would accept absolute timeouts based on the timebase's
epoch, but would not do anything upon epoch change? This is where I fail
to find any useful application for this option: since this is an
absolute timeout, we may not resync the expiry value anyway  - not
because POSIX does it this way, but first and foremost because it's just
logically correct -, but for the same reason, we ought to fire all
timers of this kind which would have "suddently" elapsed due to the
epoch change.

Now, instead of the A-only option, I would rather seek a way to isolate
a given timebase from the propagation of wallclock offset changes, so
that its epoch remains stable from its POV. We could then have legacy
RTOS start absolute timers within their own "time space", while being
able to apply the rules about absolute timing management common sense
dictates.

But then, the initial issue arises again: in which specific cases, do we
need to keep the timebase tied by a common epoch through the wallclock
offset, so that we could keep this option open for those skins, if need
be, too?

> 
> > 
> >> Moreover, it looks to me like the monotonic API I introduced is not very
> >> handy (fortunately, there is no in-tree user yet). It has a sticky
> >> property, i.e. you set a persistent flag in the xntimer object if it
> >> ought to be monotonic. As xntimer structures are typically also
> >> persistent, you easily end up saving the current mode, setting your own,
> >> and restoring the old one once the timer fired -- to keep other users of
> >> the timer happy. E.g., think of RTDM doing some monotonic timing with a
> >> task while the owning skin may prefer realtime mode. I'm almost
> >> convinced now that passing a non-sticky mode on each xntimer_start
> >> (along with XN_ABSOLUTE/RELATIVE in the same parameter) will be more useful.
> >>
> > 
> > This issue seems orthogonal to the more fundamental one: in which case
> > does RTDM need to recycle and _change_ the behaviour of timers owned by
> > other layers? A simple (code) illustration would help understanding the
> > issue, which is likely RTDM-specific, due to the transverse aspect of
> > this interface.
> 
> I can't tell for sure yet if there are _real_ scenarios where RTDM may
> want to switch the xnthread rtimer to monotonic while it is in some
> realtime mode, I still need to meditate on this. It's just the strong
> _feeling_ that it is cleaner to define the behaviour on start and not on
> timer init or via a sticky flag.
> 

Actually, my own strong feeling would say that fiddling with other
layers timers would be definitely wrong. The point looks pretty simple
here: whether you defined the xntimer object and you may do whatever
change you want on it, or you did not, and only the API exported by the
owning layer should give you this opportunity, albeit indirectly.

So this confirms your point that, would such change be needed, we would
need to make the monotonic flag a dynamic property of the start call. 

> Same goes for POSIX I think. You may call clock_nanosleep e.g. with
> different clock IDs for the same thread. Currently, all timeouts are
> converted before the timer is started. But if we put reasonable logic
> into the generic code, those special treatment may be obsolete. Maybe
> Gilles has some ideas on how the timer interface (which influences also
> xnpod_suspend_thread etc.) might optimally look like for this.
> 

An orthogonal option would be to make the timer object to be used a
parameter of the few timed nucleus calls.

> Jan
> 
-- 
Philippe.




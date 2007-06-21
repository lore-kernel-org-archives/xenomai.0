From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467A2FB2.6050006@domain.hid>
References: <467639BE.30504@domain.hid>  <467641F3.3010308@domain.hid>
	<1182357772.6137.39.camel@domain.hid>  <46795F21.8040007@domain.hid>
	<1182378551.6079.45.camel@domain.hid>  <467A2FB2.6050006@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 11:06:49 +0200
Message-Id: <1182416810.9709.38.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
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

On Thu, 2007-06-21 at 09:58 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2007-06-20 at 19:08 +0200, Jan Kiszka wrote: 
> >> Philippe Gerum wrote:
> >>> On Mon, 2007-06-18 at 10:27 +0200, Jan Kiszka wrote: 
> >>>> Jan Kiszka wrote:
> >>>>> ...
> >>>>> The answer I found is to synchronise all time bases as good as possible.
> >>>>> That means if one base changes its wall clock offset, all others need to
> >>>>> be adjusted as well. At this chance, we would also implement
> >>>>> synchronisation of the time bases on the system clock when they get
> >>>>> started. Because skins may work with different type width to represent
> >>>>> time, relative changes have to be applied, i.e. the core API changes
> >>>>> from xntbase_set_time(new_time) to xntbase_adjust_time(relative_change).
> >>>>> The patch (global-wallclock.patch) finally touches more parts than I was
> >>>>> first hoping. Here is the full list:
> >>>>>
> >>>>>  - synchronise slave time bases on the master on xntbase_start
> >>>>>  - xntbase_set_time -> xntbase_adjust_time, fixing all time bases
> >>>>>    currently registered
> >>>>>  - make xnarch_start_timer return the nanos since the last host tick
> >>>>>    (only ia64 affected, all others return 0 anyway, causing one tick
> >>>>>    off when synchronising on system time -- but this fiddling becomes
> >>>>>    pointless on the long term due to better clocksourses on all archs)
> >>> Support for 2.4 kernels will be still around for the Xenomai 2.x series
> >>> though, and those will likely never support clocksources. Support for
> >>> Linux 2.4 will be discontinued starting from x3.
> >> Again: As the code looks right now, only ia64 made use of this feature.
> >> We have i386 and PPC for 2.4, and both did not bother to synchronise
> >> that precisely so far (here, this interface is pointless).
> >>
> >> And on x86 with recent 2.6 kernels, simply returning 0 on success of the
> >> timer setup made the master clock deviate from the real timeofday by one
> >> tick.
> >>
> > 
> > My remark was actually a general one: what happens within Linux 2.6
> > right now cannot be used to generalize anything for Xenomai 2, so we
> 
> It can, as long as this doesn't cause regressions for 2.4 as it is the
> case here.
> 

As any general remark, it has a general scope, which is not necessarily
adapted to each and every isolated issue. This remark was triggered by
your repeated references to improved timesources expected with next
releases of Linux 2.6. So, to conclude: we agree that support for 2.4
kernels still has to be taken into account for a few Xenomai releases
(even if this tends to become a pain, due to wrappers proliferation),
but in the xnarch_start_timer() case, the point is moot (basically
because I've been lazy in the first place, and never implemented initial
tick compensation for most archs, despite I said the interface should
support it).

> > cannot use anything related as an argument for what should happen in
> > this series. For the same reason, we do need wrappers for 2.4, even when
> > the latest incarnations might backport some 2.6 features, because the
> > whole point for people about remaining with some oldish Linux 2.4
> > release is precisely that most of them will _never_ want to upgrade
> > their current setup, 2.4.25 to 2.4.34, 2.4.x to 2.6, whatever, just
> > because it works as it is, and they don't want to take the upgrade hit
> > once again for their product in the field.
> 
> No one doubts this.
> 
> > 
> >>>>>  - adapt vrtx, vxworks, and psos+ skin to new scheme, fixing sc_sclock
> >>>>>    at this chance
> >>>>>  - make xnarch_get_sys_time internal, no skin should (need to) touch
> >>>>>    this anymore
> >>> This interface has not been meant to be part of the skin building
> >>> interface, but for internal support code that needs to get the host
> >>> time. For instance, one may want this information for obscure data
> >>> logging from within a module, independently of any wallclock offset
> >>> fiddling Xenomai may do on its timebases (so nktbase is not an option
> >>> here if timebases start being tighly coupled). And this should work in
> >>> real execution mode, or in virtual simulation mode. IOW,
> >>> xnarch_get_sys_time() has to remain part of the exported internal
> >>> interface (even if as some inline routine, that's not the main issue
> >>> here).
> >> As I still haven't been able to see real code using it like this, I
> >> can't comment on it.
> >>
> > 
> > It's pretty simple to sketch some of it: you want to add some debugging
> > facility that needs timestamps, but you don't want to depend on any
> > timebase, because the timebase is part of what is being observed. What
> > you want is raw, silly, purely host-based timestamping. A bunch of
> > software models attached to Xenomai systems used for real-time
> > simulation I've seen do rely on that kind of facility.
> 
> Unless you hack Linux, host-bases timestamping only works reliably over
> Linux context. Exporting this service now with Xenomai 2.4 beyond its
> current private scope exposes a fragile service (/wrt Xenomai) to users
> who may not be aware of that fact -- therefore my strong concerns about
> this change.
> 

"users" is too vague a term. If we are talking about application
developers, they should feel deep in their guts that using something
within the xnarch layer is terminally wrong, so the point is moot
anyway.

Who I'm talking about are Xenomai sub-system developers - you, me,
whoever goes deep into the plumbing for whatever good reason. In that
case, we do want to have a mean to retrieve the host's idea of time,
regardless of whether it's reliable in distributed situations or not,
one has to decide whether it fits or not, and in most cases, it does.
Sub-systems may have access to the xnarch sub-system legitimately, and
if we want to hide the underlying environment we are compiling for
(whether the real hw or the event-driven engine), we need to export a
common interface with different implementations.

> > 
> >>>> Forgot to mention two further aspects:
> >>>>
> >>>>  - The semantic of XNTBSET was kept time base-local. But I wonder if
> >>>>    this flag is still required. Unless it was introduced to emulated
> >>>>    some special RTOS behaviour, we now have the time bases automatically
> >>>>    set on startup. Comments welcome.
> >>>>
> >>> That might be a problem wrt pSOS for instance. In theory, tm_set() has
> >>> to be issued to set the initial time, so there is indeed the notion of
> >>> unset/invalid state for the pSOS wallclock time when the system starts.
> >>> This said, in the real world, such initialization better belongs to the
> >>> BSP rather than to the application itself, and in our case, the BSP is
> >>> Linux/Xenomai's business, so this would still make sense to assume that
> >>> a timebase has no unset state from the application POV, and XNTBSET
> >>> could therefore go away.
> >> That was my first impression as well, but I cannot asses the impact as I
> >> don't know real pSOS porting scenarios.
> >>
> > 
> > The impact is basically that you won't be able to emulate some error
> > condition, because the error situation would have vanished in the first
> > place. As I said, it's not a big issue actually.
> > 
> >>> The main concern I have right now regarding this patch is that it
> >>> changes a key aspect of Xenomai's current time management scheme:
> >>> timebases would be tighly coupled, whilst they aren't right now. For
> >> Which already caused troubles when dealing with RTDM, you remember?
> >>
> > 
> > No, I've decided to stop remembering about troubles of any kind. It's called
> > selective memory, and makes life a lot easier. But yeah, the RTDM issue did
> > actually escaped my filter...
> > 
> >>> instance, two timebases could have a very different idea of the Epoch in
> >>> the current implementation, and this patch is precisely made to kill
> >>> that aspect. This is a key issue if one considers how Xenomai should
> >>> deal with concurrent skins: either 1) as isolated virtual RTOS machines
> >>> with only a few bridges allowing very simple interfaces, or 2) as
> >>> possibly cooperating interfaces. It's all a matter of design; actually,
> >>> user/customer experience I know of clearly proves that #2 makes a lot of
> >>> sense, but still, this point needs to be discussed if needed.
> >>>
> >>> So, two questions arise:
> >>>
> >>> - what's the short term impact on the common - or not that common - use
> >>> case involving multiple concurrent skins? I tend to think that not that
> >>> many people are actually leveraging the current decoupling between
> >>> timebases. But, would some do, well, then they should definitely speak
> >>> up NOW.
> >>>
> >>> - regarding the initial RTDM-related motivation now, why requiring all
> >>> timebases to be in sync Epoch-wise, instead of asking the software
> >>> wanting to exchange timestamps to always use the master timebase for
> >>> that purpose? By definition, nktbase is the most accurate, always valid
> >>> and running, and passing the timebase id along with the jiffy value when
> >>> exchanging timestamps would be no more needed.
> >> No existing API (native, posix, driver profiles, not to speak of legacy
> >> RTOSes) is prepare for this. Basically, this is the same reason why we
> >> cannot simply declare we would be able to deal with unsynchronised TSC
> >> time sources on SMP/multicore boxes. See my consideration in "Getting
> >> the clock model right".
> >>
> > 
> > This does not answer my question: why, in the RTDM case, would you
> > require the interfaces to be part of the solution, instead of leaving
> > the issue to the peers exchanging data, using the common master
> > timebase, leaving aside the unsync TSC issue which is platform-specific,
> > and will maybe require to abstract a meta-timebase on top of some
> > per-cpu master anyway.
> 
> True, the situation would not be as dramatic as with unsync'ed TSC, but
> it would still require introducing a new service, outside any existing
> API, to convert between time bases. And that service would also have to
> be _used_ by application developers. I'm already seeing the confused bug
> reports...
> 

Ok, I must agree that time issues always lead to a phenomenal degree of
confusion unless the support is straight, and orthogonal in all aspects.

> > 
> > The reason I think your patch should be merged is because we will need
> > the adequate tools for building skins which are semantically distributed
> > beasts, and for that, we do absolutly need another level of abstraction
> > to represent a consistent binding between timesources. But, merging it
> > has some impact, and I want to be as sure as possible that this won't
> > bite us later down the road.
> > 
> >> Well, what I can imaging as a compromise is to offer the user the option
> >> to explicitly decouple some skin from the system time. "Do this if you
> >> like to, but don't interact with others then!" This warning should be
> >> included in that case. But before I suggested this, I first wanted to
> >> wait for someone seriously screaming "I need this!"
> >>
> >>
> > 
> > If you think of it, decoupling only requires to keep a constant epoch
> > (at least one the nucleus does not update) somewhere within the timebase struct,
> > the user code could wire to some value when it sees fit (e.g. pSOSish tm_set(),
> 
> I know. It should be simple.
> 
> > or VRTX's sc_stime() and so on). Obtaining a so-called constant-based time would have
> > then to be available through an additional method, returning constant_epoch + delta,
> > whatever delta means wrt aperiodic/periodic behaviour. The point here is that we
> > would just shift the constant epoch - decorrelated from system time - from default
> > xntbase_get_time() behaviour to something which should be explicitly requested
> > through a new specialized timebase method if needed.
> 
> Well, that's precisely the set of new conversion functions I'm a bit
> afraid of. But as it now comes with the "special case", not the default
> one, I would be fine with it.
> 

Indeed, it's really about shifting the default behaviour to synchronized
timebases. There is not much harm to expect from using specialized
services to get a constant-based timebase anyway, since only skin
developers would need that, and those people ought to know what they are
doing.

> > 
> > IOW, introducing synchronized timebases is not the issue, making timebase
> > synchronization the default behaviour is what has some importance here.
> 
> I predict it will save all of us from headache, at least from more
> headache than with the other way around. :)
> 

Ok, let's go for it, the changes are easily identifiable. I guess that
is something we could not postpone to 2.5 anyway. I want to merge this
asap now, because I don't want to delay -rc1 anymore, and the merge
window is almost closed.

Actual uses of this feature - e.g. POSIX resync - should go into -rc2,
unless they are (almost) ready for merge right now.

> Jan
> 
-- 
Philippe.




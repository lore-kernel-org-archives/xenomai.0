MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18041.27025.80273.654686@domain.hid>
Date: Wed, 20 Jun 2007 19:53:21 +0200
In-Reply-To: <1182357772.6137.39.camel@domain.hid>
References: <467639BE.30504@domain.hid> <467641F3.3010308@domain.hid>
	<1182357772.6137.39.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > On Mon, 2007-06-18 at 10:27 +0200, Jan Kiszka wrote: 
 > > Jan Kiszka wrote:
 > > > ...
 > > > The answer I found is to synchronise all time bases as good as possible.
 > > > That means if one base changes its wall clock offset, all others need to
 > > > be adjusted as well. At this chance, we would also implement
 > > > synchronisation of the time bases on the system clock when they get
 > > > started. Because skins may work with different type width to represent
 > > > time, relative changes have to be applied, i.e. the core API changes
 > > > from xntbase_set_time(new_time) to xntbase_adjust_time(relative_change).
 > > > The patch (global-wallclock.patch) finally touches more parts than I was
 > > > first hoping. Here is the full list:
 > > > 
 > > >  - synchronise slave time bases on the master on xntbase_start
 > > >  - xntbase_set_time -> xntbase_adjust_time, fixing all time bases
 > > >    currently registered
 > > >  - make xnarch_start_timer return the nanos since the last host tick
 > > >    (only ia64 affected, all others return 0 anyway, causing one tick
 > > >    off when synchronising on system time -- but this fiddling becomes
 > > >    pointless on the long term due to better clocksourses on all archs)
 > 
 > Support for 2.4 kernels will be still around for the Xenomai 2.x series
 > though, and those will likely never support clocksources. Support for
 > Linux 2.4 will be discontinued starting from x3.
 > 
 > > >  - adapt vrtx, vxworks, and psos+ skin to new scheme, fixing sc_sclock
 > > >    at this chance
 > > >  - make xnarch_get_sys_time internal, no skin should (need to) touch
 > > >    this anymore
 > > 
 > 
 > This interface has not been meant to be part of the skin building
 > interface, but for internal support code that needs to get the host
 > time. For instance, one may want this information for obscure data
 > logging from within a module, independently of any wallclock offset
 > fiddling Xenomai may do on its timebases (so nktbase is not an option
 > here if timebases start being tighly coupled). And this should work in
 > real execution mode, or in virtual simulation mode. IOW,
 > xnarch_get_sys_time() has to remain part of the exported internal
 > interface (even if as some inline routine, that's not the main issue
 > here).
 > 
 > > Forgot to mention two further aspects:
 > > 
 > >  - The semantic of XNTBSET was kept time base-local. But I wonder if
 > >    this flag is still required. Unless it was introduced to emulated
 > >    some special RTOS behaviour, we now have the time bases automatically
 > >    set on startup. Comments welcome.
 > > 
 > 
 > That might be a problem wrt pSOS for instance. In theory, tm_set() has
 > to be issued to set the initial time, so there is indeed the notion of
 > unset/invalid state for the pSOS wallclock time when the system starts.
 > This said, in the real world, such initialization better belongs to the
 > BSP rather than to the application itself, and in our case, the BSP is
 > Linux/Xenomai's business, so this would still make sense to assume that
 > a timebase has no unset state from the application POV, and XNTBSET
 > could therefore go away.
 > 
 > The main concern I have right now regarding this patch is that it
 > changes a key aspect of Xenomai's current time management scheme:
 > timebases would be tighly coupled, whilst they aren't right now. For
 > instance, two timebases could have a very different idea of the Epoch in
 > the current implementation, and this patch is precisely made to kill
 > that aspect. This is a key issue if one considers how Xenomai should
 > deal with concurrent skins: either 1) as isolated virtual RTOS machines
 > with only a few bridges allowing very simple interfaces, or 2) as
 > possibly cooperating interfaces. It's all a matter of design; actually,
 > user/customer experience I know of clearly proves that #2 makes a lot of
 > sense, but still, this point needs to be discussed if needed.
 > 
 > So, two questions arise:
 > 
 > - what's the short term impact on the common - or not that common - use
 > case involving multiple concurrent skins? I tend to think that not that
 > many people are actually leveraging the current decoupling between
 > timebases. But, would some do, well, then they should definitely speak
 > up NOW.

There is a special concern with the POSIX spec: it states that when the
time is set, absolute timers should keep their absolute tick date (so,
when the time is set to a later date, absolute timers that should have
elapsed in the interval should elapse asap), and relative timers should
be changed to elapse at the correct date (new_elapse_date = new_date +
previous_elapse_date - old_date). The fact that the nucleus did
not implement relative and absolute timers (now it does) and that
xnpod_settime does not do what the posix spec wants is the reason why
clock_settime is still not implemented. Now, if another skin is allowed
to change the nucleus time, I guess it should trigger the posix
behaviour as well.

So, IMHO, if we take Jan's patch (which I am in favor of) we should
implement xnpod_settime the way posix wants it, after all, posix spec is
just common sense (with regard to this specific problem, I
mean). CLOCK_MONOTONIC timeouts would be implemented as relative
timeouts so that they would not be affected by CLOCK_REALTIME changes.


-- 


					    Gilles Chanteperdrix.


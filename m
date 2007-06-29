From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4683EAAB.6080401@domain.hid>
References: <4683EAAB.6080401@domain.hid>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 23:17:24 +0200
Message-Id: <1183151844.6574.157.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH-STACK] more timer rework,
	group-based	access control
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

On Thu, 2007-06-28 at 19:06 +0200, Jan Kiszka wrote:
> Hi,
> 
> here is an overview of my latest patch stack at
> 
> http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/
> 
> 
> fix-timer-wrap-arounds-v2.patch
> -------------------------------
> 
> More or less academic fixes (hopefully without regressions)

When applied to switching to signed arithmetics in a world of
unsignedness, this sounds like the famous last words: "Hey! life is
short, let's play Russian roulette!". Still, you are right, so let's
have fun: will merge.

> around the
> scenario when the underlying raw timer wraps around. However, I don't
> think we should leave this unfixed, risking an "Ariane-bug".

> run-aclocal-first.patch,

Indeed, call order was wrong. Will merge (+backport).

> link-check-sched_setaffinity.patch,

uClibc is just evil. Will merge (+backport).

> fix-patch-election.patch,

Another proof of my laziness. Will merge (+backport).

> run-default-preparation.patch,

Seems you want to be able to be lazy too. Ok, will merge (+backport).

> rt-caps-group.patch

Good idea, but totally untested on my side (did I already mention my
laziness?). Will merge and backport to 2.3.x, XENO_OPT_SECURITY_ACCESS
was too cheap to be good anyway.

> -----------------------------------
> 
> See dedicated posts earlier on this list.
> 
> 
> refactor-timer-modes.patch
> --------------------------
> 
> xntimers are now of three kinds: XNTM_MONOREL, XNTM_MONOABS, or
> XNTM_REALABS. This mode is passed on xntimer_start or on invocation of
> higher services (xnpod_suspend_thread e.g.). Users were widely
> automatically converted and may lack optimisation for the new scheme.
> Please review carefully for regressions!
> 

The only reason for me to whine about this one so far concerns naming
issues. Why do things need to be that picky?

I mean, we have only three modes, relative, absolute monotonic and
absolute realtime and we discussed in great length why we won't have
more than those. Given that "relative non-monotonic" would make no sense
here, and that "realtime" carries a strong notion of absoluteness in
relation to the wallclock, let's keep "relative", "absolute" and
"realtime". In any case, "mono" is not widespread enough for people to
immediately catch "monotonic" anyway, so in case of doubt: I'd say
_RTFM_.

Additionally, having XN_INFINITE and XNTM_RELATIVE/ABSOLUTE/REALTIME is
a clear sign of discrepancy. Please, keep my laziness intact, and let's
keep XN_ for general macros. I know that this is somehow in
contradiction with the current practice for the native skin, but I'm
full of contradictions anyway, so...

As already discussed, we do need this for -rc1 though.

> 
> isol-timebase.patch
> -------------------
> 
> Isolates time bases from the master base if XNTBISO is set on
> xntbase_alloc. This becomes default for all skins except POSIX, native,
> and RTDM. The other skins can join the system clock group by passing a
> non-zero "sync_time" module parameter on startup. The patch also
> enhances the output of /proc/xenomai/timebases. To-do: document the API
> changes...
> 

Will merge.

> 
> re-adjust-timers.patch
> ----------------------
> 
> Yet an empty placeholder. It shall contain the changes to make real-time
> timers follow wallclock adjustments.
> 

As mentioned recently, will be postponed to -rc2/3.

> 
> rtdm-timer-v2.patch
> -------------------
> 
> Revised and documented version of RTDM timers, now based on the latest
> xntimer version. The timer mode is passed on start, just like it's done
> in the xntimer API. Moreover, rtdm_task_sleep_abs is introduced as a
> replacement for the deprecated rtdm_task_sleep_until. The new service
> works both with monotonic and real-time dates, the old service will
> eventually by removed.
> 

Will merge, I guess we need refactor-timer-modes.patch to be fixed
first.

> 
> The rest is unchanged or was just refreshed.
> 

Will merge rtutils - or whatever name we'll pick - before -rc1 is out.

Ok, the merge window for new features in -rc1 is officially CLOSED.

Thanks for your work.

-- 
Philippe.




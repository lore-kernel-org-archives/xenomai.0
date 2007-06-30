From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4685F079.7090202@domain.hid>
References: <4683EAAB.6080401@domain.hid> <1183151844.6574.157.camel@domain.hid>
	<4685F079.7090202@domain.hid>
Content-Type: text/plain
Date: Sat, 30 Jun 2007 16:13:08 +0200
Message-Id: <1183212788.14520.54.camel@domain.hid>
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

On Sat, 2007-06-30 at 07:56 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> >> rt-caps-group.patch
> > 
> > Good idea, but totally untested on my side (did I already mention my
> > laziness?). Will merge and backport to 2.3.x, XENO_OPT_SECURITY_ACCESS
> > was too cheap to be good anyway.
> 
> What about moving that scheduling parameter settings into the
> trampoline? Some legacy RTOS libs would still have to be adapted.
> 

We could do that since the caller is always synchronized with the new
thread and blocks on the completion flag until xnshadow_map() has run,
so this would solve potential priority issues. This would also keep the
existing work around for a silly bug from some Linuxthreads
implementations which just did not consider the scheduling policy
setting passed to pthread_create(), and would leave the spawned thread
in SCHED_NORMAL mode in any case. However, this would still not work
with pthread libs overeagerly checking for root permissions.

> > 
> >> -----------------------------------
> >>
> >> See dedicated posts earlier on this list.
> >>
> >>
> >> refactor-timer-modes.patch
> >> --------------------------
> >>
> >> xntimers are now of three kinds: XNTM_MONOREL, XNTM_MONOABS, or
> >> XNTM_REALABS. This mode is passed on xntimer_start or on invocation of
> >> higher services (xnpod_suspend_thread e.g.). Users were widely
> >> automatically converted and may lack optimisation for the new scheme.
> >> Please review carefully for regressions!
> >>
> > 
> > The only reason for me to whine about this one so far concerns naming
> > issues. Why do things need to be that picky?
> > 
> > I mean, we have only three modes, relative, absolute monotonic and
> > absolute realtime and we discussed in great length why we won't have
> > more than those. Given that "relative non-monotonic" would make no sense
> > here, and that "realtime" carries a strong notion of absoluteness in
> > relation to the wallclock, let's keep "relative", "absolute" and
> > "realtime". In any case, "mono" is not widespread enough for people to
> > immediately catch "monotonic" anyway, so in case of doubt: I'd say
> > _RTFM_.
> > 
> > Additionally, having XN_INFINITE and XNTM_RELATIVE/ABSOLUTE/REALTIME is
> > a clear sign of discrepancy. Please, keep my laziness intact, and let's
> > keep XN_ for general macros. I know that this is somehow in
> > contradiction with the current practice for the native skin, but I'm
> > full of contradictions anyway, so...
> 
> Hmm, everything has it's pros and cons, but mostly you are right. Here
> is a new proposal, please tell me if it's acceptable so that I can
> rebase the rest:
> 
> --- xenomai.orig/include/nucleus/types.h
> +++ xenomai/include/nucleus/types.h
> @@ -62,8 +62,13 @@ typedef int (*xniack_t)(unsigned irq);
> 
>  #define XN_INFINITE   (0)
>  #define XN_NONBLOCK   ((xnticks_t)-1)
> -#define XN_RELATIVE   0
> -#define XN_ABSOLUTE   1
> +
> +/* Timer modes */
> +typedef enum xntmode {
> +       XN_RELATIVE,
> +       XN_ABSOLUTE,
> +       XN_REALTIME
> +} xntmode_t;
> 
>  #define XN_APERIODIC_TICK  0
>  #define XN_NO_TICK         ((xnticks_t)-1)
> 

Looks ok, provided we can always represent the mode as a set of discrete
values. This said, switching from a enum to a plain integer would be a
no-brainer if needed.

> 
> Last issue pending is the xintr locking thing. Will try to have a closer
> look again and kick Dmitry for some more explanations of his patch.
> 
> Jan
> 
-- 
Philippe.




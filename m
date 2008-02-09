Message-ID: <47ADC480.7010204@domain.hid>
Date: Sat, 09 Feb 2008 16:19:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47ACD0FF.8000601@domain.hid>
In-Reply-To: <47ACD0FF.8000601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Optional timer freeze during ptracing
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Freezing all Xenomai timers while just a single RT application is under
> ptrace control can be helpful in certain debugging scenarios, but it can
> as well be harmful when other parts of the systems have to continue to work.
> 
> I brought this concern up back in 2006, and I originally thought we may
> address this by freezing per process. But this is far too complex for a
> simple problem like this: Just make the whole thing configurable, and
> keep it off by default so that -ideally- only users who are aware of the
> side effects will arm it.
>

No, it's the other way around, you know when you don't want a timer to
be blocked because it serves some purpose that goes beyond the
application duty, like keeping a RTnet connection alive through which
you happen to debug; on the other hand, all other timers relate to the
logic the application implements, so you most often want them to track
the debugging state so that they don't mess up behind you back when the
debugger halts the application. Blocking timers during ptracing should
be on by default, no need to break a known behaviour Xenomai had for
ages for rare cases when some of them are also used to maintain some
external activity alive. This is the exception, and as such, those
timers should be marked as non-blockable in the code that defines them;
a global knob may then switch them to blockable if needed.

An intermediate approach would be to force the threads ptimer and rtimer
as blockable ones, and use a global flag to switch the rest as
non-blockable, albeit this may cause non-related watchdogs to keep
triggering, which most of the time could be a real pain in the neck when
debugging.

> Gilles, you recently stumbled over such a side effect and introduced
> XNTIMER_NOBLCK (for customized timer instrumentations as far as I
> understood this). Do you think we still need that knob when we have
> CONFIG_XENO_OPT_PTRACE_TIMER_FREEZE?
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.


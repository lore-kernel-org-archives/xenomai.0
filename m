Message-ID: <47ADD5E9.7070605@domain.hid>
Date: Sat, 09 Feb 2008 17:33:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47ACD0FF.8000601@domain.hid> <47ADC480.7010204@domain.hid>
	<47ADCF7E.8050505@domain.hid>
In-Reply-To: <47ADCF7E.8050505@domain.hid>
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
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Freezing all Xenomai timers while just a single RT application is under
>>> ptrace control can be helpful in certain debugging scenarios, but it can
>>> as well be harmful when other parts of the systems have to continue to work.
>>>
>>> I brought this concern up back in 2006, and I originally thought we may
>>> address this by freezing per process. But this is far too complex for a
>>> simple problem like this: Just make the whole thing configurable, and
>>> keep it off by default so that -ideally- only users who are aware of the
>>> side effects will arm it.
>>>
>> No, it's the other way around, you know when you don't want a timer to
>> be blocked because it serves some purpose that goes beyond the
>> application duty, like keeping a RTnet connection alive through which
>> you happen to debug; on the other hand, all other timers relate to the
>> logic the application implements, so you most often want them to track
>> the debugging state so that they don't mess up behind you back when the
>> debugger halts the application. Blocking timers during ptracing should
>> be on by default, no need to break a known behaviour Xenomai had for
>> ages for rare cases when some of them are also used to maintain some
>> external activity alive. This is the exception, and as such, those
>> timers should be marked as non-blockable in the code that defines them;
>> a global knob may then switch them to blockable if needed.
> 
> You focus on single application, or single function per system.
> Moreover, following this logic, you would have to suppress all
> interrupts as well while ptracing some app.
>

I focus on what's most frequent among users: a single self-contained
application with no dependency on any external timing. If global
freezing was such a problem, then we would have had significant feedback
on this issue since years, and as a matter of fact, we did not. I
understand that your kind of application case is more complex than Joe
Average's, with likely distributed topology that justifies your proposal
and makes a lot of sense in such context, but this is not the common
case. Let's keep things simple for the majority, so that people don't
have to fiddle with a configuration knob in the common case.

>> An intermediate approach would be to force the threads ptimer and rtimer
>> as blockable ones, and use a global flag to switch the rest as
>> non-blockable, albeit this may cause non-related watchdogs to keep
>> triggering, which most of the time could be a real pain in the neck when
>> debugging.
> 
> That' sounds better, specifically switching to a XNTIMER_BLCK logic.
> What about freezing the ptimer and rtimers of all xnthreads in ptraced
> processes? That shouldn't require us to track additional information in
> xntimer_t about its owner.
> 

The most effective way is to mark the timebase as enforcing blocked
state for timers, have the timer handler block any timer with a
blockable bit set in its status if that's the case. No need for scanning
any thread list, or even to know whether any given timer is one of
ptimer, rtimer or whatever. Making a timer blockable should be decided
by the code that defines it, because it just knows better if any
side-effect of blocking such timer may bite.

Still, if we go that way, we also need to mark all timers currently
created by skins as blockable (e.g. VxWorks/pSOS watchdogs and friends),
so that people get the same behaviour they are used to right now.

> Jan
> 


-- 
Philippe.


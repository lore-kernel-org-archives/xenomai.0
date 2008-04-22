Date: Tue, 22 Apr 2008 15:45:47 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
In-Reply-To: <480775C4.2060302@domain.hid>
Message-ID: <Pine.LNX.4.64.0804211731160.26198@domain.hid>
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
	<4800B4FA.1050309@domain.hid>
	<50879.62.235.129.158.1208014366.squirrel@domain.hid>
	<18432.56533.343662.272421@domain.hid>
	<Pine.LNX.4.64.0804171657380.18446@domain.hid>
	<2ff1a98a0804170830v3b2fc392lf320f05a8c7f4e8d@domain.hid>
	<2ff1a98a0804170846p2dddbea5k3b69dbbc57fb6761@domain.hid>
	<480775C4.2060302@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] rt_task_sleep_until question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 17 Apr 2008, Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> On Thu, Apr 17, 2008 at 5:30 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On Thu, Apr 17, 2008 at 5:23 PM, Klaas Gadeyne <klaas.gadeyne@domain.hid> wrote:
>>> >
>>> > On Sat, 12 Apr 2008, Gilles Chanteperdrix wrote:
>>> >
>>> >> klaas.gadeyne@domain.hid wrote:
>>> >>>> Klaas Gadeyne wrote:
>>> >>>>> I've noticed that threads which, in my ignorant opinion, are supposed
>>> >>>>> to be sleeping, get woken up much earlier than I expect them to be.
>>> >>>>>
>>> >>>>> Please find attached a modified version of the trivial-periodic.c
>>> >>>>> application, which creates a RT_TASK that should sleep as long as
>>> >>>>> possible (i.e. until unblocked by a signal handler).  However, the
>>> >>>>> task gets woken up much earlier (and many times) _before_ that time
>>> > it
>>> >>>>> seems.
>>> >>>>>
>>> >>>>>  head /tmp/app.txt
>>> >>>>> current_time = 1207928393295939429
>>> >>>>> sleep until 18446744073709551615
>>> >>>>> [TIMERLOOP] Total errors = 1, return code = -110
>>> >>>>> current_time = 1207928393296000379
>>> >>>>> sleep until 18446744073709551615
>>> >>>>> [TIMERLOOP] Total errors = 2, return code = -110
>>> >>>>> current_time = 1207928393296005409
>>> >>>>> sleep until 18446744073709551615
>>> >>>>> [TIMERLOOP] Total errors = 3, return code = -110
>>> >>>>> current_time = 1207928393296009604
>>> >>>>>
>>> >>>>> What did I overlook here?
>>> >>>>
>>> >>>> Probably an overflow issue: (RTIME)~0 will be converted to TSCs, and
>>> > if
>>> >>>> your box runs at > 1GHZ, the result of this conversion will by
>>> > something
>>> >>>> < (RTIME)~0 due to the overflow. And this can result in an absolute
>>> >>>> timeout date (in TSC units) before the current date -> ETIMEDOUT. Can
>>> >>>> you confirm this?
>>> >>>
>>> >>> I have no linux box at hand, but I noticed that [*]
>>> >>> xntimer_do_start_aperiodic() passes its xnticks_t interval argument
>>> > (which
>>> >>> is an unsigned long long) to xnarch_ns_to_tsc, and that one expects a
>>> >>> (signed) long long.
>>> >>>
>>> >>> If I did not make any calculation errors (a very small chance...) in
>>> > "my"
>>> >>> case "interval" > LLONG_MAX so there's already an overflow there.
>>> >>
>>> >> The problem is that we can not change xnarch_ns_to_tsc to use
>>> >> xnarch_ullimd instead of xnarch_llimd: xnarch_ns_to_tsc may be used to
>>> >> convert negative differences. Anyway, I do not think there is an
>>> >> overflow in llimd, otherwise you would get a processor exception, not a
>>> >> silent truncation (at least on x86). To solve this issue, we should
>>> >> probably switch to saturation arithmetic, but it would probably have a
>>> >> huge impact on performance (and on code also, since we would have to use
>>> >> xnarch_saturated_add(foo, bar) instead of foo + bar).
>>> >>
>>> >
>>> >  I see.
>>> >
>>> >  I noticed that xnpod_suspend_thread offers the possibility to suspend
>>> >  a thread "indefinitely" (until unblocked) via the (in the 2.4.x API,
>>> >  that is)
>>> >
>>> >  xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>> >
>>> >  call.
>>> >  However, since TM_INFINITE (and XN_INFINITE) are both defined as being
>>> >  zero, calls to rt_task_sleep(TM_INFINITE), are intercepted in the
>>> >  implementation of rt_task_sleep [1].  So in the latter case (which I
>>> >  would naively---i.e. without looking at API docs--- read as "sleep for
>>> >  an infinite amount of time), rt_task_sleep() returns *immediately*.
>
> This behaviour is explicitly stated in the doc, though. So people should not be
> surprised.

That why I added the stuff between the long dashes above :-)  However, if
there's even one thing even better than well documented API's, it's
well documented _and_ intuitive APIs.

>>> >  Would it make sense to change the current behaviour of
>>> >  rt_task_sleep(TM_INFINITE) and call
>>> >  xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
>>> >  instead of returning 0?
>>> >
>>> >  One could either do that by
>>> >  - altering rt_task_sleep()'s behaviour (not returning zero if delay is
>>> > zero)
>>> >  - redefining TM_INFINITE
>
> No way. You don't want to change "magic" values that lightly. This is why they
> are magic in the first place.

I know none of them were ideal solutions.  However (AFAIS, that is), 
* from a user point of view, I would find it convenient to be able to
   sleep indefinitely until somebody wakes me up using rt_task_unblock(),
   and this is currently not possible.
* the nucleus _does_ offer this functionality via the
   xnpod_suspend_thread(thread,XNDELAY,XN_INFINITE,XN_RELATIVE,NULL)
   call, but I cannot access that functionality in the native skin.

So I was wondering if nothing (else) could be done to solve that
problem, the concrete use case being a thread which is woken up every
time a job has to be done, but which can safely sleep "forever" (until 
unblocked) if nothing has to be done.

[For those really interested, I ran into this situation debugging a
CanFestival setup on xenomai, see
<http://sourceforge.net/mailarchive/forum.php?thread_name=Pine.LNX.4.64.0804141120410.11027%40ampere.labo01.fmtc.be&forum_name=canfestival-devel> ]

>>> >  Both changes might "break" existing applications however.
>>> >
>>> >  Any thoughts?
>>>
>>>  Well, I do not see how applications could find a useful use of the
>>>  "rt_task_sleep(0) returns 0 immediately" behaviour.
>>
>> Thinking more about it: there is a useful use, if the sleep duration
>> is the result of rt_time_tsc2ns. Sleeping indefinitely would be a bit
>> counter-intuitive.
>>
>
> Aside of this, the API has to be orthogonal, and having rt_task_sleep behave as
> rt_task_suspend is also counter-intuitive. Think about applications doing tick
> arithmetics to determine the remaining sleep time; at some point, they might
> hang unexpectedly with delay == 0 == TM_INFINITE.

Didn't I mention "intuitive" somewhere above yet? ;-)

Thx,

Klaas





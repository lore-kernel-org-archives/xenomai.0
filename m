Message-ID: <4358D8F2.8070606@domain.hid>
Date: Fri, 21 Oct 2005 14:02:58 +0200
From: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid> <4357C9F7.2060808@domain.hid>
	<4357CF67.8080601@domain.hid> <4357DF0F.3060806@domain.hid>
	<435896AA.1060103@domain.hid> <4358C309.5050407@domain.hid>
In-Reply-To: <4358C309.5050407@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org


>>
>>
>> Correct me if I'm wrong, but I suppose implementation should be rather
>> trivial. In fact, it should just mean embedding the code snipped you
>> wrote above (the interrupt-free relative time calculation) into the API.
>> I think that more important than saving the hassle of having the caller
>> to write it, is leaving the HAL locking unlocking up to the nucleus,
>> where it should be.
>>
>
> Indeed, it's clearly not a matter of implementation, but rather a
> question of adding 8-10 more calls bearing absolute timeouts to the
> API, which would be about a 10% increase of the number of calls. Hence
> the question: are absolute timeouts for each and every single blocking
> call a _needed_ flexibility, or is it "solely" based on the idea of
> avoiding any exception case among all timed calls?

Dunno. My vote goes for "needed flexibility", but it is just my vote.

Oh, and that'r regarding the native skin. Regarding the nucleus, I
definitely think that providing absolute timeouts in a *needed*
flexibility, since other wise a skin that provides absolute timeouts
cannot be properly implemented (at least not without disabling
interrupts and such, which seems quite a kludge). In fact, if what you
want in the nucleus is to retain the maximum flexibility with the
minimal possible API, the way to go is provide *only* absolute timeouts.
The skin implementor can then get relative timeouts by a simple
substraction (and in this case, unexpected preemprion is not a problem
as I discuss in the previous message).

Of course, changing the meaning of the timeout from relative to absolute
in the nucleus now, would be a nightmare to debug.

>> That will do. In fact, I'm used to the posix API where the only
>> synchronization call thatis timed is pthread_cond_timedwait, and I tend
>> to use cond vars more than any other primitive.
>>
>> However, as I pointed out above, I think that the implementation should
>> be just as easy with other sync primitives as with the cond var, and
>> would preserve the orthogonality of the API (*all* locking calls on
>> *all* sync primitives would allow both relative and absolute timeouts).
>>
>
> Something I would buy as a very good reason to extend the API this way
> would be the existence of some common design pattern that do need such
> generalized absolute timeouts to operate properly and efficiently. So
> far, I cannot come with any obvious illustration of such need; am I
> missing any of them here?

My experience in RT development is small. The only design pattern I know
of is the one I already discussed.

>> must be handled by the scheduler as *absoulte* time, not relative (how
>> could it otherwise compare and sort out the earliest waking thread to
>> program the timer in oneshot mode?), thus maybe the current
>> implementation of relative timeouts is in fact more complex than an
>> absolute implementation. I may be wrong, of course I haven't dared to
>> delve into the internals of xenomai :-)
>
> By the way, I just realized that in fact, the wakeup time for threads
>
> Actually, the conversion between relative and absolute dates is
> handled by a couple of lines inside the timer manager code, so it's no
> big deal using the relative timeouts

At least in my designgs (again, I'm nowhere near being an RT guru),
whenever I need to execute code along a very well defined timeline (ie
at t, t+1000, t+1200, t+1600 and t+2400), I *need* to use absolute
timeouts. I don't say it's *convenient*, I say I *need* to use absolute
timeouts.

IMHO, the fact that some design pattern cannot be properly implemented
with relative timeouts, no matter how rarely it is used, is reason
enough to at least provide the absolute time capability.

So far, implementing absolute timeouts is both easy and convenient, and
the *only* drawback is that we are adding some API calls (and you'll
agree that it's not the same adding N new functions that are alter egos
of existing functions than adding just N heterogeneous and unrelated new
functions, the level of perceived complexity added is much lower in the
first case).

> The decision to use the relative form as the preferred one has been
> made on my perception that most people express their wait limits in
> terms of count of time units, not that often in absolute dates.

Agree. But I insist that the point is not how rare a design pattern
requiring absolute timeouts is, but that if it is required, it cannot be
properly implemented with the current native API (or even the nucleus
API, which I believe is not intended to be exposed to RT application
developers but to skip developers).

I'm seriously thinking of implementing native API absolute time calls
(and BTW, sayng that after just one hour of examination of the internals
of xenomai, is the best praise I could pay to the quality of the code).
I understand your position and it is OK if you don't implement those
calls. However, in order to keep the modifications to the source
*minimal*, I would need some changes in the xenomai code. I think they
would all be totally transparent and impactless, but let me know what
you think:

I would modify the following functions (not a complete list, just the
ones I came across when tracing the timeout parameter in the
rt_mutex_lock call), such that they take an extra boolean parameter
after the timeout that specifies whether it is realtive or absolute. The
modifications would be MINIMAL, meaning that for all functions but the
last two they will just pass the bool along with the timeout. In the
last two, again the modification is minimal, taking into account the
value of the bool when updating the xntimer_t.date field.

xnsync_sleep_on()
xnpod_suspend_thread()
xntimer_start()
xntimer_do_start_periodic();
xntimer_do_start_aperiodic();


Since otherwise I would be breaking the nucleus API, I would change the
name of the functions to something else, like:

xnsync_sleep_on_absrel()
xnpod_suspend_thread_absrel()
xntimer_start_absrel()
xntimer_do_start_periodic_absrel();
xntimer_do_start_aperiodic_absrel();


(Yeah, horrible naming, but could not think of anything better)


And then add inline functions that would just call the _absrel functions
with the bool parameter set to indicate relative timeout.


What do you think?


Nacho.


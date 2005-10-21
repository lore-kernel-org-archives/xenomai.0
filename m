Message-ID: <4358C309.5050407@domain.hid>
Date: Fri, 21 Oct 2005 12:29:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid> <4357C9F7.2060808@domain.hid>
	<4357CF67.8080601@domain.hid> <4357DF0F.3060806@domain.hid>
	<435896AA.1060103@domain.hid>
In-Reply-To: <435896AA.1060103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Philippe Gerum wrote:
>=20
>=20
>>Ignacio Garc=EDa P=E9rez wrote:
>>
>>
>>>Jan Kiszka wrote:
>>>
>>>
>>>
>>>>Ignacio Garc=EDa P=E9rez wrote:
>>>>
>>>>
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>While porting my application, I noticed that all synchronization
>>>>>primitives locking calls take a relative timeout as a parameter,
>>>>>right?
>>>>>
>>>>>Of course, I can get the current time, calculate the timeout
>>>>>interval by
>>>>>substracting the current time from the desired timeout moment, and
>>>>>call
>>>>>the function. But wouldn't something like this be possible?:
>>>>>
>>>>>Suppose I want to wait on a semaphore until t=3D1000, and now=3D900.
>>>>>
>>>>>1- I get current time (900).
>>>>>2- I calculate the relative timeout as 1000-900 =3D 100
>>>>>3- I call rt_sem_p(&mysem, 100);
>>>>>
>>>>>In the best case, no preemption will occur between steps 1 and 3,
>>>>>but my
>>>>>thread will still be sleeping not until t=3D1000, but until some tim=
e
>>>>>later, t=3D1000+d, where d is the time used by the code in steps 1-3=
 and
>>>>>into the native skin/nucleus.
>>>>>
>>>>>In the worst case, in addition to that, the thread will be preempted
>>>>>between steps 1 and 3. If it is preempted by another higher priority
>>>>>thread for, say, 50 ticks, and the call in step 3 is actually execut=
ed
>>>>>at t=3D950, the thread will be sleeping until t=3D1050+d, which may =
not be
>>>>>acceptable.
>>>>>
>>>>>What do you think?
>>>>>=20
>>>>
>>>>
>>>>That's true, having to convert between absolute and relative time (an=
d
>>>>vice versa) in interruptible contexts can cause problems if the
>>>>application is not prepared for it.
>>>>
>>>>The question is: do you really need that precise timeouts for
>>>>synchronisation primitives?
>>>>
>>>
>>>Yes I do. In my application, there is a free-run periodic execution
>>>thread that gets once in a while synchronized to an external event.
>>>
>>>This thread waits on a semaphore with an absolute timeout of t, does i=
ts
>>>work, calculates t =3D t + period and waits again on the semaphore. If=
 the
>>>external event signals the semaphore, the thread wakes up immediately
>>>and does some slightly different stuff.
>>>
>>>The thing is, I want the free-run thread to execute at 2 KHz, this is,
>>>every 5 ms. If I use a relative time, I face the problem I described.
>>>
>>>I guess I could get it working properly using a periodic thread, but I=
'm
>>>sure it's not as simple (and does not "feel" as natural) as just waiti=
ng
>>>on the synchronization primitive using an absolute timeout.
>>>
>>
>>If the need for abs timeout protection is seldom, you could also make
>>the related portion of code interrupt-free, since this is what's going
>>to happen early on within the syscall anyway. e.g.:
>>
>>rthal_lock_irqsave
>><compute-timeout>
>>sem_wait(&s,timeout)
>>rthal_lock_irqrestore
>=20
>=20
> Mmmm... will sem_wait (=3Drt_sem_p) properly reenable interrupts?
>=20

> I ask, because usually, code that disables interrutps actually do push
> the processor flags and clear the interrupt flag, and code that
> reenables intrrupts just pops the flags, thus allowing nested interrupt
> disabling/enabling. If that's the case, the thread will go to sleep and
> interrupts will remain disabled, locking everything up. Right?
>=20

Actually no. When a switch occurs, the incoming task resets its own inter=
rupt=20
state, so if it has entered the rescheduling procedure interrupts on, it =
will=20
get back to this state appropriately upon wake up.

>=20
>>Ok, I admit that nobody would want to use this on a regular basis, but
>>is this a usual need in the first place?
>=20
>=20
> Not sure. I guess you're right and it's not an usual need. I'm all
> against polluting the API with every single new kludge that comes to
> mind (I praised the xenomai API in another message), but I sincerely
> think that having two versions of each blocking call with absolute and
> relative timeouts would add a great deal of flexibility while keeping
> the API clean and orthogonal.
>=20
>=20
>>>I really really think there should be, for each call that takes a
>>>timeout, two version, one that takes a relative timeout and another th=
at
>>>takes an absolute timeout.
>>>
>>>Any chances of this being implemented in the current native API?
>>>
>>>
>>
>>The issue there is really about deciding if we have a proper
>>usefulness / complexity ratio, i.e. how unique, frequently needed and
>>relevant is the feature wrt the cost to implement it and the impact on
>>the core and the API to export it.
>=20
>=20
> Correct me if I'm wrong, but I suppose implementation should be rather
> trivial. In fact, it should just mean embedding the code snipped you
> wrote above (the interrupt-free relative time calculation) into the API=
.
> I think that more important than saving the hassle of having the caller
> to write it, is leaving the HAL locking unlocking up to the nucleus,
> where it should be.
>=20

Indeed, it's clearly not a matter of implementation, but rather a questio=
n of=20
adding 8-10 more calls bearing absolute timeouts to the API, which would =
be=20
about a 10% increase of the number of calls. Hence the question: are abso=
lute=20
timeouts for each and every single blocking call a _needed_ flexibility, =
or is=20
it "solely" based on the idea of avoiding any exception case among all ti=
med calls?

>=20
>>The scenario you presented with a single synchronization allowing to
>>pend for an event and a precisely timed fallback action is not that
>>uncommon, even if it's not a frequent one either.
>>
>>In a first approach, I would suggest an intermediate solution which
>>would provide support for this kind of synchronization constructs,
>>without requiring the whole timeout API to be extended in a somewhat
>>overkill manner (i.e. as Jan already pointed out, in the general case,
>>a timeout associated to a blocking call is by essence a safety belt in
>>case things go weird, not a precision timer).
>>
>>The proposed solution would be to add a single new call to the condvar
>>interface, namely rt_cond_abswait(). Since one can already build any
>>kind of synchro object over the condvar, this would likely provide an
>>adaptable solution.
>>
>=20
> That will do. In fact, I'm used to the posix API where the only
> synchronization call thatis timed is pthread_cond_timedwait, and I tend
> to use cond vars more than any other primitive.
>=20
> However, as I pointed out above, I think that the implementation should
> be just as easy with other sync primitives as with the cond var, and
> would preserve the orthogonality of the API (*all* locking calls on
> *all* sync primitives would allow both relative and absolute timeouts).
>

Something I would buy as a very good reason to extend the API this way wo=
uld be=20
the existence of some common design pattern that do need such generalized=
=20
absolute timeouts to operate properly and efficiently. So far, I cannot c=
ome=20
with any obvious illustration of such need; am I missing any of them here=
?

> By the way, I just realized that in fact, the wakeup time for threads
> must be handled by the scheduler as *absoulte* time, not relative (how
> could it otherwise compare and sort out the earliest waking thread to
> program the timer in oneshot mode?), thus maybe the current
> implementation of relative timeouts is in fact more complex than an
> absolute implementation. I may be wrong, of course I haven't dared to
> delve into the internals of xenomai :-)

Actually, the conversion between relative and absolute dates is handled b=
y a=20
couple of lines inside the timer manager code, so it's no big deal using =
the=20
relative timeouts. The decision to use the relative form as the preferred=
 one=20
has been made on my perception that most people express their wait limits=
 in=20
terms of count of time units, not that often in absolute dates. When we d=
o need=20
absolute dates, it's much more likely to express explicit wake up times f=
or=20
services that basically do nothing else than putting the caller to sleep.

--=20

Philippe.


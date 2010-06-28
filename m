Message-ID: <4C291931.7010402@domain.hid>
Date: Mon, 28 Jun 2010 23:50:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>	<4C1B7EB1.2040006@domain.hid>	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>	<4C1B8C04.3010900@domain.hid>
	<4C1BCCBF.7010400@domain.hid>	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>	<1277330401.2453.145.camel@domain.hid>	<AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>	<1277478020.14174.96.camel@domain.hid>
	<AANLkTilOt6PsWdCc7faKOBDy1MdCZp8Lgib1d5Dzy3cz@domain.hid>
In-Reply-To: <AANLkTilOt6PsWdCc7faKOBDy1MdCZp8Lgib1d5Dzy3cz@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] co-kernel benchmarking on arm926
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nero Fernandez <grimlynch@domain.hid>
Cc: xenomai@xenomai.org

Nero Fernandez wrote:
> On Fri, Jun 25, 2010 at 8:30 PM, Philippe Gerum <rpm@xenomai.org> wrote=
:
>=20
>> On Thu, 2010-06-24 at 17:05 +0530, Nero Fernandez wrote:
>>> Thanks for your response, Philippe.
>>>
>>> The concerns while the carrying out my experiments were to:
>>>
>>>  - compare xenomai co-kernel overheads (timer and context switch
>>> latencies)
>>>    in xenomai-space vs similar native-linux overheads. These are
>>> presented in
>>>    the first two sheets.
>>>
>>>  - find out, how addition of xenomai, xenomai+adeos effects the nativ=
e
>>> kernel's
>>>    performance. Here, lmbench was used on the native linux side to
>>> estimate
>>>    the changes to standard linux services.
>> How can your reasonably estimate the overhead of co-kernel services
>> without running any co-kernel services? Interrupt pipelining is not a
>> co-kernel service. You do nothing with interrupt pipelining except
>> enabling co-kernel services to be implemented with real-time response
>> guarantee.
>>
>=20
> Repeating myself, sheet 1 and 2 contain the results of running
> co-kernel services(real-time pthread, message-queues, semaphores
> and clock-nansleep) and making measurment regarding scheduling
> and timer-base functionality provided by co-kernel via posix skin.
>=20
> Same code was then built native posix, instead of  xenomai-posix skin
> and similar measurements were taken for linux-scheduler and timerbase.
> This is something that i cant do with xenomai's native test (use it for=

> native linux benchmarking).
> The point here is to demostrate what kind of benefits may be drawn usin=
g
>  xenomai-space without any code change.
>=20
>=20
>=20
>>> Regarding the additions of latency measurements in sys-timer handler,=

>>> i performed
>>> a similar measurement from xnintr_clock_handler(), and the results
>>> were similar
>>> to ones reported from sys-timer handler in xenomai-enabled linux.
>> If your benchmark is about Xenomai, then at least make sure to provide=

>> results for Xenomai services, used in a relevant application and
>> platform context. Pretending that you instrumented
>> xnintr_clock_handler() at some point and got some results, but
>> eventually decided to illustrate your benchmark with other "similar"
>> results obtained from a totally unrelated instrumentation code, does n=
ot
>> help considering the figures as relevant.
>>
>> Btw, hooking xnintr_clock_handler() is not correct. Again, benchmarkin=
g
>> interrupt latency with Xenomai has to measure the entire code path, fr=
om
>> the moment the interrupt is taken by the CPU, until it is delivered to=

>> the Xenomai service user. By instrumenting directly in
>> xnintr_clock_handler(), your test bypasses the Xenomai timer handling
>> code which delivers the timer tick to the user code, and the
>> rescheduling procedure as well, so your figures are optimistically wro=
ng
>> for any normal use case based on real-time tasks.
>>
>=20
> Regarding hooking up a measurement-device in sys-timer itself, it serve=
s
> the benefit of observing the changes that xenomai's aperiodic handling
> of system-timer brings. This measurement does not attempt to measure
> the co-kernel services in any manner.
>=20
>=20
>=20
>>  While trying to
>>> make both these measurements, i tried to take care that delay-value
>>> logging is
>>> done at the end the handler routines,but the __ipipe_mach_tsc value i=
s
>>> recorded
>>> at the beginning of the routine (a patch for this is included in the
>>> worksheet itself)
>> This patch is hopelessly useless and misleading. Unless your intent is=

>> to have your application directly embodied into low-level interrupt
>> handlers, you are not measuring the actual overhead.
>>
>> Latency is not solely a matter of interrupt masking, but also a matter=

>> of I/D cache misses, particularly on ARM - you have to traverse the
>> actual code until delivery to exhibit the latter.
>>
>> This is exactly what the latency tests shipped with Xenomai are for:
>> - /usr/xenomai/bin/latency -t0/1/2
>> - /usr/xenomai/bin/klatency
>> - /usr/xenomai/bin/irqbench
>>
>> If your system involves user-space tasks, then you should benchmark
>> user-space response time using latency [-t0]. If you plan to use
>> kernel-based tasks such as RTDM tasks, then latency -t1 and klatency
>> tests will provide correct results for your benchmark.
>> If you are interested only in interrupt latency, then latency -t2 will=

>> help.
>>
>> If you do think that those tests do not measure what you seem to be
>> interested in, then you may want to explain why on this list, so that =
we
>> eventually understand what you are after.
>>
>>> Regarding the system, changing the kernel version would invalidate my=

>>> results
>>> as the system is a released CE device and has no plans to upgrade the=

>>> kernel.
>> Ok. But that makes your benchmark 100% irrelevant with respect to
>> assessing the real performances of a decent co-kernel on your setup.
>>
>>> AFAIK, enabling FCSE would limit the number of concurrent processes,
>>> hence
>>> becoming inviable in my scenario.
>> Ditto. Besides, FCSE as implemented in recent I-pipe patches has a
>> best-effort mode which lifts those limitations, at the expense of
>> voiding the latency guarantee, but on the average, that would still be=

>> much better than always suffering the VIVT cache insanity without FCSE=

>>
>=20
> Thanks for mentioning this. I will try to enable this option for
> re-measurements.
>=20
>=20
>> Quoting a previous mail of yours, regarding your target:
>>> Processor       : ARM926EJ-S rev 5 (v5l)
>> The latency hit induced by VIVT caching on arm926 is typically in the
>> 180-200 us range under load in user-space, and 100-120 us in kernel
>> space. So, without FCSE, this would bite at each Xenomai __and__ linux=

>> process context switch. Since your application requires that more than=

>> 95 processes be available in the system, you will likely get quite a f=
ew
>> switches in any given period of time, unless most of them always sleep=
,
>> of course.
>>
>> Ok, so let me do some wild guesses here: you told us this is a CE-base=
d
>> application; maybe it exists already? maybe it has to be put on stero=C3=
=AFds
>> for gaining decent real-time guarantees it doesn't have yet? and perha=
ps
>> the design of that application involves many processes undergoing
>> periodic activities, so lots of context switches with address space
>> changes during normal operations?
>>
>> And, you want that to run on arm926, with no FCSE, and likely not a hu=
ge
>> amount of RAM either, with more than 95 different address spaces? Don'=
t
>> you think there might be a problem? If so, don't you think implementin=
g
>> a benchmark based on those assumptions might be irrelevant at some
>> point?
>>
>>> As far as the adeos patch is concerned, i took a recent one (2.6.32)
>> I guess you meant 2.6.33?
>>
>=20
> Correction, 2.6.30.

Ok. If you are interested in the FCSE code, you may want to use FCSE v4.
See the comparison on the hackbench test here:
http://sisyphus.hd.free.fr/~gilles/pub/fcse/hackbench-fcse-v4.png

I did not rebase the I-pipe patch for 2.6.30 on this new fcse, but you
can find it in the patches for 2.6.31 and 2.6.33. Or as standalone trees
in my adeos git tree:
http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dsummary

Also note that since we are in the re-hashing tonight, as Philippe told
you, 95 processes is actually a lot on a low-end ARM platform, so you
would better be sure that you really need more than 95 processes
(beware, we are talking processes here, memory spaces, not threads, a
process may have has many threads as it wants) before deciding not to
use the FCSE guaranteed mode. Thinking that the number of processes is
unlimited on a low-end/embedded ARM system is an error: it is limited by
the available ressources (RAM, CPU) on your system. The lower the
ressources, the lower the practical limit is, and I bet this practical
limit is much lower than you would like.

--=20
					    Gilles.



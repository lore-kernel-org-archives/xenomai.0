From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
	<4C1B7EB1.2040006@domain.hid>
	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
	<4C1B8C04.3010900@domain.hid> <4C1BCCBF.7010400@domain.hid>
	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>
	<1277330401.2453.145.camel@domain.hid>
	<AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Jun 2010 17:00:20 +0200
Message-ID: <1277478020.14174.96.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] co-kernel benchmarking on arm926 (was: Fwd:
 problem in pthread_mutex_lock/unlock)
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

On Thu, 2010-06-24 at 17:05 +0530, Nero Fernandez wrote:
> Thanks for your response, Philippe.
>=20
> The concerns while the carrying out my experiments were to:
>=20
>  - compare xenomai co-kernel overheads (timer and context switch
> latencies)
>    in xenomai-space vs similar native-linux overheads. These are
> presented in=20
>    the first two sheets.
>=20
>  - find out, how addition of xenomai, xenomai+adeos effects the native
> kernel's=20
>    performance. Here, lmbench was used on the native linux side to
> estimate
>    the changes to standard linux services.

How can your reasonably estimate the overhead of co-kernel services
without running any co-kernel services? Interrupt pipelining is not a
co-kernel service. You do nothing with interrupt pipelining except
enabling co-kernel services to be implemented with real-time response
guarantee.

>=20
> Regarding the additions of latency measurements in sys-timer handler,
> i performed=20
> a similar measurement from xnintr_clock_handler(), and the results
> were similar=20
> to ones reported from sys-timer handler in xenomai-enabled linux.

If your benchmark is about Xenomai, then at least make sure to provide
results for Xenomai services, used in a relevant application and
platform context. Pretending that you instrumented
xnintr_clock_handler() at some point and got some results, but
eventually decided to illustrate your benchmark with other "similar"
results obtained from a totally unrelated instrumentation code, does not
help considering the figures as relevant.

Btw, hooking xnintr_clock_handler() is not correct. Again, benchmarking
interrupt latency with Xenomai has to measure the entire code path, from
the moment the interrupt is taken by the CPU, until it is delivered to
the Xenomai service user. By instrumenting directly in
xnintr_clock_handler(), your test bypasses the Xenomai timer handling
code which delivers the timer tick to the user code, and the
rescheduling procedure as well, so your figures are optimistically wrong
for any normal use case based on real-time tasks.

>  While trying to=20
> make both these measurements, i tried to take care that delay-value
> logging is=20
> done at the end the handler routines,but the __ipipe_mach_tsc value is
> recorded=20
> at the beginning of the routine (a patch for this is included in the
> worksheet itself)

This patch is hopelessly useless and misleading. Unless your intent is
to have your application directly embodied into low-level interrupt
handlers, you are not measuring the actual overhead.

Latency is not solely a matter of interrupt masking, but also a matter
of I/D cache misses, particularly on ARM - you have to traverse the
actual code until delivery to exhibit the latter.

This is exactly what the latency tests shipped with Xenomai are for:
- /usr/xenomai/bin/latency -t0/1/2
- /usr/xenomai/bin/klatency
- /usr/xenomai/bin/irqbench

If your system involves user-space tasks, then you should benchmark
user-space response time using latency [-t0]. If you plan to use
kernel-based tasks such as RTDM tasks, then latency -t1 and klatency
tests will provide correct results for your benchmark.
If you are interested only in interrupt latency, then latency -t2 will
help.

If you do think that those tests do not measure what you seem to be
interested in, then you may want to explain why on this list, so that we
eventually understand what you are after.

>=20
> Regarding the system, changing the kernel version would invalidate my
> results
> as the system is a released CE device and has no plans to upgrade the
> kernel.

Ok. But that makes your benchmark 100% irrelevant with respect to
assessing the real performances of a decent co-kernel on your setup.

> AFAIK, enabling FCSE would limit the number of concurrent processes,
> hence
> becoming inviable in my scenario.

Ditto. Besides, FCSE as implemented in recent I-pipe patches has a
best-effort mode which lifts those limitations, at the expense of
voiding the latency guarantee, but on the average, that would still be
much better than always suffering the VIVT cache insanity without FCSE.

Quoting a previous mail of yours, regarding your target:
> Processor       : ARM926EJ-S rev 5 (v5l)

The latency hit induced by VIVT caching on arm926 is typically in the
180-200 us range under load in user-space, and 100-120 us in kernel
space. So, without FCSE, this would bite at each Xenomai __and__ linux
process context switch. Since your application requires that more than
95 processes be available in the system, you will likely get quite a few
switches in any given period of time, unless most of them always sleep,
of course.

Ok, so let me do some wild guesses here: you told us this is a CE-based
application; maybe it exists already? maybe it has to be put on stero=C3=AF=
ds
for gaining decent real-time guarantees it doesn't have yet? and perhaps
the design of that application involves many processes undergoing
periodic activities, so lots of context switches with address space
changes during normal operations?

And, you want that to run on arm926, with no FCSE, and likely not a huge
amount of RAM either, with more than 95 different address spaces? Don't
you think there might be a problem? If so, don't you think implementing
a benchmark based on those assumptions might be irrelevant at some
point?

> As far as the adeos patch is concerned, i took a recent one (2.6.32)

I guess you meant 2.6.33?

>  and back-ported
> it to 2.6.18, so as not to lose out on any new Adeos-only upgrades. i
> carried out the=20
> back-port activity for two platforms,a qemu-based integrator platform
> (for=20
> minimal functional validity) and my proprietary board.
>=20
> However, i am new to this field and would like to correct things if i
> went wrong anywhere.
> Your comments and guidance would be much appreciated.
>=20

Since you told us only very few details, it's quite difficult to help.
AFAICS, the only advice that would make sense here, can be expressed as
a question for you: are you really, 100% sure that your app would fit on
that hardware, even without any real-time requirement?

>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Thu, Jun 24, 2010 at 3:30 AM, Philippe Gerum <rpm@xenomai.org>
> wrote:
>         On Thu, 2010-06-24 at 02:15 +0530, Nero Fernandez wrote:
>         > Thanks for your response, Gilles.
>         >
>         > i modified the code to use semaphore instead of mutex, which
>         worked
>         > fine.
>         > Attached is a compilation of some latency figures and system
>         loading
>         > figures (using lmbench)
>         > that i obtained from my proprietary ARM-9 board, using
>         Xenomai-2.5.2.
>         >
>         > Any comments are welcome. TIY.
>         >
>        =20
>        =20
>         Yikes. Let me sum up what I understood from your intent:
>        =20
>         - you are measuring lmbench test latencies, that is to say,
>         you don't
>         measure the real-time core capabilities at all. Unless you
>         crafted a
>         Xenomai-linked version of lmbench, you are basically testing
>         regular
>         processes.
>        =20
>         - you are benchmarking your own port of the interrupt pipeline
>         over some
>         random, outdated vendor kernel (2.6.18-based Mvista 5.0 dates
>         back to
>         2007, right?), albeit the original ARM port of such code is
>         based on
>         mainline since day #1. Since the latest latency-saving
>         features like
>         FCSE are available with Adeos patches on recent kernels, you
>         are likely
>         looking at ancient light rays from a fossile galaxy (btw, this
>         may
>         explain the incorrect results in the 0k context switch test -
>         you don't
>         have FCSE enabled in your Adeos port, right?).
>        =20
>         - instead of reporting figures from a real-time interrupt
>         handler
>         actually connected to the Xenomai core, you hijacked the
>         system timer
>         core to pile up your instrumentation on top of the original
>         code you
>         were supposed to benchmark. If this helps,
>         run /usr/xenomai/bin/latency
>         -t2 and you will get the real figures.
>        =20
>         Quoting you, from your document:
>         "The intent for running these tests is to gauge the overhead
>         of running
>         interrupt-virtualization and further running a (real-time
>         co-kernel +
>         interrupt virtualization) on an embedded-device."
>        =20
>         I'm unsure that you clearly identified the functional layers.
>         If you
>         don't measure the Xenomai core based on Xenomai activities,
>         then you
>         don't measure the co-kernel overhead. Besides, trying to
>         measure the
>         interrupt pipeline overhead via the lmbench micro-benchmarks
>         makes no
>         sense.
>        =20
>        =20
>         >
>         > On Sat, Jun 19, 2010 at 1:15 AM, Gilles Chanteperdrix
>         > <gilles.chanteperdrix@xenomai.org> wrote:
>         >
>         >         Gilles Chanteperdrix wrote:
>         >         > Nero Fernandez wrote:
>         >         >> On Fri, Jun 18, 2010 at 7:42 PM, Gilles
>         Chanteperdrix
>         >         >> <gilles.chanteperdrix@xenomai.org
>         >         >> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>         >         >>
>         >         >>     Nero Fernandez wrote:
>         >         >>     > Hi,
>         >         >>     >
>         >         >>     > Please find an archive attached,
>         containing :
>         >         >>     >  - a program for testing
>         context-switch-latency using
>         >         posix-APIs
>         >         >>     >    for native linux kernel and
>         xenomai-posix-skin
>         >         (userspace).
>         >         >>     >  - Makefile to build it using xenomai
>         >         >>
>         >         >>     Your program is very long to tell fast. But
>         it seems
>         >         you are using the
>         >         >>     mutex as if they were recursive. Xenomai
>         posix skin
>         >         mutexes used to be
>         >         >>     recursive by default, but no longer are.
>         >         >>
>         >         >>     Also note that your code does not check the
>         return
>         >         value of the posix
>         >         >>     skin services, which is a really bad idea.
>         >         >>
>         >         >>     --
>         >         >>
>          Gilles.
>         >         >>
>         >         >>
>         >         >> Thanks for the prompt response.
>         >         >>
>         >         >> Could you explain  'recursive usage of mutex' a
>         little
>         >         further?
>         >         >> Are the xenomai pthread-mutexes very different in
>         behaviour
>         >         than regular
>         >         >> posix mutexes?
>         >         >
>         >         > The posix specification does not define the
>         default type of
>         >         a mutex. So,
>         >         >  in short, the behaviour of a "regular posix
>         mutex" is
>         >         unspecified.
>         >         > However, following the principle of least
>         surprise, Xenomai
>         >         chose, like
>         >         > Linux, to use the "normal" type by default.
>         >         >
>         >         > What is the type of a posix mutex is explained in
>         many
>         >         places, starting
>         >         > with Xenomai API documentation. So, no, I will not
>         repeat it
>         >         here.
>         >
>         >
>         >         Actually, that is not your problem. However, you do
>         not check
>         >         the return
>         >         value of posix services, which is a bad idea. And
>         indeed, if
>         >         you check
>         >         it you will find your error: a thread which does not
>         own a
>         >         mutex tries
>         >         to unlock it.
>         >
>         >         Sorry, mutex are not semaphore, this is invalid, and
>         Xenomai
>         >         returns an
>         >         error in such a case.
>         >
>         >         --
>         >                                                    Gilles.
>         >
>        =20
>         > _______________________________________________
>         > Xenomai-core mailing list
>         > Xenomai-core@domain.hid
>         > https://mail.gna.org/listinfo/xenomai-core
>        =20
>        =20
>        =20
>         --
>         Philippe.
>        =20
>        =20
>=20


--=20
Philippe.




MIME-Version: 1.0
In-Reply-To: <1277478020.14174.96.camel@domain.hid>
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
	<4C1B7EB1.2040006@domain.hid>
	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
	<4C1B8C04.3010900@domain.hid> <4C1BCCBF.7010400@domain.hid>
	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>
	<1277330401.2453.145.camel@domain.hid>
	<AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
	<1277478020.14174.96.camel@domain.hid>
Date: Mon, 28 Jun 2010 23:20:18 +0530
Message-ID: <AANLkTilOt6PsWdCc7faKOBDy1MdCZp8Lgib1d5Dzy3cz@domain.hid>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64b059e0368e7048a1ac19d
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0016e64b059e0368e7048a1ac19d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 25, 2010 at 8:30 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Thu, 2010-06-24 at 17:05 +0530, Nero Fernandez wrote:
> > Thanks for your response, Philippe.
> >
> > The concerns while the carrying out my experiments were to:
> >
> >  - compare xenomai co-kernel overheads (timer and context switch
> > latencies)
> >    in xenomai-space vs similar native-linux overheads. These are
> > presented in
> >    the first two sheets.
> >
> >  - find out, how addition of xenomai, xenomai+adeos effects the native
> > kernel's
> >    performance. Here, lmbench was used on the native linux side to
> > estimate
> >    the changes to standard linux services.
>
> How can your reasonably estimate the overhead of co-kernel services
> without running any co-kernel services? Interrupt pipelining is not a
> co-kernel service. You do nothing with interrupt pipelining except
> enabling co-kernel services to be implemented with real-time response
> guarantee.
>

Repeating myself, sheet 1 and 2 contain the results of running
co-kernel services(real-time pthread, message-queues, semaphores
and clock-nansleep) and making measurment regarding scheduling
and timer-base functionality provided by co-kernel via posix skin.

Same code was then built native posix, instead of  xenomai-posix skin
and similar measurements were taken for linux-scheduler and timerbase.
This is something that i cant do with xenomai's native test (use it for
native linux benchmarking).
The point here is to demostrate what kind of benefits may be drawn using
 xenomai-space without any code change.



>
> > Regarding the additions of latency measurements in sys-timer handler,
> > i performed
> > a similar measurement from xnintr_clock_handler(), and the results
> > were similar
> > to ones reported from sys-timer handler in xenomai-enabled linux.
>
> If your benchmark is about Xenomai, then at least make sure to provide
> results for Xenomai services, used in a relevant application and
> platform context. Pretending that you instrumented
> xnintr_clock_handler() at some point and got some results, but
> eventually decided to illustrate your benchmark with other "similar"
> results obtained from a totally unrelated instrumentation code, does not
> help considering the figures as relevant.
>
> Btw, hooking xnintr_clock_handler() is not correct. Again, benchmarking
> interrupt latency with Xenomai has to measure the entire code path, from
> the moment the interrupt is taken by the CPU, until it is delivered to
> the Xenomai service user. By instrumenting directly in
> xnintr_clock_handler(), your test bypasses the Xenomai timer handling
> code which delivers the timer tick to the user code, and the
> rescheduling procedure as well, so your figures are optimistically wrong
> for any normal use case based on real-time tasks.
>

Regarding hooking up a measurement-device in sys-timer itself, it serves
the benefit of observing the changes that xenomai's aperiodic handling
of system-timer brings. This measurement does not attempt to measure
the co-kernel services in any manner.


>

>  While trying to
> > make both these measurements, i tried to take care that delay-value
> > logging is
> > done at the end the handler routines,but the __ipipe_mach_tsc value is
> > recorded
> > at the beginning of the routine (a patch for this is included in the
> > worksheet itself)
>
> This patch is hopelessly useless and misleading. Unless your intent is
> to have your application directly embodied into low-level interrupt
> handlers, you are not measuring the actual overhead.
>
> Latency is not solely a matter of interrupt masking, but also a matter
> of I/D cache misses, particularly on ARM - you have to traverse the
> actual code until delivery to exhibit the latter.
>
> This is exactly what the latency tests shipped with Xenomai are for:
> - /usr/xenomai/bin/latency -t0/1/2
> - /usr/xenomai/bin/klatency
> - /usr/xenomai/bin/irqbench
>
> If your system involves user-space tasks, then you should benchmark
> user-space response time using latency [-t0]. If you plan to use
> kernel-based tasks such as RTDM tasks, then latency -t1 and klatency
> tests will provide correct results for your benchmark.
> If you are interested only in interrupt latency, then latency -t2 will
> help.
>
> If you do think that those tests do not measure what you seem to be
> interested in, then you may want to explain why on this list, so that we
> eventually understand what you are after.
>
> >
> > Regarding the system, changing the kernel version would invalidate my
> > results
> > as the system is a released CE device and has no plans to upgrade the
> > kernel.
>
> Ok. But that makes your benchmark 100% irrelevant with respect to
> assessing the real performances of a decent co-kernel on your setup.
>
> > AFAIK, enabling FCSE would limit the number of concurrent processes,
> > hence
> > becoming inviable in my scenario.
>
> Ditto. Besides, FCSE as implemented in recent I-pipe patches has a
> best-effort mode which lifts those limitations, at the expense of
> voiding the latency guarantee, but on the average, that would still be
> much better than always suffering the VIVT cache insanity without FCSE
>

Thanks for mentioning this. I will try to enable this option for
re-measurements.


> Quoting a previous mail of yours, regarding your target:
> > Processor       : ARM926EJ-S rev 5 (v5l)
>
> The latency hit induced by VIVT caching on arm926 is typically in the
> 180-200 us range under load in user-space, and 100-120 us in kernel
> space. So, without FCSE, this would bite at each Xenomai __and__ linux
> process context switch. Since your application requires that more than
> 95 processes be available in the system, you will likely get quite a few
> switches in any given period of time, unless most of them always sleep,
> of course.
>
> Ok, so let me do some wild guesses here: you told us this is a CE-based
> application; maybe it exists already? maybe it has to be put on stero=EFd=
s
> for gaining decent real-time guarantees it doesn't have yet? and perhaps
> the design of that application involves many processes undergoing
> periodic activities, so lots of context switches with address space
> changes during normal operations?
>
> And, you want that to run on arm926, with no FCSE, and likely not a huge
> amount of RAM either, with more than 95 different address spaces? Don't
> you think there might be a problem? If so, don't you think implementing
> a benchmark based on those assumptions might be irrelevant at some
> point?
>
> > As far as the adeos patch is concerned, i took a recent one (2.6.32)
>
> I guess you meant 2.6.33?
>

Correction, 2.6.30.


> >  and back-ported
> > it to 2.6.18, so as not to lose out on any new Adeos-only upgrades. i
> > carried out the
> > back-port activity for two platforms,a qemu-based integrator platform
> > (for
> > minimal functional validity) and my proprietary board.
> >
> > However, i am new to this field and would like to correct things if i
> > went wrong anywhere.0
> > Your comments and guidance would be much appreciated.
> >
>
> Since you told us only very few details, it's quite difficult to help.
> AFAICS, the only advice that would make sense here, can be expressed as
> a question for you: are you really, 100% sure that your app would fit on
> that hardware, even without any real-time requirement?
>
> >
> >
> >
> >
> >
> >
> >
> >
> > On Thu, Jun 24, 2010 at 3:30 AM, Philippe Gerum <rpm@xenomai.org>
> > wrote:
> >         On Thu, 2010-06-24 at 02:15 +0530, Nero Fernandez wrote:
> >         > Thanks for your response, Gilles.
> >         >
> >         > i modified the code to use semaphore instead of mutex, which
> >         worked
> >         > fine.
> >         > Attached is a compilation of some latency figures and system
> >         loading
> >         > figures (using lmbench)
> >         > that i obtained from my proprietary ARM-9 board, using
> >         Xenomai-2.5.2.
> >         >
> >         > Any comments are welcome. TIY.
> >         >
> >
> >
> >         Yikes. Let me sum up what I understood from your intent:
> >
> >         - you are measuring lmbench test latencies, that is to say,
> >         you don't
> >         measure the real-time core capabilities at all. Unless you
> >         crafted a
> >         Xenomai-linked version of lmbench, you are basically testing
> >         regular
> >         processes.
> >
> >         - you are benchmarking your own port of the interrupt pipeline
> >         over some
> >         random, outdated vendor kernel (2.6.18-based Mvista 5.0 dates
> >         back to
> >         2007, right?), albeit the original ARM port of such code is
> >         based on
> >         mainline since day #1. Since the latest latency-saving
> >         features like
> >         FCSE are available with Adeos patches on recent kernels, you
> >         are likely
> >         looking at ancient light rays from a fossile galaxy (btw, this
> >         may
> >         explain the incorrect results in the 0k context switch test -
> >         you don't
> >         have FCSE enabled in your Adeos port, right?).
> >
> >         - instead of reporting figures from a real-time interrupt
> >         handler
> >         actually connected to the Xenomai core, you hijacked the
> >         system timer
> >         core to pile up your instrumentation on top of the original
> >         code you
> >         were supposed to benchmark. If this helps,
> >         run /usr/xenomai/bin/latency
> >         -t2 and you will get the real figures.
> >
> >         Quoting you, from your document:
> >         "The intent for running these tests is to gauge the overhead
> >         of running
> >         interrupt-virtualization and further running a (real-time
> >         co-kernel +
> >         interrupt virtualization) on an embedded-device."
> >
> >         I'm unsure that you clearly identified the functional layers.
> >         If you
> >         don't measure the Xenomai core based on Xenomai activities,
> >         then you
> >         don't measure the co-kernel overhead. Besides, trying to
> >         measure the
> >         interrupt pipeline overhead via the lmbench micro-benchmarks
> >         makes no
> >         sense.
> >
> >
> >         >
> >         > On Sat, Jun 19, 2010 at 1:15 AM, Gilles Chanteperdrix
> >         > <gilles.chanteperdrix@xenomai.org> wrote:
> >         >
> >         >         Gilles Chanteperdrix wrote:
> >         >         > Nero Fernandez wrote:
> >         >         >> On Fri, Jun 18, 2010 at 7:42 PM, Gilles
> >         Chanteperdrix
> >         >         >> <gilles.chanteperdrix@xenomai.org
> >         >         >> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >         >         >>
> >         >         >>     Nero Fernandez wrote:
> >         >         >>     > Hi,
> >         >         >>     >
> >         >         >>     > Please find an archive attached,
> >         containing :
> >         >         >>     >  - a program for testing
> >         context-switch-latency using
> >         >         posix-APIs
> >         >         >>     >    for native linux kernel and
> >         xenomai-posix-skin
> >         >         (userspace).
> >         >         >>     >  - Makefile to build it using xenomai
> >         >         >>
> >         >         >>     Your program is very long to tell fast. But
> >         it seems
> >         >         you are using the
> >         >         >>     mutex as if they were recursive. Xenomai
> >         posix skin
> >         >         mutexes used to be
> >         >         >>     recursive by default, but no longer are.
> >         >         >>
> >         >         >>     Also note that your code does not check the
> >         return
> >         >         value of the posix
> >         >         >>     skin services, which is a really bad idea.
> >         >         >>
> >         >         >>     --
> >         >         >>
> >          Gilles.
> >         >         >>
> >         >         >>
> >         >         >> Thanks for the prompt response.
> >         >         >>
> >         >         >> Could you explain  'recursive usage of mutex' a
> >         little
> >         >         further?
> >         >         >> Are the xenomai pthread-mutexes very different in
> >         behaviour
> >         >         than regular
> >         >         >> posix mutexes?
> >         >         >
> >         >         > The posix specification does not define the
> >         default type of
> >         >         a mutex. So,
> >         >         >  in short, the behaviour of a "regular posix
> >         mutex" is
> >         >         unspecified.
> >         >         > However, following the principle of least
> >         surprise, Xenomai
> >         >         chose, like
> >         >         > Linux, to use the "normal" type by default.
> >         >         >
> >         >         > What is the type of a posix mutex is explained in
> >         many
> >         >         places, starting
> >         >         > with Xenomai API documentation. So, no, I will not
> >         repeat it
> >         >         here.
> >         >
> >         >
> >         >         Actually, that is not your problem. However, you do
> >         not check
> >         >         the return
> >         >         value of posix services, which is a bad idea. And
> >         indeed, if
> >         >         you check
> >         >         it you will find your error: a thread which does not
> >         own a
> >         >         mutex tries
> >         >         to unlock it.
> >         >
> >         >         Sorry, mutex are not semaphore, this is invalid, and
> >         Xenomai
> >         >         returns an
> >         >         error in such a case.
> >         >
> >         >         --
> >         >                                                    Gilles.
> >         >
> >
> >         > _______________________________________________
> >         > Xenomai-core mailing list
> >         > Xenomai-core@domain.hid
> >         > https://mail.gna.org/listinfo/xenomai-core
> >
> >
> >
> >         --
> >         Philippe.
> >
> >
> >
>
>
> --
> Philippe.
>
>
>

--0016e64b059e0368e7048a1ac19d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Jun 25, 2010 at 8:30 PM, Philipp=
e Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
i.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
On Thu, 2010-06-24 at 17:05 +0530, Nero Fernandez wrote:<br>
&gt; Thanks for your response, Philippe.<br>
&gt;<br>
&gt; The concerns while the carrying out my experiments were to:<br>
&gt;<br>
&gt; =A0- compare xenomai co-kernel overheads (timer and context switch<br>
&gt; latencies)<br>
&gt; =A0 =A0in xenomai-space vs similar native-linux overheads. These are<b=
r>
&gt; presented in<br>
&gt; =A0 =A0the first two sheets.<br>
&gt;<br>
&gt; =A0- find out, how addition of xenomai, xenomai+adeos effects the nati=
ve<br>
&gt; kernel&#39;s<br>
&gt; =A0 =A0performance. Here, lmbench was used on the native linux side to=
<br>
&gt; estimate<br>
&gt; =A0 =A0the changes to standard linux services.<br>
<br>
How can your reasonably estimate the overhead of co-kernel services<br>
without running any co-kernel services? Interrupt pipelining is not a<br>
co-kernel service. You do nothing with interrupt pipelining except<br>
enabling co-kernel services to be implemented with real-time response<br>
guarantee.<br></blockquote><div>=A0</div><div>Repeating myself, sheet 1 and=
 2 contain the results of running <br>co-kernel services(real-time pthread,=
 message-queues, semaphores <br>and clock-nansleep) and making measurment r=
egarding scheduling <br>
and timer-base functionality provided by co-kernel via posix skin.<br><br>S=
ame code was then built native posix, instead of=A0 xenomai-posix skin<br>a=
nd similar measurements were taken for linux-scheduler and timerbase.<br>
This is something that i cant do with xenomai&#39;s native test (use it for=
<br>native linux benchmarking). <br>The point here is to demostrate what ki=
nd of benefits may be drawn using<br>=A0xenomai-space without any code chan=
ge.<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;<br>
&gt; Regarding the additions of latency measurements in sys-timer handler,<=
br>
&gt; i performed<br>
&gt; a similar measurement from xnintr_clock_handler(), and the results<br>
&gt; were similar<br>
&gt; to ones reported from sys-timer handler in xenomai-enabled linux.<br>
<br>
If your benchmark is about Xenomai, then at least make sure to provide<br>
results for Xenomai services, used in a relevant application and<br>
platform context. Pretending that you instrumented<br>
xnintr_clock_handler() at some point and got some results, but<br>
eventually decided to illustrate your benchmark with other &quot;similar&qu=
ot;<br>
results obtained from a totally unrelated instrumentation code, does not<br=
>
help considering the figures as relevant.<br>
<br>
Btw, hooking xnintr_clock_handler() is not correct. Again, benchmarking<br>
interrupt latency with Xenomai has to measure the entire code path, from<br=
>
the moment the interrupt is taken by the CPU, until it is delivered to<br>
the Xenomai service user. By instrumenting directly in<br>
xnintr_clock_handler(), your test bypasses the Xenomai timer handling<br>
code which delivers the timer tick to the user code, and the<br>
rescheduling procedure as well, so your figures are optimistically wrong<br=
>
for any normal use case based on real-time tasks.<br></blockquote><div>=A0<=
br>Regarding hooking up a measurement-device in sys-timer itself, it serves=
<br>the benefit of observing the changes that xenomai&#39;s aperiodic handl=
ing<br>
of system-timer brings. This measurement does not attempt to measure <br>th=
e co-kernel services in any manner.<br>=A0</div><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">

=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; =A0While trying to<br>
&gt; make both these measurements, i tried to take care that delay-value<br=
>
&gt; logging is<br>
&gt; done at the end the handler routines,but the __ipipe_mach_tsc value is=
<br>
&gt; recorded<br>
&gt; at the beginning of the routine (a patch for this is included in the<b=
r>
&gt; worksheet itself)<br>
<br>
This patch is hopelessly useless and misleading. Unless your intent is<br>
to have your application directly embodied into low-level interrupt<br>
handlers, you are not measuring the actual overhead.<br>
<br>
Latency is not solely a matter of interrupt masking, but also a matter<br>
of I/D cache misses, particularly on ARM - you have to traverse the<br>
actual code until delivery to exhibit the latter.<br>
<br>
This is exactly what the latency tests shipped with Xenomai are for:<br>
- /usr/xenomai/bin/latency -t0/1/2<br>
- /usr/xenomai/bin/klatency<br>
- /usr/xenomai/bin/irqbench<br>
<br>
If your system involves user-space tasks, then you should benchmark<br>
user-space response time using latency [-t0]. If you plan to use<br>
kernel-based tasks such as RTDM tasks, then latency -t1 and klatency<br>
tests will provide correct results for your benchmark.<br>
If you are interested only in interrupt latency, then latency -t2 will<br>
help.<br>
<br>
If you do think that those tests do not measure what you seem to be<br>
interested in, then you may want to explain why on this list, so that we<br=
>
eventually understand what you are after.<br>
<br>
&gt;<br>
&gt; Regarding the system, changing the kernel version would invalidate my<=
br>
&gt; results<br>
&gt; as the system is a released CE device and has no plans to upgrade the<=
br>
&gt; kernel.<br>
<br>
Ok. But that makes your benchmark 100% irrelevant with respect to<br>
assessing the real performances of a decent co-kernel on your setup.<br>
<br>
&gt; AFAIK, enabling FCSE would limit the number of concurrent processes,<b=
r>
&gt; hence<br>
&gt; becoming inviable in my scenario.<br>
<br>
Ditto. Besides, FCSE as implemented in recent I-pipe patches has a<br>
best-effort mode which lifts those limitations, at the expense of<br>
voiding the latency guarantee, but on the average, that would still be<br>
much better than always suffering the VIVT cache insanity without FCSE<br><=
/blockquote><div><br>Thanks for mentioning this. I will try to enable this =
option for re-measurements.<br>=A0<br></div><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">

Quoting a previous mail of yours, regarding your target:<br>
&gt; Processor =A0 =A0 =A0 : ARM926EJ-S rev 5 (v5l)<br>
<br>
The latency hit induced by VIVT caching on arm926 is typically in the<br>
180-200 us range under load in user-space, and 100-120 us in kernel<br>
space. So, without FCSE, this would bite at each Xenomai __and__ linux<br>
process context switch. Since your application requires that more than<br>
95 processes be available in the system, you will likely get quite a few<br=
>
switches in any given period of time, unless most of them always sleep,<br>
of course.<br>
<br>
Ok, so let me do some wild guesses here: you told us this is a CE-based<br>
application; maybe it exists already? maybe it has to be put on stero=EFds<=
br>
for gaining decent real-time guarantees it doesn&#39;t have yet? and perhap=
s<br>
the design of that application involves many processes undergoing<br>
periodic activities, so lots of context switches with address space<br>
changes during normal operations?<br>
<br>
And, you want that to run on arm926, with no FCSE, and likely not a huge<br=
>
amount of RAM either, with more than 95 different address spaces? Don&#39;t=
<br>
you think there might be a problem? If so, don&#39;t you think implementing=
<br>
a benchmark based on those assumptions might be irrelevant at some<br>
point?<br>
<br>
&gt; As far as the adeos patch is concerned, i took a recent one (2.6.32)<b=
r>
<br>
I guess you meant 2.6.33?<br></blockquote><div>=A0</div><div>Correction, 2.=
6.30.<br><br></div><blockquote class=3D"gmail_quote" style=3D"border-left: =
1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;=
">

<br>
&gt; =A0and back-ported<br>
&gt; it to 2.6.18, so as not to lose out on any new Adeos-only upgrades. i<=
br>
&gt; carried out the<br>
&gt; back-port activity for two platforms,a qemu-based integrator platform<=
br>
&gt; (for<br>
&gt; minimal functional validity) and my proprietary board.<br>
&gt;<br>
&gt; However, i am new to this field and would like to correct things if i<=
br>
&gt; went wrong anywhere.0<br>
&gt; Your comments and guidance would be much appreciated.<br>
&gt;<br>
<br>
Since you told us only very few details, it&#39;s quite difficult to help.<=
br>
AFAICS, the only advice that would make sense here, can be expressed as<br>
a question for you: are you really, 100% sure that your app would fit on<br=
>
that hardware, even without any real-time requirement?<br>
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Jun 24, 2010 at 3:30 AM, Philippe Gerum &lt;<a href=3D"mailto:=
rpm@xenomai.org">rpm@xenomai.org</a>&gt;<br>
&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 On Thu, 2010-06-24 at 02:15 +0530, Nero Fernandez wrot=
e:<br>
&gt; =A0 =A0 =A0 =A0 &gt; Thanks for your response, Gilles.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; i modified the code to use semaphore instead of m=
utex, which<br>
&gt; =A0 =A0 =A0 =A0 worked<br>
&gt; =A0 =A0 =A0 =A0 &gt; fine.<br>
&gt; =A0 =A0 =A0 =A0 &gt; Attached is a compilation of some latency figures=
 and system<br>
&gt; =A0 =A0 =A0 =A0 loading<br>
&gt; =A0 =A0 =A0 =A0 &gt; figures (using lmbench)<br>
&gt; =A0 =A0 =A0 =A0 &gt; that i obtained from my proprietary ARM-9 board, =
using<br>
&gt; =A0 =A0 =A0 =A0 Xenomai-2.5.2.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Any comments are welcome. TIY.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Yikes. Let me sum up what I understood from your inten=
t:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 - you are measuring lmbench test latencies, that is to=
 say,<br>
&gt; =A0 =A0 =A0 =A0 you don&#39;t<br>
&gt; =A0 =A0 =A0 =A0 measure the real-time core capabilities at all. Unless=
 you<br>
&gt; =A0 =A0 =A0 =A0 crafted a<br>
&gt; =A0 =A0 =A0 =A0 Xenomai-linked version of lmbench, you are basically t=
esting<br>
&gt; =A0 =A0 =A0 =A0 regular<br>
&gt; =A0 =A0 =A0 =A0 processes.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 - you are benchmarking your own port of the interrupt =
pipeline<br>
&gt; =A0 =A0 =A0 =A0 over some<br>
&gt; =A0 =A0 =A0 =A0 random, outdated vendor kernel (2.6.18-based Mvista 5.=
0 dates<br>
&gt; =A0 =A0 =A0 =A0 back to<br>
&gt; =A0 =A0 =A0 =A0 2007, right?), albeit the original ARM port of such co=
de is<br>
&gt; =A0 =A0 =A0 =A0 based on<br>
&gt; =A0 =A0 =A0 =A0 mainline since day #1. Since the latest latency-saving=
<br>
&gt; =A0 =A0 =A0 =A0 features like<br>
&gt; =A0 =A0 =A0 =A0 FCSE are available with Adeos patches on recent kernel=
s, you<br>
&gt; =A0 =A0 =A0 =A0 are likely<br>
&gt; =A0 =A0 =A0 =A0 looking at ancient light rays from a fossile galaxy (b=
tw, this<br>
&gt; =A0 =A0 =A0 =A0 may<br>
&gt; =A0 =A0 =A0 =A0 explain the incorrect results in the 0k context switch=
 test -<br>
&gt; =A0 =A0 =A0 =A0 you don&#39;t<br>
&gt; =A0 =A0 =A0 =A0 have FCSE enabled in your Adeos port, right?).<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 - instead of reporting figures from a real-time interr=
upt<br>
&gt; =A0 =A0 =A0 =A0 handler<br>
&gt; =A0 =A0 =A0 =A0 actually connected to the Xenomai core, you hijacked t=
he<br>
&gt; =A0 =A0 =A0 =A0 system timer<br>
&gt; =A0 =A0 =A0 =A0 core to pile up your instrumentation on top of the ori=
ginal<br>
&gt; =A0 =A0 =A0 =A0 code you<br>
&gt; =A0 =A0 =A0 =A0 were supposed to benchmark. If this helps,<br>
&gt; =A0 =A0 =A0 =A0 run /usr/xenomai/bin/latency<br>
&gt; =A0 =A0 =A0 =A0 -t2 and you will get the real figures.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Quoting you, from your document:<br>
&gt; =A0 =A0 =A0 =A0 &quot;The intent for running these tests is to gauge t=
he overhead<br>
&gt; =A0 =A0 =A0 =A0 of running<br>
&gt; =A0 =A0 =A0 =A0 interrupt-virtualization and further running a (real-t=
ime<br>
&gt; =A0 =A0 =A0 =A0 co-kernel +<br>
&gt; =A0 =A0 =A0 =A0 interrupt virtualization) on an embedded-device.&quot;=
<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I&#39;m unsure that you clearly identified the functio=
nal layers.<br>
&gt; =A0 =A0 =A0 =A0 If you<br>
&gt; =A0 =A0 =A0 =A0 don&#39;t measure the Xenomai core based on Xenomai ac=
tivities,<br>
&gt; =A0 =A0 =A0 =A0 then you<br>
&gt; =A0 =A0 =A0 =A0 don&#39;t measure the co-kernel overhead. Besides, try=
ing to<br>
&gt; =A0 =A0 =A0 =A0 measure the<br>
&gt; =A0 =A0 =A0 =A0 interrupt pipeline overhead via the lmbench micro-benc=
hmarks<br>
&gt; =A0 =A0 =A0 =A0 makes no<br>
&gt; =A0 =A0 =A0 =A0 sense.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Sat, Jun 19, 2010 at 1:15 AM, Gilles Chanteper=
drix<br>
&gt; =A0 =A0 =A0 =A0 &gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
i.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 Gilles Chanteperdrix wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Nero Fernandez wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; On Fri, Jun 18, 2010 at =
7:42 PM, Gilles<br>
&gt; =A0 =A0 =A0 =A0 Chanteperdrix<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; &lt;<a href=3D"mailto:gi=
lles.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a><br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; &lt;mailto:<a href=3D"ma=
ilto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>=
&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 Nero Fernandez w=
rote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; Hi,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; Please find=
 an archive attached,<br>
&gt; =A0 =A0 =A0 =A0 containing :<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; =A0- a prog=
ram for testing<br>
&gt; =A0 =A0 =A0 =A0 context-switch-latency using<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 posix-APIs<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; =A0 =A0for =
native linux kernel and<br>
&gt; =A0 =A0 =A0 =A0 xenomai-posix-skin<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 (userspace).<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; =A0- Makefi=
le to build it using xenomai<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 Your program is =
very long to tell fast. But<br>
&gt; =A0 =A0 =A0 =A0 it seems<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 you are using the<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 mutex as if they=
 were recursive. Xenomai<br>
&gt; =A0 =A0 =A0 =A0 posix skin<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 mutexes used to be<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 recursive by def=
ault, but no longer are.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 Also note that y=
our code does not check the<br>
&gt; =A0 =A0 =A0 =A0 return<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 value of the posix<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 skin services, w=
hich is a really bad idea.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0Gilles.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; Thanks for the prompt re=
sponse.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; Could you explain =A0&#3=
9;recursive usage of mutex&#39; a<br>
&gt; =A0 =A0 =A0 =A0 little<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 further?<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; Are the xenomai pthread-=
mutexes very different in<br>
&gt; =A0 =A0 =A0 =A0 behaviour<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 than regular<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;&gt; posix mutexes?<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; The posix specification does=
 not define the<br>
&gt; =A0 =A0 =A0 =A0 default type of<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 a mutex. So,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0in short, the behaviour o=
f a &quot;regular posix<br>
&gt; =A0 =A0 =A0 =A0 mutex&quot; is<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 unspecified.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; However, following the princ=
iple of least<br>
&gt; =A0 =A0 =A0 =A0 surprise, Xenomai<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 chose, like<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Linux, to use the &quot;norm=
al&quot; type by default.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; What is the type of a posix =
mutex is explained in<br>
&gt; =A0 =A0 =A0 =A0 many<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 places, starting<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; with Xenomai API documentati=
on. So, no, I will not<br>
&gt; =A0 =A0 =A0 =A0 repeat it<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 here.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 Actually, that is not your proble=
m. However, you do<br>
&gt; =A0 =A0 =A0 =A0 not check<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 the return<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 value of posix services, which is=
 a bad idea. And<br>
&gt; =A0 =A0 =A0 =A0 indeed, if<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 you check<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 it you will find your error: a th=
read which does not<br>
&gt; =A0 =A0 =A0 =A0 own a<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 mutex tries<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 to unlock it.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 Sorry, mutex are not semaphore, t=
his is invalid, and<br>
&gt; =A0 =A0 =A0 =A0 Xenomai<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 returns an<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 error in such a case.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; _______________________________________________<b=
r>
&gt; =A0 =A0 =A0 =A0 &gt; Xenomai-core mailing list<br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"mailto:Xenomai-core@domain.hid">Xenomai-c=
ore@domain.hid</a><br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-=
core" target=3D"_blank">https://mail.gna.org/listinfo/xenomai-core</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Philippe.<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e64b059e0368e7048a1ac19d--


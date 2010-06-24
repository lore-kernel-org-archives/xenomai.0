MIME-Version: 1.0
In-Reply-To: <1277330401.2453.145.camel@domain.hid>
References: <AANLkTikU5zPKew64ZxWGokwh5R5F-sNegWdDzOENWdzB@mail.gmail.com>
	<4C1B7EB1.2040006@domain.hid>
	<AANLkTinABTK2nMI0QfZVaULQ4OKwF0678PKOBc_OMIn1@domain.hid>
	<AANLkTiklRlwsIJfelo0eT2GZDvI6PtDAwc4qluLCr6R5@domain.hid>
	<4C1B8C04.3010900@domain.hid> <4C1BCCBF.7010400@domain.hid>
	<AANLkTilBt1fx4MFJ_Tmuz-fUl1D190u_FYDfLn09JaA3@domain.hid>
	<1277330401.2453.145.camel@domain.hid>
Date: Thu, 24 Jun 2010 17:05:26 +0530
Message-ID: <AANLkTincrp1q4RbmCoijrummF3IS_tfBJ-YGZnGFbpw0@domain.hid>
From: Nero Fernandez <grimlynch@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64af3c0fcb9670489c50c29
Subject: Re: [Xenomai-core] Fwd: problem in pthread_mutex_lock/unlock
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

--0016e64af3c0fcb9670489c50c29
Content-Type: text/plain; charset=ISO-8859-1

Thanks for your response, Philippe.

The concerns while the carrying out my experiments were to:

 - compare xenomai co-kernel overheads (timer and context switch latencies)
   in xenomai-space vs similar native-linux overheads. These are presented
in
   the first two sheets.

 - find out, how addition of xenomai, xenomai+adeos effects the native
kernel's
   performance. Here, lmbench was used on the native linux side to estimate
   the changes to standard linux services.

Regarding the additions of latency measurements in sys-timer handler, i
performed
a similar measurement from xnintr_clock_handler(), and the results were
similar
to ones reported from sys-timer handler in xenomai-enabled linux. While
trying to
make both these measurements, i tried to take care that delay-value logging
is
done at the end the handler routines,but the __ipipe_mach_tsc value is
recorded
at the beginning of the routine (a patch for this is included in the
worksheet itself)

Regarding the system, changing the kernel version would invalidate my
results
as the system is a released CE device and has no plans to upgrade the
kernel.
AFAIK, enabling FCSE would limit the number of concurrent processes, hence
becoming inviable in my scenario.
As far as the adeos patch is concerned, i took a recent one (2.6.32) and
back-ported
it to 2.6.18, so as not to lose out on any new Adeos-only upgrades. i
carried out the
back-port activity for two platforms,a qemu-based integrator platform (for
minimal functional validity) and my proprietary board.

However, i am new to this field and would like to correct things if i went
wrong anywhere.
Your comments and guidance would be much appreciated.






On Thu, Jun 24, 2010 at 3:30 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Thu, 2010-06-24 at 02:15 +0530, Nero Fernandez wrote:
> > Thanks for your response, Gilles.
> >
> > i modified the code to use semaphore instead of mutex, which worked
> > fine.
> > Attached is a compilation of some latency figures and system loading
> > figures (using lmbench)
> > that i obtained from my proprietary ARM-9 board, using Xenomai-2.5.2.
> >
> > Any comments are welcome. TIY.
> >
>
> Yikes. Let me sum up what I understood from your intent:
>
> - you are measuring lmbench test latencies, that is to say, you don't
> measure the real-time core capabilities at all. Unless you crafted a
> Xenomai-linked version of lmbench, you are basically testing regular
> processes.
>
> - you are benchmarking your own port of the interrupt pipeline over some
> random, outdated vendor kernel (2.6.18-based Mvista 5.0 dates back to
> 2007, right?), albeit the original ARM port of such code is based on
> mainline since day #1. Since the latest latency-saving features like
> FCSE are available with Adeos patches on recent kernels, you are likely
> looking at ancient light rays from a fossile galaxy (btw, this may
> explain the incorrect results in the 0k context switch test - you don't
> have FCSE enabled in your Adeos port, right?).
>
> - instead of reporting figures from a real-time interrupt handler
> actually connected to the Xenomai core, you hijacked the system timer
> core to pile up your instrumentation on top of the original code you
> were supposed to benchmark. If this helps, run /usr/xenomai/bin/latency
> -t2 and you will get the real figures.
>
> Quoting you, from your document:
> "The intent for running these tests is to gauge the overhead of running
> interrupt-virtualization and further running a (real-time co-kernel +
> interrupt virtualization) on an embedded-device."
>
> I'm unsure that you clearly identified the functional layers. If you
> don't measure the Xenomai core based on Xenomai activities, then you
> don't measure the co-kernel overhead. Besides, trying to measure the
> interrupt pipeline overhead via the lmbench micro-benchmarks makes no
> sense.
>
> >
> > On Sat, Jun 19, 2010 at 1:15 AM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> >
> >         Gilles Chanteperdrix wrote:
> >         > Nero Fernandez wrote:
> >         >> On Fri, Jun 18, 2010 at 7:42 PM, Gilles Chanteperdrix
> >         >> <gilles.chanteperdrix@xenomai.org
> >         >> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >         >>
> >         >>     Nero Fernandez wrote:
> >         >>     > Hi,
> >         >>     >
> >         >>     > Please find an archive attached, containing :
> >         >>     >  - a program for testing context-switch-latency using
> >         posix-APIs
> >         >>     >    for native linux kernel and xenomai-posix-skin
> >         (userspace).
> >         >>     >  - Makefile to build it using xenomai
> >         >>
> >         >>     Your program is very long to tell fast. But it seems
> >         you are using the
> >         >>     mutex as if they were recursive. Xenomai posix skin
> >         mutexes used to be
> >         >>     recursive by default, but no longer are.
> >         >>
> >         >>     Also note that your code does not check the return
> >         value of the posix
> >         >>     skin services, which is a really bad idea.
> >         >>
> >         >>     --
> >         >>                                                Gilles.
> >         >>
> >         >>
> >         >> Thanks for the prompt response.
> >         >>
> >         >> Could you explain  'recursive usage of mutex' a little
> >         further?
> >         >> Are the xenomai pthread-mutexes very different in behaviour
> >         than regular
> >         >> posix mutexes?
> >         >
> >         > The posix specification does not define the default type of
> >         a mutex. So,
> >         >  in short, the behaviour of a "regular posix mutex" is
> >         unspecified.
> >         > However, following the principle of least surprise, Xenomai
> >         chose, like
> >         > Linux, to use the "normal" type by default.
> >         >
> >         > What is the type of a posix mutex is explained in many
> >         places, starting
> >         > with Xenomai API documentation. So, no, I will not repeat it
> >         here.
> >
> >
> >         Actually, that is not your problem. However, you do not check
> >         the return
> >         value of posix services, which is a bad idea. And indeed, if
> >         you check
> >         it you will find your error: a thread which does not own a
> >         mutex tries
> >         to unlock it.
> >
> >         Sorry, mutex are not semaphore, this is invalid, and Xenomai
> >         returns an
> >         error in such a case.
> >
> >         --
> >                                                    Gilles.
> >
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
>
>
> --
> Philippe.
>
>
>

--0016e64af3c0fcb9670489c50c29
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for your response, Philippe.<br><br>The concerns while the carrying =
out my experiments were to:<br><br>=A0- compare xenomai co-kernel overheads=
 (timer and context switch latencies)<br>=A0=A0 in xenomai-space vs similar=
 native-linux overheads. These are presented in <br>
=A0=A0 the first two sheets.<br><br>=A0- find out, how addition of xenomai,=
 xenomai+adeos effects the native kernel&#39;s <br>=A0=A0 performance. Here=
, lmbench was used on the native linux side to estimate<br>=A0=A0 the chang=
es to standard linux services.<br>
<br>Regarding the additions of latency measurements in sys-timer handler, i=
 performed <br>a similar measurement from xnintr_clock_handler(), and the r=
esults were similar <br>to ones reported from sys-timer handler in xenomai-=
enabled linux. While trying to <br>
make both these measurements, i tried to take care that delay-value logging=
 is <br>done at the end the handler routines,but the __ipipe_mach_tsc value=
 is recorded <br>at the beginning of the routine (a patch for this is inclu=
ded in the worksheet itself)<br>
<br>Regarding the system, changing the kernel version would invalidate my r=
esults<br>as the system is a released CE device and has no plans to upgrade=
 the kernel.<br>AFAIK, enabling FCSE would limit the number of concurrent p=
rocesses, hence<br>
becoming inviable in my scenario.<br>As far as the adeos patch is concerned=
, i took a recent one (2.6.32) and back-ported<br>it to 2.6.18, so as not t=
o lose out on any new Adeos-only upgrades. i carried out the <br>back-port =
activity for two platforms,a qemu-based integrator platform (for <br>
minimal functional validity) and my proprietary board.<br><br>However, i am=
 new to this field and would like to correct things if i went wrong anywher=
e.<br>Your comments and guidance would be much appreciated.<br><br><br>
<br><br><br><br><div class=3D"gmail_quote">On Thu, Jun 24, 2010 at 3:30 AM,=
 Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rp=
m@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">
<div class=3D"im">On Thu, 2010-06-24 at 02:15 +0530, Nero Fernandez wrote:<=
br>
&gt; Thanks for your response, Gilles.<br>
&gt;<br>
&gt; i modified the code to use semaphore instead of mutex, which worked<br=
>
&gt; fine.<br>
&gt; Attached is a compilation of some latency figures and system loading<b=
r>
&gt; figures (using lmbench)<br>
&gt; that i obtained from my proprietary ARM-9 board, using Xenomai-2.5.2.<=
br>
&gt;<br>
&gt; Any comments are welcome. TIY.<br>
&gt;<br>
<br>
</div>Yikes. Let me sum up what I understood from your intent:<br>
<br>
- you are measuring lmbench test latencies, that is to say, you don&#39;t<b=
r>
measure the real-time core capabilities at all. Unless you crafted a<br>
Xenomai-linked version of lmbench, you are basically testing regular<br>
processes.<br>
<br>
- you are benchmarking your own port of the interrupt pipeline over some<br=
>
random, outdated vendor kernel (2.6.18-based Mvista 5.0 dates back to<br>
2007, right?), albeit the original ARM port of such code is based on<br>
mainline since day #1. Since the latest latency-saving features like<br>
FCSE are available with Adeos patches on recent kernels, you are likely<br>
looking at ancient light rays from a fossile galaxy (btw, this may<br>
explain the incorrect results in the 0k context switch test - you don&#39;t=
<br>
have FCSE enabled in your Adeos port, right?).<br>
<br>
- instead of reporting figures from a real-time interrupt handler<br>
actually connected to the Xenomai core, you hijacked the system timer<br>
core to pile up your instrumentation on top of the original code you<br>
were supposed to benchmark. If this helps, run /usr/xenomai/bin/latency<br>
-t2 and you will get the real figures.<br>
<br>
Quoting you, from your document:<br>
&quot;The intent for running these tests is to gauge the overhead of runnin=
g<br>
interrupt-virtualization and further running a (real-time co-kernel +<br>
interrupt virtualization) on an embedded-device.&quot;<br>
<br>
I&#39;m unsure that you clearly identified the functional layers. If you<br=
>
don&#39;t measure the Xenomai core based on Xenomai activities, then you<br=
>
don&#39;t measure the co-kernel overhead. Besides, trying to measure the<br=
>
interrupt pipeline overhead via the lmbench micro-benchmarks makes no<br>
sense.<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; On Sat, Jun 19, 2010 at 1:15 AM, Gilles Chanteperdrix<br>
&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Gilles Chanteperdrix wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; Nero Fernandez wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; On Fri, Jun 18, 2010 at 7:42 PM, Gilles Chant=
eperdrix<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
nomai.org">gilles.chanteperdrix@xenomai.org</a><br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &lt;mailto:<a href=3D"mailto:gilles.chanteper=
drix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 Nero Fernandez wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; Hi,<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; Please find an archive attached,=
 containing :<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; =A0- a program for testing conte=
xt-switch-latency using<br>
&gt; =A0 =A0 =A0 =A0 posix-APIs<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; =A0 =A0for native linux kernel a=
nd xenomai-posix-skin<br>
&gt; =A0 =A0 =A0 =A0 (userspace).<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 &gt; =A0- Makefile to build it using =
xenomai<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 Your program is very long to tell fas=
t. But it seems<br>
&gt; =A0 =A0 =A0 =A0 you are using the<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 mutex as if they were recursive. Xeno=
mai posix skin<br>
&gt; =A0 =A0 =A0 =A0 mutexes used to be<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 recursive by default, but no longer a=
re.<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 Also note that your code does not che=
ck the return<br>
&gt; =A0 =A0 =A0 =A0 value of the posix<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 skin services, which is a really bad =
idea.<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; Thanks for the prompt response.<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; Could you explain =A0&#39;recursive usage of =
mutex&#39; a little<br>
&gt; =A0 =A0 =A0 =A0 further?<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; Are the xenomai pthread-mutexes very differen=
t in behaviour<br>
&gt; =A0 =A0 =A0 =A0 than regular<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; posix mutexes?<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; The posix specification does not define the defau=
lt type of<br>
&gt; =A0 =A0 =A0 =A0 a mutex. So,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0in short, the behaviour of a &quot;regular pos=
ix mutex&quot; is<br>
&gt; =A0 =A0 =A0 =A0 unspecified.<br>
&gt; =A0 =A0 =A0 =A0 &gt; However, following the principle of least surpris=
e, Xenomai<br>
&gt; =A0 =A0 =A0 =A0 chose, like<br>
&gt; =A0 =A0 =A0 =A0 &gt; Linux, to use the &quot;normal&quot; type by defa=
ult.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; What is the type of a posix mutex is explained in=
 many<br>
&gt; =A0 =A0 =A0 =A0 places, starting<br>
&gt; =A0 =A0 =A0 =A0 &gt; with Xenomai API documentation. So, no, I will no=
t repeat it<br>
&gt; =A0 =A0 =A0 =A0 here.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Actually, that is not your problem. However, you do no=
t check<br>
&gt; =A0 =A0 =A0 =A0 the return<br>
&gt; =A0 =A0 =A0 =A0 value of posix services, which is a bad idea. And inde=
ed, if<br>
&gt; =A0 =A0 =A0 =A0 you check<br>
&gt; =A0 =A0 =A0 =A0 it you will find your error: a thread which does not o=
wn a<br>
&gt; =A0 =A0 =A0 =A0 mutex tries<br>
&gt; =A0 =A0 =A0 =A0 to unlock it.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Sorry, mutex are not semaphore, this is invalid, and X=
enomai<br>
&gt; =A0 =A0 =A0 =A0 returns an<br>
&gt; =A0 =A0 =A0 =A0 error in such a case.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
&gt;<br>
</div></div><div class=3D"im">&gt; ________________________________________=
_______<br>
&gt; Xenomai-core mailing list<br>
&gt; <a href=3D"mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-core" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-core</a><br>
<br>
<br>
</div>--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016e64af3c0fcb9670489c50c29--


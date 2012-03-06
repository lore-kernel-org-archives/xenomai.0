MIME-Version: 1.0
In-Reply-To: <4F516540.5030801@domain.hid>
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
	<CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
	<4F46C7CD.1070509@domain.hid>
	<CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
	<4F4920DE.40600@domain.hid>
	<CAHOEnGcVoRVtfL0Fgz-zx-==2YkM7QH3abtSLDaZdyVo0gk60Q@mail.gmail.com>
	<CAHOEnGfcSwNEi61Kq9=HHzNrMTV6eFc9ZzJJTSqKZRD4wS9juA@mail.gmail.com>
	<4F509B3C.9030105@domain.hid> <4F509C26.7070308@domain.hid>
	<CAHOEnGegK_DzKg_RTf7yadD2mAxJJOSgdpMn+nxRCHsjAp7mrg@domain.hid>
	<4F516540.5030801@domain.hid>
From: =?ISO-8859-1?Q?Oscar_D=E1vila?= <odavilar@domain.hid>
Date: Mon, 5 Mar 2012 21:14:01 -0600
Message-ID: <CAHOEnGc88-bEJTkgnuWNB9rEkKofZYiYCUedLapTHjiRRqptDg@domain.hid>
Content-Type: multipart/alternative; boundary=14dae93996cd7a264604ba8a70b8
Subject: Re: [Xenomai-help] Freeze while running examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--14dae93996cd7a264604ba8a70b8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2012/3/2 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 03/03/2012 01:14 AM, Oscar D=E1vila wrote:
> > 2012/3/2 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 03/02/2012 11:04 AM, Gilles Chanteperdrix wrote:
> >>> On 03/01/2012 05:23 AM, Oscar D=E1vila wrote:
> >>>> Finally i could get the dump
> >>>>
> >>>>
> >>>> post-prompt
> >>>> No breakpoints or watchpoints.
> >>>>
> >>>> breakpoints-table-end
> >>>>
> >>>> post-prompt
> >>>> Dump of assembler code for function __ipipe_sync_stage:
> >>>> 0xc106d376 <__ipipe_sync_stage+0>:   push   %ebp
> >>>> (...)
> >>>> 0xc106d526 <__ipipe_sync_stage+432>: ret
> >>>> End of assembler dump.
> >>>
> >>> The address where the EIP is when the NMI watchdog triggers is
> >>> 0xc106d5e1, so, outside this code.
> >>>
> >> And this dump does not seem to correspond to the kernel that was runni=
ng
> >> when the bug happened, because in that case we had
> >>
> >> 0xc106d5e1 =3D=3D __ipipe_sync_stage + 0x21b
> >>
> >> whereas in your dump,
> >>
> >> __ipipe_sync_stage + 0x21b =3D=3D 0xc106d591
> >>
> >> Sorry about that, i lost that image of the kernel.
> >
> > Here is a new complete test.
> >
> > Kernel Messages
> >
> >
> > Kernel failure message 1:
> > BUG: NMI Watchdog detected LOCKUP on CPU0, ip c10751d3, registers:
> >
> >                       local_irq_disable_hw();
> > c10751bf:     fa                      cli
> > c10751c0:     89 e0                   mov    %esp,%eax
> > c10751c2:     25 00 e0 ff ff          and    $0xffffe000,%eax
> >                       root_stall_after_handler();
> >                       while (__ipipe_check_root_resched())
> > c10751c7:     83 78 14 00             cmpl   $0x0,0x14(%eax)
> > c10751cb:     75 58                   jne    c1075225 <__xirq_end+0x2>
> > c10751cd:     f6 40 08 08             testb  $0x8,0x8(%eax)
> > c10751d1:     74 52                   je     c1075225 <__xirq_end+0x2>
> > c10751d3:     eb f8                   jmp    c10751cd
> <__ipipe_sync_stage+0x12b>
> >                               __ipipe_preempt_schedule_irq();
>
> Looks like an infinite loop when CONFIG_PREEMPT is off. Try putting an
> #ifdef CONFIG_PREEMPT around this code:
>
> #ifdef CONFIG_PREEMPT
>                        while (__ipipe_check_root_resched())
>                                __ipipe_preempt_schedule_irq();
> #endif
>
> To test that this is indeed the issue, you may try enabling
> CONFIG_PREEMPT in the code.



I recompiled the kernel enabling CONFIG_PREEMPT and it worked, also i tried
the other option, where i add the #ifdef CONFIG_PREEMPT to the source of
core.c, and it also worked.

So it seems that was the problem. Now i can run trivial_periodic.

But after some time with the kernel after running trivial_periodic, the
machines still freezes, i will try to see where the failure is happening
now.

Which type of preemption model its preferred? i mean, using the
CONFIG_PREEMPT enabled or without the:
                       while (__ipipe_check_root_resched())
                               __ipipe_preempt_schedule_irq();

Thanks again.

--=20
Oscar D=E1vila Ram=EDrez

--14dae93996cd7a264604ba8a70b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2012/3/2 Gilles Chanteperdrix <span dir=3D"ltr">=
&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank">g=
illes.chanteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">



<div><div></div><div>On 03/03/2012 01:14 AM, Oscar D=E1vila wrote:<br>
&gt; 2012/3/2 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdr=
ix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;<=
br>
&gt;<br>
&gt;&gt; On 03/02/2012 11:04 AM, Gilles Chanteperdrix wrote:<br>
&gt;&gt;&gt; On 03/01/2012 05:23 AM, Oscar D=E1vila wrote:<br>
&gt;&gt;&gt;&gt; Finally i could get the dump<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; post-prompt<br>
&gt;&gt;&gt;&gt; No breakpoints or watchpoints.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; breakpoints-table-end<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; post-prompt<br>
&gt;&gt;&gt;&gt; Dump of assembler code for function __ipipe_sync_stage:<br=
>
&gt;&gt;&gt;&gt; 0xc106d376 &lt;__ipipe_sync_stage+0&gt;: =A0 push =A0 %ebp=
<br>
&gt;&gt;&gt;&gt; (...)<br>
&gt;&gt;&gt;&gt; 0xc106d526 &lt;__ipipe_sync_stage+432&gt;: ret<br>
&gt;&gt;&gt;&gt; End of assembler dump.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The address where the EIP is when the NMI watchdog triggers is=
<br>
&gt;&gt;&gt; 0xc106d5e1, so, outside this code.<br>
&gt;&gt;&gt;<br>
&gt;&gt; And this dump does not seem to correspond to the kernel that was r=
unning<br>
&gt;&gt; when the bug happened, because in that case we had<br>
&gt;&gt;<br>
&gt;&gt; 0xc106d5e1 =3D=3D __ipipe_sync_stage + 0x21b<br>
&gt;&gt;<br>
&gt;&gt; whereas in your dump,<br>
&gt;&gt;<br>
&gt;&gt; __ipipe_sync_stage + 0x21b =3D=3D 0xc106d591<br>
&gt;&gt;<br>
&gt;&gt; Sorry about that, i lost that image of the kernel.<br>
&gt;<br>
&gt; Here is a new complete test.<br>
&gt;<br>
&gt; Kernel Messages<br>
&gt;<br>
&gt;<br>
&gt; Kernel failure message 1:<br>
&gt; BUG: NMI Watchdog detected LOCKUP on CPU0, ip c10751d3, registers:<br>
&gt;<br>
</div></div><div>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq=
_disable_hw();<br>
&gt; c10751bf: =A0 =A0 fa =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cli<br=
>
&gt; c10751c0: =A0 =A0 89 e0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov =A0 =
=A0%esp,%eax<br>
&gt; c10751c2: =A0 =A0 25 00 e0 ff ff =A0 =A0 =A0 =A0 =A0and =A0 =A0$0xffff=
e000,%eax<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root_stall_after_handler()=
;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__ipipe_check_root_=
resched())<br>
&gt; c10751c7: =A0 =A0 83 78 14 00 =A0 =A0 =A0 =A0 =A0 =A0 cmpl =A0 $0x0,0x=
14(%eax)<br>
&gt; c10751cb: =A0 =A0 75 58 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jne =A0 =
=A0c1075225 &lt;__xirq_end+0x2&gt;<br>
&gt; c10751cd: =A0 =A0 f6 40 08 08 =A0 =A0 =A0 =A0 =A0 =A0 testb =A0$0x8,0x=
8(%eax)<br>
&gt; c10751d1: =A0 =A0 74 52 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 je =A0 =A0=
 c1075225 &lt;__xirq_end+0x2&gt;<br>
&gt; c10751d3: =A0 =A0 eb f8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jmp =A0 =
=A0c10751cd &lt;__ipipe_sync_stage+0x12b&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ipipe_pr=
eempt_schedule_irq();<br>
<br>
</div>Looks like an infinite loop when CONFIG_PREEMPT is off. Try putting a=
n<br>
#ifdef CONFIG_PREEMPT around this code:<br>
<br>
#ifdef CONFIG_PREEMPT<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (__ipipe_check_root_r=
esched())<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ipipe_pre=
empt_schedule_irq();<br>
#endif<br>
<br>
To test that this is indeed the issue, you may try enabling<br>
CONFIG_PREEMPT in the code.=A0</blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
=A0</blockquote><div>I recompiled the kernel enabling CONFIG_PREEMPT and it=
 worked, also i tried the other option, where i add the #ifdef CONFIG_PREEM=
PT to the source of core.c, and it also worked.</div>



<div><br></div><div>So it seems that was the problem. Now i can run trivial=
_periodic.</div><div><br></div><div>But after some time with the kernel aft=
er running trivial_periodic, the machines still freezes, i will try to see =
where the failure is happening now.</div>

<div><br></div><div>Which type of preemption model its preferred? i mean, u=
sing the CONFIG_PREEMPT enabled or without the:</div><div>=A0=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__ipipe_check_root_resched())<br>=A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ipipe_preempt=
_schedule_irq();</div>

<div><br></div><div>Thanks again.</div><div>=A0</div></div>-- <br><div>Osca=
r D=E1vila Ram=EDrez<br></div><br>

--14dae93996cd7a264604ba8a70b8--


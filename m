MIME-Version: 1.0
In-Reply-To: <4F4E87C2.3070106@domain.hid>
References: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>
	<4F4E630C.8020301@domain.hid>
	<CAEc6OSypUWu3PmMy0HKzTipyrQsU-PDoQYAdH7BeMo+5gCh0uA@mail.gmail.com>
	<4F4E680C.1000602@domain.hid>
	<CAEc6OSwe8WO=FRh9e7TSfSjVw5kbGphUYCQA4hjkzXbn8kCgRg@domain.hid>
	<4F4E712F.7050104@domain.hid>
	<CAEc6OSwv_h6Rmv8FhLPhbgCQs-hmzCX+9COXj_T8nYLH0yhbaw@domain.hid>
	<4F4E8112.6060909@domain.hid>
	<CAEc6OSyVayLDKw=rfQu7PbQhothpa3-pGvnRtq=7C-BxhOeYdw@domain.hid>
	<4F4E87C2.3070106@domain.hid>
Date: Wed, 29 Feb 2012 21:42:16 +0100
Message-ID: <CAEc6OSxGsg9iKPe2P=fb8zRDsQkOOmq14-xVOH2Xmf=ZDGv4xg@domain.hid>
From: Charles Lesire-Cabaniols <charles.lesire@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8f2345670bb7dc04ba2061e8
Subject: Re: [Xenomai-help] Execution time profiling
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

--e89a8f2345670bb7dc04ba2061e8
Content-Type: text/plain; charset=UTF-8

2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 02/29/2012 08:59 PM, Charles Lesire-Cabaniols wrote:
> > 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 02/29/2012 08:44 PM, Charles Lesire-Cabaniols wrote:
> >>> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >>>
> >>>> On 02/29/2012 07:03 PM, Charles Lesire-Cabaniols wrote:
> >>>>> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >>>>>
> >>>>>> On 02/29/2012 06:52 PM, Charles Lesire-Cabaniols wrote:
> >>>>>>> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >>>>>>>
> >>>>>>>> On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:
> >>>>>>>>> Hi guys,
> >>>>>>>>>
> >>>>>>>>> I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.
> >>>>>>>>>
> >>>>>>>>> I want to evaluate the execution time of a simple program,
> executed
> >>>> as
> >>>>>> a
> >>>>>>>>> real-time thread.
> >>>>>>>>>
> >>>>>>>>> I definitely wonder about which functions to use, as I have
> >>>> completely
> >>>>>>>>> inconsistent measures.
> >>>>>>>>> I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.
> >>>>>>>>> I also directly read the CNNT register with ARM instructions
> (which
> >>>> is
> >>>>>>>> the
> >>>>>>>>> only one I think correct) in order to have a (good?) reference.
> >>>>>>>>> (...)
> >>>>>>>>> What am I doing wrong?
> >>>>>>>>
> >>>>>>>> So, you should printf("%Lu %Lu\n", rt_timer_read(),
> rt_timer_tsc());
> >>>>>>>>
> >>>>>>>> Not printf("%lu", ...)
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>>                                            Gilles.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Effectively, that looks cleaner, thanks:
> >>>>>>>
> >>>>>>> ----- Xenomai rt_timer_read -----
> >>>>>>> start: 49166276042 ; end: 49166432273 ; (s-e): 156231 ; CET: 156231
> >>>>>>> ----- Xenomai rt_timer_tsc -----
> >>>>>>> start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992
> >>>>>>> ----- Xenomai clock_gettime -----
> >>>>>>> [ s] start: 946684855 ; end: 946684855 ; (s-e): 0 ; CET: 0
> >>>>>>> [ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET:
> 156844
> >>>>>>>
> >>>>>>> My ARM instruction reads 110554.
> >>>>>>>
> >>>>>>> Which Xenomai function should I use?
> >>>>>>> Which one is supposed to be the more accurate?
> >>>>>>> Does rt_timer_read return nsecs?
> >>>>>>> What is the unit of rt_timer_tsc?
> >>>>>>
> >>>>>> rt_timer_tsc uses whatever hardware counter is available, you need
> >>>>>> rt_timer_tsc2ns or rt_timer_ns2tsc to convert between this unit to
> and
> >>>>>> from nanoseconds.
> >>>>>>
> >>>>>> For more details, see:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>
> >>
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__timer.html
> >>>>>>
> >>>>>> Depending on how xenomai user-space was compiled, rt_timer_tsc
> should
> >>>>>> have the lowest overhead.
> >>>>>>
> >>>>>
> >>>>> And are the default options the best ones?
> >>>>
> >>>> Yes, but I am not sure the debian package uses the default one. Please
> >>>> post here the disassembly of rt_timer_tsc, I will tell you if your
> >>>> system is compiled for the lowest overhead.
> >>>>
> >>>>
> >>> How to do that?
> >>
> >> arm-none-linux-objdump -d /path/to/libnative.so.3 | less
> >> search <rt_timer_tsc>, when you find it, post the disassembly here.
> >>
> >
> > Here it is:
> >
> > 00005a54 <rt_timer_tsc>:
> >     5a54:       e59f2034        ldr     r2, [pc, #52]   ; 5a90
> > <rt_timer_tsc+0x3c>
> >     5a58:       e3e03a0f        mvn     r3, #61440      ; 0xf000
> >     5a5c:       e59f1030        ldr     r1, [pc, #48]   ; 5a94
> > <rt_timer_tsc+0x40>
> >     5a60:       e08f2002        add     r2, pc, r2
> >     5a64:       e5133003        ldr     r3, [r3, #-3]
> >     5a68:       e7921001        ldr     r1, [r2, r1]
> >     5a6c:       e59f0024        ldr     r0, [pc, #36]   ; 5a98
> > <rt_timer_tsc+0x44>
> >     5a70:       e2833003        add     r3, r3, #3
> >     5a74:       e0403283        sub     r3, r0, r3, lsl #5
> >     5a78:       e92d4010        push    {r4, lr}
> >     5a7c:       e5910008        ldr     r0, [r1, #8]
> >     5a80:       e1a0e00f        mov     lr, pc
> >     5a84:       e12fff13        bx      r3
> >     5a88:       e8bd4010        pop     {r4, lr}
> >     5a8c:       e12fff1e        bx      lr
> >     5a90:       000086a4        andeq   r8, r0, r4, lsr #13
> >     5a94:       000000ec        andeq   r0, r0, ip, ror #1
> >     5a98:       ffff1004        undefined instruction 0xffff1004
>
> This is the good one.
>
> --
>                                                                Gilles.
>

Ok, thanks Gilles. Now I am more confident in my measurements! :)

Charles

--e89a8f2345670bb7dc04ba2061e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/2/29 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 02/29/2012 08:59 PM, Charles Les=
ire-Cabaniols wrote:<br>
&gt; 2012/2/29 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; On 02/29/2012 08:44 PM, Charles Lesire-Cabaniols wrote:<br>
&gt;&gt;&gt; 2012/2/29 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 02/29/2012 07:03 PM, Charles Lesire-Cabaniols wrote:<br=
>
&gt;&gt;&gt;&gt;&gt; 2012/2/29 Gilles Chanteperdrix &lt;<a href=3D"mailto:g=
illes.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<b=
r>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 02/29/2012 06:52 PM, Charles Lesire-Cabaniols w=
rote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2012/2/29 Gilles Chanteperdrix &lt;<a href=3D"=
mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</=
a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 02/29/2012 06:29 PM, Charles Lesire-Cab=
aniols wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi guys,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I have installed a Debian+Xenomai (2.6=
.0) OS on my Gumstix Overo.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I want to evaluate the execution time =
of a simple program, executed<br>
&gt;&gt;&gt;&gt; as<br>
&gt;&gt;&gt;&gt;&gt;&gt; a<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; real-time thread.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I definitely wonder about which functi=
ons to use, as I have<br>
&gt;&gt;&gt;&gt; completely<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; inconsistent measures.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I have tried using rt_timer_read, rt_t=
imer_tsc, clock_gettime.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I also directly read the CNNT register=
 with ARM instructions (which<br>
&gt;&gt;&gt;&gt; is<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; only one I think correct) in order to =
have a (good?) reference.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; (...)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; What am I doing wrong?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; So, you should printf(&quot;%Lu %Lu\n&quot=
;, rt_timer_read(), rt_timer_tsc());<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Not printf(&quot;%lu&quot;, ...)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gilles.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Effectively, that looks cleaner, thanks:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----- Xenomai rt_timer_read -----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; start: 49166276042 ; end: 49166432273 ; (s-e):=
 156231 ; CET: 156231<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----- Xenomai rt_timer_tsc -----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; start: 639161547 ; end: 639163539 ; (s-e): 199=
2 ; CET: 1992<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ----- Xenomai clock_gettime -----<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; [ s] start: 946684855 ; end: 946684855 ; (s-e)=
: 0 ; CET: 0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; [ns] start: 275520245 ; end: 275677089 ; (s-e)=
: 156844 ; CET: 156844<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; My ARM instruction reads 110554.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Which Xenomai function should I use?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Which one is supposed to be the more accurate?=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Does rt_timer_read return nsecs?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; What is the unit of rt_timer_tsc?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; rt_timer_tsc uses whatever hardware counter is ava=
ilable, you need<br>
&gt;&gt;&gt;&gt;&gt;&gt; rt_timer_tsc2ns or rt_timer_ns2tsc to convert betw=
een this unit to and<br>
&gt;&gt;&gt;&gt;&gt;&gt; from nanoseconds.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; For more details, see:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.xenomai.org/documentation/xenomai-2.6/html/a=
pi/group__native__timer.html" target=3D"_blank">http://www.xenomai.org/docu=
mentation/xenomai-2.6/html/api/group__native__timer.html</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Depending on how xenomai user-space was compiled, =
rt_timer_tsc should<br>
&gt;&gt;&gt;&gt;&gt;&gt; have the lowest overhead.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; And are the default options the best ones?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Yes, but I am not sure the debian package uses the default=
 one. Please<br>
&gt;&gt;&gt;&gt; post here the disassembly of rt_timer_tsc, I will tell you=
 if your<br>
&gt;&gt;&gt;&gt; system is compiled for the lowest overhead.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; How to do that?<br>
&gt;&gt;<br>
&gt;&gt; arm-none-linux-objdump -d /path/to/libnative.so.3 | less<br>
&gt;&gt; search &lt;rt_timer_tsc&gt;, when you find it, post the disassembl=
y here.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Here it is:<br>
&gt;<br>
&gt; 00005a54 &lt;rt_timer_tsc&gt;:<br>
&gt; =C2=A0 =C2=A0 5a54: =C2=A0 =C2=A0 =C2=A0 e59f2034 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ldr =C2=A0 =C2=A0 r2, [pc, #52] =C2=A0 ; 5a90<br>
&gt; &lt;rt_timer_tsc+0x3c&gt;<br>
&gt; =C2=A0 =C2=A0 5a58: =C2=A0 =C2=A0 =C2=A0 e3e03a0f =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mvn =C2=A0 =C2=A0 r3, #61440 =C2=A0 =C2=A0 =C2=A0; 0xf000<br>
&gt; =C2=A0 =C2=A0 5a5c: =C2=A0 =C2=A0 =C2=A0 e59f1030 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ldr =C2=A0 =C2=A0 r1, [pc, #48] =C2=A0 ; 5a94<br>
&gt; &lt;rt_timer_tsc+0x40&gt;<br>
&gt; =C2=A0 =C2=A0 5a60: =C2=A0 =C2=A0 =C2=A0 e08f2002 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0add =C2=A0 =C2=A0 r2, pc, r2<br>
&gt; =C2=A0 =C2=A0 5a64: =C2=A0 =C2=A0 =C2=A0 e5133003 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ldr =C2=A0 =C2=A0 r3, [r3, #-3]<br>
&gt; =C2=A0 =C2=A0 5a68: =C2=A0 =C2=A0 =C2=A0 e7921001 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ldr =C2=A0 =C2=A0 r1, [r2, r1]<br>
&gt; =C2=A0 =C2=A0 5a6c: =C2=A0 =C2=A0 =C2=A0 e59f0024 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ldr =C2=A0 =C2=A0 r0, [pc, #36] =C2=A0 ; 5a98<br>
&gt; &lt;rt_timer_tsc+0x44&gt;<br>
&gt; =C2=A0 =C2=A0 5a70: =C2=A0 =C2=A0 =C2=A0 e2833003 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0add =C2=A0 =C2=A0 r3, r3, #3<br>
&gt; =C2=A0 =C2=A0 5a74: =C2=A0 =C2=A0 =C2=A0 e0403283 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sub =C2=A0 =C2=A0 r3, r0, r3, lsl #5<br>
&gt; =C2=A0 =C2=A0 5a78: =C2=A0 =C2=A0 =C2=A0 e92d4010 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0push =C2=A0 =C2=A0{r4, lr}<br>
&gt; =C2=A0 =C2=A0 5a7c: =C2=A0 =C2=A0 =C2=A0 e5910008 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ldr =C2=A0 =C2=A0 r0, [r1, #8]<br>
&gt; =C2=A0 =C2=A0 5a80: =C2=A0 =C2=A0 =C2=A0 e1a0e00f =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mov =C2=A0 =C2=A0 lr, pc<br>
&gt; =C2=A0 =C2=A0 5a84: =C2=A0 =C2=A0 =C2=A0 e12fff13 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bx =C2=A0 =C2=A0 =C2=A0r3<br>
&gt; =C2=A0 =C2=A0 5a88: =C2=A0 =C2=A0 =C2=A0 e8bd4010 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pop =C2=A0 =C2=A0 {r4, lr}<br>
&gt; =C2=A0 =C2=A0 5a8c: =C2=A0 =C2=A0 =C2=A0 e12fff1e =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bx =C2=A0 =C2=A0 =C2=A0lr<br>
&gt; =C2=A0 =C2=A0 5a90: =C2=A0 =C2=A0 =C2=A0 000086a4 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0andeq =C2=A0 r8, r0, r4, lsr #13<br>
&gt; =C2=A0 =C2=A0 5a94: =C2=A0 =C2=A0 =C2=A0 000000ec =C2=A0 =C2=A0 =C2=A0=
 =C2=A0andeq =C2=A0 r0, r0, ip, ror #1<br>
&gt; =C2=A0 =C2=A0 5a98: =C2=A0 =C2=A0 =C2=A0 ffff1004 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0undefined instruction 0xffff1004<br>
<br>
</div></div>This is the good one.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Gilles.<br>
</font></span></blockquote></div><br>Ok, thanks Gilles. Now I am more confi=
dent in my measurements! :)<br><br>Charles<br>

--e89a8f2345670bb7dc04ba2061e8--


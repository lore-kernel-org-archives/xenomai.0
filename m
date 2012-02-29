MIME-Version: 1.0
In-Reply-To: <4F4E712F.7050104@domain.hid>
References: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>
	<4F4E630C.8020301@domain.hid>
	<CAEc6OSypUWu3PmMy0HKzTipyrQsU-PDoQYAdH7BeMo+5gCh0uA@mail.gmail.com>
	<4F4E680C.1000602@domain.hid>
	<CAEc6OSwe8WO=FRh9e7TSfSjVw5kbGphUYCQA4hjkzXbn8kCgRg@domain.hid>
	<4F4E712F.7050104@domain.hid>
Date: Wed, 29 Feb 2012 20:44:54 +0100
Message-ID: <CAEc6OSwv_h6Rmv8FhLPhbgCQs-hmzCX+9COXj_T8nYLH0yhbaw@domain.hid>
From: Charles Lesire-Cabaniols <charles.lesire@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec554d9e2e4ab9204ba1f9389
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

--bcaec554d9e2e4ab9204ba1f9389
Content-Type: text/plain; charset=UTF-8

2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 02/29/2012 07:03 PM, Charles Lesire-Cabaniols wrote:
> > 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 02/29/2012 06:52 PM, Charles Lesire-Cabaniols wrote:
> >>> 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >>>
> >>>> On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:
> >>>>> Hi guys,
> >>>>>
> >>>>> I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.
> >>>>>
> >>>>> I want to evaluate the execution time of a simple program, executed
> as
> >> a
> >>>>> real-time thread.
> >>>>>
> >>>>> I definitely wonder about which functions to use, as I have
> completely
> >>>>> inconsistent measures.
> >>>>> I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.
> >>>>> I also directly read the CNNT register with ARM instructions (which
> is
> >>>> the
> >>>>> only one I think correct) in order to have a (good?) reference.
> >>>>> (...)
> >>>>> What am I doing wrong?
> >>>>
> >>>> So, you should printf("%Lu %Lu\n", rt_timer_read(), rt_timer_tsc());
> >>>>
> >>>> Not printf("%lu", ...)
> >>>>
> >>>> --
> >>>>                                            Gilles.
> >>>>
> >>>
> >>> Effectively, that looks cleaner, thanks:
> >>>
> >>> ----- Xenomai rt_timer_read -----
> >>> start: 49166276042 ; end: 49166432273 ; (s-e): 156231 ; CET: 156231
> >>> ----- Xenomai rt_timer_tsc -----
> >>> start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992
> >>> ----- Xenomai clock_gettime -----
> >>> [ s] start: 946684855 ; end: 946684855 ; (s-e): 0 ; CET: 0
> >>> [ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET: 156844
> >>>
> >>> My ARM instruction reads 110554.
> >>>
> >>> Which Xenomai function should I use?
> >>> Which one is supposed to be the more accurate?
> >>> Does rt_timer_read return nsecs?
> >>> What is the unit of rt_timer_tsc?
> >>
> >> rt_timer_tsc uses whatever hardware counter is available, you need
> >> rt_timer_tsc2ns or rt_timer_ns2tsc to convert between this unit to and
> >> from nanoseconds.
> >>
> >> For more details, see:
> >>
> >>
> >>
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__timer.html
> >>
> >> Depending on how xenomai user-space was compiled, rt_timer_tsc should
> >> have the lowest overhead.
> >>
> >
> > And are the default options the best ones?
>
> Yes, but I am not sure the debian package uses the default one. Please
> post here the disassembly of rt_timer_tsc, I will tell you if your
> system is compiled for the lowest overhead.
>
>
How to do that?


> > How can I tune the TSC performance?
>
> You use the --enable-arm-tsc or --disable-arm-tsc option of xenomai
> configure script. The default is --enable-arm-tsc=kuser and should be
> the best option. If you pass --disable-arm-tsc, rt_timer_tsc will emit a
> system call.
>
>
I do not use the debian package, but I compile Xenomai from sources ;
actually I have a vanilla kernel and a debain rootfs.
I think --enable-arm-tsc is the default then.


> --
>                                                                Gilles.
>

--bcaec554d9e2e4ab9204ba1f9389
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/2/29 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 02/29/2012 07:03 PM, Charles Les=
ire-Cabaniols wrote:<br>
&gt; 2012/2/29 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; On 02/29/2012 06:52 PM, Charles Lesire-Cabaniols wrote:<br>
&gt;&gt;&gt; 2012/2/29 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:<br=
>
&gt;&gt;&gt;&gt;&gt; Hi guys,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I have installed a Debian+Xenomai (2.6.0) OS on my Gum=
stix Overo.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I want to evaluate the execution time of a simple prog=
ram, executed as<br>
&gt;&gt; a<br>
&gt;&gt;&gt;&gt;&gt; real-time thread.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I definitely wonder about which functions to use, as I=
 have completely<br>
&gt;&gt;&gt;&gt;&gt; inconsistent measures.<br>
&gt;&gt;&gt;&gt;&gt; I have tried using rt_timer_read, rt_timer_tsc, clock_=
gettime.<br>
&gt;&gt;&gt;&gt;&gt; I also directly read the CNNT register with ARM instru=
ctions (which is<br>
&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt; only one I think correct) in order to have a (good?) r=
eference.<br>
&gt;&gt;&gt;&gt;&gt; (...)<br>
&gt;&gt;&gt;&gt;&gt; What am I doing wrong?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; So, you should printf(&quot;%Lu %Lu\n&quot;, rt_timer_read=
(), rt_timer_tsc());<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Not printf(&quot;%lu&quot;, ...)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Gilles.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Effectively, that looks cleaner, thanks:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ----- Xenomai rt_timer_read -----<br>
&gt;&gt;&gt; start: 49166276042 ; end: 49166432273 ; (s-e): 156231 ; CET: 1=
56231<br>
&gt;&gt;&gt; ----- Xenomai rt_timer_tsc -----<br>
&gt;&gt;&gt; start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992<br=
>
&gt;&gt;&gt; ----- Xenomai clock_gettime -----<br>
&gt;&gt;&gt; [ s] start: 946684855 ; end: 946684855 ; (s-e): 0 ; CET: 0<br>
&gt;&gt;&gt; [ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET: =
156844<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; My ARM instruction reads 110554.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Which Xenomai function should I use?<br>
&gt;&gt;&gt; Which one is supposed to be the more accurate?<br>
&gt;&gt;&gt; Does rt_timer_read return nsecs?<br>
&gt;&gt;&gt; What is the unit of rt_timer_tsc?<br>
&gt;&gt;<br>
&gt;&gt; rt_timer_tsc uses whatever hardware counter is available, you need=
<br>
&gt;&gt; rt_timer_tsc2ns or rt_timer_ns2tsc to convert between this unit to=
 and<br>
&gt;&gt; from nanoseconds.<br>
&gt;&gt;<br>
&gt;&gt; For more details, see:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.xenomai.org/documentation/xenomai-2.6/html/a=
pi/group__native__timer.html" target=3D"_blank">http://www.xenomai.org/docu=
mentation/xenomai-2.6/html/api/group__native__timer.html</a><br>
&gt;&gt;<br>
&gt;&gt; Depending on how xenomai user-space was compiled, rt_timer_tsc sho=
uld<br>
&gt;&gt; have the lowest overhead.<br>
&gt;&gt;<br>
&gt;<br>
&gt; And are the default options the best ones?<br>
<br>
</div></div>Yes, but I am not sure the debian package uses the default one.=
 Please<br>
post here the disassembly of rt_timer_tsc, I will tell you if your<br>
system is compiled for the lowest overhead.<br>
<div class=3D"im"><br></div></blockquote><div><br>How to do that?<br>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"im">
&gt; How can I tune the TSC performance?<br>
<br>
</div>You use the --enable-arm-tsc or --disable-arm-tsc option of xenomai<b=
r>
configure script. The default is --enable-arm-tsc=3Dkuser and should be<br>
the best option. If you pass --disable-arm-tsc, rt_timer_tsc will emit a<br=
>
system call.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br>I do not use the debian package, but I compile Xenomai from sou=
rces ; actually I have a vanilla kernel and a debain rootfs.<br>I think --e=
nable-arm-tsc is the default then.<br>
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"HOEnZb"><font color=3D"#888888">
--<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Gilles.<br>
</font></span></blockquote></div><br>

--bcaec554d9e2e4ab9204ba1f9389--


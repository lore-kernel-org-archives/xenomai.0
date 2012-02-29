MIME-Version: 1.0
In-Reply-To: <4F4E680C.1000602@domain.hid>
References: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>
	<4F4E630C.8020301@domain.hid>
	<CAEc6OSypUWu3PmMy0HKzTipyrQsU-PDoQYAdH7BeMo+5gCh0uA@mail.gmail.com>
	<4F4E680C.1000602@domain.hid>
Date: Wed, 29 Feb 2012 19:03:28 +0100
Message-ID: <CAEc6OSwe8WO=FRh9e7TSfSjVw5kbGphUYCQA4hjkzXbn8kCgRg@domain.hid>
From: Charles Lesire-Cabaniols <charles.lesire@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4efe34fa1bf47f04ba1e297f
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

--e0cb4efe34fa1bf47f04ba1e297f
Content-Type: text/plain; charset=UTF-8

2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 02/29/2012 06:52 PM, Charles Lesire-Cabaniols wrote:
> > 2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:
> >>> Hi guys,
> >>>
> >>> I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.
> >>>
> >>> I want to evaluate the execution time of a simple program, executed as
> a
> >>> real-time thread.
> >>>
> >>> I definitely wonder about which functions to use, as I have completely
> >>> inconsistent measures.
> >>> I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.
> >>> I also directly read the CNNT register with ARM instructions (which is
> >> the
> >>> only one I think correct) in order to have a (good?) reference.
> >>> (...)
> >>> What am I doing wrong?
> >>
> >> So, you should printf("%Lu %Lu\n", rt_timer_read(), rt_timer_tsc());
> >>
> >> Not printf("%lu", ...)
> >>
> >> --
> >>                                            Gilles.
> >>
> >
> > Effectively, that looks cleaner, thanks:
> >
> > ----- Xenomai rt_timer_read -----
> > start: 49166276042 ; end: 49166432273 ; (s-e): 156231 ; CET: 156231
> > ----- Xenomai rt_timer_tsc -----
> > start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992
> > ----- Xenomai clock_gettime -----
> > [ s] start: 946684855 ; end: 946684855 ; (s-e): 0 ; CET: 0
> > [ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET: 156844
> >
> > My ARM instruction reads 110554.
> >
> > Which Xenomai function should I use?
> > Which one is supposed to be the more accurate?
> > Does rt_timer_read return nsecs?
> > What is the unit of rt_timer_tsc?
>
> rt_timer_tsc uses whatever hardware counter is available, you need
> rt_timer_tsc2ns or rt_timer_ns2tsc to convert between this unit to and
> from nanoseconds.
>
> For more details, see:
>
>
> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__timer.html
>
> Depending on how xenomai user-space was compiled, rt_timer_tsc should
> have the lowest overhead.
>

And are the default options the best ones?
How can I tune the TSC performance?



>
> --
>                                            Gilles.
>

--e0cb4efe34fa1bf47f04ba1e297f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/2/29 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 02/29/2012 06:52 PM, Charles Les=
ire-Cabaniols wrote:<br>
&gt; 2012/2/29 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:<br>
&gt;&gt;&gt; Hi guys,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Ove=
ro.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I want to evaluate the execution time of a simple program, exe=
cuted as a<br>
&gt;&gt;&gt; real-time thread.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I definitely wonder about which functions to use, as I have co=
mpletely<br>
&gt;&gt;&gt; inconsistent measures.<br>
&gt;&gt;&gt; I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.=
<br>
&gt;&gt;&gt; I also directly read the CNNT register with ARM instructions (=
which is<br>
&gt;&gt; the<br>
&gt;&gt;&gt; only one I think correct) in order to have a (good?) reference=
.<br>
&gt;&gt;&gt; (...)<br>
&gt;&gt;&gt; What am I doing wrong?<br>
&gt;&gt;<br>
&gt;&gt; So, you should printf(&quot;%Lu %Lu\n&quot;, rt_timer_read(), rt_t=
imer_tsc());<br>
&gt;&gt;<br>
&gt;&gt; Not printf(&quot;%lu&quot;, ...)<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Gilles.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Effectively, that looks cleaner, thanks:<br>
&gt;<br>
&gt; ----- Xenomai rt_timer_read -----<br>
&gt; start: 49166276042 ; end: 49166432273 ; (s-e): 156231 ; CET: 156231<br=
>
&gt; ----- Xenomai rt_timer_tsc -----<br>
&gt; start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992<br>
&gt; ----- Xenomai clock_gettime -----<br>
&gt; [ s] start: 946684855 ; end: 946684855 ; (s-e): 0 ; CET: 0<br>
&gt; [ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET: 156844<b=
r>
&gt;<br>
&gt; My ARM instruction reads 110554.<br>
&gt;<br>
&gt; Which Xenomai function should I use?<br>
&gt; Which one is supposed to be the more accurate?<br>
&gt; Does rt_timer_read return nsecs?<br>
&gt; What is the unit of rt_timer_tsc?<br>
<br>
</div></div>rt_timer_tsc uses whatever hardware counter is available, you n=
eed<br>
rt_timer_tsc2ns or rt_timer_ns2tsc to convert between this unit to and<br>
from nanoseconds.<br>
<br>
For more details, see:<br>
<br>
<a href=3D"http://www.xenomai.org/documentation/xenomai-2.6/html/api/group_=
_native__timer.html" target=3D"_blank">http://www.xenomai.org/documentation=
/xenomai-2.6/html/api/group__native__timer.html</a><br>
<br>
Depending on how xenomai user-space was compiled, rt_timer_tsc should<br>
have the lowest overhead.<br></blockquote><div><br>And are the default opti=
ons the best ones?<br>How can I tune the TSC performance?<br><br>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">

<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Gilles.<br>
</font></span></blockquote></div><br>

--e0cb4efe34fa1bf47f04ba1e297f--


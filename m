MIME-Version: 1.0
In-Reply-To: <4F4E630C.8020301@domain.hid>
References: <CAEc6OSwfGvfwXM3vqtAXd7o_XeMhSmuvj8mkd8ziLXQSMyK0aA@mail.gmail.com>
	<4F4E630C.8020301@domain.hid>
Date: Wed, 29 Feb 2012 18:52:58 +0100
Message-ID: <CAEc6OSypUWu3PmMy0HKzTipyrQsU-PDoQYAdH7BeMo+5gCh0uA@mail.gmail.com>
From: Charles Lesire-Cabaniols <charles.lesire@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec54ee4a08f49f004ba1e03b4
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

--bcaec54ee4a08f49f004ba1e03b4
Content-Type: text/plain; charset=UTF-8

2012/2/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:
> > Hi guys,
> >
> > I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.
> >
> > I want to evaluate the execution time of a simple program, executed as a
> > real-time thread.
> >
> > I definitely wonder about which functions to use, as I have completely
> > inconsistent measures.
> > I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.
> > I also directly read the CNNT register with ARM instructions (which is
> the
> > only one I think correct) in order to have a (good?) reference.
> > (...)
> > What am I doing wrong?
>
> So, you should printf("%Lu %Lu\n", rt_timer_read(), rt_timer_tsc());
>
> Not printf("%lu", ...)
>
> --
>                                            Gilles.
>

Effectively, that looks cleaner, thanks:

----- Xenomai rt_timer_read -----
start: 49166276042 ; end: 49166432273 ; (s-e): 156231 ; CET: 156231
----- Xenomai rt_timer_tsc -----
start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992
----- Xenomai clock_gettime -----
[ s] start: 946684855 ; end: 946684855 ; (s-e): 0 ; CET: 0
[ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET: 156844

My ARM instruction reads 110554.

Which Xenomai function should I use?
Which one is supposed to be the more accurate?
Does rt_timer_read return nsecs?
What is the unit of rt_timer_tsc?

Charles.

--bcaec54ee4a08f49f004ba1e03b4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/2/29 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On 02/29/2012 06:29 PM, Charles Lesire-Cabaniols wrote:<b=
r>
&gt; Hi guys,<br>
&gt;<br>
&gt; I have installed a Debian+Xenomai (2.6.0) OS on my Gumstix Overo.<br>
&gt;<br>
&gt; I want to evaluate the execution time of a simple program, executed as=
 a<br>
&gt; real-time thread.<br>
&gt;<br>
&gt; I definitely wonder about which functions to use, as I have completely=
<br>
&gt; inconsistent measures.<br>
&gt; I have tried using rt_timer_read, rt_timer_tsc, clock_gettime.<br>
&gt; I also directly read the CNNT register with ARM instructions (which is=
 the<br>
&gt; only one I think correct) in order to have a (good?) reference.<br>
</div>&gt; (...)<br>
<div class=3D"im">&gt; What am I doing wrong?<br>
<br>
</div>So, you should printf(&quot;%Lu %Lu\n&quot;, rt_timer_read(), rt_time=
r_tsc());<br>
<br>
Not printf(&quot;%lu&quot;, ...)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Gilles.<br>
</font></span></blockquote></div><br>Effectively, that looks cleaner, thank=
s:<br><br>----- Xenomai rt_timer_read -----<br>start: 49166276042 ; end: 49=
166432273 ; (s-e): 156231 ; CET: 156231 <br>----- Xenomai rt_timer_tsc ----=
-<br>
start: 639161547 ; end: 639163539 ; (s-e): 1992 ; CET: 1992 <br>----- Xenom=
ai clock_gettime -----<br>[ s] start: 946684855 ; end: 946684855 ; (s-e): 0=
 ; CET: 0 <br>[ns] start: 275520245 ; end: 275677089 ; (s-e): 156844 ; CET:=
 156844 <br>
<br>My ARM instruction reads 110554.<br><br>Which Xenomai function should I=
 use?<br>Which one is supposed to be the more accurate?<br>Does rt_timer_re=
ad return nsecs?<br>What is the unit of rt_timer_tsc?<br><br>Charles.<br>

--bcaec54ee4a08f49f004ba1e03b4--


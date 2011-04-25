MIME-Version: 1.0
In-Reply-To: <4DB3479B.20609@domain.hid>
References: <BANLkTim3Z6v5Jr+O8197WZZAOpHsPwjwPA@mail.gmail.com>
	<4DB3479B.20609@domain.hid>
Date: Mon, 25 Apr 2011 11:23:07 -0400
Message-ID: <BANLkTik0RVY7wtUSekBT-x4t-4qCWrFawA@mail.gmail.com>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: multipart/alternative; boundary=0023545bde24de79fd04a1bfc8e5
Subject: Re: [Xenomai-help] FAQ, context switch latency
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

--0023545bde24de79fd04a1bfc8e5
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Apr 23, 2011 at 5:41 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Eric Eric wrote:
> > Hello, I've asked a lot of questions here and gotten very prompt and
> helpful
> > responses, so I summarized them in a FAQ since I figure others may have
> > similar questions.  See http://ericrebates.zzl.org/xen_faq.txt .  If
> this
> > seems useful maybe someone can append them to the end of the wiki FAQ.
>
> I am not sure all questions really are really that frequent, but yes, we
> should add some to the FAQ. Would you be willing to do it? If yes, I
> will give you write access to the wiki.
>

Sure.  Maybe the best approach is to create a link from the FAQ to an LFAQ
(less frequently asked questions) so as not to add a bunch of questions that
don't apply to most people.


>
> >
> > On another note, I have been comparing Xenomai's context switch latency
> to
> > GHS Integrity.  I found that on average Xenomai seems to take three times
> as
> > long to context switch versus Integrity (12uS vs. 4uS) running almost
> > identical test code.  Does anyone know why this may be or how to reduce
> this
> > latency in Xenomai?  Since it appears Gilles helped implement the fast
> > context switching extension for the Linux kernel, I'm assuming Xenomai is
> > also taking advantage of this extension.
>
> I assume you are measuring context switch times in kernel-space, then
> FCSE will not help you, FCSE helps for MMU context switches.


Right, didn't think about that.  I suppose FCSE will also not help with
context switches between threads of the same process either.


> And if you
> are testing on omap3, FCSE is not implemented for omap3. Do you have
> unlocked context switch enabled ?
>

Unlocked context switch is enabled.


> What I-pipe patch version are you using?
>

2.6.33-arm-1.18-00


>
> You can probably reduce a bit the time by using rt_timer_tsc() or even
> xnarch_get_cpu_tsc() to do the measurements, then rt_timer_tsc2ns after
> the second measurement, but I am afraid you will not go as low as 4us.
>

I will try this although I doubt it will have much impact.  I say that
because I also used rtdm_clock_read_monotonic to benchmark mutex lock/unlock
cycles, and got down to 2uS in that measurement, which seems to imply that
the overhead of rtdm_clock_read_monotonic is small compared to 12uS.


> You can also try and enable the I-pipe tracer to see where the time is
> spent, but beware of the time dilation...
>

This seems like an interesting idea.  What is the time dilation issue?


>
> --
>                                                                 Gilles.
>

--0023545bde24de79fd04a1bfc8e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 23, 2011 at 5:41 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
enomai.org</a>&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px =
solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">Eric Eric wrote:<br>
&gt; Hello, I&#39;ve asked a lot of questions here and gotten very prompt a=
nd helpful<br>
&gt; responses, so I summarized them in a FAQ since I figure others may hav=
e<br>
&gt; similar questions. =A0See <a href=3D"http://ericrebates.zzl.org/xen_fa=
q.txt" target=3D"_blank">http://ericrebates.zzl.org/xen_faq.txt</a> . =A0If=
 this<br>
&gt; seems useful maybe someone can append them to the end of the wiki FAQ.=
<br>
<br>
</div>I am not sure all questions really are really that frequent, but yes,=
 we<br>
should add some to the FAQ. Would you be willing to do it? If yes, I<br>
will give you write access to the wiki.<br></blockquote><div><br>Sure.=A0 M=
aybe the best approach is to create a link from the FAQ to an LFAQ (less fr=
equently asked questions) so as not to add a bunch of questions that don&#3=
9;t apply to most people.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im"><br>
&gt;<br>
&gt; On another note, I have been comparing Xenomai&#39;s context switch la=
tency to<br>
&gt; GHS Integrity. =A0I found that on average Xenomai seems to take three =
times as<br>
&gt; long to context switch versus Integrity (12uS vs. 4uS) running almost<=
br>
&gt; identical test code. =A0Does anyone know why this may be or how to red=
uce this<br>
&gt; latency in Xenomai? =A0Since it appears Gilles helped implement the fa=
st<br>
&gt; context switching extension for the Linux kernel, I&#39;m assuming Xen=
omai is<br>
&gt; also taking advantage of this extension.<br>
<br>
</div>I assume you are measuring context switch times in kernel-space, then=
<br>
FCSE will not help you, FCSE helps for MMU context switches. </blockquote><=
div><br>Right, didn&#39;t think about that.=A0 I suppose FCSE will also not=
 help with context switches between threads of the same process either.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">And if y=
ou<br>
are testing on omap3, FCSE is not implemented for omap3. Do you have<br>
unlocked context switch enabled ?<br></blockquote><div><br>Unlocked context=
 switch is enabled.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); paddi=
ng-left: 1ex;">

What I-pipe patch version are you using?<br></blockquote><div><br>2.6.33-ar=
m-1.18-00<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0p=
t 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1=
ex;">

<br>
You can probably reduce a bit the time by using rt_timer_tsc() or even<br>
xnarch_get_cpu_tsc() to do the measurements, then rt_timer_tsc2ns after<br>
the second measurement, but I am afraid you will not go as low as 4us.<br><=
/blockquote><div><br>I will try this although I doubt it will have much imp=
act.=A0 I say that because I also used rtdm_clock_read_monotonic to benchma=
rk mutex lock/unlock cycles, and got down to 2uS in that measurement, which=
 seems to imply that the overhead of rtdm_clock_read_monotonic is small com=
pared to 12uS.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
You can also try and enable the I-pipe tracer to see where the time is<br>
spent, but beware of the time dilation...<br></blockquote><div><br>This see=
ms like an interesting idea.=A0 What is the time dilation issue?<br>=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bor=
der-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--0023545bde24de79fd04a1bfc8e5--


MIME-Version: 1.0
In-Reply-To: <4EA1C2FB.1050009@domain.hid>
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
	<4EA19A9D.1080502@domain.hid>
	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>
	<4EA1B033.6060707@domain.hid>
	<CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>
	<4EA1BE4C.5030301@domain.hid>
	<CAMwkeZzPDN5TFKiU05tuZdW4=yHT1XoWe2=xwceiimRw-rF4_w@domain.hid>
	<4EA1C2FB.1050009@domain.hid>
Date: Fri, 21 Oct 2011 17:15:05 -0200
Message-ID: <CAMwkeZwXzXZrGoXxPxyisOCkekf3jzjWh5pp-Ddv5oj9kL4ZdQ@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5215d7b0e075a04afd3e426
Subject: Re: [Xenomai-help] rt_task_wait_period returns an undocumented value
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
Cc: Xenomai-help@domain.hid

--bcaec5215d7b0e075a04afd3e426
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 21 de octubre de 2011 17:07, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> escribi=C3=B3:

> On 10/21/2011 09:01 PM, Fernando Herrero Carr=C3=B3n wrote:
> > El 21 de octubre de 2011 16:47, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> escribi=C3=B3:
> >> I guess you have to check the code to understand what happens. But
> >> really, running tasks with a 11500 period is already preposterous.
> >
> >
> > It's the very minimal example that I could come up with, I can attach t=
he
> > code if you will. But there is not much more than mlockall(),
> > rt_task_shadow(), rt_task_set_periodic() and
> > while(){rt_tast_wait_period()}...
>
> I mean check xenomai code.
>

Oh, yeah, I will.


> >
> > Why do you mean it is preposterous? Because it is not a round figure or
> > because it is too low? If you mean it is too low, well, I have a DAQ
> board
> > that can make acquisitions at up to 120kHz, which means a period of 800=
0
> ns.
> > I want to achieve the fastest acquistion rate possible, and was pushing
> the
> > limits to see where xenomai could go.
>
> Because it is way too low, you will get a complete lockup of your system
> as soon as you starting putting load on it.
>
>
Ok, thanks for the advice. The computations I will be doing will not be ver=
y
expensive in principle, but I believe the analogy infrastructure is the
actual bottleneck. I have not been able to perform the acquisitions I want
beyond 10kHz. At higher frequencies it looks like analogy does not have
enough time to acknowledge all DMA interruptions. But this is a different
issue.

Best regards,
Fernando

--bcaec5215d7b0e075a04afd3e426
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 21 de octubre de 2011 17:07, Gilles Chanteper=
drix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
rg">gilles.chanteperdrix@xenomai.org</a>&gt;</span> escribi=C3=B3:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 10/21/2011 09:01 PM, Fernando Herrero Carr=C3=B3n wrot=
e:<br>
&gt; El 21 de octubre de 2011 16:47, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; escribi=C3=B3:<br>
&gt;&gt; I guess you have to check the code to understand what happens. But=
<br>
&gt;&gt; really, running tasks with a 11500 period is already preposterous.=
<br>
&gt;<br>
&gt;<br>
&gt; It&#39;s the very minimal example that I could come up with, I can att=
ach the<br>
&gt; code if you will. But there is not much more than mlockall(),<br>
&gt; rt_task_shadow(), rt_task_set_periodic() and<br>
&gt; while(){rt_tast_wait_period()}...<br>
<br>
</div>I mean check xenomai code.<br></blockquote><div><br>Oh, yeah, I will.=
<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt =
0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex=
;"><div class=3D"im">

&gt;<br>
&gt; Why do you mean it is preposterous? Because it is not a round figure o=
r<br>
&gt; because it is too low? If you mean it is too low, well, I have a DAQ b=
oard<br>
&gt; that can make acquisitions at up to 120kHz, which means a period of 80=
00 ns.<br>
&gt; I want to achieve the fastest acquistion rate possible, and was pushin=
g the<br>
&gt; limits to see where xenomai could go.<br>
<br>
</div>Because it is way too low, you will get a complete lockup of your sys=
tem<br>
as soon as you starting putting load on it.<br>
<br></blockquote><div><br>Ok, thanks for the advice. The computations I wil=
l be doing will not be very expensive in principle, but I believe the analo=
gy infrastructure is the actual bottleneck. I have not been able to perform=
 the acquisitions I want beyond 10kHz. At higher frequencies it looks like =
analogy does not have enough time to acknowledge all DMA interruptions. But=
 this is a different issue.<br>
<br>Best regards,<br>Fernando<br></div></div>

--bcaec5215d7b0e075a04afd3e426--


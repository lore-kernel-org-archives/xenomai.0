MIME-Version: 1.0
In-Reply-To: <4E8C3AF9.7070604@domain.hid>
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
	<4E8AEB1D.2060706@domain.hid>
	<CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
	<4E8B0DEA.8030102@domain.hid>
	<CAGc_wL2wb76-t7RBWJnKxgcvsrcKgnFgV4qkjvUgh5AvM7ie3g@domain.hid>
	<4E8B3744.2030407@domain.hid>
	<CAGc_wL2RgNKfMUyQURJ8G2ceaJtvnJL6LpFue3ekuwJ99vwPww@domain.hid>
	<4E8C3AF9.7070604@domain.hid>
Date: Wed, 5 Oct 2011 11:39:39 -0300
Message-ID: <CAMwkeZyDjpqb11NoxUCTxwpmY5RV0bjRzAHG6HeeyW5RvXejDQ@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53af23a8658d304ae8e2d9b
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec53af23a8658d304ae8e2d9b
Content-Type: text/plain; charset=UTF-8

2011/10/5 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 10/05/2011 09:48 AM, Julien Delange wrote:
> > On Tue, Oct 4, 2011 at 12:41 PM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> >> Another mail in that thread seem to suggest that it could be long. Have
> >> you tried timing the various parts of your loop to see where the time is
> >> spent?
> >
> > No, sorry, my bad. Unfortunately, I cannot make more tests at this
> > time because I don't have the hardware.
> > I will do additional investigation soon, I would have access to the
> > acquisition card soon. My intent was to know if there was an obvious
> > error either in my code or in my kernel configuration. Apparently not,
> > so, I will try to figure out the root causes of these issues.
>
> It is my understaning when reading Fernando's answer to your mail that
> you are not using the proper interface for what you are trying to do.
>
>
Yes, my suggestion is to use a different interface that will definitely
provide higher acquisition speeds. However I am wondering if using the
"instruction" interface the delay would be over the milliseconds. I'm
recalling some tests that I did using comedi in linux user-space, that is
without any real-time support software. I could acquire 8 channels and the
board's internal timer using the instruction list technique at 120us
(microseconds) intervals. However my board has 8 parallel ADCs (NI 6143), so
check if yours has parallel or serial converters. If it has to serialize
conversions then the overall acquisition period will increase.

Back to your code, are you sure about  "insn_tab[i].data_size     = 8;"? Try
data_size = 1 instead.

Best,
Fernando

--bcaec53af23a8658d304ae8e2d9b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/10/5 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 20=
4); padding-left: 1ex;">
<div class=3D"im">On 10/05/2011 09:48 AM, Julien Delange wrote:<br>
&gt; On Tue, Oct 4, 2011 at 12:41 PM, Gilles Chanteperdrix<br>
&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt; Another mail in that thread seem to suggest that it could be long.=
 Have<br>
&gt;&gt; you tried timing the various parts of your loop to see where the t=
ime is<br>
&gt;&gt; spent?<br>
&gt;<br>
&gt; No, sorry, my bad. Unfortunately, I cannot make more tests at this<br>
&gt; time because I don&#39;t have the hardware.<br>
&gt; I will do additional investigation soon, I would have access to the<br=
>
&gt; acquisition card soon. My intent was to know if there was an obvious<b=
r>
&gt; error either in my code or in my kernel configuration. Apparently not,=
<br>
&gt; so, I will try to figure out the root causes of these issues.<br>
<br>
</div>It is my understaning when reading Fernando&#39;s answer to your mail=
 that<br>
you are not using the proper interface for what you are trying to do.<br>
<br></blockquote></div><br>Yes, my suggestion is to use a different interfa=
ce that will definitely provide higher acquisition speeds. However I am won=
dering if using the &quot;instruction&quot; interface the delay would be ov=
er the milliseconds. I&#39;m recalling some tests that I did using comedi i=
n linux user-space, that is without any real-time support software. I could=
 acquire 8 channels and the board&#39;s internal timer using the instructio=
n list technique at 120us (microseconds) intervals. However my board has 8 =
parallel ADCs (NI 6143), so check if yours has parallel or serial converter=
s. If it has to serialize conversions then the overall acquisition period w=
ill increase.<br>
<br>Back to your code, are you sure about=C2=A0 &quot;insn_tab[i].data_size=
 =C2=A0 =C2=A0 =3D 8;&quot;? Try data_size =3D 1 instead.<br><br>Best,<br>F=
ernando<br>

--bcaec53af23a8658d304ae8e2d9b--


MIME-Version: 1.0
In-Reply-To: <CAMesUR7Kn66LETRjRatAPJ5SFM+3EkkbSYwtPo8h1jP96crqYQ@mail.gmail.com>
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>
	<4E8AEB1D.2060706@domain.hid>
	<CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>
	<4E8B0DEA.8030102@domain.hid>
	<CAGc_wL2wb76-t7RBWJnKxgcvsrcKgnFgV4qkjvUgh5AvM7ie3g@domain.hid>
	<4E8B3744.2030407@domain.hid>
	<CAGc_wL2RgNKfMUyQURJ8G2ceaJtvnJL6LpFue3ekuwJ99vwPww@domain.hid>
	<4E8C3AF9.7070604@domain.hid>
	<CAMwkeZyDjpqb11NoxUCTxwpmY5RV0bjRzAHG6HeeyW5RvXejDQ@mail.gmail.com>
	<CAMesUR7Kn66LETRjRatAPJ5SFM+3EkkbSYwtPo8h1jP96crqYQ@mail.gmail.com>
Date: Wed, 5 Oct 2011 19:55:24 -0300
Message-ID: <CAMwkeZxf8xizLZ5Pyg+L8CwHxnY7oYXDxiCBYDGR93NWZ2vWAw@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53051297ef69904ae951a01
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

--bcaec53051297ef69904ae951a01
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 5 de octubre de 2011 18:28, Alexis Berlemont
<alexis.berlemont@domain.hid>escribi=C3=B3:

> 2011/10/5 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> >
> >
> > 2011/10/5 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >>
> >> On 10/05/2011 09:48 AM, Julien Delange wrote:
> >> > On Tue, Oct 4, 2011 at 12:41 PM, Gilles Chanteperdrix
> >> > <gilles.chanteperdrix@xenomai.org> wrote:
> >> >> Another mail in that thread seem to suggest that it could be long.
> Have
> >> >> you tried timing the various parts of your loop to see where the ti=
me
> >> >> is
> >> >> spent?
> >> >
> >> > No, sorry, my bad. Unfortunately, I cannot make more tests at this
> >> > time because I don't have the hardware.
> >> > I will do additional investigation soon, I would have access to the
> >> > acquisition card soon. My intent was to know if there was an obvious
> >> > error either in my code or in my kernel configuration. Apparently no=
t,
> >> > so, I will try to figure out the root causes of these issues.
> >>
> >> It is my understaning when reading Fernando's answer to your mail that
> >> you are not using the proper interface for what you are trying to do.
> >>
> >
> > Yes, my suggestion is to use a different interface that will definitely
> > provide higher acquisition speeds. However I am wondering if using the
> > "instruction" interface the delay would be over the milliseconds. I'm
> > recalling some tests that I did using comedi in linux user-space, that =
is
> > without any real-time support software. I could acquire 8 channels and
> the
> > board's internal timer using the instruction list technique at 120us
> > (microseconds) intervals. However my board has 8 parallel ADCs (NI 6143=
),
> so
> > check if yours has parallel or serial converters. If it has to serializ=
e
> > conversions then the overall acquisition period will increase.
> >
> > Back to your code, are you sure about  "insn_tab[i].data_size     =3D 8=
;"?
> Try
> > data_size =3D 1 instead.
> >
>
> The field data_size is supposed to hold the size of the acquisition in
> bytes.
>
> If you have an 8bits converter, 1 is OK; but according to the driver
> Julien contributed, the converter width is 16bits.
>

Oh, I see, thanks for pointing this out. On the code I had working with
comedi I used 1 for subdevices providing "sampl_t" samples (2 bytes) and 2
for subdevices providing "lsampl_t" samples (4 bytes) (timer/counter
subdevices, for instance). I really think that rationale is misleading, and
find working in terms of bytes much saner! In any case, using 8 as Julien
does seems to not be correct.

Best regards,
Fernando

--bcaec53051297ef69904ae951a01
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 5 de octubre de 2011 18:28, Alexis Berlemont =
<span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis.=
berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=3D"g=
mail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(=
204, 204, 204); padding-left: 1ex;">
2011/10/5 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com">elferdo@domain.hid</a>&gt;:<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt;<br>
&gt; 2011/10/5 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 10/05/2011 09:48 AM, Julien Delange wrote:<br>
&gt;&gt; &gt; On Tue, Oct 4, 2011 at 12:41 PM, Gilles Chanteperdrix<br>
&gt;&gt; &gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gille=
s.chanteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; Another mail in that thread seem to suggest that it could=
 be long. Have<br>
&gt;&gt; &gt;&gt; you tried timing the various parts of your loop to see wh=
ere the time<br>
&gt;&gt; &gt;&gt; is<br>
&gt;&gt; &gt;&gt; spent?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; No, sorry, my bad. Unfortunately, I cannot make more tests at=
 this<br>
&gt;&gt; &gt; time because I don&#39;t have the hardware.<br>
&gt;&gt; &gt; I will do additional investigation soon, I would have access =
to the<br>
&gt;&gt; &gt; acquisition card soon. My intent was to know if there was an =
obvious<br>
&gt;&gt; &gt; error either in my code or in my kernel configuration. Appare=
ntly not,<br>
&gt;&gt; &gt; so, I will try to figure out the root causes of these issues.=
<br>
&gt;&gt;<br>
&gt;&gt; It is my understaning when reading Fernando&#39;s answer to your m=
ail that<br>
&gt;&gt; you are not using the proper interface for what you are trying to =
do.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes, my suggestion is to use a different interface that will definitel=
y<br>
&gt; provide higher acquisition speeds. However I am wondering if using the=
<br>
&gt; &quot;instruction&quot; interface the delay would be over the millisec=
onds. I&#39;m<br>
&gt; recalling some tests that I did using comedi in linux user-space, that=
 is<br>
&gt; without any real-time support software. I could acquire 8 channels and=
 the<br>
&gt; board&#39;s internal timer using the instruction list technique at 120=
us<br>
&gt; (microseconds) intervals. However my board has 8 parallel ADCs (NI 614=
3), so<br>
&gt; check if yours has parallel or serial converters. If it has to seriali=
ze<br>
&gt; conversions then the overall acquisition period will increase.<br>
&gt;<br>
&gt; Back to your code, are you sure about=C2=A0 &quot;insn_tab[i].data_siz=
e =C2=A0 =C2=A0 =3D 8;&quot;? Try<br>
&gt; data_size =3D 1 instead.<br>
&gt;<br>
<br>
</div></div>The field data_size is supposed to hold the size of the acquisi=
tion in bytes.<br>
<br>
If you have an 8bits converter, 1 is OK; but according to the driver<br>
Julien contributed, the converter width is 16bits.<br></blockquote></div><b=
r>Oh, I see, thanks for pointing this out. On the code I had working with=
=20
comedi I used 1 for subdevices providing &quot;sampl_t&quot; samples (2 byt=
es) and
 2 for subdevices providing &quot;lsampl_t&quot; samples (4 bytes) (timer/c=
ounter=20
subdevices, for instance). I really think that rationale is misleading,=20
and find working in terms of bytes much saner! In any case, using 8 as=20
Julien does seems to not be correct.<br>
<br>Best regards,<br><font color=3D"#888888">Fernando</font><br><br>

--bcaec53051297ef69904ae951a01--


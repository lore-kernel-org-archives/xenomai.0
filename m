MIME-Version: 1.0
In-Reply-To: <4D3E4EBA.6050806@domain.hid>
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
	<4D3E385A.5010209@domain.hid>
	<AANLkTikk=xBwB2JzxgyC08=nZY8gAHeXht+_cfZBMGK7@domain.hid>
	<4D3E42BA.4000601@domain.hid>
	<AANLkTi=E=4mSZ_QwD5wNXQMZ2dQJO6kG8vMLGnD52cy0@domain.hid>
	<4D3E4EBA.6050806@domain.hid>
Date: Mon, 24 Jan 2011 22:23:30 -0600
Message-ID: <AANLkTike9rXOKAuGy3Pi+ot8-753pzNAEK=xjhsgzU3O@mail.gmail.com>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba1819c82c2c0b049aa414f8
Subject: Re: [Xenomai-help] Segmentation Fault when writing in registers
 (AT91SAM - ARM9)
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
Cc: xenomai-help <xenomai@xenomai.org>

--90e6ba1819c82c2c0b049aa414f8
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 24, 2011 at 10:16 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> at91_enthus wrote:
> >>> On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix <
> >>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>
> >>>> at91_enthus wrote:
> >>>>> Hi.
> >>>>>
> >>>>> I  was testing Xenomai on my AT91SAM9G20-based board and tried to
> adapt
> >>>> the
> >>>>> code found here:
> >>>>> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs .
> >>>> By the way, this code is ridiculous. It creates a real-time task to
> >>>> write to some non real-time device, which makes the real-time task
> >> useless.
> >>>>
> >>> I know.
> >> Yes, but this example is bad in many ways:
> >> - first it uses xenomai api to create a real-time task, and uses write
> >> which causes the real-time task to switch to secondary domain;
> >> - the Makefile does not use xeno-config, which have been the recommended
> >> way of getting the compiler flags since day 1;
> >> - it nullifies SIGTERM and SIGINT, which is a dubious decision, and
> >> could lead people to believe that they should do the same when using
> >> Xenomai, whereas there is no such requirement.
> >> - the pointers point to outdated version of the documentation.
> >> - it uses runinfo/xeno-load, which are kind of outdated too, make things
> >> uselessly complicated, and in any case, tell you to type Ctrl-C to
> >> interrupt the program, which is bound to fail if anything goes wrong,
> >> since SIGINT is neutralized in the program.
> >>
> >>> That's why I went to mmap().
> >> That is not really the right solution either. I admit that for driving
> >> leds, it may be a bit overkill, but anyway, what you should do is write
> >> an RTDM driver for driving the leds. Keeping the driver separated from
> >> the application will allow the same program to run on other platforms
> >> where driving the LEDS is done differently without changing much of the
> >> application code. In other word, the application/driver separation is a
> >> sane one.
> >>
> >> Anyway, mmap should work.
> >>
> >>  (I chose that sample code because, for
> >>> now, I am only learning to use basic functions)
> >>>> Wrong test here. Should be "if (aic_base == MAP_FAILED)"
> >>> Indeed, my program fails miserably when I check the mapping of AIC, not
> >>> PIOB's. And yet, I just can't figure why in the non-Xenomai code, AIC
> >>> mmap-ing works  fine.
> >> Well errno might give you a clue. Do you have FCSE enabled?
> >>
> >> Regards.
> >>
> >> --
> >>                                                                 Gilles.
> >>
> >
> > FCSE is enabled. errno returns  22 (invalid argument).
>
> best effort or guaranteed?


Best effort


> Please activate FCSE messages.


... compiling new kernel


> How big is
> MAP_SIZE?
>
>
4096

--90e6ba1819c82c2c0b049aa414f8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 24, 2011 at 10:16 PM, Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">at91_enthus wrote:<br>
&gt; On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt; On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix &lt;<br>
&gt;&gt;&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt;&gt;&gt; Hi.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I =A0was testing Xenomai on my AT91SAM9G20-based board=
 and tried to adapt<br>
&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt;&gt; code found here:<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"http://www.armadeus.com/wiki/index.php?titl=
e=3DXenomai:Blinking_LEDs" target=3D"_blank">http://www.armadeus.com/wiki/i=
ndex.php?title=3DXenomai:Blinking_LEDs</a> .<br>
&gt;&gt;&gt;&gt; By the way, this code is ridiculous. It creates a real-tim=
e task to<br>
&gt;&gt;&gt;&gt; write to some non real-time device, which makes the real-t=
ime task<br>
&gt;&gt; useless.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; I know.<br>
&gt;&gt; Yes, but this example is bad in many ways:<br>
&gt;&gt; - first it uses xenomai api to create a real-time task, and uses w=
rite<br>
&gt;&gt; which causes the real-time task to switch to secondary domain;<br>
&gt;&gt; - the Makefile does not use xeno-config, which have been the recom=
mended<br>
&gt;&gt; way of getting the compiler flags since day 1;<br>
&gt;&gt; - it nullifies SIGTERM and SIGINT, which is a dubious decision, an=
d<br>
&gt;&gt; could lead people to believe that they should do the same when usi=
ng<br>
&gt;&gt; Xenomai, whereas there is no such requirement.<br>
&gt;&gt; - the pointers point to outdated version of the documentation.<br>
&gt;&gt; - it uses runinfo/xeno-load, which are kind of outdated too, make =
things<br>
&gt;&gt; uselessly complicated, and in any case, tell you to type Ctrl-C to=
<br>
&gt;&gt; interrupt the program, which is bound to fail if anything goes wro=
ng,<br>
&gt;&gt; since SIGINT is neutralized in the program.<br>
&gt;&gt;<br>
&gt;&gt;&gt; That&#39;s why I went to mmap().<br>
&gt;&gt; That is not really the right solution either. I admit that for dri=
ving<br>
&gt;&gt; leds, it may be a bit overkill, but anyway, what you should do is =
write<br>
&gt;&gt; an RTDM driver for driving the leds. Keeping the driver separated =
from<br>
&gt;&gt; the application will allow the same program to run on other platfo=
rms<br>
&gt;&gt; where driving the LEDS is done differently without changing much o=
f the<br>
&gt;&gt; application code. In other word, the application/driver separation=
 is a<br>
&gt;&gt; sane one.<br>
&gt;&gt;<br>
&gt;&gt; Anyway, mmap should work.<br>
&gt;&gt;<br>
&gt;&gt; =A0(I chose that sample code because, for<br>
&gt;&gt;&gt; now, I am only learning to use basic functions)<br>
&gt;&gt;&gt;&gt; Wrong test here. Should be &quot;if (aic_base =3D=3D MAP_F=
AILED)&quot;<br>
&gt;&gt;&gt; Indeed, my program fails miserably when I check the mapping of=
 AIC, not<br>
&gt;&gt;&gt; PIOB&#39;s. And yet, I just can&#39;t figure why in the non-Xe=
nomai code, AIC<br>
&gt;&gt;&gt; mmap-ing works =A0fine.<br>
&gt;&gt; Well errno might give you a clue. Do you have FCSE enabled?<br>
&gt;&gt;<br>
&gt;&gt; Regards.<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
&gt;&gt;<br>
&gt;<br>
&gt; FCSE is enabled. errno returns =A022 (invalid argument).<br>
<br>
</div></div>best effort or guaranteed? </blockquote><div><br>Best effort<br=
>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.=
8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Please =
activate FCSE messages.</blockquote>
<div><br>... compiling new kernel<br>=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;"> How big is<br>
MAP_SIZE?<br>
<br>
</blockquote><div><br>4096 <br></div></div><br><br>

--90e6ba1819c82c2c0b049aa414f8--


MIME-Version: 1.0
In-Reply-To: <4D3E42BA.4000601@domain.hid>
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
	<4D3E385A.5010209@domain.hid>
	<AANLkTikk=xBwB2JzxgyC08=nZY8gAHeXht+_cfZBMGK7@domain.hid>
	<4D3E42BA.4000601@domain.hid>
Date: Mon, 24 Jan 2011 22:14:03 -0600
Message-ID: <AANLkTi=E=4mSZ_QwD5wNXQMZ2dQJO6kG8vMLGnD52cy0@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba1819c85efcf4049aa3f2e1
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

--90e6ba1819c85efcf4049aa3f2e1
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 24, 2011 at 9:25 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> at91_enthus wrote:
> >>> Hi.
> >>>
> >>> I  was testing Xenomai on my AT91SAM9G20-based board and tried to adapt
> >> the
> >>> code found here:
> >>> http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs .
> >> By the way, this code is ridiculous. It creates a real-time task to
> >> write to some non real-time device, which makes the real-time task
> useless.
> >>
> >>
> > I know.
>
> Yes, but this example is bad in many ways:
> - first it uses xenomai api to create a real-time task, and uses write
> which causes the real-time task to switch to secondary domain;
> - the Makefile does not use xeno-config, which have been the recommended
> way of getting the compiler flags since day 1;
> - it nullifies SIGTERM and SIGINT, which is a dubious decision, and
> could lead people to believe that they should do the same when using
> Xenomai, whereas there is no such requirement.
> - the pointers point to outdated version of the documentation.
> - it uses runinfo/xeno-load, which are kind of outdated too, make things
> uselessly complicated, and in any case, tell you to type Ctrl-C to
> interrupt the program, which is bound to fail if anything goes wrong,
> since SIGINT is neutralized in the program.
>
> >
> > That's why I went to mmap().
>
> That is not really the right solution either. I admit that for driving
> leds, it may be a bit overkill, but anyway, what you should do is write
> an RTDM driver for driving the leds. Keeping the driver separated from
> the application will allow the same program to run on other platforms
> where driving the LEDS is done differently without changing much of the
> application code. In other word, the application/driver separation is a
> sane one.
>
> Anyway, mmap should work.
>
>  (I chose that sample code because, for
> > now, I am only learning to use basic functions)
>
> >> Wrong test here. Should be "if (aic_base == MAP_FAILED)"
> >
> > Indeed, my program fails miserably when I check the mapping of AIC, not
> > PIOB's. And yet, I just can't figure why in the non-Xenomai code, AIC
> > mmap-ing works  fine.
>
> Well errno might give you a clue. Do you have FCSE enabled?
>
> Regards.
>
> --
>                                                                 Gilles.
>

FCSE is enabled. errno returns  22 (invalid argument).

Thanks.

--90e6ba1819c85efcf4049aa3f2e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 24, 2011 at 9:25 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-le=
ft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">at91_enthus wrote:<br>
&gt; On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; at91_enthus wrote:<br>
&gt;&gt;&gt; Hi.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I =A0was testing Xenomai on my AT91SAM9G20-based board and tri=
ed to adapt<br>
&gt;&gt; the<br>
&gt;&gt;&gt; code found here:<br>
&gt;&gt;&gt; <a href=3D"http://www.armadeus.com/wiki/index.php?title=3DXeno=
mai:Blinking_LEDs" target=3D"_blank">http://www.armadeus.com/wiki/index.php=
?title=3DXenomai:Blinking_LEDs</a> .<br>
&gt;&gt; By the way, this code is ridiculous. It creates a real-time task t=
o<br>
&gt;&gt; write to some non real-time device, which makes the real-time task=
 useless.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; I know.<br>
<br>
</div>Yes, but this example is bad in many ways:<br>
- first it uses xenomai api to create a real-time task, and uses write<br>
which causes the real-time task to switch to secondary domain;<br>
- the Makefile does not use xeno-config, which have been the recommended<br=
>
way of getting the compiler flags since day 1;<br>
- it nullifies SIGTERM and SIGINT, which is a dubious decision, and<br>
could lead people to believe that they should do the same when using<br>
Xenomai, whereas there is no such requirement.<br>
- the pointers point to outdated version of the documentation.<br>
- it uses runinfo/xeno-load, which are kind of outdated too, make things<br=
>
uselessly complicated, and in any case, tell you to type Ctrl-C to<br>
interrupt the program, which is bound to fail if anything goes wrong,<br>
since SIGINT is neutralized in the program.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; That&#39;s why I went to mmap().<br>
<br>
</div>That is not really the right solution either. I admit that for drivin=
g<br>
leds, it may be a bit overkill, but anyway, what you should do is write<br>
an RTDM driver for driving the leds. Keeping the driver separated from<br>
the application will allow the same program to run on other platforms<br>
where driving the LEDS is done differently without changing much of the<br>
application code. In other word, the application/driver separation is a<br>
sane one.<br>
<br>
Anyway, mmap should work.<br>
<div class=3D"im"><br>
=A0(I chose that sample code because, for<br>
&gt; now, I am only learning to use basic functions)<br>
<br>
&gt;&gt; Wrong test here. Should be &quot;if (aic_base =3D=3D MAP_FAILED)&q=
uot;<br>
&gt;<br>
&gt; Indeed, my program fails miserably when I check the mapping of AIC, no=
t<br>
&gt; PIOB&#39;s. And yet, I just can&#39;t figure why in the non-Xenomai co=
de, AIC<br>
&gt; mmap-ing works =A0fine.<br>
<br>
</div>Well errno might give you a clue. Do you have FCSE enabled?<br>
<br>
Regards.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br></font></blockquote><div><br>FCSE is enabled. errno returns=
=A0 22 (invalid argument).<br><br>Thanks.<br></div></div>

--90e6ba1819c85efcf4049aa3f2e1--


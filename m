MIME-Version: 1.0
In-Reply-To: <4D3E385A.5010209@domain.hid>
References: <AANLkTi=wo34Zr40GZ+HKegcFKYYcDqj8uzgEqyDCqDj=@mail.gmail.com>
	<4D3E385A.5010209@domain.hid>
Date: Mon, 24 Jan 2011 21:13:24 -0600
Message-ID: <AANLkTikk=xBwB2JzxgyC08=nZY8gAHeXht+_cfZBMGK7@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e6ff36580df78049aa319de
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

--e0cb4e6ff36580df78049aa319de
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 24, 2011 at 8:41 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> > Hi.
> >
> > I  was testing Xenomai on my AT91SAM9G20-based board and tried to adapt
> the
> > code found here:
> > http://www.armadeus.com/wiki/index.php?title=Xenomai:Blinking_LEDs .
>
> By the way, this code is ridiculous. It creates a real-time task to
> write to some non real-time device, which makes the real-time task useless.
>
>
I know. That's why I went to mmap(). (I chose that sample code because, for
now, I am only learning to use basic functions)

>Wrong test here. Should be "if (aic_base == MAP_FAILED)"

Indeed, my program fails miserably when I check the mapping of AIC, not
PIOB's. And yet, I just can't figure why in the non-Xenomai code, AIC
mmap-ing works  fine.

--e0cb4e6ff36580df78049aa319de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 24, 2011 at 8:41 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div>at91_enthus wrote:<br>
&gt; Hi.<br>
&gt;<br>
&gt; I =A0was testing Xenomai on my AT91SAM9G20-based board and tried to ad=
apt the<br>
&gt; code found here:<br>
&gt; <a href=3D"http://www.armadeus.com/wiki/index.php?title=3DXenomai:Blin=
king_LEDs" target=3D"_blank">http://www.armadeus.com/wiki/index.php?title=
=3DXenomai:Blinking_LEDs</a> .<br>
<br>
</div>By the way, this code is ridiculous. It creates a real-time task to<b=
r>
write to some non real-time device, which makes the real-time task useless.=
<br>
<br></blockquote><div><br>I know. That&#39;s why I went to mmap(). (I chose=
 that sample code because, for now, I am only learning to use basic functio=
ns)<br>=A0</div>&gt;Wrong test here. Should be &quot;if (aic_base =3D=3D MA=
P_FAILED)&quot;<br>
<br>Indeed, my program fails miserably when I check the mapping of AIC, not=
 PIOB&#39;s. And yet, I just can&#39;t figure why in the non-Xenomai code, =
AIC mmap-ing works=A0 fine. <br>
</div>

--e0cb4e6ff36580df78049aa319de--


MIME-Version: 1.0
In-Reply-To: <CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
Date: Mon, 3 Oct 2011 23:41:59 +0200
Message-ID: <CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec520f0853b54d004ae6bd86c
Subject: Re: [Xenomai-help] Command code working with comedi not working
	with analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--bcaec520f0853b54d004ae6bd86c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 30 de septiembre de 2011 00:16, Alexis Berlemont <
alexis.berlemont@domain.hid> escribi=C3=B3:

> Hi,
> [...]
> With insn_read, did you manage to acquire correct values at least?
>
>
Dear Alexis,

insn_read does indeed work. If I run "insn_read -S 1000" I get my input
sampled at approx 125kHz. Running cmd_read with and without '-m' only
returns 0x8000.

I have been playing around with __a4l_info and the driver code to track dow=
n
my problem. I am not familiar at all with low-level DAQ programming, so I
just followed my intuition.

I modified
buffer.c:a4l_read_buf and buffer.h:__consume

to dump the values that were being consumed from the internal buffer. There
I found the infamous 0x8000, so my conclusion is that those values are
traveling along the kernel side. I decided I would go the other way around
and modified

drivers/analogy/national_instruments/mio_common.c: handle_a_interrupt
and drivers/analogy/buffer.c: a4l_buf_evt

I guess that interrupt is being generated every time a DMA transfer has
been completed from the DAQ to analogy's internal  buffer. I dump variable
"count" in a4l_buf_evt and it always reports the appropriate byte count to
be transferred, which is "number of channels" * 2.

My guess is that the DMA transfers are being performed to the wrong place,
because the whole procedure seems to be working ok otherwise.

All help is appreciated,
Fernando

--bcaec520f0853b54d004ae6bd86c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 30 de septiembre de 2011 00:16, Alexis Berlem=
ont <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid">ale=
xis.berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex;">
Hi,<br>[...]<br>With insn_read, did you manage to acquire correct values at=
 least?<br><br></blockquote><div>=C2=A0</div><span class=3D"Apple-style-spa=
n" style=3D"font-family: arial, sans-serif; font-size: 10px; border-collaps=
e: collapse; ">Dear Alexis,</span></div>
<div class=3D"gmail_quote"><span class=3D"Apple-style-span" style=3D"font-f=
amily: arial, sans-serif; font-size: 10px; border-collapse: collapse; "><br=
></span></div><div class=3D"gmail_quote"><span class=3D"Apple-style-span" s=
tyle=3D"font-family: arial, sans-serif; font-size: 10px; border-collapse: c=
ollapse; ">insn_read does indeed work. If I run &quot;insn_read -S 1000&quo=
t; I get my input sampled at approx 125kHz. Running cmd_read with and witho=
ut &#39;-m&#39; only returns 0x8000.<br>
<br>I have been playing around with __a4l_info and the driver code to track=
 down my problem. I am not familiar at all with low-level DAQ programming, =
so I just followed my intuition.<br><br>I modified=C2=A0<br><div style=3D"m=
argin-left: 40px; ">
buffer.c:a4l_read_buf and buffer.h:__consume<br><br></div>to dump the value=
s that were being consumed from the internal buffer. There I found the infa=
mous 0x8000, so my conclusion is that those values are traveling along the =
kernel side. I decided I would go the other way around and modified<br>
<br><div style=3D"margin-left: 40px; ">drivers/analogy/national_instruments=
/mio_common.c: handle_a_interrupt<br>and drivers/analogy/buffer.c: a4l_buf_=
evt<br><br></div>I guess that interrupt is being generated every time a DMA=
 transfer has=C2=A0 been completed from the DAQ to analogy&#39;s internal=
=C2=A0 buffer. I dump variable &quot;count&quot; in a4l_buf_evt and it alwa=
ys reports the appropriate byte count to be transferred, which is &quot;num=
ber of channels&quot; * 2.<br>
<br>My guess is that the DMA transfers are being performed to the wrong pla=
ce, because the whole procedure seems to be working ok otherwise.<br><br>Al=
l help is appreciated,<br><font color=3D"#888888">Fernando</font><br><br>
</span><div>=C2=A0</div></div>

--bcaec520f0853b54d004ae6bd86c--


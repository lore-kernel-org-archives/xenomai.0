MIME-Version: 1.0
In-Reply-To: <CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
Date: Tue, 4 Oct 2011 17:29:44 -0300
Message-ID: <CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec53af23ab7acb604ae7ef33c
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

--bcaec53af23ab7acb604ae7ef33c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 3 de octubre de 2011 18:41, Fernando Herrero Carr=C3=B3n
<elferdo@domain.hid>escribi=C3=B3:

> El 30 de septiembre de 2011 00:16, Alexis Berlemont <
> alexis.berlemont@domain.hid> escribi=C3=B3:
>
>> Hi,
>> [...]
>>
>> With insn_read, did you manage to acquire correct values at least?
>>
>>
> Dear Alexis,
>
> insn_read does indeed work. If I run "insn_read -S 1000" I get my input
> sampled at approx 125kHz. Running cmd_read with and without '-m' only
> returns 0x8000.
>
> I have been playing around with __a4l_info and the driver code to track
> down my problem. I am not familiar at all with low-level DAQ programming,=
 so
> I just followed my intuition.
>
> I modified
>  buffer.c:a4l_read_buf and buffer.h:__consume
>
> to dump the values that were being consumed from the internal buffer. The=
re
> I found the infamous 0x8000, so my conclusion is that those values are
> traveling along the kernel side. I decided I would go the other way aroun=
d
> and modified
>
> drivers/analogy/national_instruments/mio_common.c: handle_a_interrupt
> and drivers/analogy/buffer.c: a4l_buf_evt
>
> I guess that interrupt is being generated every time a DMA transfer has
> been completed from the DAQ to analogy's internal  buffer. I dump variabl=
e
> "count" in a4l_buf_evt and it always reports the appropriate byte count t=
o
> be transferred, which is "number of channels" * 2.
>
> My guess is that the DMA transfers are being performed to the wrong place=
,
> because the whole procedure seems to be working ok otherwise.
>
> All help is appreciated,
> Fernando
>
>
>

Dear all,

More updates on this. I just tested both the "cmd_read" example and my own
code on the analogy_fake device. They're both working, I get a sawtooth
shape. So my guess is still that there is some error in the DMA transfer in
the NI driver(s).

Could anyone please help me indicating where DMA is setup in the NI drivers=
?
I'll try to have a look at it myself, but a more experienced advice would b=
e
helpful.

Thanks,
Fernando

--bcaec53af23ab7acb604ae7ef33c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 3 de octubre de 2011 18:41, Fernando Herrero =
Carr=C3=B3n <span dir=3D"ltr">&lt;<a href=3D"mailto:elferdo@domain.hid" targ=
et=3D"_blank">elferdo@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1p=
x solid rgb(204, 204, 204); padding-left: 1ex;">

<div class=3D"gmail_quote">El 30 de septiembre de 2011 00:16, Alexis Berlem=
ont <span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid" tar=
get=3D"_blank">alexis.berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


Hi,<br>[...]<div><br>With insn_read, did you manage to acquire correct valu=
es at least?<br><br></div></blockquote><div>=C2=A0</div><span style=3D"font=
-family: arial,sans-serif; font-size: 10px; border-collapse: collapse;">Dea=
r Alexis,</span></div>


<div class=3D"gmail_quote"><span style=3D"font-family: arial,sans-serif; fo=
nt-size: 10px; border-collapse: collapse;"><br></span></div><div class=3D"g=
mail_quote"><span style=3D"font-family: arial,sans-serif; font-size: 10px; =
border-collapse: collapse;"><div>

insn_read does indeed work. If I run &quot;insn_read -S 1000&quot; I get my=
 input sampled at approx 125kHz. Running cmd_read with and without &#39;-m&=
#39; only returns 0x8000.<br>
<br></div><div>I have been playing around with __a4l_info and the driver co=
de to track down my problem. I am not familiar at all with low-level DAQ pr=
ogramming, so I just followed my intuition.<br><br>I modified=C2=A0<br>
<div style=3D"margin-left: 40px;">
buffer.c:a4l_read_buf and buffer.h:__consume<br><br></div>to dump the value=
s that were being consumed from the internal buffer. There I found the infa=
mous 0x8000, so my conclusion is that those values are traveling along the =
kernel side. I decided I would go the other way around and modified<br>


<br><div style=3D"margin-left: 40px;">drivers/analogy/national_instruments/=
mio_common.c: handle_a_interrupt<br>and drivers/analogy/buffer.c: a4l_buf_e=
vt<br><br></div>I guess that interrupt is being generated every time a DMA =
transfer has=C2=A0 been completed from the DAQ to analogy&#39;s internal=C2=
=A0 buffer. I dump variable &quot;count&quot; in a4l_buf_evt and it always =
reports the appropriate byte count to be transferred, which is &quot;number=
 of channels&quot; * 2.<br>


<br>My guess is that the DMA transfers are being performed to the wrong pla=
ce, because the whole procedure seems to be working ok otherwise.<br><br>Al=
l help is appreciated,<br><font color=3D"#888888">Fernando</font><br><br>


</div></span><div>=C2=A0</div></div>
</blockquote></div><br>Dear all,<br><br>More updates on this. I just tested=
 both the &quot;cmd_read&quot; example and my own code on the analogy_fake =
device. They&#39;re both working, I get a sawtooth shape. So my guess is st=
ill that there is some error in the DMA transfer in the NI driver(s).<br>
<br>Could anyone please help me indicating where DMA is setup in the NI dri=
vers? I&#39;ll try to have a look at it myself, but a more experienced advi=
ce would be helpful.<br><br>Thanks,<br>Fernando<br>

--bcaec53af23ab7acb604ae7ef33c--


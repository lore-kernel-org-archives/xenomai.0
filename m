MIME-Version: 1.0
In-Reply-To: <CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
	<CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
	<CAMwkeZxinGD8_yEYmo+ySHx9dzU6hEM4BFH4jejnTMd87f0M9Q@mail.gmail.com>
	<CAMesUR4+G-Bx9tDUPajp4EcKP70zLvQuLyjLeyNpfyrmCpwBBw@domain.hid>
	<CAMwkeZyQwtJbcMjOiSnmzoRDud+4=6Nt2NOcEdFG_+1QVSHoSQ@mail.gmail.com>
	<CAMwkeZzajkK7gRYH5cnAW1-5HvgxQyUogDZKpms1FUyLtwxpdg@domain.hid>
	<CAMesUR67RpFHRiNcd-yfR9WF2FRe1U3yBdXWP2dU30aQovCHKQ@mail.gmail.com>
Date: Wed, 5 Oct 2011 20:06:40 -0300
Message-ID: <CAMwkeZxybKS+-B2C_yaYX3_XSYnAKcj8xfX_YOgQ6Kt=mNTzJQ@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec531487fca29b604ae9542d5
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
To: Xenomai help <xenomai@xenomai.org>

--bcaec531487fca29b604ae9542d5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El 5 de octubre de 2011 18:16, Alexis Berlemont
<alexis.berlemont@domain.hid>escribi=C3=B3:

> Hi,
>
> 2011/10/4 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> > El 3 de octubre de 2011 18:41, Fernando Herrero Carr=C3=B3n <
> elferdo@domain.hid>
> > escribi=C3=B3:
> >>
> >> El 30 de septiembre de 2011 00:16, Alexis Berlemont
> >> <alexis.berlemont@domain.hid> escribi=C3=B3:
> >>>
> >>> Hi,
> >>> [...]
> >>> With insn_read, did you manage to acquire correct values at least?
> >>>
> >>
> >> Dear Alexis,
> >> insn_read does indeed work. If I run "insn_read -S 1000" I get my inpu=
t
> >> sampled at approx 125kHz. Running cmd_read with and without '-m' only
> >> returns 0x8000.
> >>
> >> I have been playing around with __a4l_info and the driver code to trac=
k
> >> down my problem. I am not familiar at all with low-level DAQ
> programming, so
> >> I just followed my intuition.
> >>
> >> I modified
> >> buffer.c:a4l_read_buf and buffer.h:__consume
> >>
> >> to dump the values that were being consumed from the internal buffer.
> >> There I found the infamous 0x8000, so my conclusion is that those valu=
es
> are
> >> traveling along the kernel side. I decided I would go the other way
> around
> >> and modified
> >>
> >> drivers/analogy/national_instruments/mio_common.c: handle_a_interrupt
> >> and drivers/analogy/buffer.c: a4l_buf_evt
> >>
> >> I guess that interrupt is being generated every time a DMA transfer ha=
s
> >> been completed from the DAQ to analogy's internal  buffer. I dump
> variable
> >> "count" in a4l_buf_evt and it always reports the appropriate byte coun=
t
> to
> >> be transferred, which is "number of channels" * 2.
> >>
> >> My guess is that the DMA transfers are being performed to the wrong
> place,
> >> because the whole procedure seems to be working ok otherwise.
> >>
> >> All help is appreciated,
> >> Fernando
> >>
> >>
> >
> > Dear all,
> >
> > More updates on this. I just tested both the "cmd_read" example and my
> own
> > code on the analogy_fake device. They're both working, I get a sawtooth
> > shape. So my guess is still that there is some error in the DMA transfe=
r
> in
> > the NI driver(s).
> >
> > Could anyone please help me indicating where DMA is setup in the NI
> drivers?
> > I'll try to have a look at it myself, but a more experienced advice wou=
ld
> be
> > helpful.
> >
>
> I think the problem might be located at two different places:
> 1) Either the DMA controller is badly configured and it copies the
> properly acquired values to wrong places.
> 2) Or the DAQ-STC module is badly configured; so, the  DMA controller
> copies the wrong values to right places.
>
> Concerning the alternative 1, I think it is not the most probable one.
> Why? Because, the DMA controller (the MITE) is configured the same way
> whatever the NI acquisition board holds it (or nearly).
> To check this idea: let's make a little test with cmd_read.
>
> If cmd_read is launched with the option -m (map), we get direct
> access, in user space, to the memory area the DMA controller is
> supposed to shot to.
>
> So, just after a4l_mmap (before the DMA controller shots anything):
> 367:            /* Map the analog input subdevice buffer */
> 368:            ret =3D a4l_mmap(&dsc, cmd.idx_subd, buf_size, &map);
> you can have a look at the values hold by the buffer:
> - If the values are already 0x8000, we might conclude that the DMA
> controller does not send anything there.
> - If the values are not 0x8000, then we are sure that the DMA
> controller does behave as expected. Consequently we can skip
> alternative 1) and focus on the second one.
>
> If the DAQ is not properly configured; things are getting a little bit
> simpler (if we have the documentation /. developer manual of your
> acquisition card). We just have to find which stuff was not properly
> configured.  A simple solution could be the monitoring of the status
> registers. In such a case, I can send you a patch which will dump the
> content of these registers.
>
> But before going that way, could you make the test with cmd_read + mmap?
>
> Regards,
>
> Alexis.
>

Ok, I'll check those tomorrow. From what I recall, I checked cmd_read just
passing the '-m' option and resulted in the same behaviour, but I'll rechec=
k
tomorrow.

What I find somewhat surprising is that I got it working with comedi, so I
guess that the register programming should also be working with analogy. Th=
e
only difference I have managed to find so far between the analogy and the
comedi drivers, besides generic buffer management, is that comedi appears t=
o
handle DMA through the "generic device" interface (as in
http://www.mjmwired.net/kernel/Documentation/DMA-API.txt) and analogy
handles DMA through the PCI interface (as in
http://m8-android-kernel.googlecode.com/svn/trunk/Documentation/DMA-mapping=
.txt).
But this is merely speculation.

I'll look tomorrow at your two options in more detail.

Thanks for your help!
Fernando

--bcaec531487fca29b604ae9542d5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">El 5 de octubre de 2011 18:16, Alexis Berlemont =
<span dir=3D"ltr">&lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis.=
berlemont@domain.hid</a>&gt;</span> escribi=C3=B3:<br><blockquote class=3D"g=
mail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(=
204, 204, 204); padding-left: 1ex;">
Hi,<br>
<br>
2011/10/4 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com">elferdo@domain.hid</a>&gt;:<br>
<div><div></div><div class=3D"h5">&gt; El 3 de octubre de 2011 18:41, Ferna=
ndo Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid">elferdo@domain.hid=
ail.com</a>&gt;<br>
&gt; escribi=C3=B3:<br>
&gt;&gt;<br>
&gt;&gt; El 30 de septiembre de 2011 00:16, Alexis Berlemont<br>
&gt;&gt; &lt;<a href=3D"mailto:alexis.berlemont@domain.hid">alexis.berlemont=
@gmail.com</a>&gt; escribi=C3=B3:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt; [...]<br>
&gt;&gt;&gt; With insn_read, did you manage to acquire correct values at le=
ast?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Dear Alexis,<br>
&gt;&gt; insn_read does indeed work. If I run &quot;insn_read -S 1000&quot;=
 I get my input<br>
&gt;&gt; sampled at approx 125kHz. Running cmd_read with and without &#39;-=
m&#39; only<br>
&gt;&gt; returns 0x8000.<br>
&gt;&gt;<br>
&gt;&gt; I have been playing around with __a4l_info and the driver code to =
track<br>
&gt;&gt; down my problem. I am not familiar at all with low-level DAQ progr=
amming, so<br>
&gt;&gt; I just followed my intuition.<br>
&gt;&gt;<br>
&gt;&gt; I modified<br>
&gt;&gt; buffer.c:a4l_read_buf and buffer.h:__consume<br>
&gt;&gt;<br>
&gt;&gt; to dump the values that were being consumed from the internal buff=
er.<br>
&gt;&gt; There I found the infamous 0x8000, so my conclusion is that those =
values are<br>
&gt;&gt; traveling along the kernel side. I decided I would go the other wa=
y around<br>
&gt;&gt; and modified<br>
&gt;&gt;<br>
&gt;&gt; drivers/analogy/national_instruments/mio_common.c: handle_a_interr=
upt<br>
&gt;&gt; and drivers/analogy/buffer.c: a4l_buf_evt<br>
&gt;&gt;<br>
&gt;&gt; I guess that interrupt is being generated every time a DMA transfe=
r has<br>
&gt;&gt; been completed from the DAQ to analogy&#39;s internal=C2=A0 buffer=
. I dump variable<br>
&gt;&gt; &quot;count&quot; in a4l_buf_evt and it always reports the appropr=
iate byte count to<br>
&gt;&gt; be transferred, which is &quot;number of channels&quot; * 2.<br>
&gt;&gt;<br>
&gt;&gt; My guess is that the DMA transfers are being performed to the wron=
g place,<br>
&gt;&gt; because the whole procedure seems to be working ok otherwise.<br>
&gt;&gt;<br>
&gt;&gt; All help is appreciated,<br>
&gt;&gt; Fernando<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; Dear all,<br>
&gt;<br>
&gt; More updates on this. I just tested both the &quot;cmd_read&quot; exam=
ple and my own<br>
&gt; code on the analogy_fake device. They&#39;re both working, I get a saw=
tooth<br>
&gt; shape. So my guess is still that there is some error in the DMA transf=
er in<br>
&gt; the NI driver(s).<br>
&gt;<br>
&gt; Could anyone please help me indicating where DMA is setup in the NI dr=
ivers?<br>
&gt; I&#39;ll try to have a look at it myself, but a more experienced advic=
e would be<br>
&gt; helpful.<br>
&gt;<br>
<br>
</div></div>I think the problem might be located at two different places:<b=
r>
1) Either the DMA controller is badly configured and it copies the<br>
properly acquired values to wrong places.<br>
2) Or the DAQ-STC module is badly configured; so, the =C2=A0DMA controller<=
br>
copies the wrong values to right places.<br>
<br>
Concerning the alternative 1, I think it is not the most probable one.<br>
Why? Because, the DMA controller (the MITE) is configured the same way<br>
whatever the NI acquisition board holds it (or nearly).<br>
To check this idea: let&#39;s make a little test with cmd_read.<br>
<br>
If cmd_read is launched with the option -m (map), we get direct<br>
access, in user space, to the memory area the DMA controller is<br>
supposed to shot to.<br>
<br>
So, just after a4l_mmap (before the DMA controller shots anything):<br>
367: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Map the analog input subde=
vice buffer */<br>
368: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D a4l_mmap(&amp;dsc, cm=
d.idx_subd, buf_size, &amp;map);<br>
you can have a look at the values hold by the buffer:<br>
- If the values are already 0x8000, we might conclude that the DMA<br>
controller does not send anything there.<br>
- If the values are not 0x8000, then we are sure that the DMA<br>
controller does behave as expected. Consequently we can skip<br>
alternative 1) and focus on the second one.<br>
<br>
If the DAQ is not properly configured; things are getting a little bit<br>
simpler (if we have the documentation /. developer manual of your<br>
acquisition card). We just have to find which stuff was not properly<br>
configured. =C2=A0A simple solution could be the monitoring of the status<b=
r>
registers. In such a case, I can send you a patch which will dump the<br>
content of these registers.<br>
<br>
But before going that way, could you make the test with cmd_read + mmap?<br=
>
<br>
Regards,<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>Ok, I&#39;ll check those tomorrow. From what =
I recall, I checked cmd_read just passing the &#39;-m&#39; option and resul=
ted in the same behaviour, but I&#39;ll recheck tomorrow.<br><br>What I fin=
d somewhat surprising is that I got it working with comedi, so I guess that=
 the register programming should also be working with analogy. The only dif=
ference I have managed to find so far between the analogy and the comedi dr=
ivers, besides generic buffer management, is that comedi appears to handle =
DMA through the &quot;generic device&quot; interface (as in <a href=3D"http=
://www.mjmwired.net/kernel/Documentation/DMA-API.txt">http://www.mjmwired.n=
et/kernel/Documentation/DMA-API.txt</a>) and analogy handles DMA through th=
e PCI interface (as in <a href=3D"http://m8-android-kernel.googlecode.com/s=
vn/trunk/Documentation/DMA-mapping.txt">http://m8-android-kernel.googlecode=
.com/svn/trunk/Documentation/DMA-mapping.txt</a>). But this is merely specu=
lation.<br>
<br>I&#39;ll look tomorrow at your two options in more detail.<br><br>Thank=
s for your help!<br>Fernando<br><br><br>

--bcaec531487fca29b604ae9542d5--


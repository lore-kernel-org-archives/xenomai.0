MIME-Version: 1.0
In-Reply-To: <CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
References: <CAMwkeZy-9Qw0LALq8rrJQKET_Bu7UHgu8YYoFw1z6jdS687fBg@domain.hid>
	<CAGc_wL172OGHZ-8SG8e77Fp5qwHqKvTY610aQsr3WA_bp+3HRg@domain.hid>
Date: Wed, 28 Sep 2011 12:19:38 -0300
Message-ID: <CAMwkeZyvyhHPZTWz1LiaOhWA9TdrQaXMo833Ej5JRwJR3Da2xw@domain.hid>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec52154f1ad665f04ae01ebf9
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

--bcaec52154f1ad665f04ae01ebf9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2011/9/28 Julien Delange <julien.delange@domain.hid>

> 2011/9/27 Fernando Herrero Carr=C3=B3n <elferdo@domain.hid>:
> > [snip]
>
> Dear Fernando,
>
> Would it be possible to provide more information about your bug, in
> particular, the configuration of the board (which is analogy0, ...)
> and the code you are trying to use ?
>
> Also, as Gilles said, please also try the latest rc release, it might
> solve your issues.
>
> Thanks,
>

Dear Gilles and Julien,

Thanks for your replies. I will try the latest RC and let you know.

These are the details of my setup:

- Dmesg output:

 Analogy: MITE: Available NI device IDs: 0x1870 0x70c0

- lspci:
01:05.0 Class ff00: National Instruments Device 70c0 (this should be the NI
6143) <- used for AO
01:06.0 Class ff00: National Instruments PCI-6713 <- used for AI

- analogy-config:
/usr/xenomai/sbin/analogy_config  analogy0 analogy_ni_pcimio 1,5
/usr/xenomai/sbin/analogy_config  analogy1 analogy_ni_pcimio 1,6

- cat /proc/analogy/devices
--  Analogy devices --

| idx | status | driver
|  00 | Linked | analogy_ni_pcimio
|  01 | Linked | analogy_ni_pcimio
|  02 | Unused | No driver
[...]

- cat /proc/analogy/00-analogy_ni_pcimio
--  Subdevices --

| idx | type
|  00 | Analog input subdevice
|  01 | Unused subdevice
|  02 | Digital input/output subdevice
|  03 | Unused subdevice
|  04 | Unused subdevice
|  05 | Calibration subdevice
|  06 | Memory subdevice
|  07 | Digital input/output subdevice
|  08 | Unused subdevice
|  09 | Serial subdevice
|  10 | Unused subdevice
|  11 | Counter subdevice
|  12 | Counter subdevice
|  13 | Counter subdevice

- cat /proc/analogy/01-analogy_ni_pcimio
--  Subdevices --

| idx | type
|  00 | Unused subdevice
|  01 | Analog output subdevice
|  02 | Digital input/output subdevice
|  03 | Unused subdevice
|  04 | Unused subdevice
|  05 | Calibration subdevice
|  06 | Memory subdevice
|  07 | Digital input/output subdevice
|  08 | Unused subdevice
|  09 | Serial subdevice
|  10 | Unused subdevice
|  11 | Counter subdevice
|  12 | Counter subdevice
|  13 | Counter subdevice

Thanks,
Fernando

--bcaec52154f1ad665f04ae01ebf9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/9/28 Julien Delange <span dir=3D"ltr">&lt;<=
a href=3D"mailto:julien.delange@domain.hid" target=3D"_blank">julien.delange=
@gmail.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"mar=
gin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-=
left: 1ex;">

2011/9/27 Fernando Herrero Carr=C3=B3n &lt;<a href=3D"mailto:elferdo@domain.hid.=
com" target=3D"_blank">elferdo@domain.hid</a>&gt;:<br>
&gt; [snip]<br>
<br>
Dear Fernando,<br>
<br>
Would it be possible to provide more information about your bug, in<br>
particular, the configuration of the board (which is analogy0, ...)<br>
and the code you are trying to use ?<br>
<br>
Also, as Gilles said, please also try the latest rc release, it might<br>
solve your issues.<br>
<br>
Thanks,<br></blockquote></div><br>Dear Gilles and Julien,<br><br>Thanks for=
 your replies. I will try the latest RC and let you know.<br><br>These are =
the details of my setup:<br><br>- Dmesg output:<br><br><div style=3D"margin=
-left: 40px;">

=C2=A0Analogy: MITE: Available NI device IDs: 0x1870 0x70c0<br></div><br>- =
lspci:<br><div style=3D"margin-left: 40px;">01:05.0 Class ff00: National In=
struments Device 70c0 (this should be the NI 6143) &lt;- used for AO<br></d=
iv>
<div style=3D"margin-left: 40px;">01:06.0 Class ff00: National Instruments =
PCI-6713 &lt;- used for AI<br>
</div><br>- analogy-config:<br><div style=3D"margin-left: 40px;">/usr/xenom=
ai/sbin/analogy_config=C2=A0 analogy0 analogy_ni_pcimio 1,5<br>/usr/xenomai=
/sbin/analogy_config=C2=A0 analogy1 analogy_ni_pcimio 1,6<br><br></div>- ca=
t /proc/analogy/devices <br>
<div style=3D"margin-left: 40px;">--=C2=A0 Analogy devices --<br><br>| idx =
| status | driver<br>|=C2=A0 00 | Linked | analogy_ni_pcimio<br>|=C2=A0 01 =
| Linked | analogy_ni_pcimio<br>|=C2=A0 02 | Unused | No driver<br>[...]<br=
><br></div>- cat /proc/analogy/00-analogy_ni_pcimio <br>
<div style=3D"margin-left: 40px;">--=C2=A0 Subdevices --<br><br>| idx | typ=
e<br>|=C2=A0 00 | Analog input subdevice<br>|=C2=A0 01 | Unused subdevice<b=
r>|=C2=A0 02 | Digital input/output subdevice<br>|=C2=A0 03 | Unused subdev=
ice<br>|=C2=A0 04 | Unused subdevice<br>
|=C2=A0 05 | Calibration subdevice<br>|=C2=A0 06 | Memory subdevice<br>|=C2=
=A0 07 | Digital input/output subdevice<br>|=C2=A0 08 | Unused subdevice<br=
>|=C2=A0 09 | Serial subdevice<br>|=C2=A0 10 | Unused subdevice<br>|=C2=A0 =
11 | Counter subdevice<br>|=C2=A0 12 | Counter subdevice<br>
|=C2=A0 13 | Counter subdevice<br><br></div>- cat /proc/analogy/01-analogy_=
ni_pcimio <br><div style=3D"margin-left: 40px;">--=C2=A0 Subdevices --<br><=
br>| idx | type<br>|=C2=A0 00 | Unused subdevice<br>|=C2=A0 01 | Analog out=
put subdevice<br>|=C2=A0 02 | Digital input/output subdevice<br>
|=C2=A0 03 | Unused subdevice<br>|=C2=A0 04 | Unused subdevice<br>|=C2=A0 0=
5 | Calibration subdevice<br>|=C2=A0 06 | Memory subdevice<br>|=C2=A0 07 | =
Digital input/output subdevice<br>|=C2=A0 08 | Unused subdevice<br>|=C2=A0 =
09 | Serial subdevice<br>|=C2=A0 10 | Unused subdevice<br>
|=C2=A0 11 | Counter subdevice<br>|=C2=A0 12 | Counter subdevice<br>|=C2=A0=
 13 | Counter subdevice<br></div><br>Thanks,<br>Fernando<br>

--bcaec52154f1ad665f04ae01ebf9--


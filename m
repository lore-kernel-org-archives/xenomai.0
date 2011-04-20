Message-ID: <COL104-W40EFBABDB7D1AD7B0D1690E9930@domain.hid>
Content-Type: multipart/alternative;
	boundary="_eb4f078f-3fa5-4179-a4ae-ad0e70c43df8_"
From: =?iso-8859-1?B?RnJhbudvaXMgQmVhdWZvcnQ=?= <francois.beaufort@domain.hid>
Date: Wed, 20 Apr 2011 15:13:06 +0200
In-Reply-To: <4DAEBB48.2070700@domain.hid>
References: <COL104-W8B4D8E6C75C99ECA28042E9930@domain.hid>,
	<4DAE99F2.7030002@domain.hid>
	<COL104-W334D71DB0C86070AC9F939E9930@domain.hid>,
	<4DAEBB48.2070700@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Xenomai-core] xenomai and framebuffer-ipu on
	target iMx35
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

--_eb4f078f-3fa5-4179-a4ae-ad0e70c43df8_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Wed=2C 20 Apr 2011 12:54:00 +0200
> From: gilles.chanteperdrix@xenomai.org
> To: francois.beaufort@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai-core] xenomai and framebuffer-ipu on target iMx35
>=20
> Fran=E7ois Beaufort wrote:
> > I can't show you  /proc/interrupts when ipu and I-pipe are enabled
> > because the system doesn't start in this case.
>=20
> Ok. I failed to get that from your first mail. I do not know either if
> you are using a vanilla kernel=2C or a patched one?
>=20
> If a patched one=2C then you have to verify that generic_handle_irq is
> replaced with ipipe_handle_chained_irq for multiplexed GPIO irqs.
>=20
> Note that I CCd the Xenomai-help mailing list=2C next private mail will
> receive no answer.
>=20
> --=20
>                                                                 Gilles.
>=20

Thank you for your answers.

I can now start Linux-xenomai with framebuffer and ipu.

I use a kernel patched by the Phytec BSP patches and next by the adeos pipe=
.

I have modified the file linux-2.6.35.9/drivers/dma/ipu/ipu_irq.c :

lines 305 and 343 :

-  generic_handle_irq(irq)=3B
+ ipipe_handle_chained_irq(irq)=3B


This file is not modified by any patch.

Thank you.

Fran=E7ois.

 		 	   		  =

--_eb4f078f-3fa5-4179-a4ae-ad0e70c43df8_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
<br><br>&gt=3B Date: Wed=2C 20 Apr 2011 12:54:00 +0200<br>&gt=3B From: gill=
es.chanteperdrix@domain.hid<br>&gt=3B To: francois.beaufort@domain.hid<br>&gt=
=3B CC: xenomai@xenomai.org<br>&gt=3B Subject: Re: [Xenomai-core] xenomai =
and framebuffer-ipu on target iMx35<br>&gt=3B <br>&gt=3B Fran=E7ois Beaufor=
t wrote:<br>&gt=3B &gt=3B I can't show you  /proc/interrupts when ipu and I=
-pipe are enabled<br>&gt=3B &gt=3B because the system doesn't start in this=
 case.<br>&gt=3B <br>&gt=3B Ok. I failed to get that from your first mail. =
I do not know either if<br>&gt=3B you are using a vanilla kernel=2C or a pa=
tched one?<br>&gt=3B <br>&gt=3B If a patched one=2C then you have to verify=
 that generic_handle_irq is<br>&gt=3B replaced with ipipe_handle_chained_ir=
q for multiplexed GPIO irqs.<br>&gt=3B <br>&gt=3B Note that I CCd the Xenom=
ai-help mailing list=2C next private mail will<br>&gt=3B receive no answer.=
<br>&gt=3B <br>&gt=3B -- <br>&gt=3B                                        =
                         Gilles.<br>&gt=3B <br><br>Thank you for your answe=
rs.<br><br>I can now start Linux-xenomai with framebuffer and ipu.<br><br>I=
 use a kernel patched by the Phytec BSP patches and next by the adeos pipe.=
<br><br>I have modified the file linux-2.6.35.9/drivers/dma/ipu/ipu_irq.c :=
<br><br>lines 305 and 343 :<br><br>-&nbsp=3B generic_handle_irq(irq)=3B<br>=
+ ipipe_handle_chained_irq(irq)=3B<br><br><br>This file is not modified by =
any patch.<br><br>Thank you.<br><br>Fran=E7ois.<br><br> 		 	   		  </body>
</html>=

--_eb4f078f-3fa5-4179-a4ae-ad0e70c43df8_--


MIME-Version: 1.0
In-Reply-To: <4BE0B79D.6070105@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>
	<4B770554.3080809@domain.hid>
	<8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>
	<8b216e9e1002150919p250b5270tab0bf5f242e87a25@domain.hid>
	<4B799016.2040305@domain.hid>
	<8b216e9e1002151034n362f83afwfd6b9355ec071540@domain.hid>
	<8b216e9e1003020729t58db73fdv88d9927695baae75@domain.hid>
	<4B8D2F9D.3050500@domain.hid> <4BE0B79D.6070105@domain.hid>
Date: Thu, 6 May 2010 00:27:41 -0300
Message-ID: <g2x8b216e9e1005052027h7d34e71sb0cc3ad1a3f528@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=001636e90a217abed50485e48677
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

--001636e90a217abed50485e48677
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/5/4 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Gilles Chanteperdrix wrote:
> > No, will try and get a Xenomai-patched 2.6.30 running on IGEP real soon
> > now... However, ARM I-pipe patches for something more recent than 2.6.3=
0
> > should come soon, so, will not try really hard.
> >
>
> Hi Felipe,
>
> I finally had time to run Xenomai on IGEP. It almost worked out of the
> box (just had spurious irqs caused by the twl4030-irq driver using the
> I2C drive, a workaround being to disable the I2C irq line when writing
> to the I2C controller registers). If will be in the
> adeos-ipipe-2.6.33-arm-1.16-01 patch, for which you may have seen the
> pull request if you are subscribed to the adeos mailing list. And this
> patch will be part of the upcoming Xenomai 2.5.3 release, available real
> soon too (I mean today or tomorrow, no kidding).
>
> I am of course interested in your feedback.
>
> Thanks in advance.
> Regards.
>
>
Great! I will try it tomorrow. Your timing is just perfect - we have just
finished testing in our x86 machine and we were getting ready to make
everything work in our IGEP.

Many thanks for the great work,
     -Felipe Brand=E3o Cavalcanti


> --
>                                             Gilles.
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Automation and Robotics Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--001636e90a217abed50485e48677
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/5/4 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gille=
s.chanteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span=
><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); paddi=
ng-left: 1ex;">
<div class=3D"im">Gilles Chanteperdrix wrote:<br>
&gt; No, will try and get a Xenomai-patched 2.6.30 running on IGEP real soo=
n<br>
&gt; now... However, ARM I-pipe patches for something more recent than 2.6.=
30<br>
&gt; should come soon, so, will not try really hard.<br>
&gt;<br>
<br>
</div>Hi Felipe,<br>
<br>
I finally had time to run Xenomai on IGEP. It almost worked out of the<br>
box (just had spurious irqs caused by the twl4030-irq driver using the<br>
I2C drive, a workaround being to disable the I2C irq line when writing<br>
to the I2C controller registers). If will be in the<br>
adeos-ipipe-2.6.33-arm-1.16-01 patch, for which you may have seen the<br>
pull request if you are subscribed to the adeos mailing list. And this<br>
patch will be part of the upcoming Xenomai 2.5.3 release, available real<br=
>
soon too (I mean today or tomorrow, no kidding).<br>
<br>
I am of course interested in your feedback.<br>
<br>
Thanks in advance.<br>
Regards.<br>
<br></blockquote><div><br>Great! I will try it tomorrow. Your timing is jus=
t perfect - we have=20
just finished testing in our x86 machine and we were getting ready to=20
make everything work in our IGEP.<br>
<br>
Many thanks for the great work,<br>
=A0=A0=A0=A0 -Felipe Brand=E3o Cavalcanti<br>=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb=
(204, 204, 204); padding-left: 1ex;">
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =A0 -Fe=
lipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Automation and Robotics La=
boratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =
=A0 UnB - University of Bras=EDlia, Brazil<br>
 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--001636e90a217abed50485e48677--


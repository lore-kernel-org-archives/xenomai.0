Message-ID: <307507.12667.qm@domain.hid>
Date: Mon, 9 Aug 2010 02:54:55 -0700 (PDT)
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1753008490-1281347695=:12667"
Subject: [Xenomai-help] Having trouble with a BeagleBoard GPIO interrupt pin
Reply-To: bob.feretich@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-1753008490-1281347695=:12667
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I am converting my second driver to RTDM. This one receives a negativing go=
ing edge triggered interrupt on GPIO133 of the OMAP3 chip.

I have...
ret =3D rtdm_irq_request(&adis_data_rdy_irq_handle, irq,=0D
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 adis_data_rdy_irq_handler,=
=0D
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 RTDM_IRQTYPE_EDGE,=20
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 "asuspidvr", ctx);
then...
ret =3D rtdm_irq_enable(&adis_data_rdy_irq_handle);

but the interrupt handler is never invoked.

cat /proc/xenomai/irq shows:
IRQ=A0=A0=A0=A0=A0=A0=A0=A0 CPU0
=A037:=A0=A0=A0=A0=A0=A0 15815=A0=A0=A0=A0=A0=A0=A0=A0 [timer]
=A039:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 asuspidvr
=A048:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 asuspidvr
=A091:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 asuspidvr
293:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 asuspidvr
418:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0 [virtual]

IRQ 293 in the interrupt that should be happening.

I can see the pulses on the input pin and the non-rt version of the driver =
sees the interrupts, so that excludes hardware issues and u-boot pin config=
uration issues.

Any suggestions?
Regards,
Bob Feretich


--0-1753008490-1281347695=:12667
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">I am converting my second driver to RTDM. Thi=
s one receives a negativing going edge triggered interrupt on GPIO133 of th=
e OMAP3 chip.<br><br>I have...<br>ret =3D rtdm_irq_request(&amp;adis_data_r=
dy_irq_handle, irq,=0D<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adis_data_rdy_irq_handler,=0D<=
br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTDM_IRQTYPE_EDGE, <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "asuspidvr"=
, ctx);<br>then...<br>ret =3D rtdm_irq_enable(&amp;adis_data_rdy_irq_handle=
);<br><br>but the interrupt handler is never invoked.<br><br>cat /proc/xeno=
mai/irq shows:<br>IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<=
br>&nbsp;37:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 15815&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [timer]<br>&nbsp;39:=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asuspidvr<br>&nbsp;48:&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; asuspidvr<br>&nbsp;91:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; asuspidvr<br>293:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asuspidvr<br>418:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [virtual]<br><br>IRQ 293 in the interrupt =
that should be happening.<br><br>I can see the pulses on the input pin and =
the non-rt version of the driver sees the interrupts, so that excludes hard=
ware issues and u-boot pin configuration issues.<br><br>Any
 suggestions?<br>Regards,<br>Bob Feretich<br><br></td></tr></table>
--0-1753008490-1281347695=:12667--


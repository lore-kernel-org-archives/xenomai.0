Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Mar 2008 11:02:44 +0100
Message-ID: <4E70056F9205354583FBC4273D5430FFF1AF10@domain.hid>
References: <4E70056F9205354583FBC4273D5430FFF1AA2A@svr-exc-01.intern.wipotec.de>
	<2ff1a98a0803070833xc04bf5du3efdc9c46b1badf2@domain.hid>
From: "Laux Karsten-Olaf" <karsten-olaf.laux@domain.hid>
Subject: Re: [Adeos-main] AT91SAM9263 and ipipe
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org


> From what I read in the AT91 headers, the difference between SAM9263 =
and other AT91s is that=20
> the TC interrupt is shared. Are you sure you do not get problems with =
this ?

Yepp, this is the "problem". The TCB-clock is not found in =
at91_ipipe_time.c: the setup-code looks for "at91_tc0", but there is =
only a "at91_tcb" clock.

Below is a patch which should avoid this problem. The patch was created =
on base of linux-2.6.24 + adoes-ipipe-2.6.24-arm-1.9.00.


Thanks for your hint,
Karsten.



>>>>>>>>>> SNIP >>>>>>>>>>><

--- at91_ipipe_time.c.orig	2008-03-14 08:00:25.000000000 +0100
+++ at91_ipipe_time.c	2008-03-14 08:04:55.000000000 +0100
@@ -239,7 +239,12 @@
 EXPORT_SYMBOL(__ipipe_mach_get_tsc);
=20
 static struct clocksource clksrc =3D {
+#if !defined(CONFIG_ARCH_AT91SAM9263)
 	.name   =3D "at91_tc" __stringify(CONFIG_IPIPE_AT91_TC),
+#else
+	// at91sam9263 only has a single TCB clock
+	.name   =3D "at91_tcb",
+#endif=09
 	.rating =3D 250,
 	.read   =3D __ipipe_mach_get_tsc,
 	.mask   =3D CLOCKSOURCE_MASK(64),
@@ -325,7 +330,12 @@
 }
=20
 static struct clk *tc, local_tc =3D {
+#if !defined(CONFIG_ARCH_AT91SAM9263)
 	.name		=3D "tc" __stringify(CONFIG_IPIPE_AT91_TC) "_clk",
+#else
+	// at91sam9263 only has a single TCB clock
+	.name   	=3D "tcb_clk",
+#endif=09
 	.users          =3D 0,
 	.type		=3D CLK_TYPE_PERIPHERAL,
 	.pmc_mask       =3D 1 << (KERNEL_TIMER_IRQ_NUM),

_____________________________________________________________________

Karsten-Olaf Laux=20
Electronic and Software Engineering OEM

Wipotec GmbH
Adam-Hoffmann-Str. 26=20
67657 Kaiserslautern

T +49.631.34146-0
F +49.631.34146-8640
http://www.wipotec.com

Precise, ultra fast weighing solutions - LIVE!
Interpack D=FCsseldorf | 24.-30.04.2008 | Hall15 - Stand B41=20

Legal information:
Wipotec Wiege- und Positioniersysteme GmbH
HRB 2317 Kaiserslautern, Management: T. D=FCppre, U. Wagner

This e-mail may contain confidential and/or privileged information.=20
If you are not the intended recipient (or have received this e-mail in =
error)
please notify the sender immediately and delete this e-mail. Any =
unauthorized=20
copying, disclosure or distribution of the material in this e-mail is =
strictly=20
forbidden.



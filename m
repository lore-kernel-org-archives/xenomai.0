Message-ID: <45D0937E.4000202@domain.hid>
Date: Mon, 12 Feb 2007 17:19:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] interrupts test
References: <775081.52919.qm@domain.hid>
In-Reply-To: <775081.52919.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2363382F54745C0070B709D1"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2363382F54745C0070B709D1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> Hi=20
> I have attached a  kernel module parint.c.When i insert parint.ko  into=
 kernel i get the following message from kernel .

This is not Xenomai-related.

>=20
> Request_irq returns 0
> Interrupt generated. You should see the handler-message
> Badness in enable_irq at kernel/irq/manage.c:126
>  [<c012da81>] enable_irq+0x68/0xdf
>  [<c80be033>] init_module+0x22/0x52 [parint]
>  [<c80be000>] handler+0x0/0x11 [parint]
>  [<c012c78a>] sys_init_module+0xb5/0x221
>  [<c0102898>] syscall_call+0x7/0xb
>=20
>=20
>=20
> Please if some one can point out the mistake i would be very helpful.
> Thanks.
>=20
> =20
> ---------------------------------
>  Get your own web address.
>  Have a HUGE year through Yahoo! Small Business.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> #include <linux/module.h>
> #include <linux/interrupt.h>
> #include <asm/io.h>
>=20
> #define BASEPORT 0x378
>=20
> static int handler(void)
> {
> 	// do stuff
> 	printk(">>> PARALLEL PORT INT HANDLED\n");
> 	return IRQ_HANDLED;
> }
>=20
> int xinit_module(void)
> {
> 	int ret;
> 	ret =3D request_irq(7, handler, SA_INTERRUPT, "parallelport", NULL);
> 	enable_irq(7);

I think someone already suggested to study the Linux Device Drivers
book. That one shouldn't state that you need the line above.

>         printk("\nRequest_irq returns %d \n",ret);
>=20
> 	//set port to interrupt mode; pins are output
> 	outb_p(0x10, BASEPORT + 2);=20
>=20
> //	printk("Generating interrupt now on all output pins (intr/ACK =3D pi=
n 10)\n");
> =09
> 	//generate interrupt
> 	outb_p(0, BASEPORT);
> 	outb_p(255, BASEPORT);
> 	outb_p(0, BASEPORT);
> //	printk("Interrupt generated. You should see the handler-message\n");=

> 	return 0;
> }
>=20
> void xcleanup_module(void)
> {
> 	disable_irq(7);
> 	free_irq(7, NULL);
> }
>=20
> module_init(xinit_module);
> module_exit(xcleanup_module);
> MODULE_LICENSE("GPL");
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enig2363382F54745C0070B709D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0JN+niDOoMHTA+kRAhIXAJ91090RD3Smwy1mff+Avtpc0pMRwgCfSu0c
+QNkbHIrNHxxUA/z8gnDUJ0=
=HhYv
-----END PGP SIGNATURE-----

--------------enig2363382F54745C0070B709D1--


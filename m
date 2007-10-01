Message-ID: <47013FAF.8040306@domain.hid>
Date: Mon, 01 Oct 2007 20:42:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <330902.482.qm@domain.hid>
In-Reply-To: <330902.482.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8936B07AD067A7FA67C57985"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Adeos-main] EBUSY error with rt_intr_create API
	for timer interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: poornima r <rpoornar@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8936B07AD067A7FA67C57985
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

poornima r wrote:
> Hello,
>=20
> I am trying to register an handler for the timer
> interrupt with the following call in my init_module()
> (kernel space) for xenomai domain.
>=20
> err =3D=20
> rt_intr_create(&intr_desc,"ir-xenomai",TIMER_INTERRUPT,
> &ir_handler,NULL, I_SHARED);

Xenomai questions are better addressed to Xenomai mailing lists. I moved
this thread therefore.

> =20
> When I try inseting my module, I get EBUSY error.
>=20
> Is there any problem with the interrupt object
> creation mode (I_SHARED)?
> Why is this error when interrupts can be shared
> between=20
> Xenomai and Linux?

Generally, sharing IRQs between the RT and the non-RT (Linux) domain is
a very tricky thing that quickly makes your box instable or at least
indeterministic.

Specifically for sharing the timer IRQ, the Xenomai with the help of the
I-pipe patch provides fine APIs so that you don't need to mess with
internals, just have a look at the docs. Because Xenomai already manages
the timer IRQ in the RT domain, rt_intr_create denies the access.

Jan


--------------enig8936B07AD067A7FA67C57985
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHAT+vniDOoMHTA+kRAiuNAJ0XtBnJz1oAIPQr+dr/0bGgoYcUfQCdHSRd
0L7kbWBz+RW9+gfSP4OmiDA=
=uEN9
-----END PGP SIGNATURE-----

--------------enig8936B07AD067A7FA67C57985--


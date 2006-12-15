Message-ID: <4582D86A.9020600@domain.hid>
Date: Fri, 15 Dec 2006 18:16:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] measuring external interrupt latency
References: <4582D4D0.3060404@domain.hid>
In-Reply-To: <4582D4D0.3060404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC671C77069D4FDF79B288706"
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
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC671C77069D4FDF79B288706
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Markus Franke wrote:
> Dear Xenomai users/developers,
>=20
> I want to measure external interrupt latencies. Therefore, I have a
> parallel port loopback connector (25 pins). Pin 9 (D7) and Pin 10 (ACK)=

> are connected. I would like to trigger an interrupt via Pin 9 and
> measure the time till the ISR is entered.

If you trigger the IRQ with the target itself, you do not generate
realistic load. Reason: the task (RT or not) flipping the related port
bit will always move the system into a similar state right before the
IRQ event. With an asynchronous external IRQ source, you can hit the
system in far more interesting states (given you generate adequate load,
see TROUBLESHOOTING).

>=20
> Can somebody give me a hint how to start writing such an application. I=

> read something about RTDM and I also had a look on the IRQ-Loop

Why do you want to rewrite the existing tests? As an exercise, or is
something missing? If the latter, I would rather suggest to enhance them
(and post patches afterwards :) ).

> testsuite. I am wondering whether I can reuse some of this code which i=
s
> written there. Besides, is it really necessary to use the RTDM framewor=
k?

Technically, you don't need RTDM, you could achieve most features also
via other skins (some scenarios will still require kernel space
nevertheless). We picked RTDM for the tests to benchmark scenarios you
will (should) have later on your real system as well: cleanly separated
applications talking to RTDM drivers controlling the hardware.

>=20
> Sorry, but I am really new to Xenomai. I just want to have some small
> hints how to start developing.
>=20
>=20
> Thanks in advance,
>=20
> Markus Franke
>=20

Jan


--------------enigC671C77069D4FDF79B288706
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgthrniDOoMHTA+kRAvsrAJ4thWu8Ku9ByP1Vl5T0SzNjEhBjigCfdzte
+PRvox4+d4kGgyeaY5nUUMQ=
=rR/u
-----END PGP SIGNATURE-----

--------------enigC671C77069D4FDF79B288706--


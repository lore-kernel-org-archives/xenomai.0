Message-ID: <44D2E878.2030509@domain.hid>
Date: Fri, 04 Aug 2006 08:26:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] testing interrupt latency
References: <1154615459.9835.62.camel@domain.hid>
In-Reply-To: <1154615459.9835.62.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig306E8306A404272662B2A556"
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
To: Bart Jonkers <jonkersbart@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig306E8306A404272662B2A556
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bart Jonkers wrote:
> Hey,
>=20
> I have written a small module to test the interrupt response time of
> Xenomai to compare it with the time of Linux.
>=20
> I generate an interrupt on a GPIO pin and toggles another GPIO pin in
> the interrupt service routine. (code below)
> The time between the generated interrupt and the value change on the
> GPIO pin is taken as interrupt response time.

Can we say that playing with such GPIO pins is a good generic way to
measure IRQ latencies on ARM platforms? If so, do you see a chance to
enhance the existing irqbench framework with this mechanism?

Jan


--------------enig306E8306A404272662B2A556
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0uh4niDOoMHTA+kRAnVwAJ9ledbaaQ35BjxrZQJ2H7fFxoPS/QCfRRXp
+fgf0Ok8dyvzqfoiEdOIXpE=
=iVjX
-----END PGP SIGNATURE-----

--------------enig306E8306A404272662B2A556--


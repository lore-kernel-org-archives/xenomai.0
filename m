Message-ID: <45360543.7010503@domain.hid>
Date: Wed, 18 Oct 2006 12:43:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT socket CAN architecture
References: <54b161f50610180247m71815adfu4082fcfd5d679c0f@domain.hid>
In-Reply-To: <54b161f50610180247m71815adfu4082fcfd5d679c0f@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig933438626E1C4EF6721499BC"
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig933438626E1C4EF6721499BC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> Hello everyone,
>=20
> I'm in the need of a realtime CAN driver which is as fast as possible
> and at
> the same time user-friendly. The RT socket CAN driver looks rather
> appealing
> to me, but I'm wondering if there's any negative impact on speed (in th=
e
> context of minimal response times) in using a socket approach.
> Also, is there any of you with some testresults?

Wolfgang once had some test results (and application code) on
hardware-based loopback latencies, maybe he can post them when time permi=
ts.

For sure, twiddling directly with the CAN hardware is always faster than
having generic layer(s) in between, but the impact of the CAN stack is
fairly small, specifically as we have a direct wake-up path from the IRQ
to the application on reception or TX buffer availability.

Do you have any scenario and/or numbers you would like to compare them
against?

Jan


--------------enig933438626E1C4EF6721499BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNgVDniDOoMHTA+kRAq2PAJwNOqMhPIgaAHwr5mRYTKj9loYENwCeJNEe
LdhhzBu1gYWXxKavzsy4fAA=
=jlxI
-----END PGP SIGNATURE-----

--------------enig933438626E1C4EF6721499BC--


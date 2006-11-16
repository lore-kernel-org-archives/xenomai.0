Message-ID: <455C8766.5030905@domain.hid>
Date: Thu, 16 Nov 2006 16:44:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid parameter for xeno_rtcan_mem.ko
References: <54b161f50611160723r355a603awc1d8e1234e5ed44d@domain.hid>
In-Reply-To: <54b161f50611160723r355a603awc1d8e1234e5ed44d@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1B83D52B76212CDB8DA68070"
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
--------------enig1B83D52B76212CDB8DA68070
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> Hello everyone,
>=20
> I tried to load the xeno_rtcan_mem module. I got a message that paramet=
er
> 'io' is unknown. After a modinfo I found out that the actual parameter
> should be 'mem'. I suggest you fix this, since it can be somewhat
> confusing.

I simple patch would explain better that you are referring to the
message in rtcan_mem_init(). And it would already fix the issue. :)

Jan


--------------enig1B83D52B76212CDB8DA68070
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXIdmniDOoMHTA+kRAg96AJ9zlNQFNObdIDjS0dSJgXIDwjRqiwCcDorA
xXSryAPDjpDDHBIYed5xtmY=
=5ckQ
-----END PGP SIGNATURE-----

--------------enig1B83D52B76212CDB8DA68070--


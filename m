Message-ID: <48731B11.80906@domain.hid>
Date: Tue, 08 Jul 2008 09:45:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <486E6486.5060000@domain.hid>
	<200807072312.57613.berlemont.hauw@domain.hid>
In-Reply-To: <200807072312.57613.berlemont.hauw@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig988EAADBBE59B116F3172B5E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] comedi: Fix include for do_div
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig988EAADBBE59B116F3172B5E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexis Berlemont wrote:
> Hi,
>=20
> Sorry for answering so lately, I was not at home the last four days.
>=20
>> Required with 2.6.26 where there is no more calc64. And asm/div64.h is=

>> what you actually want.
>=20
> Thanks.

Sorry, but the committed fix is bogus for 2.6.26. I would suggest just
to pick up what I proposed, kernel headers do the same since ages
(including 2.4).

Jan


--------------enig988EAADBBE59B116F3172B5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkhzGxUACgkQniDOoMHTA+kCVgCcDtLuRxWjw09YYlJ37GL00Mz2
+NAAn1YVfTJEAbMBWvFYoJDOYE1SF3Is
=RcvT
-----END PGP SIGNATURE-----

--------------enig988EAADBBE59B116F3172B5E--


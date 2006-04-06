Message-ID: <44357E5F.9020907@domain.hid>
Date: Thu, 06 Apr 2006 22:47:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Preventing kernel misconfiguration.
References: <17461.19934.435991.242022@domain.hid>
	<44354FDB.9060106@domain.hid>
In-Reply-To: <44354FDB.9060106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39428B70B3800B88E6BF0B92"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39428B70B3800B88E6BF0B92
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Here is a patch that "selects" the I-pipe option when Xenomai is
>> enabled, it should help preventing kernel misconfigurations.
>>
>=20
> We definitely need this.
>=20

What about thinking further: warn in the Xenomai menu (via "comment ...
if") when problematic switches like power management are on? Just a
quick idea.

Jan


--------------enig39428B70B3800B88E6BF0B92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENX5fniDOoMHTA+kRAmxdAJ4gJb+dLjwozZxAYT4vM1o2yuUa8wCbBf44
A2DPlzqYJueosoGjOUet6Gk=
=l/nw
-----END PGP SIGNATURE-----

--------------enig39428B70B3800B88E6BF0B92--


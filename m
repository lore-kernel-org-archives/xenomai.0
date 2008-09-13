Message-ID: <48CB64BC.1060607@domain.hid>
Date: Sat, 13 Sep 2008 08:59:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CAACEF.3010902@domain.hid>
In-Reply-To: <48CAACEF.3010902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAE201F78BBC01183478B575"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai for SH4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pavel Bartusek <pavel.bartusek@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDAE201F78BBC01183478B575
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Bartusek wrote:
> Hello,
>=20
> I'd like to use Xenomai on SH4 architecture and it seems it is not in
> the list of supported architectures now. There were some attempt in the=

> past to port Xenomai to SH4 architecture
> (http://article.gmane.org/gmane.linux.real-time.xenomai.users/858/match=
=3Dxenomai+sh4)
> Unfortunately, it seems it the patch hasn't been integrated to the
> mainstream Xenomai. Does somebody have the patch or is somebody working=

> on the port  for SH4 now ?

As far as I know, that patch never saw any public light, so we were
unable to even review it. Dunno what happened to this effort, if it was
stopped or if there is now some Xenomai-based SH4 product being shipped
without providing the GPL sources... Maybe you want to contact that guy
directly, asking for the state.

Otherwise, a new effort would be welcome, and I can only encourage doing
it differently (release often, release early).

Jan


--------------enigDAE201F78BBC01183478B575
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjLZLwACgkQniDOoMHTA+n37gCdFwdOEwEWilypR2DyROM1Fl+0
HI8An24AcD1swgJNyA7cDqgxmNsbmDIb
=U8GO
-----END PGP SIGNATURE-----

--------------enigDAE201F78BBC01183478B575--


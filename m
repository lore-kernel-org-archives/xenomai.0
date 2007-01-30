Message-ID: <45BF0E00.3020202@domain.hid>
Date: Tue, 30 Jan 2007 10:21:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai Bits on MIPS
References: <400777.67348.qm@domain.hid>
In-Reply-To: <400777.67348.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F78AB07E64B8B6CE5DEF295"
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
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F78AB07E64B8B6CE5DEF295
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

somshekar kadam wrote:
> Hi All,=20
>=20
>   I am porting Xenomai on MIPS, I am beginner o
> Xenomai, please help me in understanding this point.=20
>=20
> whats the purpose of bits directory in include
> directory, please throw some light on this, I see it
> for 64 bit adoption , correct me if am wrong, what are
> the depedency of it on xenomai.=20
>=20
> Please comment.=20

Yes, but first on the netiquette:

 o Please don't reply to arbitrary threads when starting a new one, it
   confuses people's mail clients.

 o Please don't put arbitrary people in CC when starting a new thread.

Now on the bits directory: It contains arch-dependent internal helper
functions of the related nucleus core modules. Check them carefully for
potential adoptions that might be required on MIPS.

Jan


--------------enig4F78AB07E64B8B6CE5DEF295
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFvw4AniDOoMHTA+kRAuXfAJ99ZlFsKTDPkufxwoD0mpvnQkmkdwCeOoTt
iGs/Fz+LfPVEi2L3AS9tPjc=
=0/BQ
-----END PGP SIGNATURE-----

--------------enig4F78AB07E64B8B6CE5DEF295--


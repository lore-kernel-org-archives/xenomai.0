Message-ID: <45C4A7E2.8080903@domain.hid>
Date: Sat, 03 Feb 2007 16:18:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rtdm over x86_64
References: <200702031313.20104.paul_c@domain.hid> <45C4A580.3000904@domain.hid>
In-Reply-To: <45C4A580.3000904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9010E846A87FB9BDCAC80F64"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9010E846A87FB9BDCAC80F64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> But first I need some build environment. A quick shot ended here when
> trying to configure a patch and prepared 2.6.19 kernel:
>=20
> # make ARCH=3Dx86_64 CC=3D"gcc -m64" oldconfig
> ...
> init/Kconfig:572: can't open file "arch/x86_64/xenomai/Kconfig"
>=20
> Anyone any idea? Is something missing, or is the prepare script broken?=


Obviously a missing commit. Philippe?


--------------enig9010E846A87FB9BDCAC80F64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFxKfiniDOoMHTA+kRApWXAJ9UeDhletkLOoGZmVDW7RJ5PseB0ACeMMRP
nb2YI+lOhqEHoIywHpgDRn0=
=dy8p
-----END PGP SIGNATURE-----

--------------enig9010E846A87FB9BDCAC80F64--


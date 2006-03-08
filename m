Message-ID: <440F15C9.1020509@domain.hid>
Date: Wed, 08 Mar 2006 18:35:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Error on rtdm skin with --enable-dox-doc
References: <200603081421.10284.lbocseg@domain.hid>
In-Reply-To: <200603081421.10284.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE06CBF93A103A9030402777E"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE06CBF93A103A9030402777E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan,
>=20
> When compiling svn xenomai I noticed the following error with --enable-=
dox-doc=20
> switch:
>=20
> CC [M]  kernel/xenomai/skins/rtdm/drvlib.o
> kernel/xenomai/skins/rtdm/drvlib.c:1513:1: error: unterminated #ifdef
>=20

I just passed this stage with trunk revision 671 without problems
(doxygen 1.4.4). Moreover, there is no #ifdef or related preprocessor
stuff in the latest drvlib.c at line 1513.

Jan


--------------enigE06CBF93A103A9030402777E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDxXJniDOoMHTA+kRAqr7AJ490r3ywmuxFCk2GbikVJzYm+61bACeI73s
jtCtcrCd4lIZ5Ty/7ZiZ0KM=
=H0AF
-----END PGP SIGNATURE-----

--------------enigE06CBF93A103A9030402777E--


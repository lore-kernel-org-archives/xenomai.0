Message-ID: <48E8AFB4.4040208@domain.hid>
Date: Sun, 05 Oct 2008 14:14:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1KmEP8-0003wS-5y@domain.hid>
In-Reply-To: <E1KmEP8-0003wS-5y@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0761B403DF16D1DFE89FA659"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-commits] r4210 - in /trunk:
	ChangeLog	src/skins/native/task.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0761B403DF16D1DFE89FA659
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Author: gch
> Date: Sat Oct  4 23:11:09 2008
> New Revision: 4210
>=20
> URL: http://svn.gna.org/viewcvs/xenomai?rev=3D4210&view=3Drev
> Log:
> Call __real_pthread_setschedparam in order to inform the libc of the sc=
heduling parameters change.

Well, I dropped this idea after realizing that it will kick us out of
primary mode in all cases. This change is an improvement (/wrt Linux
scheduling accuracy) for borderline threads, but it will cause
regressions for primary-only threads. I have no idea right now how to
make both happy, at least without explicit pthread_setschedparam
invocations by the user application.

Jan


--------------enig0761B403DF16D1DFE89FA659
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjor7gACgkQniDOoMHTA+m63QCdF5b9JLcZBAcEh18nhHlNNG1l
um8AnRzvjLBtHstYRxruRvAtSCRLRrzv
=ldsY
-----END PGP SIGNATURE-----

--------------enig0761B403DF16D1DFE89FA659--


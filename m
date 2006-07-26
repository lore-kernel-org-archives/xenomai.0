Message-ID: <44C70EF2.3060405@domain.hid>
Date: Wed, 26 Jul 2006 08:42:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot running again. rtnet does not compile,
	small error in sim testsuite.
References: <200607260652.58806.niklaus.giger@domain.hid>
In-Reply-To: <200607260652.58806.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96234091D4D9137A38946A14"
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96234091D4D9137A38946A14
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> Back from my vacation I discovered that the buildbot did not run during=
 my=20
> absence as I had added a (debugging) printf some time before vacation. =
This=20
> printf did not harm as long as the session was alive. But before leavin=
g I=20
> cleanup my desktop and bang the xenomai repository watcher got killed. =
Sorry!
>=20
> I fixed the error and now the buildbot is running again.
>=20
> RTnet seems to have a compile problem: see
> http://ngiger.dyndns.org/buildbot/tqm860/builds/227/step-mk_RTnet/0
> In file included from rtnet_ifs.c:30:
> ../../../stack/include/rtnet.h:29:23: rtdm/rtdm.h: No such file or dire=
ctory
> rtnet_ifs.c: In function `main':
> <..>

Seems to me like you do not install the Xenomai user-space part
properly. At least I'm not able to find any "make install" in the logs.
As a result, there are no headers like rtdm/rtdm.h under
/usr/include/xenomai (i.e. the include path xeno-config tells to RTnet).

>=20
> The timing behaviour seems to have changed a little bit as the simulato=
r=20
> testsuite reports in:
> http://ngiger.dyndns.org/buildbot/sim/builds/213/step-check_sim/0
> vxworks->t010823-2:t010823-2.c:163: Expected sequence: SEQ("Test2",2009=
); got=20
> SEQ("Test2",2002)
> vxworks->t010823-2: t010823-2.c:166, test finished: 1 failures/ 33 test=
s
>=20
> Best regards
>=20

Thanks,
Jan



--------------enig96234091D4D9137A38946A14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFExw72niDOoMHTA+kRAr0IAJ9HfYNXLQINvRn9oMVWVmdryLGr+wCcCYPU
50+8LEVI1aE25GcEganWcXM=
=4oJR
-----END PGP SIGNATURE-----

--------------enig96234091D4D9137A38946A14--


Message-ID: <46265B29.1050100@domain.hid>
Date: Wed, 18 Apr 2007 19:53:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <88AEA5AC18A141439A0D954EB037B0D30439F5B4@domain.hid>
In-Reply-To: <88AEA5AC18A141439A0D954EB037B0D30439F5B4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig98F667A4AA13593219BEB54D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Ipipe and Siemens A&D Realtime
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98F667A4AA13593219BEB54D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Krause, Karl-Heinz wrote:
> Hi Philippe
>=20
> =20
>=20
> as promised some time ago, I'd like to let you know the result of our w=
ork.
>=20
> Attached are=20
>=20
> -          a few recycled slides from a presentation describing motivat=
ion, features and results
>=20
> -          the patch file for a  adeos-ipipe-2.6.15-i386-1.3-04.patch  =
patched kernel2.6.15.4=20

You attached the glibc patches, but your ipipe variant is missing. Could
you also explain a bit what kind of optimisations your ipipe version
contains, maybe they are of generic interest and we can discuss a
potential integration? And a description of the features/hooks it adds
would be good as well. That might help to restart a discussion if there
is more common ground and a chance to merge.

>=20
> Since some parts of the kernel functionality (clock registration, realt=
ime capable message queues) and=20
>=20
> most parts of the glibc changes are also of  interest for the  RT_PREEM=
PT solution we are in contact with=20
>=20
> Thomas Gleixner trying to leverage the work.
>=20
> An update to newer versions of  kernel and glibc (basically  because of=
 the PI mutexes) is planned for later,
>=20
> presumably when RT_PREEMPT  has become mainline status.
>=20

Hmm, so your approach is locked to 2.6.15 for now? What is blocking
kernel / ipipe updates?

> =20
>=20
> If you need any further information just let me know.
>=20

According to your slides, you did a lot of concrete testing. Do you
happen to have comparative numbers of recent Xenomai's POSIX skin as
well (forgetting about the ABI issue for the moment)? Or do you have a
releasable test suite?

Jan


--------------enig98F667A4AA13593219BEB54D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJlsxniDOoMHTA+kRAqN7AJ46NmSzmTEQ3gtlVqGGGAAXtXPr2wCeJQ9D
H/quIrx+rVnFIsbIaswcfMg=
=japF
-----END PGP SIGNATURE-----

--------------enig98F667A4AA13593219BEB54D--


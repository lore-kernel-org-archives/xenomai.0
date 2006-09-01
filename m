Message-ID: <44F814F2.8070402@domain.hid>
Date: Fri, 01 Sep 2006 13:09:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.2.x broken (r1534)
References: <44F80898.3030203@domain.hid>
In-Reply-To: <44F80898.3030203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig91CF5FC09B7F262E50A91070"
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
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91CF5FC09B7F262E50A91070
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> I just did a fresh checkout of the v2.2.x and it does not compile:
>=20
> gcc: pthread_create: No such file or directory
> gcc: pthread_detach: No such file or directory
> gcc: pthread_setschedparam: No such file or directory
> gcc: pthread_getschedparam: No such file or directory
> gcc: pthread_yield: No such file or directory
> gcc: sched_yield: No such file or directory
> gcc: sem_init: No such file or directory
> gcc: sem_destroy: No such file or directory
> gcc: sem_post: No such file or directory
> ...
>=20
>=20
> Any idea of what's broken?
>=20

Confirmed. Looks the me like the backport of the @file posix wrapping is
broken (rev #1525). If you want to dig deeper, compare with SVN head.

Jan


--------------enig91CF5FC09B7F262E50A91070
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE+BTyniDOoMHTA+kRAkJNAJ4jfCAl4W4biwtloNxKMXpZjj4iEQCghKeh
whpFxQZk2PM1ROSwWeYGgFE=
=E/eg
-----END PGP SIGNATURE-----

--------------enig91CF5FC09B7F262E50A91070--


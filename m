Message-ID: <455F4A24.8060408@domain.hid>
Date: Sat, 18 Nov 2006 19:00:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot: Errors building rtnet since at least
	r1834
References: <200611181818.17629.niklaus.giger@domain.hid>
In-Reply-To: <200611181818.17629.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF9C6E3B38819679A1216444"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF9C6E3B38819679A1216444
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi
>=20
> Unfortunately I cannot say since when this build is broken, as I had to=
=20
> reinstall the buildbot on my main server. But this particular build tar=
get=20
> should not have been affected. (Same compiler, same build slave, same=20
> scripts)
>=20
> But since at November 12 I get the following errors in my builds:
> See http://ngiger.dyndns.org/buildbot-full/tqm_f/builds/0/step-mk_RTnet=
/1
> libtool: link: warning: library=20
> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' wa=
s=20
> moved.
> libtool: link: warning: library=20
> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was move=
d.
> libtool: link: warning: library=20
> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/libpthread_rt.la' wa=
s=20
> moved.
> libtool: link: warning: library=20
> `/var/buildbot/install/tqm_f-r1834/usr/xenomai/lib/librtdm.la' was move=
d.
>=20
> Has anybody a hint, what the reason could be?

DESTDIR issue? Are you compiling both Xenomai and RTnet with the same
DESTDIR?

Check what's stated in those .la files and compare with the RTnet build
parameters.

Jan

PS: This is a *warning*, not a fatal *error*. Or did you just want to
receive more attention? ;)


--------------enigCF9C6E3B38819679A1216444
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFX0opniDOoMHTA+kRAt4cAJ9urRn71HdSgf6gPSRv2M8aG+k/VwCbBc6g
ddzQGS7hqtaUUzUPcP839GQ=
=f42X
-----END PGP SIGNATURE-----

--------------enigCF9C6E3B38819679A1216444--


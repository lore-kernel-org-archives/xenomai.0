Message-ID: <44DB1865.90004@domain.hid>
Date: Thu, 10 Aug 2006 13:28:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] expected output and runtime of switchtest ?
References: <44DA896F.9060102@domain.hid>
In-Reply-To: <44DA896F.9060102@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig976BA93379E801F413C1C4FF"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig976BA93379E801F413C1C4FF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
>=20
>=20
> soekris:/usr/xenomai/testsuite/switchtest# modprobe xeno_switchtest
> [  160.221018] Xenomai: starting RTDM services.
> soekris:/usr/xenomai/testsuite/switchtest#
> soekris:/usr/xenomai/testsuite/switchtest# switch -n
> soekris:/usr/xenomai/testsuite/switchtest# switch rtk0
> cpu 0: 498
> cpu 0: 998
> cpu 0: 1498
> cpu 0: 2000
> cpu 0: 2496
> cpu 0: 2998
> cpu 0: 3498
> cpu 0: 3998
> cpu 0: 4500
>=20
> ...
>=20
> This prog has been running for atleast 1/2 hr,
> with minimum args..
>=20
> what should it be doing ?

This is a regression test. You should see an error message or a system
crash if something goes wrong. The output above looks ok (number of
passed loops, kind of lifesign).

Jan


--------------enig976BA93379E801F413C1C4FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE2xhqniDOoMHTA+kRAiJfAJ4j0LAy/4Y1wTRo6Lhil0mmRmoglQCeP0hL
p8YAuQUeL61emCcKSJdkEdU=
=7Rqz
-----END PGP SIGNATURE-----

--------------enig976BA93379E801F413C1C4FF--


Message-ID: <43CFE1EE.5060502@domain.hid>
Date: Thu, 19 Jan 2006 20:01:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtbenchmark
References: <200601191535.16322.lbocseg@domain.hid>
In-Reply-To: <200601191535.16322.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3118F12CD7B6A69B1D635C81"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3118F12CD7B6A69B1D635C81
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Jan, what is rtbenchmark for?
>=20
> Is there any written program along xenomai that uses this module?
>=20

testsuite/latency. Try with -t1|2 for timed kernel task or timer
handler. The benchmark device implements the test routines, and it also
exports the ipipe tracer's interface to userspace. latency -f makes use
of it to freeze a back-trace of the worst case jitter.

Jan


--------------enig3118F12CD7B6A69B1D635C81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDz+HuniDOoMHTA+kRAlhyAJ9lBK97p2yvPtiLT0aa43Mpp3iY0gCdG2Ri
T321eDLz3L1TyIcOsOW2Y8c=
=3Fls
-----END PGP SIGNATURE-----

--------------enig3118F12CD7B6A69B1D635C81--


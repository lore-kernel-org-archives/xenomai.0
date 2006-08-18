Message-ID: <44E6009E.7020304@domain.hid>
Date: Fri, 18 Aug 2006 20:02:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
	<44E5F0B4.8070405@domain.hid>
In-Reply-To: <44E5F0B4.8070405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF865385D134672C6EE4029A"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Test, benchmark
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF865385D134672C6EE4029A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> ...
> just responding to small part now..
>=20
> this patch adds switchtest, switchbench (and drops switch) and irqbench=
=2E
>=20
> each test-prog has a corresponding $XENOT_<progname>
> with which you can inject new test arguments individually.
> Most of these can be undef'd, except for XENOT_IRQBENCH,
> which needs to be set in order for test to run (since the test requires=

> additional resources, as you noted above)

I doesn't necessarily require additional parameters (default is the
first serial port on PCs).

Why not adding a switch to xeno_test instead? Something like "-a
<additional-tests>" (e.g. "-a irqbench,whateverbench"). However, please
don't forget to document this extension (man page?).

Jan


--------------enigCF865385D134672C6EE4029A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5gCeniDOoMHTA+kRAsxyAJ9xtxyYegAi+CYBYiZSRBp6V2N1KgCfTy0k
TFgAMHMJggNKBiReQcqguhY=
=dLW2
-----END PGP SIGNATURE-----

--------------enigCF865385D134672C6EE4029A--


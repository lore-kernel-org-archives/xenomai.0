Message-ID: <456D6451.3030705@domain.hid>
Date: Wed, 29 Nov 2006 11:43:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFB1D798B9898506EF0C2774D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] Xenomai examples repository
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB1D798B9898506EF0C2774D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

we had this topic a few times before, but it's getting more and more
urgent now: How to establish a repository for Xenomai example code?

I think we have basically two options:

 A) create /examples/<skin>, including /examples/rtdm/<profile> in the
    SVN

 B) create corresponding pages in the wiki

Option A) has the advantage that we could easily integrate the example
build in the regular build process (when building SVN check-outs), track
API changes, and keep the examples in sync that way.

Option B) would be easier to maintain by non-core developers as the wiki
is open for anyone. Both options require some review of the examples
anyway, but B) would allow to relax the process a bit.

Please comment everyone, even if your are "only" a user, but maybe
interested in contributing example code in the future.

Mahlzeit,
Jan


--------------enigFB1D798B9898506EF0C2774D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbWRRniDOoMHTA+kRAmMjAJ9dJmllLEQog1DD/Bpk6NzZiTZmtwCePXtK
x3zNIdAa81inW4fTDG8givY=
=8dZg
-----END PGP SIGNATURE-----

--------------enigFB1D798B9898506EF0C2774D--


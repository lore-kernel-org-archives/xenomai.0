Message-ID: <44195924.9090709@domain.hid>
Date: Thu, 16 Mar 2006 13:25:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigABB49EC2E24C6118443C92C4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] POSIX include problem
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
--------------enigABB49EC2E24C6118443C92C4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

don't know yet what's going wrong, but the following demo code doesn't
compile against the POSIX skin due to unresolved SIG_BLOCK:

#include <pthread.h>
#include <signal.h>

int main()
{
        return SIG_BLOCK;
}

Comment out the pthread include, and it will work again. Any ideas?

Jan


--------------enigABB49EC2E24C6118443C92C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGVkkniDOoMHTA+kRAjJdAJ48gsok3F1UmvAMoII+mWOVKu+I9gCfRiVF
HryE1Hb+AspZUn0KVQYFIFo=
=tRNi
-----END PGP SIGNATURE-----

--------------enigABB49EC2E24C6118443C92C4--


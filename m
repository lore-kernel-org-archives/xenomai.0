Message-ID: <48F3C3E4.4020801@domain.hid>
Date: Mon, 13 Oct 2008 23:55:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFB7CD4DAFCA4CB34C4F8FFE5"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] __thread instead of pthread_get/setspecific
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB7CD4DAFCA4CB34C4F8FFE5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

looking into the "xeno_in_primary_mode" thing I wondered how to make the
thread state quickly retrievable. Going via pthread_getspecific as we do
for xeno_get_current appears logical - but not optimal. Though
getspecific is optimized for speed, it remains a function call, a few
sanity checks, and only finally a TLS variable access. That could be
achieved in a much lighter way by using a __thread variable.

But can we assume that all target we support also support the __thread
storage class? TLS is surely mandatory now: I assume pthread_getspecific
would become non-RT safe without it, right? Is there anything we
can/must check for during configure to verify __thread support?

Jan


--------------enigFB7CD4DAFCA4CB34C4F8FFE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjzw+gACgkQniDOoMHTA+kJSgCffbPyjymFQcZUEljDeLRV/k7a
26QAoIAZB7ysj85YP0c5qYzJX1VK+qD3
=Uk/L
-----END PGP SIGNATURE-----

--------------enigFB7CD4DAFCA4CB34C4F8FFE5--


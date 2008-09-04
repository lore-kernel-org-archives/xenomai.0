Message-ID: <48BF8AA6.6090702@domain.hid>
Date: Thu, 04 Sep 2008 09:13:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFF35ECC5E85E76FB8C5F3E62"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] First thoughts on fast xnsynch
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
--------------enigFF35ECC5E85E76FB8C5F3E62
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

I spent a few brain cycles on the design of a generic fast-lock via
xnsynch. The first thing was defining the lock word and going through
its use cases.

You suggested to realize lock stealing directly in user space, but I
don't see now how this should work reasonably. Our problem is that we
would have to atomically check for the woken state AND compare the
current priority against the owner ones. Imaginable only if we replicate
the priorities into the lock word - but this makes things at least
horribly complicated (e.g. when priorities change). So I think we have
to drop this goal. Or what did you have in mind?

Jan


--------------enigFF35ECC5E85E76FB8C5F3E62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAki/iqoACgkQniDOoMHTA+kByACfdIU054/S9A2t1Rsh7aN0GAsU
1o8Anj1+RdL4BVUBbqy0VlYtTZN621mx
=WOFl
-----END PGP SIGNATURE-----

--------------enigFF35ECC5E85E76FB8C5F3E62--


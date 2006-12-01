Message-ID: <45704CAB.5060502@domain.hid>
Date: Fri, 01 Dec 2006 16:39:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E84456974DE32EC4C7164DA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] libnative versioning
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
--------------enig6E84456974DE32EC4C7164DA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

we just had some fun here with incompatible native libraries. A program
was built against some 2.2 release and was then started on a target with
2.3 libs installed. The result: undefined symbol rt_mutex_lock. The
reason: this function was renamed to rt_mutex_acquire in trunk to
resolve a naming conflict in recent kernels.

So we now have incompatible libraries and should either increment some
version number of libnative or export the necessary aliases for
lock/unlock. What is preferred?

Jan


--------------enig6E84456974DE32EC4C7164DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFcEyrniDOoMHTA+kRAjgxAJ4gpc2bP0WKQX2AkTqK4ncXQXRKwQCbB5LR
wejqDWlYN6EaZovGyVzsNcw=
=tAmE
-----END PGP SIGNATURE-----

--------------enig6E84456974DE32EC4C7164DA--


Message-ID: <45DC0623.3080706@domain.hid>
Date: Wed, 21 Feb 2007 09:43:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig47253CCFC252175620A23037"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Enhanced RTDM device closure
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
--------------enig47253CCFC252175620A23037
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

a few changes of the RTDM layer were committed to trunk recently. They
make handling of RTDM file descriptors more handy:

 o rt_dev_close/POSIX-close now polls as long as the underlying device
   reports -EAGAIN. No more looping inside the application is required.
   This applies to the usual non-RT invocation of close, the corner
   case "close from RT context" can still return EAGAIN.

 o Automatic cleanup of open file descriptors has been implemented. This
   is not yet the perfect design (*), but a straightforward approach to
   ease the cleanup after application crashes or other unexpected
   terminations.

The code is still young, so testers are welcome.

Jan


(*) Actually, I would like to see generic per-process file descriptor
tables one day, used by both the POSIX and the RTDM skin. The FD table
should be obtained via xnshadow_ppd_get(). But first this requires
lock-less xnshadow_ppd_get() based on ipipe_get_ptd() to keep the
overhead limited. Yet another story.


--------------enig47253CCFC252175620A23037
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3AYkniDOoMHTA+kRArGcAJ0aJI44Ef4dzBqa0xraAngzBqyYKwCfRMdS
w4P3H2RkcysH9PtYFOVifZ8=
=/GLf
-----END PGP SIGNATURE-----

--------------enig47253CCFC252175620A23037--


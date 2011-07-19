Message-ID: <4E2527B2.3030305@domain.hid>
Date: Tue, 19 Jul 2011 08:44:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5683433C91A26211AAB07BCF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] Fixes for domain migration races
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5683433C91A26211AAB07BCF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I've just uploaded my upstream queue that mostly deals with the various
races I found in the domain migration code.

One of my concerns raised earlier turned out to be for no reason: We do
not allow Linux to wake up a task that has TASK_ATOMICSWITCH set. So the
deletion race can indeed be fixed by the patch I sent earlier. However,
we do not synchronize setting and testing of TASK_ATOMICSWITCH (because
we cannot hold the rq lock), thus we still face a small race window that
allows premature wakeups, at least in theory. That's now addressed by
patch 3.

Besides another race around set/clear_task_nowakeup, there should have
been a window during early migration to RT where we silently swallowed
Linux signals. Closed by patch 4, hopefully also fixing our spurious gdb
lockups on SMP boxes - time will tell.

Please review carefully.

Jan


--------------enig5683433C91A26211AAB07BCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4lJ7YACgkQitSsb3rl5xSHqACfTh3v3r0nVB0kNeoW5828zyAU
N+wAn3Z0E6Ajl3WVeGQR12R6QnfcX3pF
=ZCJ6
-----END PGP SIGNATURE-----

--------------enig5683433C91A26211AAB07BCF--


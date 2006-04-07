Message-ID: <44361837.9080206@domain.hid>
Date: Fri, 07 Apr 2006 09:43:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig87C9A22A88FF95D7351B1AFD"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] nkpod->watchdog_trigger per CPU?
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
--------------enig87C9A22A88FF95D7351B1AFD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

analysing the watchdog characteristics in our scenarios, I just wondered
if it is SMP-aware (we have no SMP in use, it's a pure analytical concern=
).

The watchdog timeout is stored system-wide in nkpod->watchdog_trigger,
but it is based on a per-CPU clock (TSC). Is the tick IRQ bound to a
specific CPU in SMP scenarios so that this doesn't matter? Or am I just
overseeing some detail?

Jan


--------------enig87C9A22A88FF95D7351B1AFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENhg4niDOoMHTA+kRAjatAJ9WH+qiU4NXODh290/GgeO4pUmsHQCfbOEi
pRmA4fNqk5epAtH96DWOe64=
=BKm6
-----END PGP SIGNATURE-----

--------------enig87C9A22A88FF95D7351B1AFD--


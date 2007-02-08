Message-ID: <45CAE190.6020404@domain.hid>
Date: Thu, 08 Feb 2007 09:38:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig165AE766E137D1600DA8E33F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Fixed two timer base regressions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig165AE766E137D1600DA8E33F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

the "trivial" bugs are fixed already: see #2152 for the reason why
rt_dev_read timeouts took too long (the timer mode was ignored by
xnsynch_sleep_on), and I also found a yet invisible bug in
rtdm_toseq_init that would have picked the wrong time base (#2153).

Now just that rtcanrecv issue remains...

Jan


--------------enig165AE766E137D1600DA8E33F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFyuGQniDOoMHTA+kRAvi9AJ0QlkFnRFW6oN8OMFNJJMp7iXMMDACfYWWP
DPqAv5j9W+ijAWMKLBn0Jw0=
=XwZP
-----END PGP SIGNATURE-----

--------------enig165AE766E137D1600DA8E33F--


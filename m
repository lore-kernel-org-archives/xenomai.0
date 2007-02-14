Message-ID: <45D35545.20100@domain.hid>
Date: Wed, 14 Feb 2007 19:30:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E93586BBD1A37B08535C997"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] RT-CAN tx_sem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E93586BBD1A37B08535C997
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

fiddling with the CAN utils, I noticed the behaviour that rtcansend on
freshly registered but stopped devices simply blocks. And when you
meanwhile call rtcanconfig up on that device, rtcansend will continue to
block.

The reason is that during startup of CAN devices the tx-semaphore is
re-initialised while it is already set up during device registration.
Re-init on an already initialised rtdm_sem is, say, undefined.

So rtdm_sem should better only be initialised/destroyed by the drivers.
Trying to send on a shut down CAN device could be catched differently,
e.g. via the device state. This likely needs more thoughts, take it as a
note that $something should be done.

Jan


--------------enig7E93586BBD1A37B08535C997
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF01VFniDOoMHTA+kRAkbzAJ49r+l0AjQrnkHb1WRe0pmusnjrIACfefOy
U6tauGDNX3Deqc/yPjdyEsk=
=0szF
-----END PGP SIGNATURE-----

--------------enig7E93586BBD1A37B08535C997--


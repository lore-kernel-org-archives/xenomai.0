Message-ID: <44DCA9DC.1000509@domain.hid>
Date: Fri, 11 Aug 2006 18:01:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD6325AFCCB7E57C827E10B7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] CAN stack merged
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>, Philippe Gerum <rpm@xenomai.org>, xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD6325AFCCB7E57C827E10B7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

I just hit enter, and all the nice CAN code is now in SVN head. We only
need a check-in of a bootstrap run with the fitting autotool versions.
Philippe, could you do this? [Meanwhile, one can also run it locally
after checking out from SVN.]

Both the drivers and the tools were merged. You find the latter under
src/utils/can. rtcanconfig will be installed to <prefix>/sbin,
rtcansend/resc go to <prefix>/bin.

Wolfgang suggested to collect driver documentation under doc/drivers/,
maybe this is better than having it in the driver's source directory (or
under doc/txt like for irqbench or 16550A).

The utils README should be converted to man pages. Unless Wolfgang
already started this (but he didn't sound like that ;) ): anyone willing
to volunteer?

Many thanks again to the contributors of RT-Socket-CAN! I'm convinced
this is a significant milestone for CAN support under real-time Linux in
general and, of course, specifically under Xenomai.

Jan


--------------enigBD6325AFCCB7E57C827E10B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE3KncniDOoMHTA+kRAslJAJ4yRTvaTDy6XqygHmt+EHNUUDlzeACfffhu
Tvrs0MALipUShSYIgqOupoo=
=/UdV
-----END PGP SIGNATURE-----

--------------enigBD6325AFCCB7E57C827E10B7--


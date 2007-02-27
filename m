Message-ID: <45E4401F.3050904@domain.hid>
Date: Tue, 27 Feb 2007 15:28:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0FE226F0C9411CAC45847EA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [CAN] SIOC* clash
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
--------------enigA0FE226F0C9411CAC45847EA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

just realised that there is an ABI mine laid in rtcan.h:

#ifndef SIOCGIFINDEX
#define SIOCGIFINDEX \
            _IOWR(RTIOC_TYPE_CAN, 0x00, struct ifreq)
#endif

So, if you happen to have included sys/ioctl.h earlier in your
application, an incompatible IOCTL code will be used in user space.

I recommend to switch to existing IOCTL codes where available (that's
what we do in RTnet as well). This may also mean betting on the current
IOCTL assignments in Socket-CAN, that they will survive unchanged the
eventual merge into Linux mainline.

Jan


--------------enigA0FE226F0C9411CAC45847EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5EAfniDOoMHTA+kRAnm0AJ4kOwu3VL4Z8ul0AKXktObHYbiIVQCfXnn1
/ZVSXp41Io0ksfVfo6Hco2I=
=3+fw
-----END PGP SIGNATURE-----

--------------enigA0FE226F0C9411CAC45847EA--


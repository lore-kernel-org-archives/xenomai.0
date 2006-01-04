Message-ID: <43BBDA7D.3020600@domain.hid>
Date: Wed, 04 Jan 2006 15:23:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig13EFEF430F833F45B9D38582"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] "xenomai" prefix in RTDM userspace includes
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
--------------enig13EFEF430F833F45B9D38582
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

the current RTDM profile headers (so far only rtserial.h and
rtbenchmark.h) suffer from the "xenomai" prefix in the include path.
This was introduced with 2.1. An example: rtserial.h contains "#include
<xenomai/rtdm/rtdm.h>" which is fine in kernel space but requires that -
in my eyes - ugly "xenomai"->"." link in the installation include dir.
Moreover, it makes the RTDM profile headers Xenomai-specific (what they
are not).

The orginal (but nowhere stated - yeah) idea was to always have a
"rtdm/" dir in the include path whenever writing a RTDM driver or
application for some supported environment. So I would rather like to
see the Makefiles for Xenomai's RTDM drivers fixed in this regard,
simply by adding

EXTRA_CFLAGS += -Iinclude/xenomai

This would allow to use the generic "#include <rtdm/rtdm.h>" in the
profile headers again. Tweaking the Makefiles instead of the headers is
also the way we handled this for drivers outside Xenomai (RTnet,
rt_sja1000, ...).

Objections?

Jan


PS: A cleanup of the RTDM userspace header installation is scheduled -
only rtdm.h + the profile header will survive this.

--------------enig13EFEF430F833F45B9D38582
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDu9qBniDOoMHTA+kRAj0dAJ4rVl4g/L0Hqgf1M0sUBUju8Ucp5ACfaZJo
CU2WYRGvUHN0OphAKgit6TM=
=v99W
-----END PGP SIGNATURE-----

--------------enig13EFEF430F833F45B9D38582--


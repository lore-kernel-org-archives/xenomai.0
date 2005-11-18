Message-ID: <437E090E.3060406@domain.hid>
Date: Fri, 18 Nov 2005 18:02:06 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Announce: RTDM CAN Device Profile and Driver
References: <Pine.GSO.4.58.0511171900490.10042@domain.hid>
In-Reply-To: <Pine.GSO.4.58.0511171900490.10042@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig97BE5073B07A4E2ABD01EFE7"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97BE5073B07A4E2ABD01EFE7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hello list,
>=20
> as a result of a student research project of mine (kind of bachelor
> thesis), here is a CAN device profile for RTDM including a driver for t=
he
> SJA1000-based eNET PHYTEC card. See RT-Add-On-Repository at the Univers=
ity
> of Hannover:
> http://www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon/
>=20

To add a further note to this announcement:

It is planned to extend, or better: break up this driver into a generic
protocol part (socket setup/cleanup, transmission management, demux on
reception, etc.), a controller-specific part, and a eNET-specific
fragment (register addressing). The controller-specific part would be
first for SJA1000, of course. Further controllers could then be added
later. Thus, we aim at a real-time CAN framework which will be open for
a (hopefully) broad hardware support - based on this socket model!

There is nothing like a fixed schedule so far, but I would suggest Q2
2006 as a rather pessimistic goal for the integration of such a
framework into the Xenomai code base. As usual: any active contribution
could significantly speed up such a development! Actually, not so much
work remains, it just has to be a clean break-up and adjustment. And we
need intensive testing...

Have a nice weekend,
Jan


--------------enig97BE5073B07A4E2ABD01EFE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDfgkOncNeS9Q0k+IRAkQdAKDKe4gkfvN32vASUA/foWiXhqaWEwCghCgK
UdrORYd2hghxJ/o9+HG/HJA=
=pf78
-----END PGP SIGNATURE-----

--------------enig97BE5073B07A4E2ABD01EFE7--


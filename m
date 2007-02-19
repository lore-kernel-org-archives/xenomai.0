Message-ID: <45D9BEA6.5000305@domain.hid>
Date: Mon, 19 Feb 2007 16:13:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN bug fix for
	no-filter	definition
References: <45D9BDE0.3030900@domain.hid>
In-Reply-To: <45D9BDE0.3030900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD491DEB50A15D8A93BDA333"
Sender: jan.kiszka@domain.hid
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
--------------enigFD491DEB50A15D8A93BDA333
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> I just applied the following bug fix to the trunk for RT-Socket-CAN whe=
n
> using the no-filter definition. Here is the ChangeLog entry:
>=20
> 2007-02-19  Wolfgang Grandegger  <wg@domain.hid>
>=20
> * ksrc/drivers/can/rtcan_raw.c (rtcan_raw_bind),
>   ksrc/drivers/can/rtcan_socket.h: Fix bug using rtcan_flist_no_filter
>   and use proper type for RTCAN_FLIST_NO_FILTER to get warnings.

Using static inlines instead of defines - where possible - helps to
increase type-safety even further. rtcan_socket.h appear to contain some
appropriate candidates.

Jan


--------------enigFD491DEB50A15D8A93BDA333
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2b6mniDOoMHTA+kRAiOJAJ0VOM/eEZvWr1SGqOKqidGd/9CSNgCeKfTv
qs/vOm6sGV2mF/rPCK0quPU=
=y+LR
-----END PGP SIGNATURE-----

--------------enigFD491DEB50A15D8A93BDA333--


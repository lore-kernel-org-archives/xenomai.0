Message-ID: <43D7D7E3.3040804@domain.hid>
Date: Wed, 25 Jan 2006 20:56:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200601251552.10271.lbocseg@domain.hid>
In-Reply-To: <200601251552.10271.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0D24E4F347903D906806F470"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: RTDM and udelay
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D24E4F347903D906806F470
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Is there any alternative to udelay on RTDM?
>=20
> Or should I do something like:
>=20
> void rt_udelay(unsigned int usec) {
>   uint64_t timeout =3D rtdm_clock_read () + usec;
>   while (rtdm_clock_read () < timeout);
> }

You mean something like this: =3D:)

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtdm/drvlib.=
c?v=3DSVN-trunk#L366

>=20
> Or maybe my design is wrong.
>=20
> I have a function, say WriteI2C(...). Should I create it as a task and =
call=20
> rtdm_task_sleep?

Depending on how long you would like to sleep and if you are not inside
an IRQ handler, a re-scheduling call like rtdm_task_sleep() can be
better. If it's just about a few microseconds, busy sleeping should be
preferred.

Jan


--------------enig0D24E4F347903D906806F470
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD19fkniDOoMHTA+kRAi2iAJ0SjLbv4LaH6QP/18ZdRXVPZ5CmsgCfXjbj
v8lD7ekyjX/BgVBbAspzq2Y=
=7vJM
-----END PGP SIGNATURE-----

--------------enig0D24E4F347903D906806F470--


Message-ID: <45D8B818.1090500@domain.hid>
Date: Sun, 18 Feb 2007 21:33:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D8B15C.5050707@domain.hid>
In-Reply-To: <45D8B15C.5050707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DCD080043495CFCEEC2AF72"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: More RTCAN patches
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
--------------enig6DCD080043495CFCEEC2AF72
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Jan,
>=20
> I have two more patches in my quilt stack:

Sigh. ;)

>=20
>   2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
>=20
>   * ksrc/drivers/can/rtcan_raw.c, ksrc/drivers/can/rtcan_socket.h:  add=

>     prefix RTCAN_ to TIMESTAMP_SIZE, HAS_TIMESTAMP and HAS_NO_TIMESTAMP=

>     to avoid name clashes, e.g. TIMESTAMP_SIZE is used by the kernel
>     starting with 2.6.20.

These are only internal flags, right? Should go into stable as well
then, I guess.

>=20
>   * include/rtdm/rtcan.h: add "__attribute__ ((aligned(8)))" to the
>     data[8] element of the struct can_frame.

Was already committed.

>=20
>   2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
>=20
>   * include/rtdm/rtcan.h
>     ksrc/drivers/can/Config.in,
>     ksrc/drivers/can/Kconfig,
>     ksrc/drivers/can/rtcan_dev.h,
>     ksrc/drivers/can/rtcan_module.c,
>     ksrc/drivers/can/rtcan_raw.c,
>     ksrc/drivers/can/rtcan_raw.h,
>     ksrc/drivers/can/rtcan_socket.c,
>     ksrc/drivers/can/rtcan_socket.h,
>     ksrc/drivers/can/rtcan_socket.h,
>     ksrc/drivers/can/rtcan_virt.c,
>     ksrc/drivers/can/sja1000/rtcan_sja1000.c,
>     ksrc/drivers/can/mscan/rtcan_mscan.c,
>     src/utils/can/rtcansend.c: The socket option CAN_RAW_TX_LOOPBACK
>     has been renamed to CAN_RAW_LOOPBACK to be compatible with the
>     Socket-CAN implementation. Furthermore, all lower and upper case
>     strings "tx_loopback" have been replaced with "loopback" (to
>     shorten names).

Will commit to trunk.

>=20
> The first one also fixes the alignment issue discussed on the Socket-CA=
N
>  mailing list.
>=20
> Any comments or objections?
>=20
> Wolfgang.
>=20

Jan


--------------enig6DCD080043495CFCEEC2AF72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF2LgYniDOoMHTA+kRAhNkAJ4i2fUdwbrAQ8XZTZFrgNDLwHUzCQCfehX+
Ry2oTzcpGrFpMrnwp2dAA0Q=
=zM2X
-----END PGP SIGNATURE-----

--------------enig6DCD080043495CFCEEC2AF72--


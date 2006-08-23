Message-ID: <44ECB145.7030409@domain.hid>
Date: Wed, 23 Aug 2006 21:49:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Various fixes and improvements
	for	RT-Socket-CAN
References: <44EC9E02.3090201@domain.hid>
In-Reply-To: <44EC9E02.3090201@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig13DC24D0EF1B2F991853ABF7"
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
--------------enig13DC24D0EF1B2F991853ABF7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> attached is a patch for the RT-Socket-CAN RTDM driver providing:
>=20
>   * ksrc/drivers/can/rtcan_dev.c, ksrc/drivers/can/rtcan_dev.h,
>   ksrc/drivers/can/rtcan_modules.c: Suppress handling of refcount
>   if module support is not enabled or modules cannot be unloaded.
>=20
>   * ksrc/drivers/can/mscan/rtcan_mscan.c,
>   ksrc/drivers/can/mscan/rtcan_mscan_proc.c,
>   ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Make the MSCAN driver
>   work on Linux 2.6. We now use our own set of MSCAN register
>   definitions because they differ between 2.4 and 2.6 (prefix).
>=20
>   * scripts/Modules.frag: bug fix for making PEAK device drivers.
>=20
> Note that it adds the file ksrc/drivers/can/mscan/rtcan_mscan_regs.h !
>=20

Applied.

Thanks,
Jan


--------------enig13DC24D0EF1B2F991853ABF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE7LFFniDOoMHTA+kRAnQLAJ4lYpHNOtfwqTRsp+KIFHH9uTI4sgCfSpKz
EtW17mdTqNvT5NgHgzgEqLo=
=Y9sM
-----END PGP SIGNATURE-----

--------------enig13DC24D0EF1B2F991853ABF7--


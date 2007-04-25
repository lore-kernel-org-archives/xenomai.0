Message-ID: <462F3E54.9050601@domain.hid>
Date: Wed, 25 Apr 2007 13:41:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <bc4264770704250422p40e58608leb3f62d23bea25cb@domain.hid>
In-Reply-To: <bc4264770704250422p40e58608leb3f62d23bea25cb@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4CB4879AB0AD64E5621EC6E9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] warnings rtcan.h rtdm.h
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4CB4879AB0AD64E5621EC6E9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

roland Tollenaar wrote:
> Hi Jan,
>=20
> you may remember that I posted this warning from the compiler a long
> while back. You fixed it (rather made it quiet) but it seems to be
> back in rtdm.h packed with 2.3.1 which I have now installed.
>=20
>=20
> It does not bother me but I thought you would like to know.
>=20
> In file included from /mnt/appusb/xenomai-2.3.1/include/rtdm/rtcan.h:25=
0,
>                  from cancom.h:6,
>                  from task1.cpp:10:
> /mnt/appusb/xenomai-2.3.1/include/rtdm/rtdm.h: In function `ssize_t
> rt_dev_sendto(int, const void*, size_t, int, const sockaddr*,
> socklen_t)':
> /mnt/appusb/xenomai-2.3.1/include/rtdm/rtdm.h:323: warning: missing
> initializer for member `msghdr::msg_flags'
>=20
> running gcc version 3.4.6

The fact is that I never touched 2.3.x, because this is just a warning,
which is not pointing to a bug. "Beautifications" do not go into the
maintenance branch, only serious fixes.

Jan


--------------enig4CB4879AB0AD64E5621EC6E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLz5UniDOoMHTA+kRAlx8AJ0W/SyeW03Ay0FInPweM9GlWvzpJACdHWXi
HMrg1u9x90RPojuYmTF7CQ0=
=CaOA
-----END PGP SIGNATURE-----

--------------enig4CB4879AB0AD64E5621EC6E9--


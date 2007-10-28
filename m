Message-ID: <47246B99.2090307@domain.hid>
Date: Sun, 28 Oct 2007 11:59:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e4ef24880710261838l4d1961a5s8117d116be499cee@domain.hid>	<e4ef24880710262040r718b58f7xa2e5f89156d9024b@domain.hid>	<e4ef24880710262126g658f3f7ci534ca13df32b2e0e@domain.hid>	<4723118D.9060807@domain.hid>
	<472326E6.9080103@domain.hid>	<47232A0C.60705@domain.hid>
	<47234083.4000602@domain.hid>
In-Reply-To: <47234083.4000602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC8DD46533ED661ABDD0B11A8"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] RTNet in non-TDMA mode?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8DD46533ED661ABDD0B11A8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
>>> between RTdevices and non-RT devices crash the system? And whether I
>>> understand correctly that later versions (2.4 up?) of xenomai do not
>>> have the problem of the freezing system at least.?
>> Since Xenomai 2.3, actually, no system is supposed to "crash" anymore
>> when IRQ conflicts between the domains arise. But if you loose, e.g.,
>> your USB keyboard or your serial console or whatever input device due =
to
>> a conflict, you may get the impression of a crash. However, if anyone
>> suspects that something else happens on his system, please report the
>> findings to the Xenomai mailing list!
>=20
> The systems I have found to "crash" all used PS/2 input device and=20
> normal VGA monitor. Generally a freeze is initiated by some grafical=20
> action in X after starting rtnet. dmesg will tell me that there is a=20

If there is a conflict with your graphic adapter, using a VESA X driver
or disabling acceleration (Option "NoAccel") should remove the need to
use the related IRQ under Linux.

> shared IRQ, and in some cases it will disable it. In the latter case th=
e=20
> system does not freeze but I still have to find another IRQ address.=20
> When there is a shared interrupt then there might be a freeze. If it=20
> does not freeze immediately it never freezes and the shared IRQ is no=20
> problem. For a while I thought there was only a problem with the VGA=20
> device and the rtnet card so if I kept those two off the same IRQ there=
=20
> would be no problem. On other machines this theory was brutally smashed=
=2E
> Sorry I cannot be more specific here since all problems in the end are =

> "solved".
>=20
> Hmm, I am just considering that since I use live linux it may be that=20
> the conflict was between the rtnet card and a USBport that gives access=
=20
> to the usbstick(s).
>=20
> But my question remains -purely out of interest- why non-rt devices and=
=20
> rt devices can _fundamentally_ not share an IRQ?
>=20
> kind
>=20
> regards,
>=20
> Roland.
>=20
>=20

Jan


--------------enigC8DD46533ED661ABDD0B11A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJGuZniDOoMHTA+kRAgzoAKCAfevUdifhOEHXQyS2EIgqZfOcQwCfbR9c
dbYSfU9ZADBKyazSs4jh6KA=
=0wns
-----END PGP SIGNATURE-----

--------------enigC8DD46533ED661ABDD0B11A8--


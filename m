Message-ID: <469BF43D.1040704@domain.hid>
Date: Tue, 17 Jul 2007 00:42:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46973753.6010206@domain.hid>
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>	<913919.1184311634860.JavaMail.ngmail@domain.hid>
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>
In-Reply-To: <21969019.1184569651818.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFC3CD4F11996F25301F8BE5E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC3CD4F11996F25301F8BE5E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I left my PC running the whole weekend using the kernel command line pa=
rameter "nmi_watchdog=3D1".
> However, using this option, the PC did not freeze at all...
> This is really ugly.
> The kernel configuration was the same I mailed a couple of days ago.

Mpf. What about nmi_watchdog=3D2? It's said to tick at lower rate, thus
may not have such an "unwanted" side-effect.

>=20
> Also, I tried (a couple of hours) to run with Xeno debugging (Nucleus d=
ebugging and Watchdog support) enabled. However, this did not lead to a f=
reeze either.
>=20
> This seems to be a really nasty timing issue...
>=20
> Any ideas on how to continue are welcome.

No. I had no time to think further so far.

Jan


--------------enigFC3CD4F11996F25301F8BE5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGm/Q+niDOoMHTA+kRAqHAAJ9vc6MEz1h9nt6gy671TbMyAWRGUwCdFJk3
8Br82OStZcXAxY3PkswkP4M=
=EYs1
-----END PGP SIGNATURE-----

--------------enigFC3CD4F11996F25301F8BE5E--


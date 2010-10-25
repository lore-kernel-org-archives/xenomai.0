Message-ID: <4CC5C93E.70503@domain.hid>
Date: Mon, 25 Oct 2010 20:15:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>	<4CC20AD2.4060501@domain.hid>	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>	<4CC44C02.4050003@domain.hid>	<AANLkTinjUHYvNJwcuEd2RQuQLWL3WvGx-jFb5iG88f0c@domain.hid>	<AANLkTikGFw6dxQHC1ukWHsTP-QoHzpbDzeMdLj=jZRP5@domain.hid>	<AANLkTimsGjmPNE1GOzmyF4pHQe6m4RmFphuhGqdTrs1D@mail.gmail.com>	<4CC5603E.1090707@domain.hid>
	<4CC566A2.2000702@domain.hid>	<AANLkTik76N-mL6ogtzFJ_vX4NF=7oDc_zdCA_y33z+Jh@domain.hid>	<AANLkTimp5_OXSo_EGkn6O0mexR1Oxb_m9SJEfPmrSf0M@mail.gmail.com>
	<AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>
In-Reply-To: <AANLkTi=Ne35gXZ=BRo09eXRjEtvPaXnkp6ix9tMWUwvn@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0779E6A335F282CB1728BD4B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0779E6A335F282CB1728BD4B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 25.10.2010 20:04, Peter Pastor wrote:
> Hey Eric,
>=20
> Thanks for your prompt response. However, I do not have the "FLAT_MEMOR=
Y"
> option available. I can only select the sparse memory model.
>=20
> I have upgraded to 2.6.35 and so far the problem has not occured. Howev=
er, I
> haven't used the system much. Again, it seems that a specific event tri=
ggers
> the problem.
>=20
> Also, can someone tell me whether the ubuntu kernel patch is recommende=
d to
> use with Xenomai ? If so, can someone tell me how to get the patch for =
my
> particular kernel version 2.6.35 ? ( I am sorry if this is the wrong ma=
iling
> list to ask this question )

Xenomai is not supported over distro-patched kernels. While some of
their patches may be orthogonal, other may have all kinds of side
effects together with I-pipe that no one wants to track down (not that
those patches are inherently bad, just not tested against I-pipe).

If you are missing a specific feature, either port it back carefully or
wait for it to appear in the next upstream kernel (e.g. AppAmor is now
in 2.6.36, and I guess we will have I-pipe for that kernel within the
next weeks).

Jan


--------------enig0779E6A335F282CB1728BD4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzFyT4ACgkQitSsb3rl5xTb7gCfXbNMtZR1YXRmG79KfDyXrexz
ZLQAniS4VcLdYX1oLhphpvcNmQDSJMuQ
=Q5QE
-----END PGP SIGNATURE-----

--------------enig0779E6A335F282CB1728BD4B--


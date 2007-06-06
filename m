Message-ID: <4666CE90.6060205@domain.hid>
Date: Wed, 06 Jun 2007 17:11:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>
In-Reply-To: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig09D16E6AEB3950B676929824"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Cyclictest
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09D16E6AEB3950B676929824
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> Hello,
>=20
> I launched the same application Cyclictest on a kernel Linux without
> Xenomai
> and a kernel Linux with Xenomai and I noticed that the result is differ=
ent.
>=20
> Here is the result with a kernel Linux without xenomai :
>=20
>> cyclictest -t 10 -c 1 -i 10500
>=20
>=20
> T: 0 (  732) P:99 I:   10500 C:    2291 Min:      41 Act:    2281
> Avg:    5075
> Max:   10224
>=20
> T: 1 (  733) P:98 I:   11000 C:    2187 Min:      66 Act:    1312
> Avg:    5085
> Max:   10236
>=20
> T: 2 (  734) P:97 I:   11500 C:    2092 Min:      91 Act:     842
> Avg:    5113
> Max:   10311
>=20
> T: 3 (  735) P:96 I:   12000 C:    2004 Min:     106 Act:    1384
> Avg:    5134
> Max:   10140
>=20
> T: 4 (  736) P:95 I:   12500 C:    1924 Min:     116 Act:    9873
> Avg:    5152
> Max:   10306
>=20
> T: 5 (  737) P:94 I:   13000 C:    1850 Min:     136 Act:     415
> Avg:    5172
> Max:   10376
>=20
> T: 6 (  738) P:93 I:   13500 C:    1782 Min:     136 Act:    3873
> Avg:    5180
> Max:   10411
>=20
> T: 7 (  751) P:92 I:   14000 C:    1722 Min:     156 Act:    3559
> Avg:    5184
> Max:   10190
>=20
> T: 8 (  752) P:91 I:   14500 C:    1663 Min:     140 Act:    8454
> Avg:    5216
> Max:   10310
>=20
> T: 9 (  753) P:90 I:   15000 C:    1608 Min:     184 Act:    2485
> Avg:    5214
> Max:   10490
>=20
>=20
> And here is the result with a kernel Linux with xenomai :
>> cyclictest -t 10 -c 1 -i 10000
>=20
>=20
> T: 0 (  893) P:99 I:   10000 C:    1756 Min:   13407 Act:   13536 Avg: =
=20
> 13452
> Max:   13693
>=20
> T: 1 (  894) P:98 I:   10500 C:    1673 Min:    4955 Act:    7595
> Avg:    9767
> Max:   14727
>=20
> T: 2 (  895) P:97 I:   11000 C:    1597 Min:    5461 Act:    7628 Avg: =
=20
> 10047
> Max:   14793
>=20
> T: 3 (  908) P:96 I:   11500 C:    1333 Min:    4987 Act:    5641
> Avg:    9808
> Max:   14779
>=20
> T: 4 (  909) P:95 I:   12000 C:    1277 Min:    5478 Act:   11665
> Avg:    9588
> Max:   13864
>=20
> T: 5 (  910) P:94 I:   12500 C:    1226 Min:    6016 Act:   11191
> Avg:    9859
> Max:   14135
>=20
> T: 6 (  911) P:93 I:   13000 C:    1179 Min:    5526 Act:    9711 Avg: =
=20
> 10130
> Max:   14901
>=20
> T: 7 (  912) P:92 I:   13500 C:    1135 Min:    5061 Act:   14740
> Avg:    9896
> Max:   14852
>=20
> T: 8 (  913) P:91 I:   14000 C:    1095 Min:    5549 Act:    7766
> Avg:    9669
> Max:   14198
>=20
> T: 9 (  914) P:90 I:   14500 C:    1057 Min:    5107 Act:   11820
> Avg:    9940
> Max:   14984
>=20
>=20
> We can see that with Xenomai, the results are less good.
> Is there an explication to this?

Did you double-check that you were not testing Xenomai with the
"vanilla" cyclictest, ie. the one without libpthread_rt dependencies...?
See "ldd cyclictest" when in doubt.

Jan


--------------enig09D16E6AEB3950B676929824
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZs6QniDOoMHTA+kRAmgJAJ0WztK/LEQYN5DbQXAvpWEqR7ZB6ACfYWuT
ORcq0+Ik9y423CzOtDeIc2c=
=3np+
-----END PGP SIGNATURE-----

--------------enig09D16E6AEB3950B676929824--


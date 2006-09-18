Message-ID: <450F084A.1070303@domain.hid>
Date: Mon, 18 Sep 2006 22:57:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rare brokenness in latency output - FPU bug!
References: <450E6745.6050903@domain.hid> <450F061A.6090507@domain.hid>
In-Reply-To: <450F061A.6090507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2975BFBA121FD7AEE16FB94C"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2975BFBA121FD7AEE16FB94C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Jan Kiszka wrote:
>> Uhh, wait! I just fired up switchtest on the same box:
>> ...
>> Gilles, what info do you need? It's all the latest on x86 here:
>> 2.6.17.13 (.config attached), ipipe-1.4, SVN #1646, gcc4.1.0.
>>
>> Jan
>=20
> I get a similar result here with xenomai-2.2.3, 2.6.17.13, x86 SMP (see=

> below).  No seg fault, though.
>=20
> -Jeff
>=20
>=20
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Testing FPU check routines...
> r0: 1 !=3D 2
> r1: 1 !=3D 2
> r2: 1 !=3D 2
> r3: 1 !=3D 2
> r4: 1 !=3D 2
> r5: 1 !=3D 2
> r6: 1 !=3D 2
> r7: 1 !=3D 2
> =3D=3D FPU check routines: OK.
> =3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4
> rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-1=
0
> rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16
> rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20
> rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2
> rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8
> rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-1=
4
> rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19
> rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22
> r0: 2147483648 !=3D 10
> r1: 2147483648 !=3D 10
> r2: 2147483648 !=3D 10
> r3: 2147483648 !=3D 10
> r4: 2147483648 !=3D 10
> r5: 2147483648 !=3D 10
> r6: 2147483648 !=3D 10
> r7: 39868544 !=3D 10
> Error after context switch from task 8(rtup1-8) to task 10(rtup_ufpp1-1=
0),
> FPU registers were set to 39868544 (maybe task ???)
> RTT|  00:00:00
> RTH|---------cpu|ctx switches|-------total
> RTD|           0|          23|          23
> RTD|           1|          28|          28
>=20

Welcome to the club!

Everyone's busy behind the curtain to analyse what's going on here. So
far we thought it's a post 2.2.2 regresssion (SVN rev 1595 for trunk,
1597 for 2.2.x), but the issue may be more tricky.

Do you get the switchtest failure also with plain 2.2.2?

What processor do you use? I was only able to trigger my problems on
Pentium MMX and older or an Athlon 800 here. A Pentium III worked fine.

Jan


--------------enig2975BFBA121FD7AEE16FB94C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFDwhKniDOoMHTA+kRAguvAJ9HL3iaIjxK7QTN9Vsn7mJvjFEHIgCfXmJQ
GTdcy6wAR3W+Df0+I+kR7v0=
=KBeD
-----END PGP SIGNATURE-----

--------------enig2975BFBA121FD7AEE16FB94C--


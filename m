Message-ID: <4A9400E4.50503@domain.hid>
Date: Tue, 25 Aug 2009 17:19:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
	<4A8F1E70.6090608@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C6@domain.hid>
	<4A925F27.4070104@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C7@domain.hid>
	<4A939CE2.3080006@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C8@domain.hid>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9C8@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE : RE : Native message queue and
	synchronisation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Cc: xenomai@xenomai.org

Berruer S=E9bastien wrote:
> Hello,
>=20
>>
>>Could you try something: with the patch still applied, could you try to
>>compile Xenomai user-space without the -msoft-float option?
>=20
> I've done the compilation of the kernel support with both previous
> patches applied.
>=20
>=20
> I've done the compilation of the user space support once with
> CFLAGS=3D-msoft-float, and once without.
>=20
>=20
> I've run almost all the applications from the testsuite. However, some
> noticed points;
>  - I can't run irqbench. I've got the following error:
>=20
> root@domain.hid:$ ./irqbench/run
> *
> *
> * Type ^C to stop this application.
> *
> *
> irqloop: error starting test: Inappropriate ioctl for device
>=20
> Must I used the serial RT driver from Xenomai for this test?
>=20
>  - When I run swithtest without any argument, I receive the message:

Yes, irqbench only works on x86, as far as I know.

> root@domain.hid:$ ./switchtest/run
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Testing FPU check routines...
> =3D=3D FPU check routines: unimplemented, skipping FPU switches tests.
> =3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 =
rtuo-8
> RTT|  00:00:01
> RTH|ctx switches|-------total
> RTD|         900|         900
> RTD|         891|        1791
> RTD|         909|        2700
> RTD|         909|        3609
> RTD|         900|        4509
> RTD|         909|        5418
> RTD|         909|        6327
> RTD|         909|        7236
> RTD|         900|        8136
> RTD|         909|        9045
> RTD|         909|        9954
>=20
> But nothing appear when I explicitly run:

Yes, using FPU in Xenomai applications only works with VFP. The Xscale
FPU support is unimplemented.

>=20
> root@domain.hid:$ ./switchtest/run rtup_ufpp
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Threads: sleeper_ufps-0 rtup_ufpp-1
> RTT|  00:00:01
> RTH|ctx switches|-------total
> RTD|         200|         200
> RTD|         198|         398
> RTD|         202|         600
> RTD|         202|         802
> RTD|         202|        1004
> RTD|         202|        1206
> RTD|         200|        1406
> RTD|         202|        1608
> RTD|         200|        1808

It does not really make sense to try this configuration, since the
Xscale fpu support is unsupported. Though I think it should exit with an
error instead of doing what it currently does.

--=20
                                          Gilles



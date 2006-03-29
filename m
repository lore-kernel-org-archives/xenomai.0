Message-ID: <442A8F84.8060506@domain.hid>
Date: Wed, 29 Mar 2006 15:45:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Run-time problem with xenomai
References: <7C4B97D3898FED44BC087D25490A44A1B6BB67@domain.hid>
In-Reply-To: <7C4B97D3898FED44BC087D25490A44A1B6BB67@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?windows-1252?Q?Hans_J=F8rgen_Olsen?= <HansJoergen.Olsen@domain.hid>
Cc: xenomai@xenomai.org

Hans J=F8rgen Olsen wrote:
> Hi.
>=20
> =20
>=20
> First: I=92m new to Xenomai and slowly becoming a not_so_new linux user=
.
>=20
> =20
>=20
> I have successfully installed Xenomai 2.1 following Hannes Mayer=92s=20
> excellent guide.
>=20
> =20
>=20
> Everything looks fine until testing using the programs in testsuite.=20
> Then the process stops with the message:
>=20
> Xenomai: incompatible feature set
>=20
> (required=3D=94sep tsc=94, present=3D=94sep=94, missing=3D=94tsc=94).
>=20

Everything is explained in the README.INSTALL file.

Basically, you seem to have compiled your kernel for an x86 architecture=20
which does not have TSC support (pre-Pentium classic or oldish x86=20
compatibles?), but you told the user-space programs configuration script=20
the opposite, i.e. --enable-x86-tsc. This is a problem, since whether=20
your CPU actually has a TSC, and the user-space support is going to use=20
it directly without resorting to Xenomai syscalls for getting=20
timestamps, or your CPU doesn't have any TSC - like your current kernel=20
setup asserts - and as such, emitting TSC-related instructions on a=20
TSC-unware hw would lead to "unexpected results".

I'd suggest that you double-check your kernel setup first, and choose a=20
processor support which actually matches your hw. If the latter has a=20
TSC, it's better to use it performance-wise, otherwise Xeno would=20
emulate a TSC, which would be fairly sub-optimal in your case. If you do=20
have one, then keep on passing --enable-x86-tsc to the configure script,=20
after rebuilding the kernel with the proper processor selection.

If you need to keep on with a processor selection which does not support=20
any TSC, then remove the --enable-x86-tsc switch when configuring the=20
user-space support, then rebuild it fully.

> =20
>=20
> A simple program of my own compile fine but stops running with the same=
=20
> error.
>=20
> =20
>=20
> I have configured Xenomai with options:
>=20
> --enable-x86-sep --enable-x86-tsc
>=20
> =20
>=20
> Using cat /proc/cpuinfo shows that both sep and tsc flags are present.
>=20
> =20
>=20
> Linux: Debian with kernel 2.6.14.7
>=20
> CPU: Pentium 4/Celeron
>=20
> =20
>=20
> Grateful for a suggestion to solve the problem.
>=20
> =20
>=20
> Hans J=F8rgen
>=20
> =20
>=20
> =20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20

Philippe.


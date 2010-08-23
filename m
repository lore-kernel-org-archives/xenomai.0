From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikCehBXnp6cwks1QQmRwhxe5Hd=McupyEz+wKPC@mail.gmail.com>
References: <AANLkTikhNX=0q8M8j1TU1DpM6_EtghX8A0UQ37P6S6Vp@domain.hid>
	<AANLkTikCehBXnp6cwks1QQmRwhxe5Hd=McupyEz+wKPC@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Aug 2010 13:40:07 +0200
Message-ID: <1282563607.1961.63.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] problem - eldk 4.2 - ppc
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodolfo Oliveira <rodolforomao@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-08-23 at 07:38 -0300, Rodolfo Oliveira wrote:
>=20
> Hi,
>=20
> Today use the eldk 3.0 version in this processor MPC5200B PPC, but I
> want to upgrade the kernel to version 2.6 and eldk 4.2 with ELDK can
> do this more easily.=20
> The problem happens when I try to compile by running the following
> commands:=20
> make distclean=20
> make clean=20
> make menuconfig=20
> make=20
>=20
> many minutes after the following error appears:=20
>   LD drivers / net / bonding / built-in.o=20
>   CC [M] drivers / net / bonding / bond_main.o=20
>   CC [M] drivers/net/bonding/bond_3ad.o=20
>   CC [M] drivers / net / bonding / bond_alb.o=20
>   CC [M] drivers / net / bonding / bond_sysfs.o=20
>   LD [M] drivers / net / bonding / bonding.o=20
>   LD drivers / net / can / built-in.o=20
>   CC [M] drivers / net / can / vcan.o=20
> drivers / net / can / vcan.c: In function 'vcan_setup':=20
> drivers / net / can / vcan.c: 207: error: implicit declaration of
> function 'SET_MODULE_OWNER'=20
> make [3]: ** [drivers / net / can / vcan.o] Error 1=20
> make [2]: ** [drivers / net / can] Error 2=20
> make [1]: ** [drivers / net] Error 2=20
> make: ** [drivers] Error 2=20
> rodolfo @ df2684: / $ ls opt/eldk/ppc_82xx/usr/src/linux-2.6.24=20
>=20
> can anyone help me?=20
>=20

This list is for development issues regarding Xenomai. You should post
your question to the proper list instead:
http://lists.denx.de/mailman/listinfo/eldk

> Thanks
>=20
> --=20
>=20
>=20
> []=C2=B4s
>=20
> =20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Rodolfo R. de O. Neto, Eng. , MBA
> Engenheiro de computa=C3=A7=C3=A3o
> MBA - Governan=C3=A7a em TI
> E-mail: rodolforomao@domain.hid
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =20
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

--=20
Philippe.




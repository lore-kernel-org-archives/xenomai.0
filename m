Message-ID: <499464DB.9040805@domain.hid>
Date: Thu, 12 Feb 2009 19:05:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20090212153715.08686BE407B@ws1-9.us4.outblaze.com>
In-Reply-To: <20090212153715.08686BE407B@ws1-9.us4.outblaze.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] lite5200b - problems in generating make
	menuconfig
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Marco_Ant=F4nio_Possamai?= <marco.possamai@domain.hid>
Cc: XENOMAI <Xenomai-help@domain.hid>

Marco Ant=F4nio Possamai wrote:
> Greetings.
>=20
> I need to create a 2.6.24 powerpc kernel image. So I did:
>=20
> $ export CROSS_COMPILE=3Dppc_6xx-
>=20
> $ git clone git://git.denx.de/linux-2.6-denx.git
> $ export KDIR=3D$PWD/linux-2.6-denx
>=20
> $ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x
> $ export XDIR=3D$PWD/xenomai-2.4.x
>=20
> $ cd $KDIR
> $ git checkout origin/DENX-v2.6.24-stable
> $ git checkout -b origin/DENX-v2.6.24-stable
>=20
> $ cd $XDIR
> $ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc
>=20
> The following shows:
>=20
> Adeos patch [default
> /home/user/xenomai-2.4.x/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24-p=
owerpc-DENX-2.1-01.patch]:
>

This is not related, but you should upgrade your I-pipe patch, there are =
at
least two candidates for 2.6.24:
http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6.=
24-powerpc-DENX-2.1-04.patch
http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6.=
24.6-powerpc-DENX-2.4-03.patch

DENX-2.6.24-stable is fairly outdated as well; DENX-v2.6.26-stable or may=
be .27
would be better. I suspect the Xenomai distro you are using is outdated a=
s well,
 probably 2.4.3. 2.4.6.1 is the current -stable, and 2.4.7 is pending for=
 release.

> Right after I get the adeos-ipipe-2.6.24 patch for powerpc installed I
> use the make ARCH=3Dpowerpc mpc5200_defconfig and it gets to:
>=20

There is no mpc5200_defconfig in DENX-v2.6.24-stable; the proper defconfi=
g is
lite5200_defconfig. Is mpc5200_defconfig a file of yours?

> root@domain.hid# make ARCH=3Dpowerpc mpc5200_defconf=
ig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/kxgettext.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   SHIPPED scripts/kconfig/zconf.hash.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> file arch/powerpc/xenomai/Kconfig already scanned?
> make[1]: ** [mpc5200_defconfig] Erro 1
> make: ** [mpc5200_defconfig] Erro 2
>=20
> Well, I don't know what's wrong with it. I've also tried the
> lite5200_defconfig and it resulted the same error messages.
>=20

$ git checkout -b 2.6.24-xeno origin/DENX-v2.6.24-stable
$ $XDIR/scripts/prepare-kernel.sh --arch=3Dpowerpc --linux=3D.
$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- lite5200_defconfig
<edit config as needed>
$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx-

If you really want to build from the user-space Xenomai tree instead, the=
n refer
to =A71.4 in README.INSTALL.

>=20
>=20
> Thank you for the attention.
>=20
> Marco Ant=F4nio Possamai
>=20
> Universidade Federal de Santa Catarina
>=20
>=20
> --=20
> Be Yourself @ mail.com!
> Choose From 200+ Email Addresses
> Get a *Free* Account at www.mail.com <http://www.mail.com/Product.aspx>=
!
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


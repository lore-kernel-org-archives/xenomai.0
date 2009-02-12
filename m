Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_1234453034308093"
MIME-Version: 1.0
From: =?iso-8859-1?B?Ik1hcmNvIEFudPRuaW8gUG9zc2FtYWki?=
	<marco.possamai@domain.hid>
Date: Thu, 12 Feb 2009 12:37:14 -0300
Message-Id: <20090212153715.08686BE407B@ws1-9.us4.outblaze.com>
Subject: [Xenomai-help] lite5200b - problems in generating make menuconfig
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: XENOMAI <Xenomai-help@domain.hid>

This is a multi-part message in MIME format.

--_----------=_1234453034308093
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Greetings.

I need to create a 2.6.24 powerpc kernel image. So I did:

$ export CROSS_COMPILE=3Dppc_6xx-

$ git clone git://git.denx.de/linux-2.6-denx.git
$ export KDIR=3D$PWD/linux-2.6-denx

$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x
$ export XDIR=3D$PWD/xenomai-2.4.x

$ cd $KDIR
$ git checkout origin/DENX-v2.6.24-stable
$ git checkout -b origin/DENX-v2.6.24-stable

$ cd $XDIR
$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc

The following shows:

Adeos patch [default
/home/user/xenomai-2.4.x/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24-power=
pc-DENX-2.1-01.patch]:

Right after I get the adeos-ipipe-2.6.24 patch for powerpc installed I
use the make ARCH=3Dpowerpc mpc5200_defconfig and it gets to:

root@domain.hid# make ARCH=3Dpowerpc mpc5200_defconfig
HOSTCC  scripts/basic/fixdep
HOSTCC  scripts/basic/docproc
HOSTCC  scripts/kconfig/conf.o
HOSTCC  scripts/kconfig/kxgettext.o
SHIPPED scripts/kconfig/zconf.tab.c
SHIPPED scripts/kconfig/lex.zconf.c
SHIPPED scripts/kconfig/zconf.hash.c
HOSTCC  scripts/kconfig/zconf.tab.o
HOSTLD  scripts/kconfig/conf
file arch/powerpc/xenomai/Kconfig already scanned?
make[1]: ** [mpc5200_defconfig] Erro 1
make: ** [mpc5200_defconfig] Erro 2

Well, I don't know what's wrong with it. I've also tried the
lite5200_defconfig and it resulted the same error messages.



Thank you for the attention.

Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina

--=20
Be Yourself @ mail.com!
Choose From 200+ Email Addresses
Get a Free Account at www.mail.com


--_----------=_1234453034308093
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<div>


<div>

<p>
Greetings.</p><p>I need to create a 2.6.24 powerpc kernel image. So I did:<=
/p><p>$ export CROSS_COMPILE=3Dppc_6xx-<br><br>$ git clone git://git.denx.d=
e/linux-2.6-denx.git<br>$ export KDIR=3D$PWD/linux-2.6-denx<br><br>$ svn co=
 http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x<br>$ export X=
DIR=3D$PWD/xenomai-2.4.x<br><br>$ cd $KDIR<br>$ git checkout origin/DENX-v2=
.6.24-stable<br>$ git checkout -b origin/DENX-v2.6.24-stable<br><br>$ cd $X=
DIR<br>$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpower=
pc</p><p>The following shows:</p><p>Adeos patch [default /home/user/xenomai=
-2.4.x/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.24-powerpc-DENX-2.1-01.pat=
ch]:<br></p><p>Right after I get the adeos-ipipe-2.6.24 patch for powerpc i=
nstalled I use the make ARCH=3Dpowerpc mpc5200_defconfig and it gets to:<br=
></p>root@domain.hid# make ARCH=3Dpowerpc mpc5200_defcon=
fig<br>&nbsp; HOSTCC&nbsp; scripts/basic/fixdep<br>&nbsp; HOSTCC&nbsp; scri=
pts/basic/docproc<br>&nbsp; HOSTCC&nbsp; scripts/kconfig/conf.o<br>&nbsp; H=
OSTCC&nbsp; scripts/kconfig/kxgettext.o<br>&nbsp; SHIPPED scripts/kconfig/z=
conf.tab.c<br>&nbsp; SHIPPED scripts/kconfig/lex.zconf.c<br>&nbsp; SHIPPED =
scripts/kconfig/zconf.hash.c<br>&nbsp; HOSTCC&nbsp; scripts/kconfig/zconf.t=
ab.o<br>&nbsp; HOSTLD&nbsp; scripts/kconfig/conf<br>file arch/powerpc/xenom=
ai/Kconfig already scanned?<br>make[1]: ** [mpc5200_defconfig] Erro 1<br>ma=
ke: ** [mpc5200_defconfig] Erro 2<br><br>Well, I don't know what's wrong wi=
th it. I've also tried the lite5200_defconfig and it resulted the same erro=
r messages.<br><br><br><br>Thank you for the attention.<br><br><pre>Marco A=
nt=F4nio Possamai

Universidade Federal de Santa Catarina
</pre>


</div>


</div>
<BR>

--=20
<div> Be Yourself @ mail.com!<br>
Choose From 200+ Email Addresses<br>
Get a <b>Free</b> Account at <a href=3D"http://www.mail.com/Product.aspx" t=
arget=3D"_blank">www.mail.com</a>!</div>

--_----------=_1234453034308093--



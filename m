Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_1226179087148310"
MIME-Version: 1.0
From: =?iso-8859-1?B?TWFyY28gQW509G5pbyBQb3NzYW1haQ==?=
	<marco.possamai@domain.hid>
Date: Sat, 8 Nov 2008 18:18:07 -0300
Message-Id: <20081108211807.EF75F47808F@ws1-5.us4.outblaze.com>
Subject: [Xenomai-help] Weird return after make instruction
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

--_----------=_1226179087148310
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello, Xenomai mailing list!

I've been on this Icecube (MPC5200 Lite) configuration assigment and came
across these weird returns, and I'm not sure if it's some kind of error
or something.

First let me show the steps I took:

$ export CROSS_COMPILE=3Dppc_6xx-


$ git clone git://git.denx.de/linux-2.6-denx.git
$ export KDIR=3D$PWD/linux-2.6-denx

$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x
$ export XDIR=3D$PWD/xenomai-2.4.x

$ cd $KDIR
$ git checkout origin/DENX-v2.6.25-stable
$ git checkout -b origin/DENX-v2.6.25-stable


$ cd $XDIR
$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc

Adeos patch [default
/home/user/linux-2.6-denx/xenomai-2.4.x/ksrc/arch/powerpc/patches/adeos-ipi=
pe-2.6.25-powerpc-DENX-2.2-03.patch]:


Configure and create the kernel enabling RT-Socket-CAN:

$ cd $KDIR
$ make ARCH=3Dpowerpc mpc5200_defconfig
$ make ARCH=3Dpowerpc menuconfig

... enable RT-Socket-CAN and MSCAN driver ...
<*> RT-Socket-CAN, CAN raw socket interface
[*]   Enable debug output (NEW)
[ ]   Enable TX loopback to local sockets (NEW)
(1024) Size of receive ring buffers (must be 2^N) (NEW)
(4)   Maximum number of devices (NEW)
(16)  Maximum number of receive filters per device (NEW)
< >   Virtual CAN bus driver (NEW)
<M>   MSCAN driver for MPC52xx
[*]     Enable CAN 1 (NEW)
[*]     Enable CAN 2 (NEW)
(66000000) Clock Frequency in Hz (NEW)
Pin Configuration (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin
...


$ make ARCH=3Dpowerpc uImage


$ cd $XDIR
$ ./configure --host=3Dppc-linux --prefix=3D/root/xenomai
$ make

The make instruction seems to work fine. But at the end, the terminal
shows me these lines:

make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src/utils/can'
make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src/utils'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src/utils'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src/utils'
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src'
make[2]: Nada a ser feito para `all-am'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src'
make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src'
Making all in include
make[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include'
Making all in asm-generic
make[2]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-generic'
Making all in bits
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-generic/bits'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-generic/bits'
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-generic'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-generic'
make[2]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-generic'
Making all in asm-blackfin
make[2]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-blackfin'
Making all in bits
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-blackfin/bits'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-blackfin/bits'
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-blackfin'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-blackfin'
make[2]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-blackfin'
Making all in asm-x86
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-x86'
Making all in bits
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-x86/bits'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-x86/bits'
make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-x86'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-x86'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-x86'
Making all in asm-ia64
make[2]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-ia64'
Making all in bits
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-ia64/bits'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-ia64/bits'
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-ia64'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-ia64'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-ia64'
Making all in asm-powerpc
make[2]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-powerpc'
Making all in bits
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-powerpc/bits'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-powerpc/bits'
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-powerpc'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-powerpc'
make[2]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-powerpc'
Making all in asm-arm
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-arm'
Making all in bits
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-arm/bits'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-arm/bits'
make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-arm'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-arm'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-arm'
Making all in asm-sim
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-sim'
Making all in bits
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-sim/bits'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/include/asm-sim/bits'
make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-sim'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-sim'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-sim'
Making all in native
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/native'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/native'
Making all in nucleus
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/nucleus'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/nucleus'
Making all in posix
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/posix'
Making all in sys
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/include/posix/sys'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/posix/sys'
make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/posix'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/posix'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/posix'
Making all in psos+
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/psos+'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/psos+'
Making all in rtai
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/rtai'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/rtai'
Making all in rtdm
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/rtdm'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/rtdm'
Making all in uitron
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/uitron'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/uitron'
Making all in vrtx
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/vrtx'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/vrtx'
Making all in vxworks
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/vxworks'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/vxworks'
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include'
make[2]: Nada a ser feito para `all-am'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include'
make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include'
Making all in config
make[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/config'
make[1]: Nada a ser feito para `all'.
make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/config'
Making all in doc
make[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc'
Making all in docbook
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook'
Making all in custom-stylesheets
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets'
Making all in xsl
make[4]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl'
Making all in common
make[5]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/common'
make[5]: Nada a ser feito para `all'.
make[5]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/common'
Making all in fo
make[5]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/fo'
make[5]: Nada a ser feito para `all'.
make[5]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/fo'
Making all in html
make[5]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/html'
make[5]: Nada a ser feito para `all'.
make[5]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/html'
make[5]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl'
make[5]: Nada a ser feito para `all-am'.
make[5]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl'
make[4]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl'
make[4]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets'
make[4]: Nada a ser feito para `all-am'.
make[4]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets'
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets'
Making all in xenomai
make[3]: Entrando no diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/xenomai'
make[3]: Nada a ser feito para `all'.
make[3]: Saindo do diret=F3rio
`/home/user/xenomai-2.4.x/doc/docbook/xenomai'
make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook'
Making all in doxygen
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/doxygen'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/doxygen'
Making all in man
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/man'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/man'
Making all in txt
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/txt'
make[2]: Nada a ser feito para `all'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/txt'
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc'
make[2]: Nada a ser feito para `all-am'.
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc'
make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc'
Making all in scripts
make[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/scripts'
make[1]: Nada a ser feito para `all'.
make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/scripts'
make[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x'
make[1]: Nada a ser feito para `all-am'.
make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x'

And I'm not sure of what to make of it.
There's no error message, but those stuff don't seem right.

By the way:
Entrando no diret=F3rio =3D Entering the directory;
Nada a ser feito =3D Nothing to be done;
Saindo do diret=F3rio =3D Leaving the directory.

Thanks for your help.

Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina

--=20
Be Yourself @ mail.com!
Choose From 200+ Email Addresses
Get a Free Account at www.mail.com


--_----------=_1226179087148310
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<div>Hello, Xenomai mailing list!<br><br>I've been on this Icecube (MPC5200=
 Lite) configuration assigment and came across these weird returns, and I'm=
 not sure if it's some kind of error or something.<br><br>First let me show=
 the steps I took:<br><br>$ export CROSS_COMPILE=3Dppc_6xx-<br><br><br>$ gi=
t clone git://git.denx.de/linux-2.6-denx.git<br>$ export KDIR=3D$PWD/linux-=
2.6-denx<br><br>$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xen=
omai-2.4.x<br>$ export XDIR=3D$PWD/xenomai-2.4.x<br><br>$ cd $KDIR<br>$ git=
 checkout origin/DENX-v2.6.25-stable<br>$ git checkout -b origin/DENX-v2.6.=
25-stable<br><br><br>$ cd $XDIR<br>$ scripts/prepare-kernel.sh --linux=3D$K=
DIR --verbose --arch=3Dpowerpc<br><br>Adeos patch [default /home/user/linux=
-2.6-denx/xenomai-2.4.x/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.25-powerp=
c-DENX-2.2-03.patch]:<br><br><br>Configure and create the kernel enabling R=
T-Socket-CAN:<br><br>$ cd $KDIR<br>$ make ARCH=3Dpowerpc mpc5200_defconfig<=
br>$ make ARCH=3Dpowerpc menuconfig<br><br>&nbsp; ... enable RT-Socket-CAN =
and MSCAN driver ...<br>&nbsp; &lt;*&gt; RT-Socket-CAN, CAN raw socket inte=
rface<br>&nbsp; [*]&nbsp;&nbsp; Enable debug output (NEW)<br>&nbsp; [ ]&nbs=
p;&nbsp; Enable TX loopback to local sockets (NEW)<br>&nbsp; (1024) Size of=
 receive ring buffers (must be 2^N) (NEW)<br>&nbsp; (4)&nbsp;&nbsp; Maximum=
 number of devices (NEW)<br>&nbsp; (16)&nbsp; Maximum number of receive fil=
ters per device (NEW)<br>&nbsp; &lt; &gt;&nbsp;&nbsp; Virtual CAN bus drive=
r (NEW)<br>&nbsp; &lt;M&gt;&nbsp;&nbsp; MSCAN driver for MPC52xx<br>&nbsp; =
[*]&nbsp;&nbsp;&nbsp;&nbsp; Enable CAN 1 (NEW)<br>&nbsp; [*]&nbsp;&nbsp;&nb=
sp;&nbsp; Enable CAN 2 (NEW)<br>&nbsp; (66000000) Clock Frequency in Hz (NE=
W)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pin Configurat=
ion (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin <br>&nbsp; ...<br><br><br>$ mak=
e ARCH=3Dpowerpc uImage<br><br><br>$ cd $XDIR<br>$ ./configure --host=3Dppc=
-linux --prefix=3D/root/xenomai<br>$ make<br><br>The make instruction seems=
 to work fine. But at the end, the terminal shows me these lines:<br><br>ma=
ke[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src/utils/can'<br>ma=
ke[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src/utils'<br>make=
[3]: Nada a ser feito para `all-am'.<br>make[3]: Saindo do diret=F3rio `/ho=
me/user/xenomai-2.4.x/src/utils'<br>make[2]: Saindo do diret=F3rio `/home/u=
ser/xenomai-2.4.x/src/utils'<br>make[2]: Entrando no diret=F3rio `/home/use=
r/xenomai-2.4.x/src'<br>make[2]: Nada a ser feito para `all-am'.<br>make[2]=
: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src'<br>make[1]: Saindo d=
o diret=F3rio `/home/user/xenomai-2.4.x/src'<br>Making all in include<br>ma=
ke[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include'<br>Making=
 all in asm-generic<br>make[2]: Entrando no diret=F3rio `/home/user/xenomai=
-2.4.x/include/asm-generic'<br>Making all in bits<br>make[3]: Entrando no d=
iret=F3rio `/home/user/xenomai-2.4.x/include/asm-generic/bits'<br>make[3]: =
Nada a ser feito para `all'.<br>make[3]: Saindo do diret=F3rio `/home/user/=
xenomai-2.4.x/include/asm-generic/bits'<br>make[3]: Entrando no diret=F3rio=
 `/home/user/xenomai-2.4.x/include/asm-generic'<br>make[3]: Nada a ser feit=
o para `all-am'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.=
x/include/asm-generic'<br>make[2]: Saindo do diret=F3rio `/home/user/xenoma=
i-2.4.x/include/asm-generic'<br>Making all in asm-blackfin<br>make[2]: Entr=
ando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-blackfin'<br>Maki=
ng all in bits<br>make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.=
x/include/asm-blackfin/bits'<br>make[3]: Nada a ser feito para `all'.<br>ma=
ke[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-blackfin=
/bits'<br>make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/includ=
e/asm-blackfin'<br>make[3]: Nada a ser feito para `all-am'.<br>make[3]: Sai=
ndo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-blackfin'<br>make[=
2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-blackfin'<b=
r>Making all in asm-x86<br>make[2]: Entrando no diret=F3rio `/home/user/xen=
omai-2.4.x/include/asm-x86'<br>Making all in bits<br>make[3]: Entrando no d=
iret=F3rio `/home/user/xenomai-2.4.x/include/asm-x86/bits'<br>make[3]: Nada=
 a ser feito para `all'.<br>make[3]: Saindo do diret=F3rio `/home/user/xeno=
mai-2.4.x/include/asm-x86/bits'<br>make[3]: Entrando no diret=F3rio `/home/=
user/xenomai-2.4.x/include/asm-x86'<br>make[3]: Nada a ser feito para `all-=
am'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/as=
m-x86'<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/=
asm-x86'<br>Making all in asm-ia64<br>make[2]: Entrando no diret=F3rio `/ho=
me/user/xenomai-2.4.x/include/asm-ia64'<br>Making all in bits<br>make[3]: E=
ntrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-ia64/bits'<br>=
make[3]: Nada a ser feito para `all'.<br>make[3]: Saindo do diret=F3rio `/h=
ome/user/xenomai-2.4.x/include/asm-ia64/bits'<br>make[3]: Entrando no diret=
=F3rio `/home/user/xenomai-2.4.x/include/asm-ia64'<br>make[3]: Nada a ser f=
eito para `all-am'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2=
.4.x/include/asm-ia64'<br>make[2]: Saindo do diret=F3rio `/home/user/xenoma=
i-2.4.x/include/asm-ia64'<br>Making all in asm-powerpc<br>make[2]: Entrando=
 no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-powerpc'<br>Making al=
l in bits<br>make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/inc=
lude/asm-powerpc/bits'<br>make[3]: Nada a ser feito para `all'.<br>make[3]:=
 Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-powerpc/bits'<=
br>make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/asm-p=
owerpc'<br>make[3]: Nada a ser feito para `all-am'.<br>make[3]: Saindo do d=
iret=F3rio `/home/user/xenomai-2.4.x/include/asm-powerpc'<br>make[2]: Saind=
o do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-powerpc'<br>Making a=
ll in asm-arm<br>make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x=
/include/asm-arm'<br>Making all in bits<br>make[3]: Entrando no diret=F3rio=
 `/home/user/xenomai-2.4.x/include/asm-arm/bits'<br>make[3]: Nada a ser fei=
to para `all'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/=
include/asm-arm/bits'<br>make[3]: Entrando no diret=F3rio `/home/user/xenom=
ai-2.4.x/include/asm-arm'<br>make[3]: Nada a ser feito para `all-am'.<br>ma=
ke[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-arm'<br>=
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/asm-arm'<b=
r>Making all in asm-sim<br>make[2]: Entrando no diret=F3rio `/home/user/xen=
omai-2.4.x/include/asm-sim'<br>Making all in bits<br>make[3]: Entrando no d=
iret=F3rio `/home/user/xenomai-2.4.x/include/asm-sim/bits'<br>make[3]: Nada=
 a ser feito para `all'.<br>make[3]: Saindo do diret=F3rio `/home/user/xeno=
mai-2.4.x/include/asm-sim/bits'<br>make[3]: Entrando no diret=F3rio `/home/=
user/xenomai-2.4.x/include/asm-sim'<br>make[3]: Nada a ser feito para `all-=
am'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/as=
m-sim'<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/=
asm-sim'<br>Making all in native<br>make[2]: Entrando no diret=F3rio `/home=
/user/xenomai-2.4.x/include/native'<br>make[2]: Nada a ser feito para `all'=
.<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/nativ=
e'<br>Making all in nucleus<br>make[2]: Entrando no diret=F3rio `/home/user=
/xenomai-2.4.x/include/nucleus'<br>make[2]: Nada a ser feito para `all'.<br=
>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/nucleus'<=
br>Making all in posix<br>make[2]: Entrando no diret=F3rio `/home/user/xeno=
mai-2.4.x/include/posix'<br>Making all in sys<br>make[3]: Entrando no diret=
=F3rio `/home/user/xenomai-2.4.x/include/posix/sys'<br>make[3]: Nada a ser =
feito para `all'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4=
.x/include/posix/sys'<br>make[3]: Entrando no diret=F3rio `/home/user/xenom=
ai-2.4.x/include/posix'<br>make[3]: Nada a ser feito para `all-am'.<br>make=
[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/posix'<br>make=
[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/include/posix'<br>Maki=
ng all in psos+<br>make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4=
.x/include/psos+'<br>make[2]: Nada a ser feito para `all'.<br>make[2]: Sain=
do do diret=F3rio `/home/user/xenomai-2.4.x/include/psos+'<br>Making all in=
 rtai<br>make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include=
/rtai'<br>make[2]: Nada a ser feito para `all'.<br>make[2]: Saindo do diret=
=F3rio `/home/user/xenomai-2.4.x/include/rtai'<br>Making all in rtdm<br>mak=
e[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/include/rtdm'<br>ma=
ke[2]: Nada a ser feito para `all'.<br>make[2]: Saindo do diret=F3rio `/hom=
e/user/xenomai-2.4.x/include/rtdm'<br>Making all in uitron<br>make[2]: Entr=
ando no diret=F3rio `/home/user/xenomai-2.4.x/include/uitron'<br>make[2]: N=
ada a ser feito para `all'.<br>make[2]: Saindo do diret=F3rio `/home/user/x=
enomai-2.4.x/include/uitron'<br>Making all in vrtx<br>make[2]: Entrando no =
diret=F3rio `/home/user/xenomai-2.4.x/include/vrtx'<br>make[2]: Nada a ser =
feito para `all'.<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4=
.x/include/vrtx'<br>Making all in vxworks<br>make[2]: Entrando no diret=F3r=
io `/home/user/xenomai-2.4.x/include/vxworks'<br>make[2]: Nada a ser feito =
para `all'.<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/inc=
lude/vxworks'<br>make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x=
/include'<br>make[2]: Nada a ser feito para `all-am'.<br>make[2]: Saindo do=
 diret=F3rio `/home/user/xenomai-2.4.x/include'<br>make[1]: Saindo do diret=
=F3rio `/home/user/xenomai-2.4.x/include'<br>Making all in config<br>make[1=
]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/config'<br>make[1]: Na=
da a ser feito para `all'.<br>make[1]: Saindo do diret=F3rio `/home/user/xe=
nomai-2.4.x/config'<br>Making all in doc<br>make[1]: Entrando no diret=F3ri=
o `/home/user/xenomai-2.4.x/doc'<br>Making all in docbook<br>make[2]: Entra=
ndo no diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook'<br>Making all in =
custom-stylesheets<br>make[3]: Entrando no diret=F3rio `/home/user/xenomai-=
2.4.x/doc/docbook/custom-stylesheets'<br>Making all in xsl<br>make[4]: Entr=
ando no diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheet=
s/xsl'<br>Making all in common<br>make[5]: Entrando no diret=F3rio `/home/u=
ser/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/common'<br>make[5]: Na=
da a ser feito para `all'.<br>make[5]: Saindo do diret=F3rio `/home/user/xe=
nomai-2.4.x/doc/docbook/custom-stylesheets/xsl/common'<br>Making all in fo<=
br>make[5]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook/c=
ustom-stylesheets/xsl/fo'<br>make[5]: Nada a ser feito para `all'.<br>make[=
5]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook/custom-styl=
esheets/xsl/fo'<br>Making all in html<br>make[5]: Entrando no diret=F3rio `=
/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/html'<br>make[5=
]: Nada a ser feito para `all'.<br>make[5]: Saindo do diret=F3rio `/home/us=
er/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl/html'<br>make[5]: Entra=
ndo no diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets=
/xsl'<br>make[5]: Nada a ser feito para `all-am'.<br>make[5]: Saindo do dir=
et=F3rio `/home/user/xenomai-2.4.x/doc/docbook/custom-stylesheets/xsl'<br>m=
ake[4]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook/custom-=
stylesheets/xsl'<br>make[4]: Entrando no diret=F3rio `/home/user/xenomai-2.=
4.x/doc/docbook/custom-stylesheets'<br>make[4]: Nada a ser feito para `all-=
am'.<br>make[4]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/docboo=
k/custom-stylesheets'<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai=
-2.4.x/doc/docbook/custom-stylesheets'<br>Making all in xenomai<br>make[3]:=
 Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/docbook/xenomai'<br>=
make[3]: Nada a ser feito para `all'.<br>make[3]: Saindo do diret=F3rio `/h=
ome/user/xenomai-2.4.x/doc/docbook/xenomai'<br>make[3]: Entrando no diret=
=F3rio `/home/user/xenomai-2.4.x/doc/docbook'<br>make[3]: Nada a ser feito =
para `all-am'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/=
doc/docbook'<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/do=
c/docbook'<br>Making all in doxygen<br>make[2]: Entrando no diret=F3rio `/h=
ome/user/xenomai-2.4.x/doc/doxygen'<br>make[2]: Nada a ser feito para `all'=
.<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc/doxygen'<=
br>Making all in man<br>make[2]: Entrando no diret=F3rio `/home/user/xenoma=
i-2.4.x/doc/man'<br>make[2]: Nada a ser feito para `all'.<br>make[2]: Saind=
o do diret=F3rio `/home/user/xenomai-2.4.x/doc/man'<br>Making all in txt<br=
>make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/doc/txt'<br>mak=
e[2]: Nada a ser feito para `all'.<br>make[2]: Saindo do diret=F3rio `/home=
/user/xenomai-2.4.x/doc/txt'<br>make[2]: Entrando no diret=F3rio `/home/use=
r/xenomai-2.4.x/doc'<br>make[2]: Nada a ser feito para `all-am'.<br>make[2]=
: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/doc'<br>make[1]: Saindo d=
o diret=F3rio `/home/user/xenomai-2.4.x/doc'<br>Making all in scripts<br>ma=
ke[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/scripts'<br>make[1=
]: Nada a ser feito para `all'.<br>make[1]: Saindo do diret=F3rio `/home/us=
er/xenomai-2.4.x/scripts'<br>make[1]: Entrando no diret=F3rio `/home/user/x=
enomai-2.4.x'<br>make[1]: Nada a ser feito para `all-am'.<br>make[1]: Saind=
o do diret=F3rio `/home/user/xenomai-2.4.x'<br><br>And I'm not sure of what=
 to make of it.<br>There's no error message, but those stuff don't seem rig=
ht.<br><br>By the way: <br>Entrando no diret=F3rio =3D Entering the directo=
ry;<br>Nada a ser feito =3D Nothing to be done;<br>Saindo do diret=F3rio =
=3D Leaving the directory.<br><br>Thanks for your help.<br><br><pre>Marco A=
nt=F4nio Possamai

Universidade Federal de Santa Catarina
</pre>


</div>
<BR>

--=20
<div> Be Yourself @ mail.com!<br>
Choose From 200+ Email Addresses<br>
Get a <b>Free</b> Account at <a href=3D"http://www.mail.com/Product.aspx" t=
arget=3D"_blank">www.mail.com</a>!</div>

--_----------=_1226179087148310--



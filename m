Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_1226098613258870"
MIME-Version: 1.0
From: =?iso-8859-1?B?TWFyY28gQW509G5pbyBQb3NzYW1haQ==?=
	<marco.possamai@domain.hid>
Date: Fri, 7 Nov 2008 19:56:53 -0300
Message-Id: <20081107225653.D614C47808F@ws1-5.us4.outblaze.com>
Subject: [Xenomai-help] Problems with uImage
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

--_----------=_1226098613258870
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi, all. I'm having some trouble trying to build uImage. Here's the steps
I took in order to get it built. It didn't quite work, unfortunately:

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
<*>   MSCAN driver for MPC52xx
[*]     Enable CAN 1 (NEW)
[*]     Enable CAN 2 (NEW)
(66000000) Clock Frequency in Hz (NEW)
Pin Configuration (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin
...

$ make ARCH=3Dpowerpc uImage

It starts building alright, but when it gets to the mscan part it
crashes, echoing the following:

CC      drivers/xenomai/can/rtcan_raw_filter.o
LD      drivers/xenomai/can/xeno_can.o
CC      drivers/xenomai/can/mscan/rtcan_mscan.o
drivers/xenomai/can/mscan/rtcan_mscan.c: In function 'mscan_gpio_config':
drivers/xenomai/can/mscan/rtcan_mscan.c:705: error: implicit declaration
of function 'mpc52xx_find_and_map'
make[4]: ** [drivers/xenomai/can/mscan/rtcan_mscan.o] Erro 1
make[3]: ** [drivers/xenomai/can/mscan] Erro 2
make[2]: ** [drivers/xenomai/can] Erro 2
make[1]: ** [drivers/xenomai] Erro 2
make: ** [drivers] Erro 2

How can I correct it? I've managed to succesfully build the image before
on a different PC using the same steps.

I'd really appreciate some help. Thanks in advance!


Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina

--=20
Be Yourself @ mail.com!
Choose From 200+ Email Addresses
Get a Free Account at www.mail.com


--_----------=_1226098613258870
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<div>

<p>Hi, all. I'm having some trouble trying to build uImage. Here's the step=
s I took in order to get it built. It didn't quite work, unfortunately:<br>=
</p><p>$ export CROSS_COMPILE=3Dppc_6xx-<br><br>$ git clone git://git.denx.=
de/linux-2.6-denx.git<br>$ export KDIR=3D$PWD/linux-2.6-denx<br><br>$ svn c=
o http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x<br>$ export =
XDIR=3D$PWD/xenomai-2.4.x<br><br>$ cd $KDIR<br>$ git checkout origin/DENX-v=
2.6.25-stable<br>$ git checkout -b origin/DENX-v2.6.25-stable<br><br>$ cd $=
XDIR<br>$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowe=
rpc<br><br>Adeos patch [default /home/user/linux-2.6-denx/xenomai-2.4.x/ksr=
c/arch/powerpc/patches/adeos-ipipe-2.6.25-powerpc-DENX-2.2-03.patch]:<br><b=
r>$ cd $KDIR<br>$ make ARCH=3Dpowerpc mpc5200_defconfig<br>$ make ARCH=3Dpo=
werpc menuconfig<br><br>&nbsp; ... enable RT-Socket-CAN and MSCAN driver ..=
.<br>&nbsp; &lt;*&gt; RT-Socket-CAN, CAN raw socket interface<br>&nbsp; [*]=
&nbsp;&nbsp; Enable debug output (NEW)<br>&nbsp; [ ]&nbsp;&nbsp; Enable TX =
loopback to local sockets (NEW)<br>&nbsp; (1024) Size of receive ring buffe=
rs (must be 2^N) (NEW)<br>&nbsp; (4)&nbsp;&nbsp; Maximum number of devices =
(NEW)<br>&nbsp; (16)&nbsp; Maximum number of receive filters per device (NE=
W)<br>&nbsp; &lt; &gt;&nbsp;&nbsp; Virtual CAN bus driver (NEW)<br>&nbsp; &=
lt;*&gt;&nbsp;&nbsp; MSCAN driver for MPC52xx<br>&nbsp; [*]&nbsp;&nbsp;&nbs=
p;&nbsp; Enable CAN 1 (NEW)<br>&nbsp; [*]&nbsp;&nbsp;&nbsp;&nbsp; Enable CA=
N 2 (NEW)<br>&nbsp; (66000000) Clock Frequency in Hz (NEW)<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pin Configuration (CAN 1 on I2C1 =
pins, CAN 2 on TMR01 pin <br>&nbsp; ...<br><br>$ make ARCH=3Dpowerpc uImage=
<br></p><p>It starts building alright, but when it gets to the mscan part i=
t crashes, echoing the following:<br></p><p>&nbsp;
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/rtcan_raw_filter.o<br>=
&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/xeno_can.o<br>&=
nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/mscan/rtcan_msca=
n.o<br>drivers/xenomai/can/mscan/rtcan_mscan.c: In function 'mscan_gpio_con=
fig':<br>drivers/xenomai/can/mscan/rtcan_mscan.c:705: error: implicit decla=
ration of function 'mpc52xx_find_and_map'<br>make[4]: ** [drivers/xenomai/c=
an/mscan/rtcan_mscan.o] Erro 1<br>make[3]: ** [drivers/xenomai/can/mscan] E=
rro 2<br>make[2]: ** [drivers/xenomai/can] Erro 2<br>make[1]: ** [drivers/x=
enomai] Erro 2<br>make: ** [drivers] Erro 2<br></p><p>How can I correct it?=
 I've managed to succesfully build the image before on a different PC using=
 the same steps.<br>
</p><p>I'd really appreciate some help. Thanks in advance!<br></p><p><br></=
p><pre>Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina
</pre>


</div>
<BR>

--=20
<div> Be Yourself @ mail.com!<br>
Choose From 200+ Email Addresses<br>
Get a <b>Free</b> Account at <a href=3D"http://www.mail.com/Product.aspx" t=
arget=3D"_blank">www.mail.com</a>!</div>

--_----------=_1226098613258870--



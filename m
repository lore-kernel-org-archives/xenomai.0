Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_1221671769182210"
MIME-Version: 1.0
From: =?iso-8859-1?B?TWFyY28gQW509G5pbyBQb3NzYW1haQ==?=
	<marco.possamai@domain.hid>
Date: Wed, 17 Sep 2008 14:16:09 -0300
Message-Id: <20080917171609.0666E1CE825@domain.hid>
Subject: [Xenomai-help] Image building, porting issues
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

--_----------=_1221671769182210
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi, all!

Once again I have come across several error codes when I try the build
image command.

Same Ubuntu 8.04 distro, here.

(All ELDK installing and configuring are now correctly done. Bad
installing and configuring were causing the previous errors I mailed
before; doesn't matter now)

Check the code so far:


$ export CROSS_COMPILE=3Dppc_6xx-


$ git clone git://git.denx.de/linux-2.6-denx.git
$ export KDIR=3D$PWD/linux-2.6-denx

$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x
$ export XDIR=3D$PWD/xenomai-2.4.x

$ cd $KDIR
$ git checkout origin/DENX-v2.6.25-stable

(All tools and sources acquired)


$ cd $XDIR
$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc


$ cd $KDIR
$ make ARCH=3Dpowerpc mpc5200_defconfig
$ make ARCH=3Dpowerpc menuconfig

(Here's the options I've enabled in the config menu that followed)

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


It then echoes the following lines plus the error messages:

CHK     include/linux/version.h
CHK     include/linux/utsrelease.h
CALL    scripts/checksyscalls.sh
CHK     include/linux/compile.h
CALL    arch/powerpc/kernel/systbl_chk.sh
CC      drivers/xenomai/can/mscan/rtcan_mscan.o
drivers/xenomai/can/mscan/rtcan_mscan.c: In function 'mscan_gpio_config':
drivers/xenomai/can/mscan/rtcan_mscan.c:705: error: implicit declaration
of function 'mpc52xx_find_and_map'
make[4]: ** [drivers/xenomai/can/mscan/rtcan_mscan.o] Erro 1
make[3]: ** [drivers/xenomai/can/mscan] Erro 2
make[2]: ** [drivers/xenomai/can] Erro 2
make[1]: ** [drivers/xenomai] Erro 2
make: ** [drivers] Erro 2


I've also tested with the following command:

$ make ARCH=3Dpowerpc uImage

and it issued the same error lines.


Any thoughts?


Thanks in advance!


Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina

--=20
Be Yourself @ mail.com!
Choose From 200+ Email Addresses
Get a Free Account at www.mail.com


--_----------=_1221671769182210
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<div>

<p>
</p><p>Hi, all!</p><p>Once again I have come across several error codes whe=
n I try the build image command.</p><p>Same Ubuntu 8.04 distro, here.</p><p=
>(All ELDK installing and configuring are now correctly done. Bad
installing and configuring were causing the previous errors I mailed
before; doesn't matter now)</p><p>Check the code so far:</p><p><br></p><p>$=
 export CROSS_COMPILE=3Dppc_6xx-<br><br><br>$ git clone git://<a target=3D"=
_blank" href=3D"http://git.denx.de/linux-2.6-denx.git">git.denx.de/linux-2.=
6-denx.git</a><br>$ export KDIR=3D$PWD/linux-2.6-denx<br>
<br>$ svn co <a target=3D"_blank" href=3D"http://svn.gna.org/svn/xenomai/br=
anches/v2.4.x">http://svn.gna.org/svn/xenomai/branches/v2.4.x</a> xenomai-2=
.4.x<br>$ export XDIR=3D$PWD/xenomai-2.4.x<br><br>$ cd $KDIR<br>$ git check=
out origin/DENX-v2.6.25-stable<br>
</p><p>(All tools and sources acquired)<br></p><p><br>$ cd $XDIR<br>$ scrip=
ts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc<br><br><br>=
$ cd $KDIR<br>$ make ARCH=3Dpowerpc mpc5200_defconfig<br>$ make ARCH=3Dpowe=
rpc menuconfig</p>
<p>(Here's the options I've enabled in the config menu that followed)</p><p=
>&nbsp; ... enable RT-Socket-CAN and MSCAN driver ...<br>&nbsp; &lt;*&gt; R=
T-Socket-CAN, CAN raw socket interface<br>&nbsp; [*]&nbsp;&nbsp; Enable deb=
ug output (NEW)<br>
&nbsp; [ ]&nbsp;&nbsp; Enable TX loopback to local sockets (NEW)<br>&nbsp; =
(1024) Size of receive ring buffers (must be 2^N) (NEW)<br>&nbsp; (4)&nbsp;=
&nbsp; Maximum number of devices (NEW)<br>&nbsp; (16)&nbsp; Maximum number =
of receive filters per device (NEW)<br>&nbsp; &lt; &gt;&nbsp;&nbsp; Virtual=
 CAN bus driver (NEW)<br>
&nbsp; &lt;*&gt;&nbsp;&nbsp; MSCAN driver for MPC52xx<br>&nbsp; [*]&nbsp;&n=
bsp;&nbsp;&nbsp; Enable CAN 1 (NEW)<br>&nbsp; [*]&nbsp;&nbsp;&nbsp;&nbsp; E=
nable CAN 2 (NEW)<br>&nbsp; (66000000) Clock Frequency in Hz (NEW)<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pin Configuration (CAN 1 =
on I2C1 pins, CAN 2 on TMR01 pin<br>
&nbsp; ...</p><p><br>$ make ARCH=3Dpowerpc uImage</p><p><br></p><p>It then =
echoes the following lines plus the error messages:<br></p><p>&nbsp; CHK&nb=
sp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>&nbsp; CHK&nbsp;&nbsp;&nbs=
p;&nbsp; include/linux/utsrelease.h<br>&nbsp; CALL&nbsp;&nbsp;&nbsp; script=
s/checksyscalls.sh<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/comp=
ile.h<br>&nbsp; CALL&nbsp;&nbsp;&nbsp; arch/powerpc/kernel/systbl_chk.sh<br=
>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/mscan/rtcan_ms=
can.o<br>drivers/xenomai/can/mscan/rtcan_mscan.c: In function 'mscan_gpio_c=
onfig':<br>drivers/xenomai/can/mscan/rtcan_mscan.c:705: error: implicit dec=
laration of function 'mpc52xx_find_and_map'<br>make[4]: ** [drivers/xenomai=
/can/mscan/rtcan_mscan.o] Erro 1<br>make[3]: ** [drivers/xenomai/can/mscan]=
 Erro 2<br>make[2]: ** [drivers/xenomai/can] Erro 2<br>make[1]: ** [drivers=
/xenomai] Erro 2<br>make: ** [drivers] Erro 2<br></p><p><br></p><p>I've als=
o tested with the following command:<br></p><p>$ make ARCH=3Dpowerpc uImage
</p><p> and it issued the same error lines.</p><p><br></p><p>Any thoughts?<=
br></p><p><br></p><p>Thanks in advance!</p><p><br>

</p><pre>Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina
</pre>


</div>
<BR>

--=20
<div> Be Yourself @ mail.com!<br>
Choose From 200+ Email Addresses<br>
Get a <b>Free</b> Account at <a href=3D"http://www.mail.com/Product.aspx" t=
arget=3D"_blank">www.mail.com</a>!</div>

--_----------=_1221671769182210--



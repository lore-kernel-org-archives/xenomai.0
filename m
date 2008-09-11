Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_1221172292236930"
MIME-Version: 1.0
From: =?iso-8859-1?B?TWFyY28gQW509G5pbyBQb3NzYW1haQ==?=
	<marco.possamai@domain.hid>
Date: Thu, 11 Sep 2008 19:31:32 -0300
Message-Id: <20080911223132.2FB4832675A@ws1-8.us4.outblaze.com>
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
To: Xenomai-help@domain.hid

This is a multi-part message in MIME format.

--_----------=_1221172292236930
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Greetings, ppl.

I'm kind of new to the whole Linux and kernel programming scenario, and
I've been having trouble with some stuff I've been encountering along a
project.

I'm using the Ubuntu 8.04 distro, btw.

Here's the beef:

I've been working on getting Xenomai ported to a Freescale mpc5200, and I
have been having trouble on the first steps, specially concerning the
Image creation (to port it to the mpc5200). Still on the configuring the
ELDK stages.

Here's the coding so far:


$ export CROSS_COMPILE=3Dppc_6xx


$ git clone git://git.denx.de/linux-2.6-denx.git
$ export KDIR=3D$PWD/linux-2.6-denx

$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x
$ export XDIR=3D$PWD/xenomai-2.4.x

$ cd $KDIR
$ git checkout origin/DENX-v2.6.25-stable

All tools and sources acquired.


$ cd $XDIR
$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc


$ cd $KDIR
$ make ARCH=3Dpowerpc mpc5200_defconfig
$ make ARCH=3Dpowerpc menuconfig

(Here's the options I've enabled in the config menu thet followed)

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


After this point, the following error messages appeared:

make: ppc_6xxgcc: Comando n=E3o encontrado (command not found)
scripts/kconfig/conf -s arch/powerpc/Kconfig
make: ppc_6xxgcc: Comando n=E3o encontrado (command not found)
/home/user/linux-2.6-denx/scripts/gcc-version.sh: line 25: ppc_6xxgcc:
comando n=E3o encontrado (command not found)
/home/user/linux-2.6-denx/scripts/gcc-version.sh: line 26: ppc_6xxgcc:
comando n=E3o encontrado (command not found)
/home/user/linux-2.6-denx/scripts/gcc-version.sh: line 25: ppc_6xxgcc:
comando n=E3o encontrado (command not found)
/home/user/linux-2.6-denx/scripts/gcc-version.sh: line 26: ppc_6xxgcc:
comando n=E3o encontrado (command not found)
/home/user/linux-2.6-denx/scripts/gcc-version.sh: line 28: ppc_6xxgcc:
comando n=E3o encontrado (command not found)
*** 2.6 kernels no longer build correctly with old versions of binutils.
*** Please upgrade your binutils to 2.12.1 or newer
make: ** [checkbin] Erro 1

The strangest thing is that I've got all gcc and binutils updated to
their newest, and somehow the ppc_6xxgcc isn't trackable anywhere.

I'm puzzled by such messages and no similar problems I've found in my
searches using Google.

Can anyone help me?


Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina

--=20
Be Yourself @ mail.com!
Choose From 200+ Email Addresses
Get a Free Account at www.mail.com


--_----------=_1221172292236930
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<div>


<div>

<p>
Greetings, ppl.</p><p>I'm kind of new to the whole Linux and kernel program=
ming scenario, and I've been having trouble with some stuff I've been encou=
ntering along a project.<br></p><p>I'm using the Ubuntu 8.04 distro, btw.</=
p><p>Here's the beef:<br></p><p>I've been working on getting Xenomai ported=
 to a Freescale mpc5200, and I have been having trouble on the first steps,=
 specially concerning the Image creation (to port it to the mpc5200). Still=
 on the configuring the ELDK stages.<br></p><p>Here's the coding so far:</p=
><p><br></p><p>$ export CROSS_COMPILE=3Dppc_6xx<br><br><br>$ git clone git:=
//git.denx.de/linux-2.6-denx.git<br>$ export KDIR=3D$PWD/linux-2.6-denx<br>=
<br>$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x<b=
r>$ export XDIR=3D$PWD/xenomai-2.4.x<br><br>$ cd $KDIR<br>$ git checkout or=
igin/DENX-v2.6.25-stable<br></p><p>All tools and sources acquired.<br></p><=
p><br>$ cd $XDIR<br>$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose -=
-arch=3Dpowerpc<br><br><br>$ cd $KDIR<br>$ make ARCH=3Dpowerpc mpc5200_defc=
onfig<br>$ make ARCH=3Dpowerpc menuconfig</p><p>(Here's the options I've en=
abled in the config menu thet followed)</p><p>&nbsp; ... enable RT-Socket-C=
AN and MSCAN driver ...<br>&nbsp; &lt;*&gt; RT-Socket-CAN, CAN raw socket i=
nterface<br>&nbsp; [*]&nbsp;&nbsp; Enable debug output (NEW)<br>&nbsp; [ ]&=
nbsp;&nbsp; Enable TX loopback to local sockets (NEW)<br>&nbsp; (1024) Size=
 of receive ring buffers (must be 2^N) (NEW)<br>&nbsp; (4)&nbsp;&nbsp; Maxi=
mum number of devices (NEW)<br>&nbsp; (16)&nbsp; Maximum number of receive =
filters per device (NEW)<br>&nbsp; &lt; &gt;&nbsp;&nbsp; Virtual CAN bus dr=
iver (NEW)<br>&nbsp; &lt;*&gt;&nbsp;&nbsp; MSCAN driver for MPC52xx<br>&nbs=
p; [*]&nbsp;&nbsp;&nbsp;&nbsp; Enable CAN 1 (NEW)<br>&nbsp; [*]&nbsp;&nbsp;=
&nbsp;&nbsp; Enable CAN 2 (NEW)<br>&nbsp; (66000000) Clock Frequency in Hz =
(NEW)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pin Configu=
ration (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin<br>&nbsp; ...</p><p><br>$ ma=
ke ARCH=3Dpowerpc uImage<br></p><p><br></p><p>After this point, the followi=
ng error messages appeared:</p><p>make: ppc_6xxgcc: Comando n=E3o encontrad=
o (command not found)<br>scripts/kconfig/conf -s arch/powerpc/Kconfig<br>ma=
ke: ppc_6xxgcc: Comando n=E3o encontrado (command not found)<br>/home/user/=
linux-2.6-denx/scripts/gcc-version.sh: line 25: ppc_6xxgcc: comando n=E3o e=
ncontrado (command not found)<br>/home/user/linux-2.6-denx/scripts/gcc-vers=
ion.sh: line 26: ppc_6xxgcc: comando n=E3o encontrado (command not found)<b=
r>/home/user/linux-2.6-denx/scripts/gcc-version.sh: line 25: ppc_6xxgcc: co=
mando n=E3o encontrado (command not found)<br>/home/user/linux-2.6-denx/scr=
ipts/gcc-version.sh: line 26: ppc_6xxgcc: comando n=E3o encontrado (command=
 not found)<br>/home/user/linux-2.6-denx/scripts/gcc-version.sh: line 28: p=
pc_6xxgcc: comando n=E3o encontrado (command not found)<br>*** 2.6 kernels =
no longer build correctly with old versions of binutils.<br>*** Please upgr=
ade your binutils to 2.12.1 or newer<br>make: ** [checkbin] Erro 1<br><br><=
/p><p>The strangest thing is that I've got all gcc and binutils updated to =
their newest, and somehow the ppc_6xxgcc isn't trackable anywhere.<br></p><=
p>I'm puzzled by such messages and no similar problems I've found in my sea=
rches using Google.</p><p>Can anyone help me?<br></p><p><br>

</p><pre>Marco Ant=F4nio Possamai

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

--_----------=_1221172292236930--



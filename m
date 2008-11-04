Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_1225836575168300"
MIME-Version: 1.0
From: =?iso-8859-1?B?TWFyY28gQW509G5pbyBQb3NzYW1haQ==?=
	<marco.possamai@domain.hid>
Date: Tue, 4 Nov 2008 19:09:34 -0300
Message-Id: <20081104220935.659ED1642C3@domain.hid>
Subject: [Xenomai-help] Problems with image building Icecube
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

--_----------=_1225836575168300
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Here's what I've done so far:

$ export CROSS_COMPILE=3Dppc_6xx-

Get the sources:

$ git clone git://git.denx.de/linux-2.6-denx.git
$ export KDIR=3D$PWD/linux-2.6-denx

$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2.4.x
$ export XDIR=3D$PWD/xenomai-2.4.x

$ cd $KDIR
$ git checkout origin/DENX-v2.6.25-stable
$ git checkout -b origin/DENX-v2.6.25-stable


Prepare the kernel for Xenomai:

$ cd $XDIR
$ scripts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc

The following will appear:

Adeos patch [default
/home/user/linux-2.6-denx/xenomai-2.4.x/ksrc/arch/powerpc/patches/adeos-ipi=
pe-2.6.25-powerpc-DENX-2.2-03.patch]:

Just hit enter.


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
<*>   MSCAN driver for MPC52xx
[*]     Enable CAN 1 (NEW)
[*]     Enable CAN 2 (NEW)
(66000000) Clock Frequency in Hz (NEW)
Pin Configuration (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin
...


Build the image:

$ make ARCH=3Dpowerpc uImage

$ cd $XDIR
$ ./configure --host=3Dppc-linux --prefix=3D/root/xenomai
$ make

After this 'make' instruction, the following echoes:

Making all in src
make[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src'
Making all in include
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src/include'
make  all-am
make[3]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src/include'
make[3]: Nada a ser feito para `all-am'.
make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src/include'
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src/include'
Making all in rtdk
make[2]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src/rtdk'
/bin/bash ../../libtool --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H -=
I.
-I../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include    -MT
librtdk_la-rt_print.lo -MD -MP -MF .deps/librtdk_la-rt_print.Tpo -c -o
librtdk_la-rt_print.lo `test -f 'rt_print.c' || echo './'`rt_print.c
 gcc -DHAVE_CONFIG_H -I. -I../../src/include -O2 -D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
-I../../include -MT librtdk_la-rt_print.lo -MD -MP -MF
.deps/librtdk_la-rt_print.Tpo -c rt_print.c  -fPIC -DPIC -o
.libs/librtdk_la-rt_print.o
{standard input}: Assembler messages:
{standard input}:217: Error: no such instruction: `sync'
{standard input}:221: Error: no such instruction: `sync'
{standard input}:565: Error: no such instruction: `sync'
{standard input}:631: Error: no such instruction: `sync'
make[2]: ** [librtdk_la-rt_print.lo] Erro 1
make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src/rtdk'
make[1]: ** [all-recursive] Erro 1
make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/src'
make: ** [all-recursive] Erro 1


I don't know what to make of it.

The ELDK is up and running, by the way.

Thanks in advance,

Marco Ant=F4nio Possamai


--=20
Be Yourself @ mail.com!
Choose From 200+ Email Addresses
Get a Free Account at www.mail.com


--_----------=_1225836575168300
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<div>

<p>
Here's what I've done so far:</p><p>
$ export CROSS_COMPILE=3Dppc_6xx-<br><br>Get the sources:<br><br>$ git clon=
e git://git.denx.de/linux-2.6-denx.git<br>$ export KDIR=3D$PWD/linux-2.6-de=
nx<br><br>$ svn co http://svn.gna.org/svn/xenomai/branches/v2.4.x xenomai-2=
.4.x<br>$ export XDIR=3D$PWD/xenomai-2.4.x<br><br>$ cd $KDIR<br>$ git check=
out origin/DENX-v2.6.25-stable<br>$ git checkout -b origin/DENX-v2.6.25-sta=
ble<br><br><br>Prepare the kernel for Xenomai:<br><br>$ cd $XDIR<br>$ scrip=
ts/prepare-kernel.sh --linux=3D$KDIR --verbose --arch=3Dpowerpc<br><br>The =
following will appear:<br><br>Adeos patch [default /home/user/linux-2.6-den=
x/xenomai-2.4.x/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.25-powerpc-DENX-2=
.2-03.patch]:<br><br>Just hit enter.<br><br><br>Configure and create the ke=
rnel enabling RT-Socket-CAN:<br><br>$ cd $KDIR<br>$ make ARCH=3Dpowerpc mpc=
5200_defconfig<br>$ make ARCH=3Dpowerpc menuconfig<br>&nbsp; ... enable RT-=
Socket-CAN and MSCAN driver ...<br>&nbsp; &lt;*&gt; RT-Socket-CAN, CAN raw =
socket interface<br>&nbsp; [*]&nbsp;&nbsp; Enable debug output (NEW)<br>&nb=
sp; [ ]&nbsp;&nbsp; Enable TX loopback to local sockets (NEW)<br>&nbsp; (10=
24) Size of receive ring buffers (must be 2^N) (NEW)<br>&nbsp; (4)&nbsp;&nb=
sp; Maximum number of devices (NEW)<br>&nbsp; (16)&nbsp; Maximum number of =
receive filters per device (NEW)<br>&nbsp; &lt; &gt;&nbsp;&nbsp; Virtual CA=
N bus driver (NEW)<br>&nbsp; &lt;*&gt;&nbsp;&nbsp; MSCAN driver for MPC52xx=
<br>&nbsp; [*]&nbsp;&nbsp;&nbsp;&nbsp; Enable CAN 1 (NEW)<br>&nbsp; [*]&nbs=
p;&nbsp;&nbsp;&nbsp; Enable CAN 2 (NEW)<br>&nbsp; (66000000) Clock Frequenc=
y in Hz (NEW)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pin=
 Configuration (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin <br>&nbsp; ...<br><b=
r><br>Build the image:<br><br>$ make ARCH=3Dpowerpc uImage<br><br>$ cd $XDI=
R<br>$ ./configure --host=3Dppc-linux --prefix=3D/root/xenomai<br>$ make<br=
></p><p>After this 'make' instruction, the following echoes:</p><p>Making a=
ll in src<br>make[1]: Entrando no diret=F3rio `/home/user/xenomai-2.4.x/src=
'<br>Making all in include<br>make[2]: Entrando no diret=F3rio `/home/user/=
xenomai-2.4.x/src/include'<br>make&nbsp; all-am<br>make[3]: Entrando no dir=
et=F3rio `/home/user/xenomai-2.4.x/src/include'<br>make[3]: Nada a ser feit=
o para `all-am'.<br>make[3]: Saindo do diret=F3rio `/home/user/xenomai-2.4.=
x/src/include'<br>make[2]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/=
src/include'<br>Making all in rtdk<br>make[2]: Entrando no diret=F3rio `/ho=
me/user/xenomai-2.4.x/src/rtdk'<br>/bin/bash ../../libtool --tag=3DCC&nbsp;=
&nbsp; --mode=3Dcompile gcc -DHAVE_CONFIG_H -I. -I../../src/include&nbsp; -=
O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -D__IN_XENO__ -Wstrict=
-prototypes -I../../include&nbsp;&nbsp;&nbsp; -MT librtdk_la-rt_print.lo -M=
D -MP -MF .deps/librtdk_la-rt_print.Tpo -c -o librtdk_la-rt_print.lo `test =
-f 'rt_print.c' || echo './'`rt_print.c<br>&nbsp;gcc -DHAVE_CONFIG_H -I. -I=
../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -D_=
_IN_XENO__ -Wstrict-prototypes -I../../include -MT librtdk_la-rt_print.lo -=
MD -MP -MF .deps/librtdk_la-rt_print.Tpo -c rt_print.c&nbsp; -fPIC -DPIC -o=
 .libs/librtdk_la-rt_print.o<br>{standard input}: Assembler messages:<br>{s=
tandard input}:217: Error: no such instruction: `sync'<br>{standard input}:=
221: Error: no such instruction: `sync'<br>{standard input}:565: Error: no =
such instruction: `sync'<br>{standard input}:631: Error: no such instructio=
n: `sync'<br>make[2]: ** [librtdk_la-rt_print.lo] Erro 1<br>make[2]: Saindo=
 do diret=F3rio `/home/user/xenomai-2.4.x/src/rtdk'<br>make[1]: ** [all-rec=
ursive] Erro 1<br>make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x/=
src'<br>make: ** [all-recursive] Erro 1<br></p><p><br></p><p>I don't know w=
hat to make of it.</p><p>The ELDK is up and running, by the way.</p><p>Than=
ks in advance,<br></p><pre>Marco Ant=F4nio Possamai

</pre>


</div>
<BR>

--=20
<div> Be Yourself @ mail.com!<br>
Choose From 200+ Email Addresses<br>
Get a <b>Free</b> Account at <a href=3D"http://www.mail.com/Product.aspx" t=
arget=3D"_blank">www.mail.com</a>!</div>

--_----------=_1225836575168300--



Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_1235070956229110"
MIME-Version: 1.0
From: =?iso-8859-1?B?Ik1hcmNvIEFudPRuaW8gUG9zc2FtYWki?=
	<marco.possamai@domain.hid>
Date: Thu, 19 Feb 2009 16:15:56 -0300
Message-Id: <20090219191556.C00FBBE407B@ws1-9.us4.outblaze.com>
Subject: [Xenomai-help] building image error regarding
	xenomai/can/mscan/rtcan_mscan.o
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

--_----------=_1235070956229110
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Greetings, all.

I'm working on building a kernel image for the mpc5200b board with
Xenomai and CAN settings. I wish to generate a cuImage.lite5200b.

Got the xenomai-2.4.3 and the linux-2.6.24. Patched it with
adeos-ipipe-2.6.24-powerpc-DENX-2.1-04.patch.

Then I've configured the CAN settings as I wanted:

$ make ARCH=3Dpowerpc lite5200_defconfig
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

But I've got the following error message after doing the 'make
ARCH=3Dpowerpc zImage' command:

...
LD      drivers/video/built-in.o
CC      drivers/xenomai/can/rtcan_dev.o
CC      drivers/xenomai/can/rtcan_socket.o
CC      drivers/xenomai/can/rtcan_module.o
CC      drivers/xenomai/can/rtcan_raw.o
CC      drivers/xenomai/can/rtcan_raw_dev.o
CC      drivers/xenomai/can/rtcan_raw_filter.o
LD      drivers/xenomai/can/xeno_can.o
CC      drivers/xenomai/can/mscan/rtcan_mscan.o
drivers/xenomai/can/mscan/rtcan_mscan.c:32:25: error: asm/ppcboot.h: No
such file or directory
make[4]: ** [drivers/xenomai/can/mscan/rtcan_mscan.o] Erro 1
make[3]: ** [drivers/xenomai/can/mscan] Erro 2
make[2]: ** [drivers/xenomai/can] Erro 2
make[1]: ** [drivers/xenomai] Erro 2
make: ** [drivers] Erro 2

It seems to have something to do with this asm/ppcboot.h which seems to
be absent. What can I do about it?

Thanks for the attention.

Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina

--=20
Be Yourself @ mail.com!
Choose From 200+ Email Addresses
Get a Free Account at www.mail.com


--_----------=_1235070956229110
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"


<div>

<p>Greetings, all.</p><p>I'm working on building a kernel image for the mpc=
5200b board with Xenomai and CAN settings. I wish to generate a cuImage.lit=
e5200b.<br></p><p>Got the xenomai-2.4.3 and the linux-2.6.24. Patched it wi=
th adeos-ipipe-2.6.24-powerpc-DENX-2.1-04.patch.<br></p><p>Then I've config=
ured the CAN settings as I wanted:</p><p> $ make ARCH=3Dpowerpc lite5200_de=
fconfig<br>$ make ARCH=3Dpowerpc menuconfig<br><br>&nbsp; ... enable RT-Soc=
ket-CAN and MSCAN driver ...<br>&nbsp; &lt;*&gt; RT-Socket-CAN, CAN raw soc=
ket interface<br>&nbsp; [*]&nbsp;&nbsp; Enable debug output (NEW)<br>&nbsp;=
 [ ]&nbsp;&nbsp; Enable TX loopback to local sockets (NEW)<br>&nbsp; (1024)=
 Size of receive ring buffers (must be 2^N) (NEW)<br>&nbsp; (4)&nbsp;&nbsp;=
 Maximum number of devices (NEW)<br>&nbsp; (16)&nbsp; Maximum number of rec=
eive filters per device (NEW)<br>&nbsp; &lt; &gt;&nbsp;&nbsp; Virtual CAN b=
us driver (NEW)<br>&nbsp; &lt;*&gt;&nbsp;&nbsp; MSCAN driver for MPC52xx<br=
>&nbsp; [*]&nbsp;&nbsp;&nbsp;&nbsp; Enable CAN 1 (NEW)<br>&nbsp; [*]&nbsp;&=
nbsp;&nbsp;&nbsp; Enable CAN 2 (NEW)<br>&nbsp; (66000000) Clock Frequency i=
n Hz (NEW)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pin Co=
nfiguration (CAN 1 on I2C1 pins, CAN 2 on TMR01 pin <br>&nbsp; ...<br></p><=
p>But I've got the following error message after doing the 'make ARCH=3Dpow=
erpc zImage' command:<br>
</p><p>...<br>
&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/video/built-in.o<br>&nbsp; =
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/rtcan_dev.o<br>&nbsp; =
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/rtcan_socket.o<br>&nbs=
p; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/rtcan_module.o<br>&=
nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/rtcan_raw.o<br>&=
nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/rtcan_raw_dev.o<=
br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/rtcan_raw_fi=
lter.o<br>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/xeno_=
can.o<br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/xenomai/can/mscan/=
rtcan_mscan.o<br>drivers/xenomai/can/mscan/rtcan_mscan.c:32:25: error: asm/=
ppcboot.h: No such file or directory<br>make[4]: ** [drivers/xenomai/can/ms=
can/rtcan_mscan.o] Erro 1<br>make[3]: ** [drivers/xenomai/can/mscan] Erro 2=
<br>make[2]: ** [drivers/xenomai/can] Erro 2<br>make[1]: ** [drivers/xenoma=
i] Erro 2<br>make: ** [drivers] Erro 2<br></p><p>It seems to have something=
 to do with this asm/ppcboot.h which seems to be absent. What can I do abou=
t it?</p><p>Thanks for the attention.<br></p><pre>Marco Ant=F4nio Possamai

Universidade Federal de Santa Catarina
</pre>


</div>
<BR>

--=20
<div> Be Yourself @ mail.com!<br>
Choose From 200+ Email Addresses<br>
Get a <b>Free</b> Account at <a href=3D"http://www.mail.com/Product.aspx" t=
arget=3D"_blank">www.mail.com</a>!</div>

--_----------=_1235070956229110--



Message-ID: <2f7417810806110043o4fbac699h318f33b7b7359d88@domain.hid>
Date: Wed, 11 Jun 2008 09:43:54 +0200
From: "quinty quinty" <webquinty2@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16153_23067491.1213170234127"
Subject: [Xenomai-help] Help rtcan and MCP5200...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_16153_23067491.1213170234127
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have a MPX5200G develop board and I use xenomai to test real time task.
My problem is that I do not know how to configurate RT-Can driver in kernel
options.

======================================
*U-Boot 1.3.0 (Feb 13 2008 -
10:14:17)
CPU:   MPC5200B v2.2, Core v1.4 at 396 Mhz
Bus 132 MHz, IPB 132 MHz, PCI 66 MHz
Board: MicroSys
MPX5200R3/CRX02
I2C:   85 kHz,
ready
DRAM:  128
MB
FLASH: 16
MB
*======================================

An now, kernel options of RT-CAN:

======================================
*[x]MSCAN driver for MPC52xx
     [x]Enable CAN 1
     [x]Enable CAN 2
     (132000000) Clock Frequency in Hz
     Pin Configuration
           [ ]CAN 1 on I2C1 pins, CAN 2 on TMR01 pins
           [x]CAN 1 and 2 on PSC2 pins*
======================================

Well, I have connected a can device, and I executed ./rtcanrecv rtcan1
--verbose, but I do not receive anything.
But, If I used can without rtcan, for example,
*ifconfig can0 up
canconfig can0 --baudrate=500000 up
candump can0
*I received messages from device, then I understand that problem is in
configuration of RT-CAN driver.

Any advice???

Best regards

------=_Part_16153_23067491.1213170234127
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, <br><br>I have a MPX5200G develop board and I use xenomai to test re=
al time task.<br>My problem is that I do not know how to configurate RT-Can=
 driver in kernel options.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
<b>U-Boot 1.3.0 (Feb 13 2008 - 10:14:17)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>CPU=
:&nbsp;&nbsp; MPC5200B v2.2, Core v1.4 at 396 Mhz <br>Bus 132 MHz, IPB 132 =
MHz, PCI 66 MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <br>Board: MicroSys MPX5200R3/CRX02&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
I2C:&nbsp;&nbsp; 85 kHz, ready&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; <br>DRAM:&nbsp; 128 MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>FLASH: 16 MB&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; <br>
</b>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>An now, kernel options=
 of RT-CAN:<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><b>[x]MSCAN=
 driver for MPC52xx <br>&nbsp;&nbsp;&nbsp;&nbsp; [x]Enable CAN 1<br>&nbsp;&=
nbsp;&nbsp;&nbsp; [x]Enable CAN 2<br>&nbsp;&nbsp;&nbsp;&nbsp; (132000000) C=
lock Frequency in Hz <br>
&nbsp;&nbsp;&nbsp;&nbsp; Pin Configuration<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ]CAN 1 on I2C1 pins, CAN 2 on TMR01 pins =
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [x]CAN 1 a=
nd 2 on PSC2 pins</b><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>Well, I have connected a can device, and I executed ./rtcanrecv rtcan1 =
--verbose, but I do not receive anything.<br>But, If I used can without rtc=
an, for example,<br><b>ifconfig can0 up<br>canconfig can0 --baudrate=3D5000=
00 up<br>
candump can0<br></b>I received messages from device, then I understand that=
 problem is in configuration of RT-CAN driver.<br><br>Any advice???<br><br>=
Best regards<br><br>

------=_Part_16153_23067491.1213170234127--


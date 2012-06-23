From: Kronander Klas <klas.kronander@epfl.ch>
Date: Sat, 23 Jun 2012 14:24:18 +0000
Message-ID: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have an installation of ubuntu 12.04 with xenomai 2.5.5.2. This PC is use=
d to communicate with a robot over CAN bus. The CAN card installed on the P=
C is a dual channel PCI card from PEAK Systems.

I have not been able to use the CAN port at all so far. The device is detec=
ted by the systems and the interfaces show up:

cat /proc/rtcan/devices
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
rtcan0          undefined stopped           0          0          0
rtcan1          undefined stopped           0          0          0

but I am unable to change the state from "stopped" to something useful. Whe=
n I try to reinitialize it tells me that the driver is not loaded:
/usr/xenomai/sbin/rtcanconfig rtcan0 -b 1000000 -c none start
Cannot open RTDM CAN socket. Maybe driver not loaded?

This is confirmed when looking at the loaded modules with lsmod | grep xeno=
_can_peak_pci, which does not find the relevant module. When I try to load =
the module with modprobe xeno_can_peak_pci I do not get any error messages,=
 but the module still does not show up when doing lsmod | grep xeno_can_pea=
k_pci.

Looking in the syslog, I can find some information regarding the CAN device=
, which seemed to have initialized during system startup:

Jun 23 16:20:37 wam-desktop kernel: [    2.105390] RT-Socket-CAN 0.90.2 - (=
C) 2006 RT-Socket-CAN Development Team
Jun 23 16:20:37 wam-desktop kernel: [    2.105397] RTCAN SJA1000 driver ini=
tialized
Jun 23 16:20:37 wam-desktop kernel: [    2.105405] PEAK-PCI-CAN: initializi=
ng device 001c:0001
Jun 23 16:20:37 wam-desktop kernel: [    2.105411] PEAK-PCI-CAN 0000:05:05.=
0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Jun 23 16:20:37 wam-desktop kernel: [    2.110385] PEAK-PCI-CAN: base_addr=
=3Df8272000 conf_addr=3Df826e000 irq=3D17
Jun 23 16:20:37 wam-desktop kernel: [    2.110398] rtcan: registered rtcan0
Jun 23 16:20:37 wam-desktop kernel: [    2.110403] PEAK-PCI-CAN: base_addr=
=3Df8276400 conf_addr=3Df826e000 irq=3D17
Jun 23 16:20:37 wam-desktop kernel: [    2.110413] rtcan: registered rtcan1

This looks fine right? Yet no driver related to any CAN device is loaded. I=
 am stuck and would greatly appreciate some help for fixing this problem.

Thanks in advance,

Best Regards,
Klas Kronander



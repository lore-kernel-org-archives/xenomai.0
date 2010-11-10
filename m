From: Anders Bach Madsen <abm@domain.hid>
Date: Wed, 10 Nov 2010 13:34:55 +0100
Message-ID: <169292FFF5F27141906C787A21B56C402E4320953C@RD01.rd.local>
Content-Language: da-DK
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Socket can devices?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hey

We have installed a Xenomai system on a Atom based computer, which runs fin=
e. We have connected a CAN card, which should be supported by the RT-Socket=
-CAN drivers in Xenomai. The card is also identified during boot and the pr=
oper kernel modules are loaded. We are however unable to create device node=
s for this card, as we cannot find it in the list of devices!

Any suggestions on how to create the device files /dev/rtcan0 and /dev/rtca=
n1 ?

If more information is needed, please say so :)

/Anders=20

Xenomai:

[    0.385244] I-pipe: Domain Xenomai registered.
[    0.385447] Xenomai: hal/i386 started.
[    0.385622] Xenomai: scheduling class idle registered.
[    0.385765] Xenomai: scheduling class rt registered.
[    0.389559] Xenomai: real-time nucleus v2.5.5.2 (Ghosts) loaded.
[    0.389968] Xenomai: SMI-enabled chipset found
[    0.390125] Xenomai: SMI workaround enabled
[    0.390292] Xenomai: NMI watchdog not available.
[    0.390453] Xenomai: starting native API services.
[    0.390595] Xenomai: starting POSIX services.
[    0.390786] Xenomai: starting RTDM services.

CAN card:

[    7.603720] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Te=
am
[    7.663851] RTCAN SJA1000 driver initialized
[    7.688604]   alloc irq_desc for 20 on node -1
[    7.688614]   alloc kstat_irqs on node -1
[    7.688634] IXXAT-PCI-CAN 0000:03:07.0: PCI INT A -> GSI 20 (level, low)=
 -> IRQ 20
[    7.688651] IXXAT-PCI-CAN: Initializing device 10b5:9050:2540
[    7.688817] IXXAT-PCI-CAN: base_addr=3D0xf80c6800 conf_addr=3D0xec80 irq=
=3D20 ocr=3D0xde cdr=3D0x80
[    7.688862] rtcan: registered rtcan0
[    7.688881] IXXAT-PCI-CAN: base_addr=3D0xf80c6a00 conf_addr=3D0xec80 irq=
=3D20 ocr=3D0xde cdr=3D0x80
[    7.688916] rtcan: registered rtcan1

Devices

rogd-xeno ~ # cat /proc/devices
Character devices:
  1 mem
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
 21 sg
 29 fb
128 ptm
136 pts
150 rtpipe
180 usb
189 usb_device
202 cpu/msr
203 cpu/cpuid
226 drm
251 hidraw
252 usbmon
253 bsg
254 rtc

Block devices:
  1 ramdisk
259 blkext
  7 loop
  8 sd
 11 sr
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
 93 nftl
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd


Best regards/Med venlig hilsen

Anders Bach Madsen
PhD Computer Science, Software Developer

R&D
Delta 4=A0=20
DK-8382 Hinnerup
http://www.rogd.dk
=A0
Tlf:=A0=A0 +45 8764 0884
Mobil: +45 2225 1331
Fax:=A0=A0 +45 8764 0844




Message-ID: <38197.128.93.15.41.1135063005.squirrel@domain.hid>
Date: Tue, 20 Dec 2005 08:16:45 +0100 (CET)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Interrupt Shied (II)
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
Cc: wjasper@domain.hid

Hi everybody:

I installed xenomai 2.1 on a little Celeron M laptop with SiS chipset
(distro : fedora core 3, kernel : linux-2.6.14.3-ipipe) :

00:00.0 Host bridge:
Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX Host (rev 11)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 0003
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL Media
IO] (rev 25)
00:02.1 SMBus:Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 00:02.6
Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller (rev a0)
00:02.7 Multimedia audio controller:
Silicon Integrated Systems [SiS] Sound Controller (rev a0)
00:03.0 USB Controller:
Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.1 USB Controller:
Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI
Fast Ethernet (rev 90)
00:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
00:09.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
00:09.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev
04) 00:0e.0 Network controller: Intersil Corporation ISL3886 [Prism
Javelin/Prism Xbow] (rev 01)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP

I left the SMI detection active, but I don't have warning message because
SiS does NOT use SMI interrupt. As I know, everything works OK.

I want to use a little USB data acquisition board USB-1208FS , because some
brave soul ( Warren J. Jasper ) has developed a generic linux library for
this card, including some good documentation an VERY GOOD test programs
(useful for "Dummies Like Me (@TM)" ).

This board is garantee to reach 250 S/s. On my PC, without Xenomai, the
maximum free-running speed is 330 S/s.

My idea is to use a real time xenomai task to pace the data acquisition. As
demo, I'm generating a square wave with the internal DAC to hear the results
on a little piezoelectric speaker. It's sound good :).

To show the dramatic difference bettewen real time and standard Linux, I'm
using the usual usleep() function to generate soft realtime square wave on
the second DAC channel. If run the program leaving the PC idle, the two
channels sound almost equal. If a begin to load the CPU, the real time sound
remain steady and clear BUT the other show jitter and "hole" (no sound).

The demo is really dramatic when the audience realize that the SAME HARDWARE
on the SAME I/O chanel can be used in "dual mode" seamless :o.

Now the problems:

1) If I push the sample rate above 50 S/s the progam starts, but, after a
while, the real time square wave disappear. Also the "SquareWave" task
disappear from /proc/xenomai/sched.

2) it is not a problem of interaction with the NON realtime square wave
because the same behavior remain if I remove the code

3) I tried the same program on the PPC achitecture using a PowerBook with
similar results.

Where is the catch ? I missed something around the interrupt shield ?

I need to develop real-time application using USB devices because we need
something usable with a laptop. Unfortunately USB is NOT supported for real
time applications and I'm not competent enough to write my real time USB
driver.
My hope is that the interrupt shield of Xenomai will save my day :)

Simone Mannori





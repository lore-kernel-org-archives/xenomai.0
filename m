Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Oct 2006 15:34:33 +0200
Message-ID: <6C66DBDE644B9E4B9408FED33753E98E04458097@domain.hid>
From: "Lankheet, Jeroen" <jeroen.lankheet@domain.hid>
Subject: [Xenomai-help] Serial port support questions
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


Dear all,

I've just installed Xenomai on top of a Fedora distribution (x86).
I'm using a Moxa industrial serial board (CP-134) in order to
communicate through RS485.

I tried to run the serial port example from
http://www.rts.uni-hannover.de/rtaddon/rt_serial_uprog.tar.bz2
It seems that my system cannot open the rtser0 device: rt_serial_uprog:
can't open rtser0 (write) I have some simple questions regarding this
example.

1. The xen_16550A module that should be loaded is not in the xenomai
dir? In fact, my /src/xenomai dir lacks a directory with modules. What
went wrong with installation?
2. What is rtser0? Is it a wrapper around the serial hardware for
realtime I/O? I have no devices in /dev that match rtser* 3. I have 4
ports in my sytem, 2 of them are RS232, 2 are RS485. How should I
address them?=20

	Oct 17 13:15:19 localhost kernel: MOXA Smartio/Industio family
driver version 1.9.5
	Oct 17 13:15:19 localhost kernel: Found MOXA CP-134U series
board(BusNo=3D5,DevNo=3D9)
	Oct 17 13:15:19 localhost kernel: ACPI: PCI Interrupt
0000:05:09.0[A] -> GSI 18 (level, low) -> IRQ 169
	Oct 17 13:15:19 localhost kernel:         ttyM0 - ttyM3  max.
baud rate =3D 921600 bps.
4. I've run this same example under RTAI. Although it couldn't read from
rtser1, writing was successful. So I'm not sure that my configuration is
proper. Is there a simple test, other than compiling/running example
programs?
5. From the RTAI installation I have a /etc/rc.d/rc.rtai file that makes
the /dev/rtf* and shm nodes. Isn't this required for Xenomai?

Regards,
Jeroen Lankheet

Consultant=20
Technical Software Engineering
_______________________________________
LogicaCMG Nederland B.V.=20
Division Industry, Distribution & Transport=20

Kennedyplein 248
Postbus 7089
5605 JB Eindhoven
The Netherlands
T: +31 (0)10 25 37 690
F: +31 (0)40 29 57 630
E: jeroen.lankheet@domain.hid
www.logicacmg.com

LogicaCMG Nederland BV
Registered office in Amsterdam, The Netherlands
Registration Number Chamber of Commerce: 3313600


This e-mail and any attachment is for authorised use by the intended recipi=
ent(s) only. It may contain proprietary material, confidential information =
and/or be subject to legal privilege. It should not be copied, disclosed to=
, retained or used by, any other party. If you are not an intended recipien=
t then please promptly delete this e-mail and any attachment and all copies=
 and inform the sender. Thank you.


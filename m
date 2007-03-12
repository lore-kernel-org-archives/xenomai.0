Message-ID: <17648569.1173693688643.JavaMail.ngmail@domain.hid>
Date: Mon, 12 Mar 2007 11:01:28 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] RTDM and user space hardware drivers
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

Hi everybody,

the RTDM API is really very good as API for drivers.=20
I have a real time (Xenomai) application in user space that has to access P=
CI boards.
The "classical" approach is now to use a kernel driver and to use RTDM as i=
nterface
between the user space application an the kernel space driver.
However, for performance issues, I prefer to write a pure user mode driver.
As the memory of the PCI board can be accesses from user space (using /dev/=
mem)=20
I want to write a pure user space driver  as this seems to me more efficien=
t (and easier to debug) than
a kernel driver.
Also, only one application is accessing the driver at a time, I can link th=
e driver directly to my application.

My questions are now:
1. Is it possible to use the RTDM API also for pure user space drivers?

2. Is there any experience concerning the performance of a user space drive=
r versus a kernel space
driver?
In my use case, I have to write and read about 60 byte (each direction) of =
(block) data to/from the PCI I/O system.

Thanks for any ideas or hints on that!

Regards

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


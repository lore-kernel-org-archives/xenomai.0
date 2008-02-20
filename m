Message-ID: <23559868.1203495913401.JavaMail.ngmail@domain.hid>
Date: Wed, 20 Feb 2008 09:25:13 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Atomic 64 bit write access on PCIe device
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

perhaps this issue is off-topic, but I expect that there are many experts o=
n that issue reading the Xenomai list...
I have a Core2Duo Intel CPU (32 bit mode) and a proprietary PCI Express I/O=
 board plugged in.
This PCI Express I/O board has some 64 bit registers that are mapped into a=
ddress space via mmap.
Now, I want to write atomically (one PCIe access) to one of the 64 bit regi=
sters.
Unfortunately, the Intel CPUs does not have an atomic 64 bit write operatio=
ns when running the CPU in 32 bit mode.
When doing something like

volatile unsigned long long *ull =3D register_address;
*ull =3D my_new_register_value;

I see the gcc is generating two 32 bit write accesses. Of course this will =
not lead to an atomic 64 bit write access.

Any idea, how I can write 64 bit integers atomically to such an 64 bit regi=
ster?


Thanks for any feedback!

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT F=DCR ALLE NEUEINSTEIGER
Jetzt bei Arcor: g=FCnstig und schnell mit DSL - das All-Inclusive-Paket
f=FCr clevere Doppel-Sparer, nur  29,95 Euro  inkl. DSL- und ISDN-Grundgeb=
=FChr!
http://www.arcor.de/rd/emf-dsl-2


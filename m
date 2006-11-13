Message-ID: <29293133.1163432148953.JavaMail.ngmail@domain.hid>
Date: Mon, 13 Nov 2006 16:35:48 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai User Space: Using 100% CPU power
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

I have an application where I need extreme precise timing (about 1=B5s) for=
 a couple of seconds
using a standard PC (to access a I/O PCI board).
For this, I want to write an application that initializes normally and=20
whenever the software is in a certain state, I want to enter a  "high-preci=
sion-timing mode".
In this high-precision-timing mode, I want to disable all interrupts and po=
ll permanently on a PCI I/O board.
The timing itself can be directly taken from the CPU's TSC using rdtsc.
Within this mode, the time measurement of register changes on the PCI I/O b=
oard is very important.
After a couple of seconds, when all relevant data is taken, I want to leave=
 this
"high-precision-mode" and come back to the normal mode.
Then the measurement results are interpreted in detail.
All this should happen in user mode, not in kernel mode.

My questions are now:=20
Is this possible using Xenomai?
How can I enter a mode that disables all interrupts (including timer) for a=
 while?

Thanks for any help on this!

Regards

Mathias




--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


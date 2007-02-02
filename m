Message-ID: <24461688.1170430564542.JavaMail.ngmail@domain.hid>
Date: Fri, 2 Feb 2007 16:36:04 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Standard linux assignment of processes to CPUs
 depends on Xenomai Config
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

I just noted another very interesting thing.
When I have the Xenomai support built directly into the kernel (no modules)=
,
the Linux scheduler assigns all Linux tasks to CPU 0 (I have a SMP with a D=
ual Core CPU).
Using e.g. taskset I can of course force tasks to run on CPU 1 but it will =
not be done
automatically.

However, when I use modules for the Xenomai stuff, the Linux scheduler assi=
gns
the tasks to both available CPUs...

This behaviour looks very strange to me...
My setup: Kernel 2.6.19.2, SMP, Pentium 4 D, Xenomai 2.3. + COW patches.
Any idea on this?!?

Thanks and regards

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


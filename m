Message-ID: <17183977.1166537582101.JavaMail.ngmail@domain.hid>
Date: Tue, 19 Dec 2006 15:13:02 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Aw: Re: Aw: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native
	leads...
In-Reply-To: <4587E404.2050101@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4587E404.2050101@domain.hid> <4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

I think you are right.
The NMI watchdog (Realtime) kernel parameter in the kernel configuration wa=
s
accidentally disabled (perhaps because I tried in between with a non-APIC I=
RQ).
Now I have again the error situation of this morning:
Even with gcc-3.3 I am not able to load the xeno_native module when NMI wat=
chdog
is enabled, the system directly reboots (without printing to the serial con=
sole)
The printout I have sent before was the printout of the standard linux NMI =
but
not of the Xenomai NMI.

I.e., it seems _not_ to be the reason of the compiler that leads to the beh=
aviour!

Regards

Mathias
> M. Koehrer wrote:
> > Hi Jan,
> >=20
> > I tried to enable the kernel hacking parameters you proposed.
> > However, now I get a "NMI early shots: 0" message many times per second=
.
> > These seems to slow down everything dramatically, it is hard to work wi=
th
> the
> > system. What are the early shots messages and how can I avoid them?
>=20
> My feeling is that the issue you saw with gcc-4.1.2 is still unsolved,
> just the recompilation made some stuff move around. Now, with additional
> features activated, the issue seems to pop up again in a different way.
>=20
> So again my suggestion: forget about the NMI for a while, check if we
> can make progress with other debugging switches.
>=20
> Further question to tighten the test case: do the basic Xenomai
> testsuite programs run without noticeable problems on your box?
>=20
> Jan
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


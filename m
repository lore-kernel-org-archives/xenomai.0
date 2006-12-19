Message-ID: <4383100.1166529856857.JavaMail.ngmail@domain.hid>
Date: Tue, 19 Dec 2006 13:04:16 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Aw: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native leads...
In-Reply-To: <4587B287.2060603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
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

I tried to enable the kernel hacking parameters you proposed.
However, now I get a "NMI early shots: 0" message many times per second.
These seems to slow down everything dramatically, it is hard to work with t=
he
system. What are the early shots messages and how can I avoid them?

Regards

Mathias


> > It was the compiler!!! Using gcc-3.3 solved the issue.
> > That means, that somehow gcc-4.1.2 must not be used with Xenomai
> currently...
>=20
> OK, this needs some examination then. Can anyone reproduce this issue?
> /me is currently lacking the compiler.
>=20
> > =20
> > This allowed me to catch the system hang I was hunting for since
> yesterday...
> > And I got it.
> > I write the information I found on the console (I have not tried with
> console redirection yet...).
> > CPU 0, eip c010122d
> > EIP 0060:[<c010122d>]
> > EFLAGS 00000246
> > EIP is at mwait_idle_with_hints+0x2c/0x2e
> > eax:0 ebx:c0498000 ecx:0 edx:0
> >=20
> > Call Trace
> > mwait_idle+0x0/0x2e
> > mwait_idle+0x1d/0x2e
> > cpu_idle+0x44/0x86
> > start_kernel+0x1f1/0x1f5
> > unknown_bootoption+0x0/0x191
>=20
> Well, this caught your box in the idle loop - not that informative yet.
> We must probably look beyond the last context switch. Please switch on
> the I-pipe tracer (kernel hacking -> I-pipe debugging) and configure
> back_trace_points to, hmm, say 200. On NMI alarm, we should then see a
> function call trace.
>=20
> >=20
> > I'll try to reproduce the same with console redirection, however, I hop=
e
> this could help already!
> >=20
> > Regards
> >=20
> > Mathias
>=20
> Thanks for your effort,
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


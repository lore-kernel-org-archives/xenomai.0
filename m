Message-ID: <358035.1166518774710.JavaMail.ngmail@domain.hid>
Date: Tue, 19 Dec 2006 09:59:34 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Aw: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native leads to
In-Reply-To: <4587A2D4.3020102@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
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

Hi!

I have modified the configuration to disable profiling and to set the NMI t=
ime value to 100.
However, there is no difference.
Could this be a compiler issue?
I am using gcc 4.1.2 (debian etch prerelease)
I try to recompile the kernel using an older gcc-3.3 to see if this helps.

Regards

Mathias
> > here is my /proc/interrupts=20
> >=20
> >            CPU0
> >   0:     331260   IO-APIC-edge      timer
> >   1:          8   IO-APIC-edge      i8042
> >   7:          0   IO-APIC-edge      parport0
> >   9:          0   IO-APIC-fasteoi   acpi
> >  14:         12   IO-APIC-edge      ide0
> >  16:       1022   IO-APIC-fasteoi   eth0
> >  19:       2358   IO-APIC-fasteoi   libata
> > NMI:     331248
> > LOC:     331233
> > ERR:          0
> > MIS:          0
>=20
> Nothing unusual on first sight.
>=20
> >=20
> > I have enclosed a config.gz file of my 2.6.19.1 kernel.
>=20
> Two things to try:
>  - CONFIG_XENO_HW_NMI_DEBUG_LATENCY_MAX=3D100 (i.e. default again)
>  - CONFIG_PROFILING=3Dy (I'm not sure ATM if it may interfere with
>                        Xenomai's watchdog)
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


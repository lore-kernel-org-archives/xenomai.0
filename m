Message-ID: <10171906.1166169332781.JavaMail.ngmail@domain.hid>
Date: Fri, 15 Dec 2006 08:55:32 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Xenomai patched SMP kernel and "nosmp" kernel
In-Reply-To: <45800AA5.9000603@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <45800AA5.9000603@domain.hid>
	<12829436.1165928388617.JavaMail.ngmail@domain.hid>
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

I tried the kernel parameter maxcpus=3D0 on my SMP enabled, Xenomai-patched=
 kernel (same as in mails below).
The kernel does not boot.
It stops after a couple of messages:
IOAPIC[0]: Invalid reference to IRQ 0

Regards

Mathias
> M. Koehrer wrote:
> > Hi everybody,
> >=20
> > I have a SMP kernel 2.6.17.7 on a Dual Core Pentium 4 running.
> > SMP is enabled at the kernel configuration.
> > This works fine.
> > However, I want to compare UP with SMP operation, that's why
> > I want to boot the system with the "nosmp" kernel parameter.
> > However, booting of the PC with  nosmp does not work.
> > First it starts fine, however when trying to access hdb (which is the C=
D
> ROM
> > drive in my system) to get info about it, the message
> > "hdb: lost interrupt"
> > appears, and booting is stopped.=20
> >=20
> > Does the nosmp parameter work with a Xenomai patched kernel?
> > Or what could be wrong with it....
> >=20
> > I am using the latest Xenomai SVN #1948.
> > The kernel patch is adeos-ipipe-2.6.17-i386-1.5-02.patch
> >=20
> > Any ideas on this?
>=20
> Same for maxcpus=3D0? I'm asking as this configures the system more
> aggressively smp-less on x86 (patching spinlock alternatives for UP,
> configuring LAPIC mode etc.).


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


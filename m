Message-ID: <4970132.1166516081275.JavaMail.ngmail@domain.hid>
Date: Tue, 19 Dec 2006 09:14:41 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native leads to
In-Reply-To: <45879DE5.5080507@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18657_3852560.1166516081274"
References: <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
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

------=_Part_18657_3852560.1166516081274
Content-Type: multipart/alternative; 
	boundary="----=_Part_18656_24748294.1166516081274"

------=_Part_18656_24748294.1166516081274
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jan,

here is my /proc/interrupts=20

           CPU0
  0:     331260   IO-APIC-edge      timer
  1:          8   IO-APIC-edge      i8042
  7:          0   IO-APIC-edge      parport0
  9:          0   IO-APIC-fasteoi   acpi
 14:         12   IO-APIC-edge      ide0
 16:       1022   IO-APIC-fasteoi   eth0
 19:       2358   IO-APIC-fasteoi   libata
NMI:     331248
LOC:     331233
ERR:          0
MIS:          0

I have enclosed a config.gz file of my 2.6.19.1 kernel.

Mathias

> > Before digging deeper into the issue I have mailed yesterday (see below=
),
> I have to solve and
> > to understand the NMI watchdog feature.
> > I have enabled the NMI watchdog in the kernel configuration and set the
> time value to 100 now (100us).
> > Also, I passed the nmi_watchdog=3D1 kernel parameter to GRUB.
> > In dmesg's output I see the line:
> > Testing NMI watchdog ... OK.
> > =20
> > The Xenomai functionality is compiled as modules (as far as it is
> possible).
> >=20
> > Now, I do a=20
> > modprobe xeno_nucleus
> > This looks fine.
> >=20
> > Now, I do a=20
> > modprobe xeno_native
> > to load the native skin (I need it for my application to run).
> > Then the PC reboots directly.
> > This means I have no chance to  start my application as the PC reboots
> before
> > I can start it...
> >=20
> > I have the impression that some important thing is missing in my test.
> > The xeno timer is not started after modprobe xenu_nucleus
> > The contents of /proc/timer is:
> > status=3Doff:setup=3D120:tickval=3D0:jiffies=3D0
> >=20
> > Could this be a reason for the behaviour?
>=20
> That's normal, it is started on loading the first skin.
>=20
> > Can I start the timer before loading xeno_native to avoid the NMIs?
>=20
> Nope, the NMI must work as you tried to use it. I have basically the
> same setup here (all modular, NMI on by default), but even with latest
> kernel/ipipe everything is fine.
>=20
> Could you post your .config to compare details? Also the output of
> /proc/interrupts over .19 would be interesting.
>=20
> Jan
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
------=_Part_18656_24748294.1166516081274--

------=_Part_18657_3852560.1166516081274
Content-Type: application/octetstream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

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
------=_Part_18657_3852560.1166516081274--



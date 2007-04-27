Message-ID: <23595872.1177680700618.JavaMail.ngmail@domain.hid>
Date: Fri, 27 Apr 2007 15:31:40 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4631F925.2090100@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi all,

sure, I can provide support in testing (as this is reproducable at my PC).

Mathias

> Philippe Gerum wrote:
> > On Fri, 2007-04-27 at 13:48 +0200, Jan Kiszka wrote:
> >=20
> >>> I have attached my kernel config to this mail.
> >>> Any idea on this? Is there anybody out there that has MSI running
> succesfully with the Xenomai adeos patch?
> >> Hmm, from a glance at the 2.6.20 ipipe patch I would say that MSI is
> >> currently unsupported. No related patch hunk makes it look suspicious =
to
> >> me -- or is this supposed to work automagically, Philippe?
> >=20
> > Since genirq, MSI interrupts have their irq_chip descriptor managed by
> > the IO-APIC support. What remains to be tested is the masking/unmasking
> > code, which is still implemented by the msi driver; unfortunately I hav=
e
> > no PCI-Express hw at hand anymore, so I can't test CONFIG_PCI_MSI
> > properly.
> >=20
> > At first sight, the issue Mathias raised looks like an out-of-bound
> > array reference indexed on an unexpectedly large IRQ value; this would
> > be quite a dumb bug, but the only way to check that is with proper hw.
> >=20
>=20
> ... or instrumentation patches for Mathias' target, in case he has the
> time to do some short-cycle tests.
>=20
> Jan
>=20
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


50=80 AMAZON-Einkaufsgutschein bei Bestellung von Arcor-DSL:
Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


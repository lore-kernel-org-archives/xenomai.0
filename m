Message-ID: <20127779.1178282801939.JavaMail.ngmail@domain.hid>
Date: Fri, 4 May 2007 14:46:41 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1178281223.29093.83.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1178281223.29093.83.camel@domain.hid> <463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
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
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

Hi Philippe,

I patched the create_irq() function to start the search for unused interrup=
ts not at
NR_IRQS -1 but from 127.
And this seems actually to work.
It looks like the right track!
That means, that actually the large IRQ numbers are conflicting with the sy=
stem
interrupts.
However, I wonder why this works with a non-adeos-patched kernel...

Regards

Mathias


>=20
> No, the trampoline code in entry.S passes us an irq actually. But there
> is indeed a vector:irq mapping issue with IRQ numbers greater than 206,
> which still badly conflict with system IRQs (MSI causes high numbered
> IRQs to be allocated). I'm working on a patch. More later.
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


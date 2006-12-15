Message-ID: <32779704.1166179579925.JavaMail.ngmail@domain.hid>
Date: Fri, 15 Dec 2006 11:46:19 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Xenomai patched SMP kernel and "nosmp" kernel
In-Reply-To: <45826122.9050209@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <45826122.9050209@domain.hid> <45800AA5.9000603@domain.hid>
	<12829436.1165928388617.JavaMail.ngmail@domain.hid>
	<10171906.1166169332781.JavaMail.ngmail@domain.hid>
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

I have used an standard vanilla kernel without any patches and this deliver=
ed the same results.=20
It seems to be an issue that is not related to Xenomai or Adeos.
When I pass the kernel parameter hdb=3Dnoprobe
the kernel boots fine (however, I can not access the CD-ROM drive anymore..=
.).
I think the reason for that could be, that my hard disk is a SATA drive and=
 the only IDE
device is the CD ROM on hdb, I do not have a hda device.
There are many entries on that somewhere in the internet...
I'll try the same on a 2.6.19.1 kernel to see if this solves the issue.

Thanks for the hints!

Regards

Mathias


> M. Koehrer wrote:
> > Hi Jan,
> >=20
> > I tried the kernel parameter maxcpus=3D0 on my SMP enabled, Xenomai-pat=
ched
> kernel (same as in mails below).
> > The kernel does not boot.
> > It stops after a couple of messages:
> > IOAPIC[0]: Invalid reference to IRQ 0
>=20
> OK, a few things more to verify:
>=20
>  - kernel boots fine with your scenario except CONFIG_IPIPE disabled?
>  - problem persists with 2.6.19-ipipe-1.6-02?
>=20
> And could you post your .config and the boot log?
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


Message-ID: <28758238.1192087500738.JavaMail.ngmail@domain.hid>
Date: Thu, 11 Oct 2007 09:25:00 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <470CADD7.8090207@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <470CADD7.8090207@domain.hid> 447E9383.8090403@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] compactPCI LAN Chip Support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid, rwatollenaar@domain.hid, jan.kiszka@domain.hid, xenomai@xenomai.org

Hi Roland,=20
> I have a machine with the following chip:
>=20
> Intel 82541PI
>=20
> and have found the below reply of yours to an email of someone else
> asking the exact same question. However this was quite long ago and the
> e1000 seems to have evolved. So my question is: is above chip supported?
>=20
> Is there a list on the web that can help me convert device IDs to chip
> types?
>=20
There is a file pci.ids (on Debian based system in /usr/share/misc) that co=
ntains
a list with PCI IDs and corresponding textual representation.
Or try the "online" version of this on=20
http://pciids.sourceforge.net/
For the Intel 82541PI the PCI Vendor:Device ID pair is 8086:107c which is s=
upported by rtnet.

Regards

Mathias

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT F=DCR ALLE NEUEINSTEIGER
Jetzt bei Arcor: g=FCnstig und schnell mit DSL - das All-Inclusive-Paket
f=FCr clevere Doppel-Sparer, nur  34,95 =80  inkl. DSL- und ISDN-Grundgeb=
=FChr!
http://www.arcor.de/rd/emf-dsl-2


Message-ID: <15573283.1178627888504.JavaMail.ngmail@domain.hid>
Date: Tue, 8 May 2007 14:38:08 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1178627340.5045.3.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1178627340.5045.3.camel@domain.hid> <1178385693.2406.7.camel@domain.hid>
	<463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
	<1178281223.29093.83.camel@domain.hid>
	<23990358.1178625225906.JavaMail.ngmail@domain.hid>
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

perhaps one more information regarding that issue:=20
When I disable SMP, it seems to work fine (APIC and local APIC are enabled)=
.

Regards

Mathias

> > as mentioned in my previous mail, the new patch works fine. However, I =
get
> the error
> > APIC error on CPU0: 00(20)
> > APIC error on CPU1: 00(40)
> > when unloading (rmmod) xeno_native.
> > I have looked closed to that issue and I have found out that this happe=
ns
> > within the inline function xnarch_notify_halt() (file pod.h)
> >=20
> >     for(cpu=3D0; cpu < nr_cpus-1; ++cpu)
> >         down(&xnarch_finalize_sync);
> >=20
>=20
> It's likely happening a few lines earlier, when sending IPI2 to
> synchronize all CPUs during Xenomai shutdown. Ok, I will have a look
> asap.
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


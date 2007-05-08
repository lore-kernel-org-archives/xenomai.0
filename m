Message-ID: <13153223.1178634900258.JavaMail.ngmail@domain.hid>
Date: Tue, 8 May 2007 16:35:00 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1178631460.5045.6.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1178631460.5045.6.camel@domain.hid> <1178627340.5045.3.camel@domain.hid>
	<1178385693.2406.7.camel@domain.hid> <463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
	<13626574.1178266851510.JavaMail.ngmail@domain.hid>
	<1178281223.29093.83.camel@domain.hid>
	<23990358.1178625225906.JavaMail.ngmail@domain.hid>
	<15573283.1178627888504.JavaMail.ngmail@domain.hid>
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

that's it! Now, everything seems to run really nicely!
The great thing is, that is I have now one of my e1000 (PCIe) running=20
in non real time mode and the other running with rtnet in real time!
They have IRQs 223 resp. 222.
As interrupt sharing was one of the main issues I had, this seems
to be solved now!
In which Xenomai version will the new adeos patch and the fix from today en=
d up?
Or should I use the 2.3.1 and using the new adeos patch + the fix?

Thank you very much for the excellent support!

Regards

Mathias
> On Tue, 2007-05-08 at 14:38 +0200, M. Koehrer wrote:
> > Hi Philippe,
> >=20
> > perhaps one more information regarding that issue:=20
> > When I disable SMP, it seems to work fine (APIC and local APIC are
> enabled).
>=20
> This should improve things:
>=20
> --- a/arch/i386/kernel/ipipe.c
> +++ b/arch/i386/kernel/ipipe.c
> @@ -373,7 +373,7 @@ int fastcall __ipipe_send_ipi (unsigned ipi, cpumask_=
t
> cpumask)
>         cpu_clear(cpuid,cpumask);
>=20
>         if (!cpus_empty(cpumask))
> -               send_IPI_mask(cpumask,ipi + FIRST_EXTERNAL_VECTOR);
> +               send_IPI_mask(cpumask,ipipe_apic_irq_vector(ipi));
>=20
>         if (self)
>                 ipipe_trigger_irq(ipi);
>=20
> --=20
> Philippe.
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
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


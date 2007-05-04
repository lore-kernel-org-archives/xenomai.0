Message-ID: <13626574.1178266851510.JavaMail.ngmail@domain.hid>
Date: Fri, 4 May 2007 10:20:51 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <463AE7D3.6030401@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <463AE7D3.6030401@domain.hid>
	<24394502.1178264721982.JavaMail.ngmail@domain.hid>
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
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

o.k., now I understand Philippes patch.
However, at one point, I am not quite sure if this is correct:
Within __ipipe_handle_irq()
the patch adds
#ifdef CONFIG_X86_LOCAL_APIC
               {
                       unsigned vector =3D irq + FIRST_EXTERNAL_VECTOR;
                       if (vector >=3D FIRST_SYSTEM_VECTOR)
                               irq =3D ipipe_apic_vector_irq(vector);
               }
#endif
I do not understand the if (vector >=3D ..) statement.
When I am at this point, the irq value is always the vector and never an ir=
q.
Thus, I think I should call ipipe_apic_vector_irq in any case.
I will do a test on that.

Regards

Mathias



----- Original Nachricht ----
Von:     Jan Kiszka <jan.kiszka@domain.hid>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   04.05.2007 09:59
Betreff: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel

> M. Koehrer wrote:
> > Hi everybody,
> >=20
> > I have been gone one step back to analyze the issue from the situation =
is
> originally occurred.
> > This was the situation that I had a 2.6.20.4 kernel and Xenomai 2.3.1
> (included Adeos patch).
> > When I  enable MSI in the kernel configuration I get the kernel message=
:
> > "spurious APIC interrupt on CPU#0, should never happen."
> > when trying to enable (ifconfig) the e1000 driver for an onboard PCIe
> network adapter.
> >=20
> > I have now used the very same kernel without Xenomai patch, but using t=
he
> same kernel config
> > (MSI enabled). This returns the IRQ 223 for the Ethernet adapter.
> > With 2.6.21 it returns IRQ 219, there seems to be a difference between
> 2.6.20 and 2.6.21.
> > Well, as I am working with 2.6.20.4, I looked deeper in that.
> >=20
> > One interesting thing I found was in arch/i386/kernel/ipipe.c at functi=
on
> __ipipe_enable_pipeline
> > I do not understand the meaning of that code.
> > At the beginning of that function, there are a couple of calls to
> ipipe_virtualize_irq().
> > These MAP the APIC system vectors.
> > However, the second call that maps=20
> > SPURIOUS_APIC_VECTOR - FIRST_EXTERNAL_VECTOR (with is infact 223) is
> mapped to
> > smp_spurious_interrupt (which leads to the result I see).
> > However, I am not sure if it is correct to use the VECTOR values here a=
s
> ipipe_virtualize_irq
> > uses "irq" as second parameter and not  a vector. This looks like a vec=
tor
> vs. irq mismatch.
>=20
> Isn't this the issue Philippe's last patch against ipipe and xenomai fixe=
s?
>=20
> >=20
> > Within the create_irq() function, the e1000 creates irq 223 on vector
> 201.
> >=20
> > When I monitor the calls to set_intr_gate() I see that the vector 32 wi=
ll
> end up at the address
> > of irq_entries_start, vector 32 will end up at irq_entries_start + 8 et=
c.
> > In entry.S this will end up in writing ~(vector) unto the stack and
> calling common_interrupt.
> > This finally calls __ipipe_handle_irq.
> > The means that __ipipe_handle_irq will not be called with the IRQ numbe=
r
> but with the vector!!
> > It could be that this is the same for the "old" IRQ vectors (<32).=20
> > However for the MSI IRQs this seems to be not correct.
> > I think that this could be the root cause for the problems I see.
>=20
> Again, please verify that you are not debugging the issue that Philippe
> may have already fixed, ie. re-evaluate your (very systematic!) findings
> after applying the ipipe fix.
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
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2


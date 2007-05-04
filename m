Message-ID: <24394502.1178264721982.JavaMail.ngmail@domain.hid>
Date: Fri, 4 May 2007 09:45:21 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi everybody,

I have been gone one step back to analyze the issue from the situation is o=
riginally occurred.
This was the situation that I had a 2.6.20.4 kernel and Xenomai 2.3.1 (incl=
uded Adeos patch).
When I  enable MSI in the kernel configuration I get the kernel message:
"spurious APIC interrupt on CPU#0, should never happen."
when trying to enable (ifconfig) the e1000 driver for an onboard PCIe netwo=
rk adapter.

I have now used the very same kernel without Xenomai patch, but using the s=
ame kernel config
(MSI enabled). This returns the IRQ 223 for the Ethernet adapter.
With 2.6.21 it returns IRQ 219, there seems to be a difference between 2.6.=
20 and 2.6.21.
Well, as I am working with 2.6.20.4, I looked deeper in that.

One interesting thing I found was in arch/i386/kernel/ipipe.c at function _=
_ipipe_enable_pipeline
I do not understand the meaning of that code.
At the beginning of that function, there are a couple of calls to ipipe_vir=
tualize_irq().
These MAP the APIC system vectors.
However, the second call that maps=20
SPURIOUS_APIC_VECTOR - FIRST_EXTERNAL_VECTOR (with is infact 223) is mapped=
 to
smp_spurious_interrupt (which leads to the result I see).
However, I am not sure if it is correct to use the VECTOR values here as ip=
ipe_virtualize_irq
uses "irq" as second parameter and not  a vector. This looks like a vector =
vs. irq mismatch.

Within the create_irq() function, the e1000 creates irq 223 on vector 201.

When I monitor the calls to set_intr_gate() I see that the vector 32 will e=
nd up at the address
of irq_entries_start, vector 32 will end up at irq_entries_start + 8 etc.
In entry.S this will end up in writing ~(vector) unto the stack and calling=
 common_interrupt.
This finally calls __ipipe_handle_irq.
The means that __ipipe_handle_irq will not be called with the IRQ number bu=
t with the vector!!
It could be that this is the same for the "old" IRQ vectors (<32).=20
However for the MSI IRQs this seems to be not correct.
I think that this could be the root cause for the problems I see.

Any feedback on this comment is highly welcome!

Regards

Mathias



> On Thu, 2007-05-03 at 09:06 +0200, M. Koehrer wrote:
> > Hi Philippe,
> >=20
> > I have restored the original kernel configuration and I got the crash
> again.
> > As it happens during the boot, it is reproducible.
> > Enclosed is the console log (including the oops), the relevant disassem=
ble
> part,
> > the output of "nm vmlinux" and my kernel config.
> > If you like I can mail you privately the vmlinux aswell.
> > What I see from the disassembler listing
> > c010f10b:       e8 5e ae 02 00          call   c0139f6e
> <__ipipe_walk_pipeline>
> > c010f110:       ff 15 68 70 3d c0       call   *0xc03d7068
> > is that ipipe_walk_pipeline is called followed by a indirect call to
> 0xc03d7068.
> > I looked at `nm vmlinux` and found out that 0xc03d7068 is
> __ipipe_logical_cpuid.
> >=20
> > I hope that helps to get closer to this bug...
> >=20
>=20
> Should be ok, thanks. I will have a close look at this.
>=20
> --=20
> Philippe.
>=20
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


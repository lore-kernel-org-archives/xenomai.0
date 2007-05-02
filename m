Message-ID: <33481027.1178097243064.JavaMail.ngmail@domain.hid>
Date: Wed, 2 May 2007 11:14:03 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <46384E4B.2050200@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <46384E4B.2050200@domain.hid> <1177947596.32698.47.camel@domain.hid>
	<1177686318.5010.106.camel@domain.hid>	
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>	
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>	
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>	
	<784082.1177682909759.JavaMail.ngmail@domain.hid>	
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>	
	<1177685762.5010.104.camel@domain.hid>	
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>	
	<1177706363.5010.158.camel@domain.hid>
	<33288775.1178089500362.JavaMail.ngmail@domain.hid>
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

here is the result of this patch.
I patched in addition to Philippe's patches.

Regards

Mathias
---------
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:5=
a:f9:0a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
dfedd3ca
*pde =3D 00000000
Oops: 0000 [#1]
SMP
Modules linked in: e1000
CPU:    0
EIP:    0060:[<dfedd3ca>]    Not tainted VLI
EFLAGS: 00010082   (2.6.20.4 #7)
EIP is at 0xdfedd3ca
eax: c0112478   ebx: 00000001   ecx: c0114581   edx: df06c001
esi: dfedf6c0   edi: dfedc240   ebp: 00000000   esp: df06ddf8
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 1242, ti=3Ddf06c000 task=3Dc16f9030 task.ti=3Ddf06c0=
00)
Stack: 00000040 ffffffff 00000000 00000007 c03e6f00 000000ec 00000000 c03d9=
180
       c010f1b5 c015291a decbe080 00000680 decbe080 00000724 c02d6dfd 00007=
600
       00000001 00000060 e099a210 00000286 ffffff24 df7065c8 00000000 00000=
00f
Call Trace:
 [<c010f1b5>] __ipipe_handle_irq+0x26b/0x2bd
 [<c015291a>] __kmalloc+0x82/0x8d
 [<c02d6dfd>] __alloc_skb+0x4f/0xf8
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c01035b9>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c02dd211>] __dev_mc_upload+0x1d/0x1e
 [<c02dd331>] dev_mc_upload+0x24/0x37
 [<c02db83c>] dev_open+0x44/0x62
 [<c02da309>] dev_change_flags+0x47/0xe4
 [<c030d422>] devinet_ioctl+0x252/0x56f
 [<c02db41a>] dev_ifsioc+0x113/0x38d
 [<c02d1834>] sock_ioctl+0x0/0x1ad
 [<c02d19c2>] sock_ioctl+0x18e/0x1ad
 [<c02d1834>] sock_ioctl+0x0/0x1ad
 [<c015e41b>] do_ioctl+0x1f/0x62
 [<c015e6a2>] vfs_ioctl+0x244/0x256
 [<c015e6e7>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 00 00 00 00 00 01 00 00 00 00 90 ed df 04 03 02 01 6b ec fe ff 00 00 =
00 00 00 00 00 00 00 00 00 00 c0 d3 ed df c0 d3 ed df 00 42 <c9> de 00 db e=
d df d0 d3 ed df d0 d3 ed df 00 00 00 00 1a 00 00
EIP: [<dfedd3ca>] 0xdfedd3ca SS:ESP 0068:df06ddf8
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
 [<c010ba83>] smp_call_function+0x66/0x10a
 [<c0119046>] printk+0x62/0xd5
 [<c010bb42>] smp_send_stop+0x1b/0x2b
 [<c01185e1>] panic+0x4d/0xe4
 [<c01040f1>] die+0x1f2/0x226
 [<c01118b0>] do_page_fault+0x447/0x517
 [<c010f84f>] __ipipe_handle_exception+0xce/0x158
 [<c03335fd>] error_code+0x81/0x90
 [<c0114581>] try_to_wake_up+0x33c/0x346
 [<c0112478>] __activate_task+0x1c/0x29
 [<c010f1b5>] __ipipe_handle_irq+0x26b/0x2bd
 [<c015291a>] __kmalloc+0x82/0x8d
 [<c02d6dfd>] __alloc_skb+0x4f/0xf8
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c01035b9>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c02dd211>] __dev_mc_upload+0x1d/0x1e
 [<c02dd331>] dev_mc_upload+0x24/0x37
 [<c02db83c>] dev_open+0x44/0x62
 [<c02da309>] dev_change_flags+0x47/0xe4
 [<c030d422>] devinet_ioctl+0x252/0x56f
 [<c02db41a>] dev_ifsioc+0x113/0x38d
 [<c02d1834>] sock_ioctl+0x0/0x1ad
 [<c02d19c2>] sock_ioctl+0x18e/0x1ad
 [<c02d1834>] sock_ioctl+0x0/0x1ad
 [<c015e41b>] do_ioctl+0x1f/0x62
 [<c015e6a2>] vfs_ioctl+0x244/0x256
 [<c015e6e7>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20

----- Original Nachricht ----
Von:     Jan Kiszka <jan.kiszka@domain.hid>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   02.05.2007 10:39
Betreff: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel

> M. Koehrer wrote:
> > Hi Philippe,
> >=20
> > I have applied the patches as proposed.
> > However, the kernel still freezes.
>=20
> :(
>=20
> > Here is the corresponding message.
> >=20
>=20
> OK, here is another instrumentation, hoping that the bug will not move
> again and that we can nail down what piece of memory contains nonsense.
>=20
> The next step would then be to narrow down the corruption window (or to
> find the reason for filling in nonsense during initialisation).
>=20
> Jan
>=20
>=20
> Index: linux-2.6.20/arch/i386/kernel/ipipe.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.20.orig/arch/i386/kernel/ipipe.c
> +++ linux-2.6.20/arch/i386/kernel/ipipe.c
> @@ -782,6 +782,13 @@ int __ipipe_handle_irq(struct pt_regs re
> =20
>  =09head =3D __ipipe_pipeline.next;
>  =09next_domain =3D list_entry(head, struct ipipe_domain, p_link);
> +=09if (irq=3D=3D219) {
> +=09=09ipipe_set_printk_sync(next_domain);
> +=09=09printk("%s:%d\n", __FUNCTION__, __LINE__);
> +=09=09printk("%s:%d %lx %p %p\n", __FUNCTION__, __LINE__,
> +=09=09=09ipipe_root.irqs[irq].control, ipipe_root.irqs[irq].acknowledge,
> +=09=09=09ipipe_root.irqs[irq].handler);
> +=09}
>  =09if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control=
)))
> {
>  =09=09if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
>  =09=09=09next_domain->irqs[irq].acknowledge(irq);
> @@ -865,6 +872,10 @@ finalize:
>  =09 * current domain in the pipeline.
>  =09 */
> =20
> +=09if (irq=3D=3D219)
> +=09=09printk("%s:%d %lx %p %p\n", __FUNCTION__, __LINE__,
> +=09=09=09ipipe_root.irqs[irq].control, ipipe_root.irqs[irq].acknowledge,
> +=09=09=09ipipe_root.irqs[irq].handler);
>  =09__ipipe_walk_pipeline(head, cpuid);
> =20
>  =09ipipe_load_cpuid();
> Index: linux-2.6.20/kernel/ipipe/core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.20.orig/kernel/ipipe/core.c
> +++ linux-2.6.20/kernel/ipipe/core.c
> @@ -791,6 +791,11 @@ void fastcall __ipipe_sync_stage(unsigne
>  =09=09=09rank =3D __ipipe_ffnz(submask);
>  =09=09=09irq =3D (level << IPIPE_IRQ_ISHIFT) + rank;
> =20
> +=09=09=09if (irq=3D=3D219)
> +=09=09=09=09printk("%s:%d %lx %p %p\n", __FUNCTION__, __LINE__,
> +=09=09=09=09=09ipipe_root.irqs[irq].control,
> +=09=09=09=09=09ipipe_root.irqs[irq].acknowledge,
> +=09=09=09=09=09ipipe_root.irqs[irq].handler);
>  =09=09=09if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
>  =09=09=09=09__clear_bit(rank, &cpudata->irq_pending_lo[level]);
>  =09=09=09=09continue;
> @@ -807,6 +812,8 @@ void fastcall __ipipe_sync_stage(unsigne
>  =09=09=09if (ipd =3D=3D ipipe_root_domain)
>  =09=09=09=09trace_hardirqs_off();
> =20
> +=09=09=09if (irq=3D=3D219)
> +=09=09=09=09printk("%s:%d\n", __FUNCTION__, __LINE__);
>  =09=09=09__ipipe_run_isr(ipd, irq, cpuid);
>  #ifdef CONFIG_SMP
>  =09=09=09{
>=20
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


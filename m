Message-ID: <26575694.1178110645829.JavaMail.ngmail@domain.hid>
Date: Wed, 2 May 2007 14:57:25 +0200 (CEST)
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
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

I have looked closed into that issue.
For that I have added a global array that is written within =20
__ipipe_handle_irq() (file arch/i386/kernel/ipipe.c):

                extern int xxx_int[];
                irq =3D ~irq;

                xxx_int[0] =3D irq;

#ifdef CONFIG_X86_LOCAL_APIC
                {
                        unsigned vector =3D irq + FIRST_EXTERNAL_VECTOR;
                        if (vector >=3D FIRST_SYSTEM_VECTOR)
                                irq =3D ipipe_apic_vector_irq(vector);
                }

                 xxx_int[1] =3D irq;


This global variable is printed out within the kernel trap.
It returns the values 0xcf and 0xe0 (207 and 224) for xxx_int[0], xxx_int[1=
].
And this is the really strange thing as the IRQ for the e1000 should be 219=
 (on a non-adeos-patched kernel).
I do not know what happens here, but it looks really strange...


Regards

Mathias
---------------------------------------
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:5=
a:f9:0a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000000
 printing eip:
00000000
*pde =3D 00000000
Oops: 0000 [#1]
SMP
Modules linked in: e1000
xxx_int: cf e0 0 0
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010086   (2.6.20.4-msi2 #11)
EIP is at _stext+0x3feffc70/0x14
eax: c0112410   ebx: 00000007   ecx: c0114519   edx: df048000
esi: 00000006   edi: 00000046   ebp: ffffffff   esp: df049e20
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 1241, ti=3Ddf048000 task=3Dc173e030 task.ti=3Ddf0480=
00)
Stack: c03e6f00 000000ec 00000000 c03d9180 c010f14d 00007600 00000001 00000=
060
       e099a1ed 00000286 ffffff24 df75b5c8 00000000 0000000f 00000001 c0103=
5b9
       df75b5c8 e099a0ff e09c0000 00000000 0000000f 00000001 80080740 dfc70=
07b
Call Trace:
 [<c010f14d>] __ipipe_handle_irq+0x1d3/0x225
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c01035b9>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c02dd151>] __dev_mc_upload+0x1d/0x1e
 [<c02dd271>] dev_mc_upload+0x24/0x37
 [<c02db77c>] dev_open+0x44/0x62
 [<c02da249>] dev_change_flags+0x47/0xe4
 [<c030d362>] devinet_ioctl+0x252/0x56f
 [<c02db35a>] dev_ifsioc+0x113/0x38d
 [<c02d1774>] sock_ioctl+0x0/0x1ad
 [<c02d1902>] sock_ioctl+0x18e/0x1ad
 [<c02d1774>] sock_ioctl+0x0/0x1ad
 [<c015e35b>] do_ioctl+0x1f/0x62
 [<c015e5e2>] vfs_ioctl+0x244/0x256
 [<c015e627>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code:  Bad EIP value.
EIP: [<00000000>] _stext+0x3feffc70/0x14 SS:ESP 0068:df049e20
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
 [<c010bab3>] smp_call_function+0x66/0x10a
 [<c0118fde>] printk+0x62/0xd5
 [<c010bb72>] smp_send_stop+0x1b/0x2b
 [<c0118579>] panic+0x4d/0xe4
 [<c0104121>] die+0x1f2/0x226
 [<c0111848>] do_page_fault+0x447/0x517
 [<c010f7e7>] __ipipe_handle_exception+0xce/0x158
 [<c010bcce>] smp_call_function_interrupt+0x31/0x4c
 [<c033353d>] error_code+0x81/0x90
 [<c0114519>] try_to_wake_up+0x33c/0x346
 [<c0112410>] __activate_task+0x1c/0x29
 [<c010f14d>] __ipipe_handle_irq+0x1d3/0x225
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c01035b9>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c02dd151>] __dev_mc_upload+0x1d/0x1e
 [<c02dd271>] dev_mc_upload+0x24/0x37
 [<c02db77c>] dev_open+0x44/0x62
 [<c02da249>] dev_change_flags+0x47/0xe4
 [<c030d362>] devinet_ioctl+0x252/0x56f
 [<c02db35a>] dev_ifsioc+0x113/0x38d
 [<c02d1774>] sock_ioctl+0x0/0x1ad
 [<c02d1902>] sock_ioctl+0x18e/0x1ad
 [<c02d1774>] sock_ioctl+0x0/0x1ad
 [<c015e35b>] do_ioctl+0x1f/0x62
 [<c015e5e2>] vfs_ioctl+0x244/0x256
 [<c015e627>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D






----- Original Nachricht ----
Von:     Jan Kiszka <jan.kiszka@domain.hid>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   02.05.2007 11:39
Betreff: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel

> M. Koehrer wrote:
> > Hi Jan,
> >=20
> > here is the result of this patch.
> > I patched in addition to Philippe's patches.
> >=20
> > Regards
> >=20
> > Mathias
> > ---------
> > Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
> > Copyright (c) 1999-2006 Intel Corporation.
> > ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> > e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
> 00:30:48:5a:f9:0a
> > e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> > BUG: unable to handle kernel NULL pointer dereference at virtual addres=
s
> 00000000
> >  printing eip:
> > dfedd3ca
> > *pde =3D 00000000
> > Oops: 0000 [#1]
> > SMP
> > Modules linked in: e1000
> > CPU:    0
> > EIP:    0060:[<dfedd3ca>]    Not tainted VLI
> > EFLAGS: 00010082   (2.6.20.4 #7)
> > EIP is at 0xdfedd3ca
> > eax: c0112478   ebx: 00000001   ecx: c0114581   edx: df06c001
> > esi: dfedf6c0   edi: dfedc240   ebp: 00000000   esp: df06ddf8
> > ds: 007b   es: 007b   ss: 0068
> > Process ifconfig (pid: 1242, ti=3Ddf06c000 task=3Dc16f9030 task.ti=3Ddf=
06c000)
> > Stack: 00000040 ffffffff 00000000 00000007 c03e6f00 000000ec 00000000
> c03d9180
> >        c010f1b5 c015291a decbe080 00000680 decbe080 00000724 c02d6dfd
> 00007600
> >        00000001 00000060 e099a210 00000286 ffffff24 df7065c8 00000000
> 0000000f
> > Call Trace:
> >  [<c010f1b5>] __ipipe_handle_irq+0x26b/0x2bd
>=20
> I must have patched crap into this, but I don't see it. Could someone
> have a look why there is no printk output related to #IRQ 219
> (~0xffffff24, see stack content)?
>=20
> BTW, Mathias, forcing your kernel into single CPU mode via kernel
> command line "cpus=3D1" doesn't expose the issue, right? Could we face
> some kind of setup race across the CPUs here?
>=20
> Thanks,
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


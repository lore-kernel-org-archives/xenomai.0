Message-ID: <33288775.1178089500362.JavaMail.ngmail@domain.hid>
Date: Wed, 2 May 2007 09:05:00 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1177947596.32698.47.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1177947596.32698.47.camel@domain.hid>
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

I have applied the patches as proposed.
However, the kernel still freezes.
Here is the corresponding message.

Regards

Mathias
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
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
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010086   (2.6.20.4 #6)
EIP is at _stext+0x3feffc70/0x14
eax: c01123d4   ebx: 00000007   ecx: c01144dd   edx: dfbd2000
esi: 00000006   edi: 00000046   ebp: ffffffff   esp: dfbd3e20
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 1241, ti=3Ddfbd2000 task=3Dc1632030 task.ti=3Ddfbd20=
00)
Stack: c03e6f00 000000ec 00000000 c03d9180 c010f110 00007600 00000001 00000=
060
       e099a1ed 00000286 ffffff24 df7575c8 00000000 0000000f 00000001 c0103=
5b9
       df7575c8 e099a0ff e09c0000 00000000 0000000f 00000001 80080740 dfd10=
07b
Call Trace:
 [<c010f110>] __ipipe_handle_irq+0x1c6/0x218
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c01035b9>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c02dd111>] __dev_mc_upload+0x1d/0x1e
 [<c02dd231>] dev_mc_upload+0x24/0x37
 [<c02db73c>] dev_open+0x44/0x62
 [<c02da209>] dev_change_flags+0x47/0xe4
 [<c030d322>] devinet_ioctl+0x252/0x56f
 [<c02db31a>] dev_ifsioc+0x113/0x38d
 [<c02d1734>] sock_ioctl+0x0/0x1ad
 [<c02d18c2>] sock_ioctl+0x18e/0x1ad
 [<c02d1734>] sock_ioctl+0x0/0x1ad
 [<c015e31f>] do_ioctl+0x1f/0x62
 [<c015e5a6>] vfs_ioctl+0x244/0x256
 [<c015e5eb>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code:  Bad EIP value.
EIP: [<00000000>] _stext+0x3feffc70/0x14 SS:ESP 0068:dfbd3e20
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
 [<c010ba83>] smp_call_function+0x66/0x10a
 [<c0118fa2>] printk+0x62/0xd5
 [<c010bb42>] smp_send_stop+0x1b/0x2b
 [<c011853d>] panic+0x4d/0xe4
 [<c01040f1>] die+0x1f2/0x226
 [<c011180c>] do_page_fault+0x447/0x517
 [<c010f7aa>] __ipipe_handle_exception+0xce/0x158
 [<c010bc9e>] smp_call_function_interrupt+0x31/0x4c
 [<c03334fd>] error_code+0x81/0x90
 [<c01144dd>] try_to_wake_up+0x33c/0x346
 [<c01123d4>] __activate_task+0x1c/0x29
 [<c010f110>] __ipipe_handle_irq+0x1c6/0x218
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c01035b9>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c02dd111>] __dev_mc_upload+0x1d/0x1e
 [<c02dd231>] dev_mc_upload+0x24/0x37
 [<c02db73c>] dev_open+0x44/0x62
 [<c02da209>] dev_change_flags+0x47/0xe4
 [<c030d322>] devinet_ioctl+0x252/0x56f
 [<c02db31a>] dev_ifsioc+0x113/0x38d
 [<c02d1734>] sock_ioctl+0x0/0x1ad
 [<c02d18c2>] sock_ioctl+0x18e/0x1ad
 [<c02d1734>] sock_ioctl+0x0/0x1ad
 [<c015e31f>] do_ioctl+0x1f/0x62
 [<c015e5a6>] vfs_ioctl+0x244/0x256
 [<c015e5eb>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


> On Fri, 2007-04-27 at 22:39 +0200, Philippe Gerum wrote:
> > On Fri, 2007-04-27 at 17:10 +0200, M. Koehrer wrote:
> > > Hi Philippe,
> > >=20
> > > here is the next result (I have switched off the "quiet" kernel
> parameter to get everything).
> > >=20
> >=20
> > There is a SMP-related bugfix regarding our IPI namespace I need to
> > backport from x86_64 to x86. Not sure this is what bites us here yet,
> > but there is no use to chase the wild goose. In any case, CONFIG_PCI_MS=
I
> > clearly worsens the situation regarding this issue.
>=20
> Here we are, please apply the first patch against a stock I-pipe 1.7-03
> kernel, then the second one against a vanilla Xenomai v2.3.x tree.
>=20
> What the first patch does is moving the system IRQs out of the regular
> interrupt namespace wrt Adeos handling, which could solve possible
> conflicts whenever CONFIG_PCI_MSI is on. The second patch makes the
> Xenomai tree aware of the differentiated namespaces.
>=20
> --=20
> Philippe.
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


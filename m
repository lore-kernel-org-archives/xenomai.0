Message-ID: <29785175.1177685539434.JavaMail.ngmail@domain.hid>
Date: Fri, 27 Apr 2007 16:52:19 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4632092F.3020607@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4632092F.3020607@domain.hid> <4631FF09.2000601@domain.hid>
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
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

here is the next result:

Regards

Mathias
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Performing network-prepareConfiguring network interfaces...BUG: unable to h=
andle kernel paging request at virtual address 5112039a
 printing eip:
*pde =3D 00000000
Oops: 0002 [#1]
SMP=20
Modules linked in: e1000
CPU:    0
EIP:    0060:[<c03e5680>]    Not tainted VLI
EFLAGS: 00010092   (2.6.20.4 #17)
EIP is at 0xc03e5680
eax: c0112254   ebx: 00000006   ecx: c011435d   edx: dfa42000
esi: 00000046   edi: ffffffff   ebp: 00000000   esp: dfa43e24
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 1241, ti=3Ddfa42000 task=3Ddfc80030 task.ti=3Ddfa420=
00)
Stack: 000000db 00000000 c03d9100 c010ef91 00006d80 00000001 00000060 e099a=
1ed=20
       00000286 ffffff24 df6fe5c8 00000000 0000000f 00000002 c0103439 df6fe=
5c8=20
       e099a0ff e09c0000 00000000 0000000f 00000002 80080740 dfdd007b df6f0=
07b=20
Call Trace:
 [<c010ef91>] __ipipe_handle_irq+0x1b9/0x20b
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c0103439>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c02dcf91>] __dev_mc_upload+0x1d/0x1e
 [<c02dd0b1>] dev_mc_upload+0x24/0x37
 [<c02db5bc>] dev_open+0x44/0x62
 [<c02da089>] dev_change_flags+0x47/0xe4
 [<c030d1a2>] devinet_ioctl+0x252/0x56f
 [<c02db19a>] dev_ifsioc+0x113/0x38d
 [<c02d15b4>] sock_ioctl+0x0/0x1ad
 [<c02d1742>] sock_ioctl+0x18e/0x1ad
 [<c02d15b4>] sock_ioctl+0x0/0x1ad
 [<c015e1a7>] do_ioctl+0x1f/0x62
 [<c015e42e>] vfs_ioctl+0x244/0x256
 [<c015e473>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 91 3d c0 0=
0 91 3d c0 00 00 00 00 00 00 00 00 00 00 00 00 00=20
EIP: [<c03e5680>] 0xc03e5680 SS:ESP 0068:dfa43e24
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
 [<c010b903>] smp_call_function+0x66/0x10a
 [<c0118e22>] printk+0x62/0xd5
 [<c010b9c2>] smp_send_stop+0x1b/0x2b
 [<c01183bd>] panic+0x4d/0xe4
 [<c0103f71>] die+0x1f2/0x226
 [<c011168c>] do_page_fault+0x447/0x517
 [<c013fb96>] __alloc_pages+0x52/0x286
 [<c010f62b>] __ipipe_handle_exception+0xce/0x158
 [<c01521cb>] kmem_cache_alloc+0x5d/0x67
 [<c010bb1e>] smp_call_function_interrupt+0x31/0x4c
 [<c033337d>] error_code+0x81/0x90
 [<c011435d>] try_to_wake_up+0x33c/0x346
 [<c0112254>] __activate_task+0x1c/0x29
 [<c010ef91>] __ipipe_handle_irq+0x1b9/0x20b
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c0103439>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a1ed>] e1000_set_multi+0xee/0x189 [e1000]
 [<c02dcf91>] __dev_mc_upload+0x1d/0x1e
 [<c02dd0b1>] dev_mc_upload+0x24/0x37
 [<c02db5bc>] dev_open+0x44/0x62
 [<c02da089>] dev_change_flags+0x47/0xe4
 [<c030d1a2>] devinet_ioctl+0x252/0x56f
 [<c02db19a>] dev_ifsioc+0x113/0x38d
 [<c02d15b4>] sock_ioctl+0x0/0x1ad
 [<c02d1742>] sock_ioctl+0x18e/0x1ad
 [<c02d15b4>] sock_ioctl+0x0/0x1ad
 [<c015e1a7>] do_ioctl+0x1f/0x62
 [<c015e42e>] vfs_ioctl+0x244/0x256
 [<c015e473>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D






----- Original Nachricht ----
Von:     Jan Kiszka <jan.kiszka@domain.hid>
An:      "M. Koehrer" <mathias_koehrer@domain.hid>
Datum:   27.04.2007 16:31
Betreff: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel

> M. Koehrer wrote:
> > Hi Jan,=20
> >=20
> > here is the result - I have logged with a serial console (as my kernel
> freezes).
> > There are many printk messages...
> >=20
> > I hope that helps a little bit
>=20
> Not yet (was a silly patch, please revert first). Another try
>=20
> --- linux-2.6.20.orig/include/asm-i386/ipipe.h
> +++ linux-2.6.20/include/asm-i386/ipipe.h
> @@ -262,6 +262,9 @@ static inline unsigned long __ipipe_ffnz
>  do { \
>  =09local_irq_enable_nohead(ipd);=09=09=09=09 \
>  =09if (ipd =3D=3D ipipe_root_domain) {=09=09=09=09 \
> +if (!ipd->irqs[irq].handler) { \
> +=09ipipe_set_printk_sync(ipd); printk("irq=3D%d\n", irq); BUG(); \
> +}; \
>  =09=09if (likely(!ipipe_virtual_irq_p(irq))) {=09 \
>  =09=09=09__ipipe_call_root_xirq_handler(ipd,irq); \
>  =09=09} else {=09=09=09=09=09 \
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


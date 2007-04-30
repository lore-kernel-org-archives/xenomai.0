Message-ID: <10772026.1177937498308.JavaMail.ngmail@domain.hid>
Date: Mon, 30 Apr 2007 14:51:38 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4635D2A8.7050208@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4635D2A8.7050208@domain.hid> <4635B14C.2040001@domain.hid>
	<1177688176.5010.135.camel@domain.hid>
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
	<4548126.1177688516220.JavaMail.ngmail@domain.hid>
	<32420186.1177927883942.JavaMail.ngmail@domain.hid>
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

I have done three experiments:
1. Using my kernel without any additional test-patches
2. Activating the trace stuff in the .config file
3. Applying your patches from today

I hope this helps...


Regards

Mathias

Here are the three relevant result files:
************************************** 1 **********************************=
************
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
SMP=20
Modules linked in: e1000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010086   (2.6.20.4 #3)
EIP is at _stext+0x3feffc70/0x14
eax: c0112244   ebx: 00000006   ecx: c011434d   edx: df860000
esi: 00000006   edi: 00000046   ebp: ffffffff   esp: df861e20
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 1242, ti=3Ddf860000 task=3Ddfdd0030 task.ti=3Ddf8600=
00)
Stack: c03e5680 000000db 00000000 c03d9100 c010ef83 00006d80 00000001 00000=
060=20
       e099a210 00000286 ffffff24 df7085c8 00000000 0000000f 00000001 c0103=
439=20
       df7085c8 e099a0ff e09c0000 00000000 0000000f 00000001 80080740 dfc70=
07b=20
Call Trace:
 [<c010ef83>] __ipipe_handle_irq+0x1b9/0x20b
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c0103439>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c02dcf81>] __dev_mc_upload+0x1d/0x1e
 [<c02dd0a1>] dev_mc_upload+0x24/0x37
 [<c02db5ac>] dev_open+0x44/0x62
 [<c02da079>] dev_change_flags+0x47/0xe4
 [<c030d192>] devinet_ioctl+0x252/0x56f
 [<c02db18a>] dev_ifsioc+0x113/0x38d
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c02d1732>] sock_ioctl+0x18e/0x1ad
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c015e18f>] do_ioctl+0x1f/0x62
 [<c015e416>] vfs_ioctl+0x244/0x256
 [<c015e45b>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code:  Bad EIP value.
EIP: [<00000000>] _stext+0x3feffc70/0x14 SS:ESP 0068:df861e20
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
 [<c010b903>] smp_call_function+0x66/0x10a
 [<c0118e12>] printk+0x62/0xd5
 [<c010b9c2>] smp_send_stop+0x1b/0x2b
 [<c01183ad>] panic+0x4d/0xe4
 [<c0103f71>] die+0x1f2/0x226
 [<c011167c>] do_page_fault+0x447/0x517
 [<c010f61d>] __ipipe_handle_exception+0xce/0x158
 [<c010bb1e>] smp_call_function_interrupt+0x31/0x4c
 [<c033336d>] error_code+0x81/0x90
 [<c011434d>] try_to_wake_up+0x33c/0x346
 [<c0112244>] __activate_task+0x1c/0x29
 [<c010ef83>] __ipipe_handle_irq+0x1b9/0x20b
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c0103439>] common_interrupt+0x21/0x38
 [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
 [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
 [<c02dcf81>] __dev_mc_upload+0x1d/0x1e
 [<c02dd0a1>] dev_mc_upload+0x24/0x37
 [<c02db5ac>] dev_open+0x44/0x62
 [<c02da079>] dev_change_flags+0x47/0xe4
 [<c030d192>] devinet_ioctl+0x252/0x56f
 [<c02db18a>] dev_ifsioc+0x113/0x38d
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c02d1732>] sock_ioctl+0x18e/0x1ad
 [<c02d15a4>] sock_ioctl+0x0/0x1ad
 [<c015e18f>] do_ioctl+0x1f/0x62
 [<c015e416>] vfs_ioctl+0x244/0x256
 [<c015e45b>] sys_ioctl+0x33/0x4c
 [<c01029f3>] sysenter_past_esp+0x6c/0x70
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


************************************** 2 **********************************=
************
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:5=
a:f9:0a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
BUG: scheduling while atomic: ifconfig/0x00010000/1242
 [<c0103d34>] show_trace_log_lvl+0x1f/0x34
 [<c01043b4>] show_trace+0x17/0x19
 [<c010444c>] dump_stack+0x1b/0x1d
 [<c0349ffb>] __sched_text_start+0x8b/0x8af
 [<c0102ca3>] work_resched+0x6/0x1c
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Kernel panic - not syncing: Aiee, killing interrupt handler!
 =20
************************************** 3 **********************************=
************

Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:05:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:5=
a:f9:0a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
BUG: scheduling while atomic: ifconfig/0x00010000/1241
 [<c0103d34>] show_trace_log_lvl+0x1f/0x34
 [<c01043b4>] show_trace+0x17/0x19
 [<c010444c>] dump_stack+0x1b/0x1d
 [<c034a01b>] __sched_text_start+0x8b/0x8af
 [<c0102ca3>] work_resched+0x6/0x1c
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Kernel panic - not syncing: Aiee, killing interrupt handler!
I-pipe tracer log (30 points):
     +func                    0 ipipe_trace_panic_freeze+0x9 (bust_spinlock=
s+0x1b)
     +func                    0 bust_spinlocks+0xc (panic+0x17)
     +func                    0 panic+0xd (do_exit+0x78)
     +func                    0 do_exit+0xe (sys_exit_group+0x0)
     +func                    0 do_group_exit+0xb (get_signal_to_deliver+0x=
388)
 |   +end     0x80000000     -1 __ipipe_unstall_root+0x56 (__ipipe_restore_=
root+0x18)
 |   #begin   0x80000000     -1 __ipipe_unstall_root+0x1a (__ipipe_restore_=
root+0x18)
     #func                   -1 __ipipe_unstall_root+0x8 (__ipipe_restore_r=
oot+0x18)
     #func                   -1 __ipipe_restore_root+0x8 (_spin_unlock_irqr=
estore+0x1e)
     #func                   -2 _spin_unlock_irqrestore+0x8 (complete_all+0=
x48)
     #func                   -2 __wake_up_common+0xe (complete_all+0x3f)
 |   #end     0x80000001     -2 __ipipe_stall_root+0x47 (_spin_lock_irqsave=
+0x21)
 |   +begin   0x80000001     -2 __ipipe_stall_root+0x21 (_spin_lock_irqsave=
+0x21)
     +func                   -3 __ipipe_stall_root+0xa (_spin_lock_irqsave+=
0x21)
 |   +end     0x80000001     -3 __ipipe_test_root+0x41 (_spin_lock_irqsave+=
0x11)
 |   +begin   0x80000001     -3 __ipipe_test_root+0x1f (_spin_lock_irqsave+=
0x11)
     +func                   -3 __ipipe_test_root+0xa (_spin_lock_irqsave+0=
x11)
     +func                   -3 _spin_lock_irqsave+0xa (complete_all+0x1a)
     +func                   -4 complete_all+0xe (do_coredump+0x587)
     +func                   -4 up_write+0x8 (do_coredump+0x1cf)
 |   +end     0x80000000     -4 __ipipe_unstall_root+0x56 (do_coredump+0x13=
9)
 |   #begin   0x80000000     -5 __ipipe_unstall_root+0x1a (do_coredump+0x13=
9)
     #func                   -5 __ipipe_unstall_root+0x8 (do_coredump+0x139=
)
     #func                   -5 zap_process+0xa (do_coredump+0x120)
 |   #end     0x80000001     -6 __ipipe_stall_root+0x47 (_spin_lock_irq+0x1=
0)
 |   +begin   0x80000001     -6 __ipipe_stall_root+0x21 (_spin_lock_irq+0x1=
0)
     +func                   -6 __ipipe_stall_root+0xa (_spin_lock_irq+0x10=
)
     +func                   -6 _spin_lock_irq+0x9 (do_coredump+0xfd)
     +func                   -6 init_waitqueue_head+0x8 (do_coredump+0xe7)
     +func                   -7 init_waitqueue_head+0x8 (do_coredump+0xd5)
=20




> M. Koehrer wrote:
> > Hi Jan,
> >=20
> > enclosed is the output of this experiment.
> > I have removed all patches from last week before applying the new patch=
.
> >=20
>=20
> This BUG look now very different from your previous issue. Are you sure
> you build is consistent? Maybe the not-yet-backported IPI bug over
> x86_64 actually cause this heisenbug, don't know.
>=20
> Well, if and only if you have nothing better to do ;), you could retry,
> starting a test with a patch-free tree, then switching on the tracer and
> testing again, and finally re-applying my last patch. But we may also
> wait for Philippe to provide the IPI fix first.
>=20
> Jan
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

